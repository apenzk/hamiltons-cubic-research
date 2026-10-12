"""Reviewer 28: independent rebuild of the curvature algebra from definitions.

Conventions (taken literally from the review brief):
  Lambda^2 R^n with orthonormal basis phi_{ij} = E_ij - E_ji (i<j),
  <X,Y> = 1/2 tr(X^T Y).  N = n(n-1)/2.
  c_{abg} = <[phi_a,phi_b],phi_g>,  (A_a)_{mn} = c_{amn}.
  (W^#)_{ab} = -1/2 tr(A_a W A_b W),  Q(W) = W^2 + W^#.
  Curvature operators are symmetric NxN matrices, inner product tr(W W').
  Weyl_n = {Ricci-flat, Alt(W)=0}.
"""
import numpy as np
import itertools, functools

# ---------------------------------------------------------------- basics
@functools.lru_cache(maxsize=None)
def pair_index(n):
    prs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    idx = {p: k for k, p in enumerate(prs)}
    return prs, idx

def phi_matrices(n):
    prs, _ = pair_index(n)
    N = len(prs)
    P = np.zeros((N, n, n))
    for k, (i, j) in enumerate(prs):
        P[k, i, j] = 1.0
        P[k, j, i] = -1.0
    return P

@functools.lru_cache(maxsize=None)
def struct(n):
    """c[a,b,g] = <[phi_a,phi_b], phi_g>."""
    P = phi_matrices(n)
    N = P.shape[0]
    comm = np.einsum('aij,bjk->abik', P, P) - np.einsum('bij,ajk->abik', P, P)
    C = 0.5 * np.einsum('abik,gik->abg', comm, P)
    return C

# ---------------------------------------------------------------- sharp / Q
@functools.lru_cache(maxsize=None)
def _bigM(n):
    """Return (N, C) plus nothing; helper cached separately per x."""
    C = struct(n)
    return C

def sharp(n, W):
    C = struct(n)
    # (W^#)_{ab} = -1/2 tr(A_a W A_b W)
    G = np.einsum('amn,np->amp', C, W)          # (A_a W)_{mp}
    F = np.einsum('amp,bpq,qm->ab', G, C, W, optimize=True)
    return -0.5 * F

def Q(n, W):
    return W @ W + sharp(n, W)

def circ(n, X, Y):
    """Polarization X o Y = 1/2 (Q(X+Y)-Q(X)-Q(Y))."""
    C = struct(n)
    sym = 0.5 * (X @ Y + Y @ X)
    G = np.einsum('amn,np->amp', C, X)
    F = np.einsum('amp,bpq,qm->ab', G, C, Y, optimize=True)   # tr(A_a X A_b Y)
    return sym - 0.25 * (F + F.T)

def circ_operator_matrix(n, x):
    """Return M (N^2 x N^2) with M[(a,b),(q,m)] = tr(A_a x A_b .)_{coefficient}
    so that F = (M @ Y.reshape(-1)).reshape(N,N) equals tr(A_a x A_b Y)."""
    C = struct(n)
    N = C.shape[0]
    G = np.einsum('amn,np->amp', C, x)
    Ct = np.ascontiguousarray(C.transpose(1, 0, 2)).reshape(N, N * N)   # rows p, cols (b,q)
    R = (G.reshape(N * N, N) @ Ct).reshape(N, N, N, N)  # [a,m,b,q]
    M = np.ascontiguousarray(R.transpose(0, 2, 3, 1).reshape(N * N, N * N))
    return M

def circ_batch(n, x, Ys):
    """x o Y_k for a stack Ys of shape (D,N,N).  Returns (D,N,N)."""
    N = x.shape[0]
    M = circ_operator_matrix(n, x)
    Fs = (M @ Ys.reshape(Ys.shape[0], N * N).T).T.reshape(-1, N, N)
    sym = 0.5 * (np.einsum('ij,kjl->kil', x, Ys) + np.einsum('kij,jl->kil', Ys, x))
    return sym - 0.25 * (Fs + Fs.transpose(0, 2, 1))

# ---------------------------------------------------------------- Weyl space
def sym_vec_basis(N):
    """isometric vectorization index list for Sym(N) under tr(WW')."""
    idx = [(a, b) for a in range(N) for b in range(a, N)]
    return idx

def vec_sym(W):
    N = W.shape[0]
    iu = np.triu_indices(N, 1)
    out = np.concatenate([np.diag(W), np.sqrt(2.0) * W[iu]])
    return out

def unvec_sym(v, N):
    W = np.zeros((N, N))
    iu = np.triu_indices(N, 1)
    W[np.diag_indices(N)] = v[:N]
    W[iu] = v[N:] / np.sqrt(2.0)
    W = W + W.T - np.diag(np.diag(W))
    return W

def four_tensor(n, W):
    """T[i,j,k,l] antisym in ij, kl, from W."""
    prs, idx = pair_index(n)
    N = len(prs)
    T = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(prs):
        for b, (k, l) in enumerate(prs):
            v = W[a, b]
            for (ii, jj, s1) in ((i, j, 1), (j, i, -1)):
                for (kk, ll, s2) in ((k, l, 1), (l, k, -1)):
                    T[ii, jj, kk, ll] = s1 * s2 * v
    return T

@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal basis (D,N,N) of Weyl_n inside Sym(N) w.r.t. tr(WW')."""
    prs, idx = pair_index(n)
    N = len(prs)
    dimS = N * (N + 1) // 2
    rows = []
    # build a linear map on the isometric vectorization by acting on basis mats
    def sgn_idx(i, j):
        if i == j: return None, 0
        if i < j: return idx[(i, j)], 1
        return idx[(j, i)], -1
    # elementary symmetric matrices with isometric normalization
    Es = []
    iu = np.triu_indices(N, 1)
    for a in range(N):
        M = np.zeros((N, N)); M[a, a] = 1.0; Es.append(M)
    for a, b in zip(*iu):
        M = np.zeros((N, N)); M[a, b] = M[b, a] = 1.0 / np.sqrt(2.0); Es.append(M)
    Es = np.array(Es)   # (dimS, N, N), orthonormal under tr

    # Bianchi rows: for i<j<k<l : T[i,j,k,l]+T[i,k,l,j]+T[i,l,j,k] = 0
    quads = list(itertools.combinations(range(n), 4))
    B = np.zeros((len(quads), dimS))
    def entry(W, i, j, k, l):
        ai, si = sgn_idx(i, j); bi, sj = sgn_idx(k, l)
        if ai is None or bi is None: return 0.0
        return si * sj * W[ai, bi]
    for r, (i, j, k, l) in enumerate(quads):
        for c in range(dimS):
            W = Es[c]
            B[r, c] = entry(W, i, j, k, l) + entry(W, i, k, l, j) + entry(W, i, l, j, k)
    # Ricci rows: Ric[i,k] = sum_j T[i,j,k,j], for i<=k
    pairsik = [(i, k) for i in range(n) for k in range(i, n)]
    Rr = np.zeros((len(pairsik), dimS))
    for r, (i, k) in enumerate(pairsik):
        for c in range(dimS):
            W = Es[c]
            Rr[r, c] = sum(entry(W, i, j, k, j) for j in range(n))
    Amat = np.vstack([B, Rr])
    # nullspace
    u, s, vt = np.linalg.svd(Amat)
    rank = int((s > 1e-9 * s[0]).sum())
    ns = vt[rank:]           # (D, dimS) orthonormal rows
    D = ns.shape[0]
    basis = np.einsum('dc,cij->dij', ns, Es)
    return basis, ns, Es

def weyl_proj(n, W):
    basis, ns, Es = weyl_basis(n)
    co = np.einsum('dij,ij->d', basis, W)
    return np.einsum('d,dij->ij', co, basis)

def weyl_coeffs(n, W):
    basis, ns, Es = weyl_basis(n)
    return np.einsum('dij,ij->d', basis, W)

# ---------------------------------------------------------------- L operator
def L_matrix(n, x):
    """Matrix of L_x = x o (.) restricted to Weyl_n, in the orthonormal basis."""
    basis, ns, Es = weyl_basis(n)
    out = circ_batch(n, x, basis)             # (D,N,N)
    Lm = np.einsum('kij,dij->dk', out, basis)  # column k = coeffs of x o B_k
    return Lm, out

def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n
