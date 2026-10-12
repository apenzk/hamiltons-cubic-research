"""L4: the same relaxation, now with the record's proved row cap ||[v,phi]||^2 <= 2."""
import numpy as np
from scipy.optimize import linprog, minimize

def minX_cap(lam, n):
    N = len(lam); lmin = lam[0]
    A_, B_ = np.triu_indices(N, 1)
    c = 0.5*lam[A_]*lam[B_]
    q = lam[A_]+lam[B_]
    nv = len(c)
    Aeq = np.vstack([np.ones(nv), q]); beq = np.array([2*(n-2), -4*lmin])
    rows = np.zeros((N, nv))
    for k in range(nv):
        rows[A_[k], k] = 1.0; rows[B_[k], k] = 1.0
    r = linprog(c, A_ub=rows, b_ub=4*np.ones(N), A_eq=Aeq, b_eq=beq,
                bounds=[(0, None)]*nv, method='highs')
    return r.fun if r.success else np.inf

def theta_cap(x, n):
    lam = np.sort(np.asarray(x, float)); lam = lam-lam.mean()
    nr = np.linalg.norm(lam)
    if nr < 1e-9: return -1e6
    lam /= nr
    X = minX_cap(lam, n)
    return lam[0] + X/lam[0] if np.isfinite(X) else -1e6
