"""Claim 3, the gauge check: are the projected-back points ON the O(n)-orbit
of padded W_CP2?  (Standing rule: distance to a point is not distance to its orbit.)"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r112'))
import r112_core as K
import r112_claim3 as C3
from scipy.linalg import expm
from scipy.optimize import minimize

rng = np.random.default_rng(4242)
n = 6
W0 = K.cp2(n); x0 = K.coords(n, W0)
Bs = K.weyl_basis(n)
OT = K.orbit_tangent(n, W0); u, s, _ = np.linalg.svd(OT, full_matrices=False)
orb = u[:, s > 1e-9 * s[0]]
tri = [(i, j) for i in range(n) for j in range(i + 1, n)]

def mk(p):
    X = np.zeros((n, n))
    for t, (i, j) in enumerate(tri):
        X[i, j] = p[t]; X[j, i] = -p[t]
    return expm(X)

def orbdist(M):
    def f(p):
        g = K.lam2(mk(p))
        return float(np.linalg.norm(g @ M @ g.T - W0))
    best = f(np.zeros(len(tri)))
    for t in range(6):
        p0 = np.zeros(len(tri)) if t == 0 else 0.4 * rng.standard_normal(len(tri))
        r = minimize(f, p0, method='Powell',
                     options=dict(maxiter=60000, maxfev=60000, xtol=1e-12, ftol=1e-14))
        best = min(best, r.fun)
    return best

print(f"n={n} padded W_CP2: raw ||W'-W0|| vs gauge-fixed min_g ||gW'g^T - W0||")
for eps in (1e-2, 5e-2, 1e-1):
    for k in range(3):
        d = rng.standard_normal(Bs.shape[0]); d /= np.linalg.norm(d)
        x, res, th, M = C3.project_back(n, x0 + eps * d, orb)
        print(f"  eps={eps:.0e} #{k}: res={res:.1e} theta={th:.10f} "
              f"S_mmm={K.slack_mmm(n, M):.2e} raw={np.linalg.norm(x - x0):.5f} "
              f"orbit_dist={orbdist(M):.3e}")
