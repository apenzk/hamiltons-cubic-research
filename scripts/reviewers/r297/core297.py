"""Reviewer 297: independent machinery, built from the definitions in the brief only.

Conventions (from the definitions, re-derived here):
  so(n) ~ Lambda^2 R^n, basis phi_a = E_ij - E_ji (i<j), <X,Y> = 1/2 tr(X^T Y).
  ad(x) acts on Lambda^2 (antisymmetric n x n matrices M) by M -> [x, M].
  c_{abg} = <[phi_a,phi_b],phi_g>.
  (W^#)_{ab} = -1/2 tr(ad(phi_a) W ad(phi_b) W);  Q(W) = W@W + W^#;  P = <W,Q(W)>.
  L_W H = (W H + H W)/2 + sharp_bilin(W,H);  L_e = L_W / theta.
"""
import numpy as np, itertools, functools

def pairs_of(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]

@functools.lru_cache(maxsize=None)
def phi(n):
    ps = pairs_of(n)
    P = np.zeros((len(ps), n, n))
    for a, (i, j) in enumerate(ps):
        P[a, i, j] = 1.0; P[a, j, i] = -1.0
    return P

def ad(n, x):
    """N x N matrix of ad(x) on Lambda^2, in the phi basis. x is n x n antisymmetric."""
    P = phi(n)
    br = x @ P - P @ x                       # (N,n,n) = [x, phi_b]
    return 0.5 * np.einsum('aij,bij->ab', P, br)   # <[x,phi_b], phi_a>

@functools.lru_cache(maxsize=None)
def adbasis(n):
    P = phi(n)
    return np.array([ad(n, P[a]) for a in range(P.shape[0])])

def sharp(n, X, Y=None):
    """sharp_bilin(X,Y)_{ab} = -1/4 (tr(ad_a X ad_b Y) + tr(ad_a Y ad_b X)).
    With Y=None returns X^#."""
    A = adbasis(n); N = A.shape[0]
    AX = A @ X                                # (N,N,N)
    F = AX.reshape(N, N * N)
    if Y is None:
        T = F @ AX.transpose(0, 2, 1).reshape(N, N * N).T
        return -0.5 * T
    AY = A @ Y
    T = F @ AY.transpose(0, 2, 1).reshape(N, N * N).T
    return -0.25 * (T + T.T)

def Qmap(n, W):
    return W @ W + sharp(n, W)

def Pval(n, W):
    return float(np.tensordot(W, Qmap(n, W)))

def L_W(n, W, H):
    return 0.5 * (W @ H + H @ W) + sharp(n, W, H)

# ---------- Weyl_n, built independently from the curvature symmetries ----------

def _sym_basis(N):
    vs = []
    for a in range(N):
        E = np.zeros((N, N)); E[a, a] = 1.0; vs.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N)); E[a, b] = E[b, a] = 1 / np.sqrt(2); vs.append(E)
    return np.array(vs)

@functools.lru_cache(maxsize=None)
def weyl(n):
    """Orthonormal basis (d,N,N) of {W in Sym^2(Lambda^2): first Bianchi = 0, Ricci = 0}."""
    ps = pairs_of(n); idx = {p: a for a, p in enumerate(ps)}; N = len(ps)
    def cell(i, j, k, l):
        if i == j or k == l: return None
        s = 1.0
        if i > j: i, j, s = j, i, -s
        if k > l: k, l, s = l, k, -s
        return idx[(i, j)], idx[(k, l)], s
    rows = []
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        for perm in ((i, j, k, l), (i, k, j, l), (i, l, j, k)):
            pass
        row = np.zeros((N, N))
        for (a, b, c, d), sg in (((i, j, k, l), 1.0), ((i, k, l, j), 1.0), ((i, l, j, k), 1.0)):
            u, v, s = cell(a, b, c, d); row[u, v] += sg * s
        rows.append(0.5 * (row + row.T))
    for i in range(n):
        for k in range(i, n):
            row = np.zeros((N, N))
            for j in range(n):
                r = cell(i, j, k, j)
                if r is None: continue
                u, v, s = r; row[u, v] += s
            rows.append(0.5 * (row + row.T))
    C = np.array(rows); S = _sym_basis(N)
    M = np.einsum('rij,dij->rd', C, S)
    u, s, vt = np.linalg.svd(M, full_matrices=True)
    tol = max(M.shape) * (s[0] if s.size else 1.0) * 1e-12
    r = int((s > tol).sum())
    return np.einsum('kd,dij->kij', vt[r:], S)

def in_weyl(n, W):
    B = weyl(n); f = W.reshape(-1)
    co = B.reshape(B.shape[0], -1) @ f
    return float(np.linalg.norm(f - co @ B.reshape(B.shape[0], -1)))

# ---------- defect, orbit tangent, L_e spectrum ----------

def eigdata(n, W, tol=1e-9):
    lam, V = np.linalg.eigh(W)
    P = phi(n)
    v = np.einsum('ga,gij->aij', V, P)        # v[a] = a-th eigenvector as element of so(n)
    return lam, v

def g_vector(n, W, tol=1e-9):
    """g_delta = || [ad(v_delta), W] ||_F^2, computed directly as a commutator."""
    lam, v = eigdata(n, W)
    N = W.shape[0]
    out = np.zeros(N); tang = []
    for d in range(N):
        Ad = ad(n, v[d])
        Z = Ad @ W - W @ Ad
        out[d] = float(np.sum(Z * Z)); tang.append(Z)
    return lam, out, np.array(tang)

def g_vector_via_T(n, W, tol=1e-9):
    """The brief's formula: g_delta = sum_ab (lam_a-lam_b)^2 T_{delta a b}, T = c^2 in eigenframe."""
    lam, v = eigdata(n, W)
    br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
    c = 0.5 * np.einsum('abij,cij->abc', br, v)
    T = c ** 2
    return np.einsum('dab,ab->d', T, (lam[:, None] - lam[None, :]) ** 2)

def Delta(n, W, tol=1e-9):
    lam, g, _ = g_vector(n, W)
    return float(g[lam > tol].sum()), float(g.sum()), lam

def orbit_tangent(n, W):
    P = phi(n); out = []
    for a in range(P.shape[0]):
        A = ad(n, P[a]); out.append(A @ W - W @ A)
    return np.array(out)

def rowspace(V, tol=1e-9):
    F = V.reshape(V.shape[0], -1)
    u, s, vt = np.linalg.svd(F, full_matrices=False)
    r = int((s > tol * max(1.0, s[0])).sum())
    return vt[:r]

def Le_on_weyl(n, W, theta):
    """Matrix of L_e in an orthonormal basis of Weyl_n."""
    B = weyl(n); d = B.shape[0]
    img = np.array([L_W(n, W, B[k]) for k in range(d)]) / theta
    return np.einsum('kij,lij->lk', img, B)    # M[l,k] = <L_e B_k, B_l>

def le_spectrum_perp(n, W, theta):
    """Spectrum of L_e restricted to Weyl_n ∩ W^perp."""
    B = weyl(n); d = B.shape[0]
    M = Le_on_weyl(n, W, theta)
    w = np.einsum('kij,ij->k', B, W); w = w / np.linalg.norm(w)
    # orthonormal complement of w
    Uf, s, _ = np.linalg.svd(np.eye(d) - np.outer(w, w))
    U = Uf[:, :d - 1]
    Mp = U.T @ M @ U
    return np.linalg.eigvalsh(0.5 * (Mp + Mp.T)), M, w, U

# ---------- catalogue points ----------

def sphere_product(blocks):
    n = sum(blocks); ps = pairs_of(n); N = len(ps)
    lab = []
    for bi, b in enumerate(blocks): lab += [bi] * b
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(ps):
        if lab[i] == lab[j]:
            p = blocks[lab[i]]; W[a, a] = 1.0 / (p * (p - 1))
        else:
            p, q = blocks[lab[i]], blocks[lab[j]]; W[a, a] = -1.0 / (p * q)
    return W / np.linalg.norm(W), n

def cpm(m):
    n = 2 * m
    J = np.zeros((n, n))
    for t in range(m): J[2*t, 2*t+1] = 1.0; J[2*t+1, 2*t] = -1.0
    d = np.eye(n)
    Tn = (np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)
          + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
          + 2.0 * np.einsum('ij,kl->ijkl', J, J))
    ps = pairs_of(n)
    R = np.array([[Tn[i, j, k, l] for (k, l) in ps] for (i, j) in ps])
    Ric = np.einsum('ikjk->ij', Tn); scal = np.trace(Ric)
    W = R - (scal / (n * (n - 1))) * np.eye(len(ps))
    return W / np.linalg.norm(W), n

def c5_blowup(sizes=(2,2,2,2,2), diag=4.0, adjv=-2.0, nonadj=1.0):
    k = len(sizes); n = sum(sizes)
    G = [[1 if (abs(a-b) % k in (1, k-1)) else 0 for b in range(k)] for a in range(k)]
    ps = pairs_of(n); N = len(ps)
    lab = []
    for bi, b in enumerate(sizes): lab += [bi] * b
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(ps):
        A_, B_ = lab[i], lab[j]
        W[a, a] = diag if A_ == B_ else (adjv if G[A_][B_] else nonadj)
    return W / np.linalg.norm(W), n
