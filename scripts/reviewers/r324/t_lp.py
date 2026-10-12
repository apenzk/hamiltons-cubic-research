"""L4: relaxation of the deficiency identity to spectrum + the row measure's own exact constraints."""
import numpy as np
from scipy.optimize import minimize

def _lower_env(q, c, x):
    """min sum p_i c_i over prob. distributions p with sum p_i q_i = x  ==
       the lower convex envelope of {(q_i,c_i)} at x."""
    order = np.argsort(q)
    q, c = q[order], c[order]
    if x < q[0]-1e-12 or x > q[-1]+1e-12:
        return np.inf
    hull = []                                   # monotone chain, lower hull
    for i in range(len(q)):
        while len(hull) >= 2:
            (x1, y1), (x2, y2) = hull[-2], hull[-1]
            if (y2-y1)*(q[i]-x1) - (c[i]-y1)*(x2-x1) >= 0:
                hull.pop()
            else:
                break
        hull.append((q[i], c[i]))
    hx = np.array([h[0] for h in hull]); hy = np.array([h[1] for h in hull])
    return float(np.interp(x, hx, hy))

def minX(lam, n):
    N = len(lam); lmin = lam[0]
    M = 2*(n-2); F = -4*lmin
    A, B = np.triu_indices(N, 1)
    q = lam[A]+lam[B]
    c = 0.5*lam[A]*lam[B]
    return M*_lower_env(q, c, F/M)

def theta_of(lam, n):
    lam = np.sort(np.asarray(lam, float)); lam = lam-lam.mean(); lam = lam/np.linalg.norm(lam)
    X = minX(lam, n)
    return lam[0] + X/lam[0] if np.isfinite(X) else -np.inf

def ceiling(n, tries=20, seed=0):
    N = n*(n-1)//2
    rng = np.random.default_rng(seed)
    best = (-np.inf, None)
    f = lambda x: -theta_of(x, n)
    for t in range(tries):
        x0 = rng.normal(size=N)
        r = minimize(f, x0, method='Nelder-Mead',
                     options=dict(maxiter=60000, maxfev=120000, fatol=1e-13, xatol=1e-11))
        if -r.fun > best[0]:
            lam = np.sort(r.x); lam -= lam.mean(); lam /= np.linalg.norm(lam)
            best = (-r.fun, lam)
    return best
