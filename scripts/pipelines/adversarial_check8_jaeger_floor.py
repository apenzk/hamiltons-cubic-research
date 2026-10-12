"""
INDEPENDENT audit of the one number the n=12 claim rests on:

    at n=12, does  tr S^4 = E(12)  force  (tr S^3)^2 >= 0.09933 ?

Deliberately NOT the implementation under review.  That one enumerated spectra
by integer multiplicities (k_i copies of a value a_i) on a grid.  This one works
with the pushforward measure instead:

    mu = sum_i lam_i^2 * delta_{lam_i}   -- a PROBABILITY measure on (0,1], since
                                            sum lam_i^2 = ||S||^2 = 1.
    tr S^3 = E[lam],  tr S^4 = E[lam^2],  #nonzero eigenvalues = E[lam^-2] <= n.

so the question becomes a 3-constraint moment problem in continuous masses,
solved by SLSQP rather than by sweeping.  Allowing arbitrary real masses (rather
than the achievable ones, which are integer multiples of a_i^2) RELAXES the
feasible set, so this returns a LOWER bound on the true floor -- conservative in
exactly the direction that matters.
"""
import numpy as np
from scipy.optimize import minimize

def E(n):
    return (8.0*n**2-41.0*n+49.0)/(4.0*(n+1.0)*(n-2.0)*(n-3.0))

def floor_p3(n, v, natoms, restarts=4000, seed=1):
    """min E[lam] over probability measures with E[lam^2]=v, E[lam^-2]<=n."""
    rng = np.random.default_rng(seed)
    best, arg = np.inf, None
    for _ in range(restarts):
        a0 = np.sort(rng.uniform(0.05, 1.0, natoms))
        m0 = rng.dirichlet(np.ones(natoms))
        z0 = np.concatenate([m0, a0])
        cons = [
            {"type": "eq",   "fun": lambda z: z[:natoms].sum() - 1.0},
            {"type": "eq",   "fun": lambda z: (z[:natoms]*z[natoms:]**2).sum() - v},
            {"type": "ineq", "fun": lambda z: n - (z[:natoms]/z[natoms:]**2).sum()},
        ]
        bnds = [(0.0, 1.0)]*natoms + [(1e-3, 1.0)]*natoms
        r = minimize(lambda z: (z[:natoms]*z[natoms:]).sum(), z0, method="SLSQP",
                     bounds=bnds, constraints=cons,
                     options=dict(maxiter=500, ftol=1e-14))
        if not r.success:
            continue
        z = r.x; m, a = z[:natoms], z[natoms:]
        if (abs(m.sum()-1) < 1e-8 and abs((m*a**2).sum()-v) < 1e-8
                and (m/a**2).sum() <= n + 1e-7 and (m >= -1e-9).all()):
            if r.fun < best:
                best, arg = r.fun, (m.copy(), a.copy())
    return best, arg

print("independent audit -- moment-measure formulation, SLSQP, continuous masses")
print("(relaxation of the achievable set, so this LOWER-bounds the true floor)\n")
print(f"{'n':>4} {'atoms':>6} {'min (tr S^3)^2':>16} {'needed':>10} {'Jaeger 1/n':>11}   verdict")
print("-"*74)
need = {12: 0.09933, 13: 0.065183, 14: None}
for n in (12, 13, 14):
    v = E(n)
    row_best = np.inf
    for k in (2, 3):
        b, arg = floor_p3(n, v, k)
        row_best = min(row_best, b)
    y = row_best**2
    nd = need[n]
    verdict = ("CLEARS (n=14 needs nothing: already <0 at 1/n)" if nd is None
               else ("CLEARS by %.0f%%" % (100*(y/nd - 1)) if y > nd else "FAILS"))
    print(f"{n:>4} {'2,3':>6} {y:>16.6f} {(('%.6f'%nd) if nd else '--'):>10} "
          f"{1.0/n:>11.6f}   {verdict}")

print("\ncompare: the implementation under review reported 0.127058 (3-atom grid)")
print("         and 0.127118 (2-atom, tolerance-matched) at n=12.")
