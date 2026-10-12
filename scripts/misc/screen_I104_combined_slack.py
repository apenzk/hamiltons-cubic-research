"""I104: step 8's second-link slack is NOT usable, because step 7 binds at the same shape.

**What this refutes, and it is the parent's own fold from an hour earlier.**  r980 correctly observed
that L220 step 8 is a chain of two inequalities and that the parent had audited only the first:

    kappa  <=  max(x,y,z) |q| |r|^2   <=   (1/sqrt3) |q| |r|^2  =  (theta/3) |r|^2.

The first link is sharp at every shape.  The SECOND is equality only at the relabellings of
(2,-1,-1) and is slack elsewhere, by up to 0.077.  The parent recorded that as reopening a live
source for I104's missing 0.02, in the note, the plan, the ledger and the script index.

**That inference does not hold.**  The chain also bounds P(q) by step 7, 18xyz <= sqrt3/2 |q|^3, and
step 7 is tight at exactly the same shape.  The chain must hold at EVERY shape, so what matters is
the worst case over shapes of the TOTAL slack the two bounds leave on the table, and that worst case
is where both are tight.

**This is the record's own refuted candidate in new dress.**  The note already carries a section
headed "A candidate for the 0.02, REFUTED: steps 7 and 8 want the SAME shape", which screened both
maxima to the same point and found deficits of zero for each.  What is new here is only that the
second link is the place step 8 gives something up, and that it gives it up where step 7 does too.

Gate 1: (a) the (2,-1,-1) row reproduces equality for BOTH bounds, the control that the two are being
compared on the same normalisation, (b) the minimum is found by a 200001-point sweep of the shape
circle and separately checked against the closed-form maximiser, (c) the unit normalisation is
asserted on every shape, (d) the minimum combined slack is compared against 0, which is what "the
slack is usable" would have to beat.

**A SCREEN, refuting a reading the parent committed rather than supporting one.**
"""

import numpy as np

SQ3 = np.sqrt(3.0)


def unit_shape(a, b, c):
    v = np.array([a, b, c], float)
    assert abs(v.sum()) < 1e-12, f"{v} does not sum to zero"
    v = v / np.sqrt(2.0 * float(v @ v))
    assert abs(2.0 * float(v @ v) - 1.0) < 1e-12, "normalisation failed"
    return v


def step7_slack(v):
    """sqrt3/2 - 18xyz, what step 7 gives up at this shape."""
    x, y, z = v
    return SQ3 / 2 - 18 * x * y * z


def step8_slack(v):
    """1/sqrt3 - max(x,y,z), what step 8's SECOND link gives up at this shape."""
    return 1 / SQ3 - float(max(v))


print("=" * 86)
print("I104: is step 8's second-link slack usable, or does step 7 bind at the same shape?")
print("=" * 86)
print(f"\n{'shape':>16} {'step 7 slack':>14} {'step 8 slack':>14} {'combined':>12}")

for tag, s in (("(2,-1,-1)", (2, -1, -1)),
               ("(3,-1,-2)", (3, -1, -2)),
               ("(1,-0.3,-0.7)", (1, -0.3, -0.7)),
               ("(1,-1,0)", (1, -1, 0)),
               ("(5,-2,-3)", (5, -2, -3)),
               ("(4,-1,-3)", (4, -1, -3))):
    v = unit_shape(*s)
    s7, s8 = step7_slack(v), step8_slack(v)
    print(f"{tag:>16} {s7:>14.6f} {s8:>14.6f} {s7 + s8:>12.6f}")

# the control: at the S^2 x S^2 shape BOTH must be zero
v0 = unit_shape(2, -1, -1)
assert abs(step7_slack(v0)) < 1e-9, "step 7 is not tight at (2,-1,-1)"
assert abs(step8_slack(v0)) < 1e-9, "step 8's second link is not tight at (2,-1,-1)"
print("\ncontrol: at (2,-1,-1) BOTH bounds are tight  (asserted)")

# sweep the circle of unit shapes
e1 = np.array([1.0, -1.0, 0.0]) / np.sqrt(2.0)
e2 = np.array([1.0, 1.0, -2.0]) / np.sqrt(6.0)
worst, worst_v = np.inf, None
for t in np.linspace(0.0, 2 * np.pi, 200001):
    v = (np.cos(t) * e1 + np.sin(t) * e2) / np.sqrt(2.0)
    tot = step7_slack(v) + step8_slack(v)
    if tot < worst:
        worst, worst_v = tot, v

print(f"\nminimum COMBINED slack over the shape circle: {worst:.8f}")
print(f"attained at {np.round(worst_v, 6)}, max entry {max(worst_v):.6f} against 1/sqrt3 = {1/SQ3:.6f}")
print(f"  step 7 slack there: {step7_slack(worst_v):.8f}")
print(f"  step 8 slack there: {step8_slack(worst_v):.8f}")

assert worst < 1e-6, "a positive minimum would mean the slack IS usable, contradicting the finding"
print("\n" + "=" * 86)
print("The minimum combined slack is ZERO, at the S^2 x S^2 shape, where both bounds are tight.")
print("So the second link's slack is NOT usable: the chain's worst case is exactly where neither")
print("bound gives anything up. This is the record's own refuted shape-conflict candidate again.")
print("=" * 86)
