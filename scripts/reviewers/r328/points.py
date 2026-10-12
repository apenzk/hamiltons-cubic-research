"""Known points, built from scratch: balanced sphere products, tori, CP^2, paddings."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(__file__))
import core

def block_proj(n, blocks):
    """Projection of Lambda^2 onto span{w_ij : i,j in same block}."""
    P, _ = core.struct(n); N = len(P)
    lab = np.zeros(n, dtype=int)
    for b, bl in enumerate(blocks):
        for i in bl: lab[i] = b
    d = np.array([1.0 if lab[i] == lab[j] else 0.0 for (i, j) in P])
    return np.diag(d)

def sub_proj(n, gens):
    """Projection onto the span of a list of Lambda^2 vectors (given as coeff vectors)."""
    Gm = np.array(gens); q, _ = np.linalg.qr(Gm.T)
    return q @ q.T

def normalise_weyl(n, R):
    W = core.weyl_proj(n, R)
    return W / np.linalg.norm(W)

def sphere_product(n, k):
    return normalise_weyl(n, block_proj(n, [list(range(k)), list(range(k, n))]))

def maximal_torus(n):
    """so(2)^{n/2}: span of w_{01}, w_{23}, ..."""
    P, _ = core.struct(n); idx = {tuple(p): a for a, p in enumerate(P)}
    N = len(P); gens = []
    for i in range(0, n - 1, 2):
        v = np.zeros(N); v[idx[(i, i + 1)]] = 1.0; gens.append(v)
    return normalise_weyl(n, sub_proj(n, gens))

def cp2(n=4):
    """W_{CP^2} at n=4: u(2) subalgebra of so(4) -> curvature op, projected to Weyl."""
    P, _ = core.struct(n); idx = {tuple(p): a for a, p in enumerate(P)}; N = len(P)
    # complex structure J: e0->e1, e2->e3.  u(2) = {A in so(4): [A,J]=0}
    J = np.zeros((n, n)); J[0, 1] = 1; J[1, 0] = -1; J[2, 3] = 1; J[3, 2] = -1
    mats = []
    for (i, j) in P:
        A = np.zeros((n, n)); A[i, j] = 1; A[j, i] = -1; mats.append(A)
    rows = [ (A @ J - J @ A).ravel() for A in mats ]
    Cm = np.array(rows).T
    u, s, vt = np.linalg.svd(Cm)
    ns = vt[np.sum(s > 1e-9):]
    return normalise_weyl(n, sub_proj(n, list(ns)))

def pad(n, W_small, n_small):
    """Embed a Weyl tensor of R^{n_small} into R^n by zero padding on Lambda^2."""
    Ps, _ = core.struct(n_small); Pb, _ = core.struct(n)
    idx = {tuple(p): a for a, p in enumerate(Pb)}; N = len(Pb)
    M = np.zeros((N, N))
    for a, pa in enumerate(Ps):
        for b, pb in enumerate(Ps):
            M[idx[tuple(pa)], idx[tuple(pb)]] = W_small[a, b]
    return M
