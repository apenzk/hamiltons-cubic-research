import numpy as np, core

def cp_operator(m):
    """Fubini-Study curvature operator of CP^m on Lambda^2 R^{2m}, holomorphic sec curv 4."""
    n = 2*m
    J = np.zeros((n, n))
    for k in range(m):
        J[2*k, 2*k+1] = 1.0; J[2*k+1, 2*k] = -1.0
    d = np.eye(n)
    R = np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d) \
        + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J) \
        + 2*np.einsum('ij,kl->ijkl', J, J)
    P = core.pairs(n); N = len(P)
    W = np.array([[R[i, j, k, l] for (k, l) in P] for (i, j) in P])
    return W, n

def pad(W, n0, n):
    """embed Lambda^2 R^{n0} into Lambda^2 R^n by index inclusion."""
    P0 = core.pairs(n0); P = core.pairs(n)
    pos = {p: a for a, p in enumerate(P)}
    N = len(P)
    out = np.zeros((N, N))
    for a, p in enumerate(P0):
        for b, q in enumerate(P0):
            out[pos[p], pos[q]] = W[a, b]
    return out
