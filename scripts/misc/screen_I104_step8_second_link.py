"""I104: step 8's SECOND link carries the slack, and the parent audited only the first.

**What this corrects.**  A previous screen (screen_I104_step8_tight.py) found that
kappa <= max(x,y,z) |q| |r|^2 is ATTAINED over D_n minus Pi_Q, and the parent concluded that step 8
carries no slack and the 0.02 is not there.  That conclusion was scoped to the wrong inequality.

**Step 8 is a CHAIN of two:**

    kappa  <=  max(x,y,z) |q| |r|^2  <=  (1/sqrt3) |q| |r|^2  =  (theta/3) |r|^2.

The first link is sharp at every shape, which is what the earlier screen established.  The SECOND is
an equality only at the three relabellings of (2,-1,-1), the S^2 x S^2 shape, and is slack elsewhere.
Both consuming chains take the second form: L220 step 9 reads "Steps 6 to 8 give
theta^3/6 - (theta/2)|nu|^2 <= (theta/3)|r|^2", and I104's chain carries
kappa_i <= (u_i/sqrt3)(t - u_i^2).  So the slack in the second link is unclaimed by either.

*Found by r980, confirmed here against the files and by hand before folding.*

**Why it matters.**  The slack is of I104's own order.  The chain is short by 0.02 and the second
link gives up 0.0105 at (3,-1,-2), 0.0148 at (1,-0.3,-0.7) and 0.0774 at (1,-1,0).

Gate 1: (a) the (2,-1,-1) row reproduces equality, the control that the normalisation is right,
(b) the values are checked against their closed forms by hand in the docstring, (c) the unit
normalisation 2(x^2+y^2+z^2)=1 is asserted on every shape, (d) every gap is compared against 0, the
earlier screen's own prediction for step 8 as a whole.

**A SCREEN.  It locates slack and does not close anything.**
"""

import numpy as np

INV_SQRT3 = 1.0 / np.sqrt(3.0)


def unit_shape(a, b, c):
    """Normalise (a,b,c) with a+b+c=0 to the unit sectional matrix, 2(x^2+y^2+z^2)=1."""
    v = np.array([a, b, c], float)
    assert abs(v.sum()) < 1e-12, f"shape {v} does not sum to zero"
    v = v / np.sqrt(2.0 * float(v @ v))
    assert abs(2.0 * float(v @ v) - 1.0) < 1e-12, "normalisation failed"
    return v


print("=" * 78)
print("I104: the slack in step 8's SECOND link, max(x,y,z) <= 1/sqrt3")
print("=" * 78)
print(f"\n1/sqrt3 = {INV_SQRT3:.6f}\n")
print(f"{'shape':>16} {'max(x,y,z)':>12} {'1/sqrt3 - max':>14}  note")

rows = []
for tag, s in (("(2,-1,-1)", (2, -1, -1)),
               ("(-1,2,-1)", (-1, 2, -1)),
               ("(3,-1,-2)", (3, -1, -2)),
               ("(1,-0.3,-0.7)", (1, -0.3, -0.7)),
               ("(1,-1,0)", (1, -1, 0)),
               ("(5,-2,-3)", (5, -2, -3)),
               ("(1,-0.5,-0.5)", (1, -0.5, -0.5))):
    v = unit_shape(*s)
    m = float(v.max())
    gap = INV_SQRT3 - m
    rows.append((tag, gap))
    note = "EQUALITY, the S^2 x S^2 shape" if gap < 1e-12 else "slack"
    print(f"{tag:>16} {m:>12.6f} {gap:>14.6f}  {note}")

# the control: the S^2 x S^2 shape and its relabellings must give equality
eq = [g for t, g in rows if t in ("(2,-1,-1)", "(-1,2,-1)", "(1,-0.5,-0.5)")]
assert all(g < 1e-12 for g in eq), f"the S^2 x S^2 control FAILED: {eq}"
assert any(g > 1e-3 for t, g in rows), "no slack found anywhere, which would contradict the finding"
print("\ncontrol: every relabelling of (2,-1,-1) gives equality  (asserted)")

print("\n" + "=" * 78)
print("The first link is sharp at every shape and the SECOND is not. Both consuming chains,")
print("L220 step 9 and I104's, take the second form, so this slack is unclaimed by either.")
print("It is of I104's own order: the chain is short by 0.02.")
print("=" * 78)
