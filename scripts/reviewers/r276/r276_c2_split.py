"""r276 Claim 2: does fence post 11's split floor apply to the JOINT quantity too?

Post 11 bounds theta by splitting: sup tr(W^3) <= 1 and sup <W,W#> -> sqrt2, floor 1+sqrt2.
The same split applied to F = tr(M^3) + ||M#||_F gives sup F <= sup tr(M^3) + sup ||M#||_F.
Measure the two suprema separately.
"""
import sys; sys.path.insert(0, 'scripts/reviewers/r276')
import numpy as np
from scipy.optimize import minimize
from r276_core import Geom, theta0, padded_cp2, sphere_product
from r276_c3_opt import grad_sharpnorm2

def obj(x, g, N, which):
    A = g.proj_weyl(x.reshape(N, N)); r = np.linalg.norm(A); M = A / r
    if which == 'sharp':
        S = g.sharp(M); nS = np.linalg.norm(S)
        val = nS; gM = grad_sharpnorm2(g, M, S) / (2.0 * nS)
    else:
        val = float(np.trace(M @ M @ M)); gM = 3.0 * (M @ M)
    gM = 0.5 * (gM + gM.T)
    gx = g.proj_weyl((gM - np.sum(gM * M) * M) / r)
    return -val, -(0.5 * (gx + gx.T)).ravel()

print(f"{'n':>3} {'sup ||M#||_F':>14} {'sup tr(M^3)':>13} {'split bound':>12} {'sqrt3':>8} {'sup F (r276)':>13}")
supF = {6: 1.412822, 8: 1.420489, 10: 1.425703, 12: 1.429351, 14: 1.432024}
for n in (6, 8, 10, 12):
    g = Geom(n); N = g.N; rng = np.random.default_rng(900 + n)
    out = {}
    for which in ('sharp', 'tr'):
        best = -9
        seeds = [padded_cp2(g), sphere_product(g)]
        for _ in range(40 if n <= 10 else 25):
            A = rng.standard_normal((N, N)); seeds.append(0.5 * (A + A.T))
        for X0 in seeds:
            res = minimize(obj, np.asarray(X0).ravel(), args=(g, N, which), jac=True,
                           method='L-BFGS-B', options=dict(maxiter=700, ftol=1e-16, gtol=1e-12))
            best = max(best, -res.fun)
        out[which] = best
    print(f"{n:>3} {out['sharp']:14.6f} {out['tr']:13.6f} {out['sharp']+out['tr']:12.6f}"
          f" {np.sqrt(3):8.6f} {supF[n]:13.6f}")
