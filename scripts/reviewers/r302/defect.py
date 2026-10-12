import numpy as np

def Delta(g, W, tol=1e-9):
    """Delta(W) = sum over an orthonormal basis of p = span{v : W v = lam v, lam > 0}
    of ||[ad(v), W]||^2, with ad(v) = D(to_mat(v)) the so(n) action on Lambda^2."""
    ev, V = np.linalg.eigh(W)
    tot = 0.0
    for a in range(len(ev)):
        if ev[a] > tol:
            DX = g.D(g.to_mat(V[:, a]))
            tot += np.sum((DX @ W - W @ DX) ** 2)
    return tot
