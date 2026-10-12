"""Symmetry defect Delta, orbit tangent, and the H5 edge statistic."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(__file__))
import core301 as C, sym0 as S

def ad_of(n, v):
    A = C.adj(n)
    return np.tensordot(v, A, axes=(0, 0))

def delta(n, W, tol=1e-9):
    ev, V = np.linalg.eigh(W)
    tot = 0.0; pos = 0.0
    for i, lam in enumerate(ev):
        ad = ad_of(n, V[:, i])
        g = np.linalg.norm(ad @ W - W @ ad) ** 2
        tot += g
        if lam > tol: pos += g
    return pos, tot, ev

def orbit_tangent(n, W):
    """Coordinate vectors (in the Weyl basis) spanning { [ad(x), W] : x in so(n) }."""
    A = C.adj(n); Mw = C.weyl_mat(n); N = A.shape[0]
    rows = []
    for a in range(N):
        Sm = A[a] @ W - W @ A[a]
        rows.append(Mw @ C.sym_to_vec(n, 0.5 * (Sm + Sm.T)))
    R = np.array(rows)
    u, s, vt = np.linalg.svd(R, full_matrices=False)
    keep = s > 1e-9 * max(1.0, s.max())
    return vt[keep]

def edge_family(n, W, theta, blk, graph, mode='edge'):
    """A = (E_ab+E_ba)/sqrt2 for a,b in blocks joined by an edge ('edge'), any two
    distinct blocks ('allpairs'), or the same block ('within')."""
    As = []
    for i in range(n):
        for j in range(i + 1, n):
            a, b = blk[i], blk[j]
            ok = (graph[a][b] == 1) if mode == 'edge' else (a != b if mode == 'allpairs' else a == b)
            if ok:
                M = np.zeros((n, n)); M[i, j] = M[j, i] = 1 / np.sqrt(2); As.append(M)
    return As

def compress_on(n, W, theta, As, tol=1e-9):
    Mw = C.weyl_mat(n)
    w = Mw @ C.sym_to_vec(n, W); w /= np.linalg.norm(w)
    vecs = []
    for A in As:
        D = C.D_A(n, A); Hm = D @ W + W @ D
        v = Mw @ C.sym_to_vec(n, 0.5 * (Hm + Hm.T))
        vecs.append(v - (v @ w) * w)
    Hv = np.array(vecs)
    if not len(Hv): return np.array([]), None
    u, s, vt = np.linalg.svd(Hv, full_matrices=False)
    keep = s > tol * max(1.0, s.max())
    U = vt[keep]
    if U.shape[0] == 0: return np.array([]), None
    Bs = C.weyl_basis(n)
    LU = np.empty_like(U)
    for r in range(U.shape[0]):
        X = C.vec_to_sym(n, Mw.T @ U[r])
        LU[r] = Mw @ C.sym_to_vec(n, C.circ(n, W, X) / theta)
    Mc = LU @ U.T
    return np.linalg.eigvalsh(0.5 * (Mc + Mc.T)), U
