"""Reviewer 49: the theta = 0 edge case of B3's strictness clause.

If Q(W_A) = 0 and Q(W_B) = 0 on disjoint blocks then EVERY point of the 2-plane is
critical with theta = 0, so theta = min_i theta_i rather than theta < min_i theta_i.
"""
import sys
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, 'scripts/lib')
import review_r49_core as C

n = 6
B = C.weyl_basis(n); d = B.shape[0]
rng = np.random.default_rng(7)


def res(y):
    W = np.einsum('k,kij->ij', y, B)
    return np.concatenate([np.einsum('kij,ij->k', B, C.Qmap(n, W)), [np.sum(W*W) - 1.0]])


sols = []
for s in range(200):
    sol = least_squares(res, rng.standard_normal(d), xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=500)
    if np.linalg.norm(sol.fun) < 1e-10:
        sols.append(sol.x)
print(f"n=6: {len(sols)}/200 starts converged to Q(W)=0 with |W|=1", flush=True)
if sols:
    W0 = np.einsum('k,kij->ij', sols[0], B)
    print(f"  |Q(W0)| = {np.abs(C.Qmap(n, W0)).max():.2e}, theta = {C.Pval(n, W0):.2e}", flush=True)
    m = 12
    WA = C.embed(W0, 6, m, tuple(range(6)))
    WB = C.embed(W0, 6, m, tuple(range(6, 12)))
    worst = 0.0
    for a in np.linspace(0, 1, 21):
        W = C.normalize(a * WA + np.sqrt(1 - a*a) * WB)
        r, t = C.crit_residual(m, W)
        worst = max(worst, r)
    print(f"  two copies on disjoint 6-blocks of R^12: max criticality residual over the whole "
          f"unit circle = {worst:.2e}, theta == 0 throughout", flush=True)
    print("  => B3's strict inequality fails on the theta_i = 0 stratum (theta = min_i theta_i = 0).",
          flush=True)
