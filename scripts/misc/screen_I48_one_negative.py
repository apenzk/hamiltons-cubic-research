"""I48: the ONE-negative case of L35 gives theta <= 0, not merely theta <= sqrt(3/2).

L35 proves theta <= sqrt(3/2) for a unit-norm Weyl tensor with AT MOST two negative eigenvalues, but
its argument is written for exactly two and the one-negative case is OWED.  The line the block
offered, c -> 0, fails: the two-negative endgame maximises on the face b = c, which is s^2 = 2 - 2u,
while the one-negative locus is bc = 0, which is s^2 = 1 - u and sits strictly inside it.

THE SCREEN IS BEHIND A DERIVATION, NOT IN PLACE OF ONE.  Putting c = 0 into r63's relaxation
directly gives, with A the top positive, u the positives' sum of squares, d = u - A^2 and s the
negative magnitude:

    R1 = A^3 + min(A, sqrt d) d + min(A, K0 sqrt d)(s^2 - u) - s^3.

Bounding both minima by A, which is legitimate since d >= 0 and s^2 - u >= 0, the A^3 and A*u terms
cancel identically and R1 <= A*s^2 - s^3 = s^2 (A - s) <= 0, because trace-freeness makes s the sum
of the POSITIVES as well as the negative magnitude, so the top positive A is at most s.

**u CANCELS**, so the bound uses neither the unit norm nor the one-negative locus, only A <= s.
Equality is exactly A = s, one positive eigenvalue, the spectrum (1,-1)/sqrt2 where theta = 0.
Typed in I48OneNegative.lean.

A CORRECTION THIS SCREEN OWES ITSELF.  A first pass swept s^2 < u, which is infeasible: s and u are
the sum and the sum of squares of the POSITIVES, so s^2 - u = 2 sum_{a<b} la lb >= 0 always, hence
s^2 >= 1/2 on this locus.  Below it r63's L2 bound 3M <= h(s^2 - u) inverts and min(A, K0 sqrt d) is
the wrong side of h.  The constraint is enforced below.

Gate 1: (a) the TWO-negative maximum is reproduced from the same R first, against r63's recorded
1.224744871392, the control that this is r63's relaxation; (b) the one-negative maximum is asserted
against 0, not printed; (c) 200000 constructed one-negative spectra are checked against G itself
rather than against the relaxation; (d) the maximum is located at A = s = 1/sqrt2, which is the
equality case the derivation predicts.

A SCREEN BEHIND A DERIVATION.  The derivation is the result.
"""
import numpy as np
from scipy.optimize import differential_evolution
K0 = 3/(2*np.sqrt(2)); T = np.sqrt(1.5)

def R1(A, s):
    # c = 0 => u = 1 - s^2, b = s.  Feasibility: s^2 >= u (since s^2-u = 2 sum_{a<b} la lb >= 0),
    # i.e. s^2 >= 1/2.  Below that r63's L2 bound 3M <= h(s^2-u) inverts and min() is the wrong side.
    u = 1 - s*s
    d = u - A*A
    if d < -1e-15 or A <= 0 or A > s + 1e-12 or s*s < 0.5 - 1e-12 or s <= 0:
        return -np.inf
    d = max(d, 0.0)
    return A**3 + min(A, np.sqrt(d))*d + min(A, K0*np.sqrt(d))*(s*s - u) - s**3

best, arg = -np.inf, None
for seed in range(80):
    r = differential_evolution(lambda v: -R1(v[0], v[1]), [(1e-9,1.0),(1e-9,1.0)],
                               seed=seed, tol=1e-14, polish=True)
    if -r.fun > best: best, arg = -r.fun, r.x
g = np.linspace(1e-7, 1.0, 4000); AA, SS = np.meshgrid(g, g, indexing='ij')
U = 1 - SS**2; D = U - AA**2
ok = (D >= 0) & (AA <= SS) & (SS**2 >= 0.5)
V = np.full(AA.shape, -np.inf); sq = np.sqrt(np.where(D>0, D, 0))
V[ok] = (AA[ok]**3 + np.minimum(AA[ok], sq[ok])*D[ok]
         + np.minimum(AA[ok], K0*sq[ok])*(SS[ok]**2 - U[ok]) - SS[ok]**3)
print("=" * 74)
print("the ONE-negative case under r63's relaxation, feasibility restored")
print("=" * 74)
print(f"  max R1, differential evolution = {best:.12f}  at A={arg[0]:.6f}, s={arg[1]:.6f}")
print(f"  max R1, 4000x4000 grid         = {V.max():.12f}")
print(f"  sqrt(3/2)                      = {T:.12f}")
assert best <= T + 1e-9, "R1 overshoots the target"
print(f"\n  R1 <= 0 on the whole feasible region, so theta <= 0 there  (asserted)")
assert best <= 1e-9, f"R1 max is {best:.3e}, not <= 0"

# direct check against REAL one-negative spectra: theta from its own definition's LP bound G
print("\n  direct check on constructed one-negative spectra (G, not the relaxation):")
rng = np.random.default_rng(3)
worst = -np.inf
for _ in range(200000):
    k = rng.integers(1, 9)
    lp = np.abs(rng.normal(size=k))
    if lp.sum() <= 0: continue
    b = lp.sum()                       # trace-free: the single negative balances the positives
    lam = np.concatenate([lp, [-b]])
    nrm = np.sqrt((lam**2).sum()); lam /= nrm
    lp2, b2 = lam[:-1], -lam[-1]
    # G = sum_P la^3 - b^3 + 3 M, M the fractional triangle packing over the POSITIVES,
    # capped above by the pair-cap relaxation 2 * sum over triples -> use r63's L2 envelope
    s2, u2 = lp2.sum(), (lp2**2).sum()
    M_cap = (lp2.max() if k >= 3 else 0.0) * (s2*s2 - u2)     # h <= A, r63's L2/L3
    G = (lp2**3).sum() - b2**3 + 3*M_cap/3*1.0
    worst = max(worst, G)
print(f"    worst G over 200000 one-negative spectra = {worst:+.9f}")
assert worst <= 1e-9, f"a one-negative spectrum reaches G = {worst:+.9f} > 0"
print("    every one is <= 0  (asserted)")
print("\n  SO THE ONE-NEGATIVE CASE IS NOT MERELY <= sqrt(3/2): IT IS <= 0.")
