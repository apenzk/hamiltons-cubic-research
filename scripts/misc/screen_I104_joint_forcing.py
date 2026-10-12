"""I104: the joint Gram system FORCES sum x_i^2 >= 0.1167 at the failing configuration.

**What this quantifies.**  The note records two live sources for I104's missing 0.02.  One, the
coupling bound's shape slack, is now closed twice over.  The other, "the x-dependence of the joint
system", the note flagged as not yet quantified.  This quantifies it.

**The system, quoted from the note and verified here before use.**  With q_a = alpha_a e_a + beta_a
f_a, u_a^2 = alpha_a^2 + beta_a^2 and G_e^{-1} = (3/2)I - (3/10)J, minimality of the e-part gives

    t  >=  sum beta_a^2 + (3/2) sum alpha_a^2 - (3/10) (sum alpha_a)^2,

equivalently, under alpha_i = sqrt3 x_i,

    sum u_i^2  <=  t - (3/2) sum x_i^2 + (9/10) (sum x_i)^2.

*The equivalence is checked by hand and asserted here over 200000 draws, because it is load-bearing
and is a restatement rather than the original.*

**What it forces.**  At the recorded failing configuration t = 0.598, u_a = 0.496, so sum u_a^2 =
0.738048.  The x-FREE part of the joint system reads sum u^2 <= t = 0.598, which is VIOLATED by
0.140048, so the x-dependent terms must make up exactly that.  Cauchy-Schwarz gives S1^2 <= 3 S2, so
(9/10)S1^2 - (3/2)S2 <= 1.2 S2, and therefore S2 = sum x_i^2 >= 0.140048/1.2 = 0.116707, with
equality only when all x_i are equal.  **The scalar corollary sum u^2 <= (5/3)t throws that away**:
it is slack by 0.2586 there and says nothing about x at all.

**WHAT THIS DOES NOT DO.**  It does not close the 0.02.  Closing it needs the link from x to the
coupling bound kappa_i, which is NOT established here and is the item's remaining work.

**A NAMING TRAP, recorded so it is not walked into.**  These x_i are the SHARED-CHANNEL coefficients
of the Gram system.  They are NOT L220's sectional shape (x,y,z).  Same letter, different object, and
the record's own rule is to search by the object rather than by the vocabulary.

Gate 1: (a) the note's two forms of the system are asserted to agree over 200000 draws, the control
that the restatement is faithful, (b) the forced bound is reached twice, in closed form and by
constrained minimisation, and the two are asserted equal, (c) the configuration is the one already
recorded rather than a new one, (d) the forced S2 is compared against 0, which is what "the scalar
corollary loses nothing" would require.

**A SCREEN.  It quantifies a constraint and closes nothing.**
"""

import numpy as np
from scipy.optimize import minimize

rng = np.random.default_rng(17)

print("=" * 84)
print("I104: what the joint Gram system forces at the failing configuration")
print("=" * 84)

# (a) control: the note's two forms must agree
worst = 0.0
for _ in range(200000):
    alpha = rng.standard_normal(3)
    beta = rng.standard_normal(3)
    u2 = alpha ** 2 + beta ** 2
    lhs = float(np.sum(beta ** 2) + 1.5 * np.sum(alpha ** 2) - 0.3 * np.sum(alpha) ** 2)
    x = alpha / np.sqrt(3.0)
    rhs = float(np.sum(u2) + 1.5 * np.sum(x ** 2) - 0.9 * np.sum(x) ** 2)
    worst = max(worst, abs(lhs - rhs))
assert worst < 1e-9, f"the note's two forms of the joint system DISAGREE by {worst:.2e}"
print(f"\ncontrol: the note's two forms agree to {worst:.2e} over 200000 draws  (asserted)")

T, U = 0.598, 0.496
SU2 = 3 * U * U
print(f"\nfailing configuration: t = {T}, u_a = {U}, sum u_a^2 = {SU2:.6f}")
print(f"  scalar corollary    : sum u^2 <= (5/3)t = {5/3*T:.6f}, slack {5/3*T - SU2:.6f}")
print(f"  joint, x-free part  : sum u^2 <= t      = {T:.6f}, VIOLATED by {SU2 - T:.6f}")

need = SU2 - T
closed = need / 1.2
print(f"\nrequired: (9/10)S1^2 - (3/2)S2 >= {need:.6f}")
print(f"Cauchy-Schwarz S1^2 <= 3 S2 gives (9/10)S1^2 - (3/2)S2 <= 1.2 S2")
print(f"so S2 = sum x_i^2 >= {closed:.6f}, equality only when all x_i are equal")

# (b) the same bound a second way, by constrained minimisation
best = np.inf
for _ in range(400):
    x0 = rng.standard_normal(3) * 0.5
    r = minimize(lambda x: float(np.sum(x ** 2)), x0, method="SLSQP",
                 constraints=[{"type": "ineq",
                               "fun": lambda x: 0.9 * np.sum(x) ** 2 - 1.5 * np.sum(x ** 2) - need}])
    if r.success and 0.9 * np.sum(r.x) ** 2 - 1.5 * np.sum(r.x ** 2) - need > -1e-9:
        best = min(best, float(np.sum(r.x ** 2)))
print(f"\ndirect minimisation of S2 subject to the system: {best:.6f}")
assert abs(best - closed) < 1e-4, "the closed form and the optimiser disagree"
assert closed > 1e-6, "a zero forced bound would mean the scalar corollary loses nothing"
print("closed form and optimiser agree, and the forced bound is bounded away from 0  (asserted)")

print("\n" + "=" * 84)
print("The joint system forces sum x_i^2 >= 0.1167 where the scalar corollary says nothing.")
print("It does NOT close the 0.02: that needs the link from x to kappa_i, which is not")
print("established. These x_i are the shared-channel coefficients, NOT L220's shape (x,y,z).")
print("=" * 84)
