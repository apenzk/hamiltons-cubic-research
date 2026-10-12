"""Critical points built from scratch: sphere products, CP^m, C_5 blow-up, and the
n = 8 witness loaded from scripts/data (data only, no code)."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(__file__))
import core301 as C

def diag_weyl(n, K):
    """Weyl part of a diagonal curvature operator with sectional matrix K (hollow sym)."""
    r = K.sum(axis=1); scal = r.sum()
    lam = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            if i != j:
                lam[i, j] = K[i, j] - (r[i] + r[j]) / (n - 2) + scal / ((n - 1) * (n - 2))
    P, idx = C.pairs(n); N = len(P)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(P):
        W[a, a] = lam[i, j]
    return W / C.nrm(W)

def sphere_product(p, q):
    n = p + q
    K = np.zeros((n, n))
    for i in range(p):
        for j in range(p):
            if i != j: K[i, j] = 1.0
    for i in range(p, n):
        for j in range(p, n):
            if i != j: K[i, j] = 1.0
    return n, diag_weyl(n, K)

def c5_blowup():
    n = 10
    blk = [i // 2 for i in range(n)]
    K = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            if i == j: continue
            a, b = blk[i], blk[j]
            if a == b: K[i, j] = 4.0
            elif (a - b) % 5 in (1, 4): K[i, j] = -2.0
            else: K[i, j] = 1.0
    # already hollow with zero row sums -> it IS the Weyl vertex matrix
    P, idx = C.pairs(n); N = len(P)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(P):
        W[a, a] = K[i, j]
    return n, W / C.nrm(W)

def cpm(m):
    """Weyl operator of CP^m with the Fubini-Study metric, n = 2m.
    R(X,Y,Z,T) = <X,Z><Y,T>-<X,T><Y,Z> + <JX,Z><JY,T>-<JX,T><JY,Z> + 2<JX,Y><JZ,T>."""
    n = 2 * m
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = 1.0; J[2 * k + 1, 2 * k] = -1.0
    I = np.eye(n)
    R = (np.einsum('ac,bd->abcd', I, I) - np.einsum('ad,bc->abcd', I, I)
         + np.einsum('ac,bd->abcd', J, J) - np.einsum('ad,bc->abcd', J, J)
         + 2 * np.einsum('ab,cd->abcd', J, J))
    # R_{ijkl} with our operator convention: <R(e_i^e_j), e_k^e_l> = R_{ijkl}
    P, idx = C.pairs(n); N = len(P)
    M = np.zeros((N, N))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            M[a, b] = R[i, j, k, l]
    M = 0.5 * (M + M.T)
    Wp = C.proj_weyl(n, M)
    return n, Wp / C.nrm(Wp)

def witness_n8():
    W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
    return 8, W / C.nrm(W)

def theta_and_resid(n, W):
    QW = C.Q(n, W)
    th = C.ip(QW, W)
    return th, C.nrm(QW - th * W)

def diagQ(lam):
    """Q on the coordinate-diagonal slice: (Q)_ij = lam_ij^2 + sum_k lam_ik lam_jk."""
    return lam * lam + lam @ lam

def blowup_critical(graph, sizes, seed=None, tries=60):
    """Block-symmetric coordinate-diagonal critical point for the given block graph.
    Solves lam^2 + lam@lam = theta lam on the (within, edge, non-edge) ansatz."""
    from scipy.optimize import least_squares
    k = len(sizes); n = sum(sizes)
    blk = sum([[a] * sizes[a] for a in range(k)], [])
    def build(par):
        x, y, z = par
        L = np.zeros((n, n))
        for i in range(n):
            for j in range(n):
                if i == j: continue
                a, b = blk[i], blk[j]
                L[i, j] = x if a == b else (y if graph[a][b] else z)
        return L
    rng = np.random.default_rng(seed if seed is not None else 0)
    best = None
    for t in range(tries):
        p0 = rng.normal(size=3) if t else np.array([1.0, -1.0, 0.3])
        def F(par):
            L = build(par)
            th = float((diagQ(L) * L).sum() / (L * L).sum()) if (L*L).sum() > 1e-12 else 0.0
            R = diagQ(L) - th * L
            rows = L.sum(axis=1)
            return np.concatenate([R[np.triu_indices(n, 1)], rows, [np.sqrt((L*L).sum()/2) - 1]])
        sol = least_squares(F, p0, xtol=1e-15, ftol=1e-15, gtol=1e-15)
        if sol.cost < 1e-20:
            L = build(sol.x)
            if (L * L).sum() < 1e-9: continue
            nrm2 = (L * L).sum() / 2
            L = L / np.sqrt(nrm2)
            th = float((diagQ(L) * L).sum() / 2)
            if th > 1e-6:
                if best is None or th > best[0]:
                    best = (th, L)
    if best is None: return None
    th, L = best
    P, idx = C.pairs(n); N = len(P)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(P):
        W[a, a] = L[i, j]
    return n, W / C.nrm(W), blk

def cycle(k):
    G = [[0] * k for _ in range(k)]
    for a in range(k):
        G[a][(a + 1) % k] = G[(a + 1) % k][a] = 1
    return G

def complete(k):
    return [[1 if a != b else 0 for b in range(k)] for a in range(k)]
