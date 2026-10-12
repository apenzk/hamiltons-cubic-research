"""Multistart hunt for critical points in Weyl_n, and their Lemma-70 slack."""
import numpy as np, sys, os, time, json
sys.path.insert(0, os.path.dirname(__file__))
import core, lemma70
from scipy.optimize import least_squares

def coords(n, W):
    B = core.weyl_basis(n); return B @ W.ravel()

def mat(n, x):
    B = core.weyl_basis(n); N = int(round(np.sqrt(B.shape[1])))
    return (B.T @ x).reshape(N, N)

def resid(n, x):
    W = mat(n, x); th = float(np.sum(W * core.Q(n, W)))
    r = coords(n, core.Q(n, W) - th * W)
    return np.concatenate([r, [np.dot(x, x) - 1.0]])

def jac(n, x):
    B = core.weyl_basis(n); d = B.shape[0]; N = int(round(np.sqrt(B.shape[1])))
    W = mat(n, x); QW = core.Q(n, W); th = float(np.sum(W * QW))
    J = np.zeros((d + 1, d))
    for k in range(d):
        V = B[k].reshape(N, N)
        dQ = core.DQ(n, W, V)
        dth = float(np.sum(V * QW) + np.sum(W * dQ))
        J[:d, k] = coords(n, dQ - dth * W - th * V)
    J[d, :] = 2.0 * x
    return J

def solve(n, x0, ftol=1e-14, maxit=200):
    sol = least_squares(lambda x: resid(n, x), x0, jac=lambda x: jac(n, x),
                        xtol=1e-15, ftol=ftol, gtol=1e-15, max_nfev=maxit)
    x = sol.x / np.linalg.norm(sol.x)
    return x, float(np.linalg.norm(resid(n, x)[:-1]))

def ascent(n, x0, iters=400):
    x = x0 / np.linalg.norm(x0)
    for _ in range(iters):
        W = mat(n, x); y = coords(n, core.Q(n, W))
        ny = np.linalg.norm(y)
        if ny < 1e-14: return x
        x = y / ny
    return x
