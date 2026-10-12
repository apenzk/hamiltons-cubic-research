import numpy as np
from scipy.linalg import expm

def cay(X):
    n = X.shape[0]; I = np.eye(n)
    return np.linalg.solve(I - X / 2.0, I + X / 2.0)
import core

def Kmat(T):
    K = np.einsum('abab->ab', T).copy(); np.fill_diagonal(K, 0.0); return K

def kappa_obj_grad(T):
    """f = ||K(T)||_F^2 and the so(n) gradient direction X (skew) with df = <X, X_grad>."""
    u = Kmat(T)
    # G_ap = sum_{b != a} u_ab T_{abpb}
    Tabpb = np.einsum('abpb->abp', T)
    G = np.einsum('ab,abp->ap', u, Tabpb)
    Xg = 8.0 * (G - G.T) / 2.0
    return np.sum(u * u), Xg

def kappa(W, starts=12, iters=400, rng=None, return_frame=False, tol=1e-13):
    n = W.shape[0]
    if rng is None: rng = np.random.default_rng(0)
    best = -1.0; bestR = np.eye(n)
    for s in range(starts):
        R = np.eye(n) if s == 0 else np.linalg.qr(rng.standard_normal((n, n)))[0]
        T = core.rotate_W(W, R)
        f, Xg = kappa_obj_grad(T)
        step = 0.5
        for it in range(iters):
            Rn = cay(step * Xg) @ R
            Tn = core.rotate_W(W, Rn)
            fn, Xgn = kappa_obj_grad(Tn)
            if fn > f:
                R, T, f, Xg = Rn, Tn, fn, Xgn
                step *= 1.3
            else:
                step *= 0.4
            if step < 1e-14: break
        if f > best: best, bestR = f, R
    return (best, bestR) if return_frame else best

def kappa_from(W, R0, iters=500):
    import numpy as _np
    from scipy.linalg import expm as _expm
    R = R0.copy(); T = core.rotate_W(W, R); f, Xg = kappa_obj_grad(T); step = 0.3
    for it in range(iters):
        Rn = cay(step * Xg) @ R
        Tn = core.rotate_W(W, Rn); fn, Xgn = kappa_obj_grad(Tn)
        if fn > f: R, T, f, Xg = Rn, Tn, fn, Xgn; step *= 1.3
        else: step *= 0.4
        if step < 1e-14: break
    return f, R
