import numpy as np, core

def sphere_product(m1, m2, r1=1.0, r2=1.0):
    """Weyl part of S^{m1}(r1) x S^{m2}(r2), normalized to ||M||_F = 1."""
    n = m1 + m2
    R = np.zeros((n, n, n, n))
    g = np.eye(n)
    for (blk, c) in ((range(0, m1), 1.0 / r1**2), (range(m1, n), 1.0 / r2**2)):
        idx = list(blk)
        sub = np.zeros((n, n)); 
        for i in idx: sub[i, i] = 1.0
        R += c * (np.einsum('ik,jl->ijkl', sub, sub) - np.einsum('il,jk->ijkl', sub, sub))
    W = core.project_weyl(R)
    return core.normalize(W)

def cpm(m, sign=+1.0):
    """Weyl part of CP^m (Fubini-Study) in R^{2m}, normalized."""
    n = 2 * m
    J = np.zeros((n, n))
    for k in range(m):
        J[2*k, 2*k+1] = 1.0; J[2*k+1, 2*k] = -1.0
    T = (np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
         + 2*np.einsum('ij,kl->ijkl', J, J))
    W = core.project_weyl(sign * T)
    return core.normalize(W)

def pad(W, n):
    m = W.shape[0]
    out = np.zeros((n, n, n, n)); out[:m, :m, :m, :m] = W
    return out
