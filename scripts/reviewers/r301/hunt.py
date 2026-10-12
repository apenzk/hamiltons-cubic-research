"""General critical-point search on the unit sphere of Weyl_n, and the V3 statistics
at each point found:  theta, Delta, lambda_max(L_e|W-perp), lambda_max on Sym_0."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(__file__))
import core301 as C, sym0 as S, defect as DF
from scipy.optimize import least_squares

def Q_coords(n, x, B, Mw):
    X = sum(xi * b for xi, b in zip(x, B))
    return Mw @ C.sym_to_vec(n, C.Q(n, X)), X

def find_critical(n, seed, tol=1e-13):
    B = C.weyl_basis(n); Mw = C.weyl_mat(n); d = len(B)
    rng = np.random.default_rng(seed)
    x0 = rng.normal(size=d); x0 /= np.linalg.norm(x0)
    def F(x):
        q, X = Q_coords(n, x, B, Mw)
        th = q @ x
        return np.concatenate([q - th * x, [x @ x - 1.0]])
    sol = least_squares(F, x0, xtol=3e-16, ftol=3e-16, gtol=3e-16, max_nfev=4000)
    x = sol.x / np.linalg.norm(sol.x)
    q, X = Q_coords(n, x, B, Mw)
    th = q @ x
    res = np.linalg.norm(q - th * x)
    return th, X, res

def stats(n, W, theta):
    pos, tot, ev = DF.delta(n, W)
    d = len(C.weyl_basis(n)); Mw = C.weyl_mat(n)
    L = S.Le_matrix(n, W, theta)
    w = Mw @ C.sym_to_vec(n, W); w /= np.linalg.norm(w)
    P = np.eye(d) - np.outer(w, w)
    lam_full = np.linalg.eigvalsh(P @ L @ P).max()
    Ab, H, U, Mc, sv = S.compression(n, W, theta)
    evs = np.linalg.eigvalsh(Mc) if U.shape[0] else np.array([-np.inf])
    return dict(theta=theta, Delta=pos, lam_full=lam_full, lam_sym0=evs.max(),
                avg_sym0=evs.mean(), dimV=U.shape[0])
