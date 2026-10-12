import numpy as np
from scipy.optimize import minimize, linprog

def cube_opt(d, N, S2, sense, rng, tries=8):
    """extremise sum x^3 over {sum x = 0, sum x^2 = S2, x majorized-by-below by d (x >> d)}.
       sense=+1 maximise, -1 minimise. d must have length N and sum 0 (None = no majorization)."""
    sgn = -sense
    if d is not None:
        ds = np.sort(d)[::-1]; cum_d = np.cumsum(ds)[:-1]
    cons = [{'type': 'eq', 'fun': lambda x: x.sum(), 'jac': lambda x: np.ones(N)},
            {'type': 'eq', 'fun': lambda x: x @ x - S2, 'jac': lambda x: 2 * x},
            {'type': 'ineq', 'fun': lambda x: x[:-1] - x[1:],
             'jac': lambda x: np.eye(N)[:-1] - np.eye(N, k=1)[:-1]}]
    if d is not None:
        Cm = np.tril(np.ones((N - 1, N)))
        cons.append({'type': 'ineq', 'fun': lambda x: Cm @ x - cum_d, 'jac': lambda x: Cm})
    best = None
    for t in range(tries):
        if t == 0 and d is not None:
            x0 = ds.copy()
        elif t == 1:
            x0 = np.sort(np.linspace(1, -1, N))[::-1]
        else:
            x0 = np.sort(rng.standard_normal(N))[::-1]
        x0 = x0 - x0.mean(); nn = np.linalg.norm(x0)
        if nn < 1e-12: continue
        x0 = x0 * np.sqrt(S2) / nn
        r = minimize(lambda x: sgn * np.sum(x**3), x0, jac=lambda x: sgn * 3 * x**2,
                     constraints=cons, method='SLSQP',
                     options={'maxiter': 600, 'ftol': 1e-12})
        if not r.success: continue
        x = r.x
        # feasibility check
        ok = abs(x.sum()) < 1e-6 and abs(x @ x - S2) < 1e-5
        if d is not None:
            xs = np.sort(x)[::-1]
            ok = ok and (np.cumsum(xs)[:-1] - cum_d).min() > -1e-6
        if not ok: continue
        v = np.sum(x**3)
        if best is None or sense * v > sense * best: best = v
    return best
