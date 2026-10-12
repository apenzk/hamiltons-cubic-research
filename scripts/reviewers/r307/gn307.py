"""Damped Gauss-Newton on numpy.lstsq.  scipy.optimize.least_squares is unusable in this
environment: scipy.linalg.svd of a 156 x 155 matrix costs 7.9 s here against numpy's 14 ms,
and trf calls it once per Jacobian."""
import numpy as np


def gauss_newton(resid, jac, c0, iters=200, tol=1e-13):
    c = c0.copy()
    F = resid(c); f = float(F @ F)
    lam = 1e-8
    for it in range(iters):
        J = jac(c)
        g = J.T @ F
        H = J.T @ J
        for _ in range(30):
            try:
                step = np.linalg.solve(H + lam*np.eye(len(c))*max(1.0, np.trace(H)/len(c)), -g)
            except np.linalg.LinAlgError:
                lam *= 10; continue
            cn = c + step
            Fn = resid(cn); fn = float(Fn @ Fn)
            if fn < f:
                c, F, f = cn, Fn, fn
                lam = max(lam*0.3, 1e-14)
                break
            lam *= 10
        else:
            break
        if np.sqrt(f) < tol:
            break
    return c, float(np.abs(F).max())
