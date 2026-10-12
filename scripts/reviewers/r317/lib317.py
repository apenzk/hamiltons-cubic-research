"""Reviewer 317: independent implementation of the Weyl-operator machinery.

Built from definitions only. Nothing is imported from the repository.
Basis of Lambda^2(R^n) = so(n): A_ij = e_i e_j^T - e_j e_i^T for i<j,
orthonormal for <X,Y> = (1/2) tr(X^T Y).
"""
import numpy as np
import itertools


def pair_index(n):
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    idx = -np.ones((n, n), dtype=int)
    sgn = np.zeros((n, n))
    for a, (i, j) in enumerate(pairs):
        idx[i, j] = a
        idx[j, i] = a
        sgn[i, j] = 1.0
        sgn[j, i] = -1.0
    return pairs, idx, sgn


def so_basis(n):
    """Orthonormal basis A_ij of so(n) as n x n matrices."""
    pairs, _, _ = pair_index(n)
    B = np.zeros((len(pairs), n, n))
    for a, (i, j) in enumerate(pairs):
        B[a, i, j] = 1.0
        B[a, j, i] = -1.0
    return B


def structure_constants(n):
    """c[a,b,c] = <[B_a,B_b],B_c>, <X,Y> = (1/2)tr(X^T Y)."""
    B = so_basis(n)
    N = B.shape[0]
    comm = np.einsum('aij,bjk->abik', B, B) - np.einsum('bij,ajk->abik', B, B)
    c = 0.5 * np.einsum('abik,cik->abc', comm, B)
    return c


def to_tensor(M, n):
    """M: N x N operator matrix -> R[i,j,k,l]."""
    _, idx, sgn = pair_index(n)
    ii = np.where(idx >= 0, idx, 0)
    T = M[np.ix_(ii.ravel(), ii.ravel())].reshape(n, n, n, n)
    s = sgn
    return T * s[:, :, None, None] * s[None, None, :, :]


def weyl_basis(n, tol=1e-9):
    """Orthonormal basis (columns) of the space of algebraic Weyl operators,
    inside Sym(N) coordinates: symmetric, first Bianchi, Ricci-flat."""
    pairs, idx, sgn = pair_index(n)
    N = len(pairs)
    # coordinates: upper triangle of symmetric N x N
    coords = [(a, b) for a in range(N) for b in range(a, N)]
    D = len(coords)
    rows = []

    def Mfrom(k):
        M = np.zeros((N, N))
        a, b = coords[k]
        M[a, b] = 1.0
        M[b, a] = 1.0
        return M

    basis_mats = [Mfrom(k) for k in range(D)]
    tensors = np.array([to_tensor(M, n) for M in basis_mats])  # D,n,n,n,n
    # first Bianchi on i<j<k<l
    cons = []
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        cons.append(tensors[:, i, j, k, l] + tensors[:, i, k, l, j] + tensors[:, i, l, j, k])
    # Ricci
    ric = np.einsum('dijkj->dik', tensors)
    for i in range(n):
        for k in range(i, n):
            cons.append(ric[:, i, k])
    C = np.array(cons)
    # nullspace
    u, s, vt = np.linalg.svd(C)
    rank = int((s > tol * max(s[0], 1.0)).sum())
    ns = vt[rank:]  # (D - rank, D)
    return ns, coords, N


def coords_to_M(v, coords, N):
    M = np.zeros((N, N))
    for k, (a, b) in enumerate(coords):
        M[a, b] += v[k]
        if a != b:
            M[b, a] += v[k]
        else:
            pass
    return M


def M_to_coords(M, coords):
    return np.array([M[a, b] for (a, b) in coords])


def sharp(W, c):
    """W# with (W#)_{ab} = (1/2) sum_{cdef} c_{cda} c_{efb} W_{ce} W_{df}."""
    N = W.shape[0]
    # T_a = W C_a W where (C_a)_{cd} = c[c,d,a]
    Cm = np.transpose(c, (2, 0, 1))            # a, c, d
    T = np.einsum('ce,acd,df->aef', W, Cm, W)  # a, e, f
    return 0.5 * np.einsum('aef,bef->ab', T, Cm)


def Q(W, c):
    return W @ W + sharp(W, c)


def P(W, c):
    return float(np.sum(W * Q(W, c)))


def theta_of(W, c):
    """<W,Q(W)>/||W||^3 -- equals theta at a critical point with ||W||=1."""
    nrm = np.linalg.norm(W)
    return P(W, c) / nrm ** 3


def crit_residual(W, c):
    """||Q(W) - theta W|| with theta = <W,Q(W)>/||W||^2, W unit."""
    QW = Q(W, c)
    th = float(np.sum(W * QW)) / float(np.sum(W * W))
    return float(np.linalg.norm(QW - th * W)), th


def ad_on_lambda2(x, c):
    """ad(x) acting on Lambda^2: (ad x)_{ab} = sum_k x_k c[k,b,a]  (so that
    ad(x) v = [x, v])."""
    return np.einsum('k,kba->ab', x, c)


def defect_Delta(W, c, tol=1e-9):
    """Delta = sum over positive-eigenvalue eigenvectors v of ||[ad(v), W]||^2."""
    ev, V = np.linalg.eigh(W)
    tot = 0.0
    per = []
    for k in range(len(ev)):
        if ev[k] > tol:
            adv = ad_on_lambda2(V[:, k], c)
            g = np.linalg.norm(adv @ W - W @ adv) ** 2
            tot += g
            per.append(g)
    return tot, per


def sign_split(W, tol=1e-9):
    ev, V = np.linalg.eigh(W)
    p = V[:, ev > tol]
    m = V[:, ev < -tol]
    z = V[:, np.abs(ev) <= tol]
    return p, m, z, ev


def S_components(W, c, tol=1e-9):
    """Bracket-defect sums in the sign splitting."""
    p, m, z, ev = sign_split(W, tol)
    out = {}
    def proj(X, Y, Z):
        # sum over basis of X,Y,Z of c(x,y,z)^2
        t = np.einsum('abc,ax,by,cz->xyz', c, X, Y, Z)
        return float(np.sum(t ** 2))
    out['S_mmm'] = proj(m, m, m)
    out['S_mpp'] = proj(m, p, p)
    out['S_ppp'] = proj(p, p, p)
    out['dims'] = (p.shape[1], m.shape[1], z.shape[1])
    return out


def Lambda2(g, n):
    """Matrix of X -> g X g^T on the orthonormal basis A_ij of so(n)."""
    B = so_basis(n)
    Gb = np.einsum('ij,ajk,lk->ail', g, B, g)
    return 0.5 * np.einsum('ail,bil->ba', Gb, B).T


def commutant_sym_on_Rn(hbasis, n, tol=1e-8):
    """dim of {S symmetric on R^n : [S,X]=0 for all X in span(hbasis)},
    hbasis given as columns in Lambda^2 coordinates."""
    B = so_basis(n)
    mats = [np.einsum('a,aij->ij', hbasis[:, k], B) for k in range(hbasis.shape[1])]
    idx = [(i, j) for i in range(n) for j in range(i, n)]
    rows = []
    for (i, j) in idx:
        S = np.zeros((n, n)); S[i, j] = 1.0; S[j, i] = 1.0
        rows.append(np.concatenate([(S @ X - X @ S).ravel() for X in mats]))
    A = np.array(rows).T
    s = np.linalg.svd(A, compute_uv=False)
    rank = int((s > tol * max(s[0], 1.0)).sum())
    return len(idx) - rank


def gradings_in_eigenbasis(W, c, tol=1e-8, verbose=False):
    """All Lie-algebra involutions of so(n) that are diagonal in W's eigenbasis.
    Requires W to have simple spectrum. Solves eps_a eps_b eps_c = 1 over GF(2)
    for every structure-constant triple that is nonzero."""
    ev, V = np.linalg.eigh(W)
    gaps = np.diff(np.sort(ev))
    simple = gaps.min() > 1e-6
    cE = np.einsum('abc,ax,by,cz->xyz', c, V, V, V)
    N = W.shape[0]
    scale = np.abs(cE).max()
    rows = []
    for a in range(N):
        for b in range(a + 1, N):
            for d in range(b + 1, N):
                if abs(cE[a, b, d]) > tol * scale:
                    r = np.zeros(N, dtype=np.uint8)
                    r[a] ^= 1; r[b] ^= 1; r[d] ^= 1
                    rows.append(r)
    A = np.array(rows, dtype=np.uint8) if rows else np.zeros((0, N), dtype=np.uint8)
    # GF(2) nullspace
    Am = A.copy()
    piv = []
    r = 0
    for col in range(N):
        pr = None
        for rr in range(r, Am.shape[0]):
            if Am[rr, col]:
                pr = rr; break
        if pr is None:
            continue
        Am[[r, pr]] = Am[[pr, r]]
        mask = Am[:, col].copy().astype(bool)
        mask[r] = False
        Am[mask] ^= Am[r]
        piv.append(col)
        r += 1
    free = [ccc for ccc in range(N) if ccc not in piv]
    basis = []
    for f in free:
        v = np.zeros(N, dtype=np.uint8)
        v[f] = 1
        for i, pcol in enumerate(piv):
            if Am[i, f]:
                v[pcol] = 1
        basis.append(v)
    return simple, V, ev, basis, free
