"""The both-sided majorization ('Schur-Horn') relaxation F, built from the
definitions.

  d_phi = (K_ab)_{a<b}                       ||d_phi||^2 = t/2
  d     = d_phi  cat  (-spec(K|_{1^perp}))   ||d||^2     = 3t/2
  F(K)  = 3/2 * max{ p3(mu) : sum mu = 0, sum mu^2 = 1, mu > d_phi }
        - 1/2 * min{ p3(om) : sum om = 0, sum om^2 = 3, om > d     }
('>' = majorizes.)  Inner problems are solved in sorted coordinates, so the
majorization constraints are linear.
"""
import numpy as np
from scipy.optimize import minimize


def diag_data(K):
    n = K.shape[0]
    dphi = np.array([K[a, b] for a in range(n) for b in range(a + 1, n)])
    # K restricted to 1^perp
    Q = np.linalg.qr(np.eye(n) - np.ones((n, n)) / n)[0][:, :n - 1]
    ev = np.linalg.eigvalsh(Q.T @ K @ Q)
    d = np.concatenate([dphi, -ev])
    return dphi, d


def _solve(v, S, sense, nstart=6, seed=0):
    """extremise p3(x) over sum x = 0, sum x^2 = S, x sorted desc, x > v."""
    v = np.sort(np.asarray(v))[::-1]
    m = len(v)
    cs = np.cumsum(v)[:-1]
    sgn = -1.0 if sense == 'max' else 1.0
    rng = np.random.default_rng(seed)

    def f(x):
        return sgn * float(np.sum(x ** 3))

    def g(x):
        return sgn * 3.0 * x ** 2

    cons = [
        {'type': 'eq', 'fun': lambda x: float(x.sum()),
         'jac': lambda x: np.ones(m)},
        {'type': 'eq', 'fun': lambda x: float(x @ x) - S,
         'jac': lambda x: 2 * x},
        # sorted, descending
        {'type': 'ineq', 'fun': lambda x: x[:-1] - x[1:],
         'jac': lambda x: np.eye(m)[:-1] - np.eye(m)[1:]},
        # majorization
        {'type': 'ineq', 'fun': lambda x: np.cumsum(x)[:-1] - cs,
         'jac': lambda x: np.tril(np.ones((m, m)))[:-1]},
    ]
    best, bx = None, None
    scale = np.sqrt(S / max(v @ v, 1e-300))
    starts = [scale * v]
    for k in range(nstart - 1):
        z = scale * v + 0.35 * rng.standard_normal(m) * np.sqrt(S / m)
        z = np.sort(z)[::-1]
        z = z - z.mean()
        z = z * np.sqrt(S / (z @ z))
        starts.append(z)
    for x0 in starts:
        r = minimize(f, x0, jac=g, constraints=cons, method='SLSQP',
                     options={'maxiter': 500, 'ftol': 1e-12})
        if not np.isfinite(r.fun):
            continue
        x = r.x
        feas = (abs(x.sum()) < 1e-6 and abs(x @ x - S) < 1e-6
                and (np.cumsum(x)[:-1] - cs).min() > -1e-6
                and (x[:-1] - x[1:]).min() > -1e-6)
        if not feas:
            continue
        val = float(np.sum(x ** 3))
        if best is None or (sense == 'max' and val > best) or \
           (sense == 'min' and val < best):
            best, bx = val, x
    return best, bx


def F(K, nstart=6, seed=0):
    dphi, d = diag_data(K)
    a, _ = _solve(dphi, 1.0, 'max', nstart, seed)
    b, _ = _solve(d, 3.0, 'min', nstart, seed + 1)
    if a is None or b is None:
        return None
    return 1.5 * a - 0.5 * b


def analytic_slope(K, theta0_n):
    """Limiting slope of F(cK) in (2-t) at t=2, derived in REVIEW_r105.md:

        slope = 9/4 (A - B) - 3/4 theta_0(n),

    A = max over the DEGENERATE levels of d_phi and over its gap midpoints,
    B = the same minimum for d.  Singleton levels are excluded: a sorted
    perturbation confined to a singleton level must vanish.
    """
    import numpy as np
    K = K * np.sqrt(2.0 / float(np.sum(K ** 2)))
    dphi, d = diag_data(K)

    def cands(v):
        v = np.sort(v)[::-1]
        out = [L for L in np.unique(np.round(v, 9))
               if np.sum(np.abs(v - L) < 1e-9) >= 2]
        out += [0.5 * (v[j] + v[j + 1]) for j in range(len(v) - 1)
                if v[j] - v[j + 1] > 1e-9]
        return out

    A, B = max(cands(dphi)), min(cands(d))
    return 2.25 * (A - B) - 0.75 * theta0_n, A, B
