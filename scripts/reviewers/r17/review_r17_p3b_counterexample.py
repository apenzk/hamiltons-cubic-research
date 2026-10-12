"""Reviewer 17: a counterexample fed straight into p3b's OWN obstruction formula.

p3b tests |Pi_ker Q(v)|/|Q(v)| on the 9 columns of its transverse-kernel basis T
and reports 9/9 nonzero.  The obstruction is quadratic in v, so this says nothing
about other v in span(T).  Below, p3b's own kernel_and_orbit/T/Pk are used and a
unit v in span(T) is exhibited on which p3b's own expression returns ~1e-15.
"""
import numpy as np
from scipy.optimize import minimize

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from review_r11_graded_law import weyl_sphere_product_mop
from p3b_obstruction_and_path import setup, kernel_and_orbit

c, L2, alt, Eflat, D = setup(6)
W = weyl_sphere_product_mop(L2, 3, 3)
W = W / np.linalg.norm(W)
Nl = W.shape[0]
th, B, ker, T, orb = kernel_and_orbit(W, 6, c, Eflat, D)
Pk = ker @ ker.T
print(f"p3b's own numbers: theta={th:.9f} ker={ker.shape[1]} orbit={orb} transverse={T.shape[1]}")


def p3b_obs(coef):
    """p3b's expression, for v = T @ coef (its own code, lines 121-127)."""
    v = T @ (coef / np.linalg.norm(coef))
    Vm = (Eflat.T @ (B @ v)).reshape(Nl, Nl)
    Vm = 0.5 * (Vm + Vm.T)
    qv = Q_full(Vm, c)
    y = B.T @ (Eflat @ qv.reshape(-1))
    return np.linalg.norm(Pk @ y) / max(np.linalg.norm(y), 1e-300), np.linalg.norm(Pk @ y)


m = T.shape[1]
print("\np3b's reported test, its own basis vectors:")
print("  " + "  ".join(f"{p3b_obs(np.eye(m)[a])[0]:.3f}" for a in range(m)))

rng = np.random.default_rng(0)
best = (np.inf, None)
for _ in range(400):
    r = minimize(lambda z: p3b_obs(z)[1] ** 2, rng.standard_normal(m),
                 method="Nelder-Mead", options=dict(maxiter=20000, maxfev=20000,
                                                    xatol=1e-14, fatol=1e-20))
    val = p3b_obs(r.x)[0]
    if val < best[0]:
        best = (val, r.x / np.linalg.norm(r.x))
print(f"\nminimum of p3b's OWN obstruction over unit v in span(T): {best[0]:.3e}")
np.set_printoptions(precision=6, suppress=False)
print("attained at coefficient vector (in p3b's transverse basis):")
print(best[1])
rel, absv = p3b_obs(best[1])
print(f"check: |Pi_ker Q(v)|/|Q(v)| = {rel:.3e},  |Pi_ker Q(v)| = {absv:.3e}")
np.save("scratchpad/r17_zero_dir.npy", best[1])
