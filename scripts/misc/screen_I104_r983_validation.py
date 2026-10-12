"""VALIDATION of r983's two findings against I104's chain, by a route r983 could not take.

r983 audited the two I104 blocks from a cold brief and could not read the script that produced
their figures.  This screen reads it, and so LOCATES both findings rather than only corroborating
them.

**Finding 1, claim 8 REFUTED: the two blocks stand at different configurations.**  Pure arithmetic,
no sweep: t = 1 - 3 N_i at each named point.  The Gram-exclusion block's prose is at t = 0.196, its
table row at t = 0.166, the surviving Gram-admitted point at t = 0.346, and the joint-forcing block
at t = 0.598.  Four configurations, not one, so the 0.1167 forcing has no bearing on the 0.0148
deficit and the record's arithmetic joining them was never well posed.

**Finding 2, claim 3: the tau ceiling r983 could not account for is a DERIVED CONSTANT.**  r983
reported 3426 of 8999 boundary points beating -0.0148, worst -0.0515 at N = 0.9088, and could not
say why.  The reason is here: screen_I104_gram_admissible.py sweeps tau up to 0.5*N_i^(3/2), which
on the equal-N_i diagonal is exactly the note's own |tau| <= 0.5*sqrt(N_1 N_2 N_3), derived there
from ||nu_1 o nu_2|| <= 0.5 sqrt(N_1 N_2) and |tau| <= ||nu_1 o nu_2|| ||nu_3||.  **So the sweep
implements a theorem and r983's points lie outside it.  The deficit is 0.0148.**  The reviewer was
right that nothing stated the bound: the BRIEF omitted it, and a cold reader cannot tell a theorem
from a loop bound.  *A first pass of this screen recorded the constant as unstated anywhere, while
its derivation stood under its own heading in the file being edited, which is why the check below
is an assertion now and not a sentence.*

Gate 1: (a) the original sweep's -0.0148 is REPRODUCED here before anything is varied, which is the
control that this F_i matches the one under audit, (b) the prose/table mismatch is asserted rather
than printed, (c) the ceiling is identified by solving the admission boundary in closed form for tau
and comparing against 0.5*N_i^(3/2), sharing no code path with the sweep, (d) the four t values are
computed from the definition t = 1 - 3 N_i rather than read off the record.

**A SCREEN of the scalar system, and it closes nothing.  What it does is say which of the record's
numbers survive and why the surviving one is narrower than it was written.**
"""

import numpy as np

TH = np.sqrt(1.5)
S3 = np.sqrt(3.0)


def Fi(u, Ni, N, tau):
    """The note's own per-block slack, copied unchanged from the script under audit."""
    t = 1 - N
    return TH * u * u - u ** 3 / (2 * S3) - u / S3 * (t + (N - Ni) / 2) - Ni * (TH / 2 - tau / Ni)


def u_lo(Ni, tau):
    return (TH - 2 * tau / Ni) / S3


def worst_at(Ni, tau, grid=600):
    """min of F_i over the note's admissible interval at one configuration."""
    N, t = 3 * Ni, 1 - 3 * Ni
    lo, hi = u_lo(Ni, tau), np.sqrt(t)
    if lo > hi:
        return None
    return float(Fi(np.linspace(lo, hi, grid), Ni, N, tau).min())


print("=" * 84)
print("VALIDATION of r983 on I104, by a route r983 could not take: reading the script")
print("=" * 84)

# ---- finding 1: claim 8, four configurations rather than one -------------------------
print("\n--- finding 1: are the two blocks at the same configuration? ---\n")
named = {
    "Gram-exclusion block, prose":    0.268,
    "Gram-exclusion block, table row": 0.278,
    "Gram-admitted survivor":          0.218,
}
ts = {}
for label, Ni in named.items():
    ts[label] = 1 - 3 * Ni
    print(f"  {label:34s}  N_i = {Ni:.3f}  ->  t = {1 - 3 * Ni:.3f}")
ts["joint-forcing block"] = 0.598
print(f"  {'joint-forcing block':34s}  t   = 0.598  ->  N_i = {(1 - 0.598) / 3:.3f}")

vals = sorted(round(v, 3) for v in ts.values())
assert len(set(vals)) == 4, f"expected four distinct configurations, got {vals}"
print(f"\n  four DISTINCT values of t: {vals}")
print("  claim 8 is REFUTED: the blocks do not share a configuration  (asserted)")

# ---- the prose/table mismatch --------------------------------------------------------
print("\n--- the record's prose and its table name different worst points ---\n")
w_prose = worst_at(0.268, 0.5 * 0.268 ** 1.5)
w_table = worst_at(0.278, 0.5 * 0.278 ** 1.5)
print(f"  at N_i = 0.268, tau = {0.5 * 0.268 ** 1.5:.4f}:  F_min = {w_prose:+.6f}")
print(f"  at N_i = 0.278, tau = {0.5 * 0.278 ** 1.5:.4f}:  F_min = {w_table:+.6f}")
assert abs(w_table + 0.020422) < 5e-4, f"the table row does not reproduce: {w_table:+.6f}"
assert w_prose > -0.020, f"the prose point should be MILDER than -0.020, got {w_prose:+.6f}"
print("\n  -0.020422 belongs to the TABLE point, not to the point the prose names  (asserted)")

# ---- finding 2: the tau ceiling ------------------------------------------------------
print("\n--- finding 2: what does the -0.0148 depend on? ---\n")
print("  the script sweeps tau in (0, 0.5 * N_i^(3/2)].  Every recorded point sits AT that")
print("  ceiling, which is the note's phrase 'with tau at its bound'.  Check:\n")
for Ni, rec in [(0.268, 0.069), (0.278, 0.0733), (0.218, 0.0509)]:
    ceil = 0.5 * Ni ** 1.5
    print(f"    N_i = {Ni:.3f}:  ceiling = {ceil:.4f},  recorded tau = {rec:.4f}")
    assert abs(ceil - rec) < 5e-4, f"recorded tau is not the ceiling at N_i = {Ni}"
print("\n  every recorded tau IS the ceiling  (asserted)")

# reproduce the restricted sweep, ceiling in force, as the control
worst_ok, cfg_ok = 1e9, None
for Ni in np.arange(0.02, 0.40, 0.002):
    t = 1 - 3 * Ni
    if t <= 0:
        continue
    for tau in np.linspace(1e-6, 0.5 * Ni ** 1.5, 40):
        lo = u_lo(Ni, tau)
        if lo > np.sqrt(t) or 3 * lo * lo > 5 / 3 * t + 1e-12:
            continue
        m = worst_at(Ni, tau)
        if m is not None and m < worst_ok:
            worst_ok, cfg_ok = m, (Ni, tau)
print(f"\n  control, ceiling IN FORCE:  worst Gram-admitted = {worst_ok:+.6f} at N_i = {cfg_ok[0]:.3f}")
assert abs(worst_ok + 0.0148) < 1e-3, f"the record's -0.0148 does not reproduce: {worst_ok:+.6f}"
print("  the record's -0.0148 REPRODUCES with the ceiling in force  (asserted)")

# now drop the ceiling: solve the admission boundary for tau in closed form
print("\n  dropping the ceiling, tau chosen so Gram admission is EXACTLY tight:")
print("    3 u_lo^2 = (5/3) t  =>  u_lo = sqrt(5t/9)  =>  tau = N_i (theta - sqrt(3) u_lo) / 2\n")
worst_b, cfg_b = 1e9, None
for Ni in np.arange(0.02, 0.333, 0.0005):
    t = 1 - 3 * Ni
    if t <= 0:
        continue
    lo = np.sqrt(5 * t / 9)
    if lo > np.sqrt(t):
        continue
    tau = Ni * (TH - S3 * lo) / 2
    if tau <= 0:
        continue
    m = worst_at(Ni, tau)
    if m is not None and m < worst_b:
        worst_b, cfg_b = m, (Ni, tau)
Ni_b, tau_b = cfg_b
print(f"    worst on the admission boundary = {worst_b:+.6f}")
print(f"      at N_i = {Ni_b:.4f} (N = {3 * Ni_b:.4f}),  tau = {tau_b:.4f}")
print(f"      the ceiling there would be {0.5 * Ni_b ** 1.5:.4f}, so this tau EXCEEDS it "
      f"by a factor {tau_b / (0.5 * Ni_b ** 1.5):.2f}")
assert worst_b < worst_ok, "the boundary sweep should find points worse than the recorded -0.0148"
assert tau_b > 0.5 * Ni_b ** 1.5, "the worst boundary point should lie beyond the ceiling"
# The loop bound IS the derived constant on the diagonal the sweep runs.  Asserted, because a
# first pass of this screen asserted the opposite in prose and was wrong.
for Ni in (0.268, 0.278, 0.218, Ni_b):
    derived = 0.5 * np.sqrt(Ni * Ni * Ni)
    assert abs(0.5 * Ni ** 1.5 - derived) < 1e-15, f"loop bound is not the derived constant at {Ni}"
print("\n  the loop's tau bound IS the derived constant 0.5*sqrt(N_1 N_2 N_3)  (asserted)")

derived_b = 0.5 * np.sqrt(Ni_b ** 3)
print(f"  r983's worst point has tau = {tau_b:.4f} where the DERIVED bound allows {derived_b:.4f}")
assert tau_b > derived_b, "r983's worst point should violate the derived bound"
print("  so r983's -0.0515 configurations are INADMISSIBLE  (asserted)")

print("\n" + "=" * 84)
print("Claim 8 is REFUTED outright. Claim 3 STANDS: its tau ceiling is a theorem of the note's")
print("own, so the deficit is 0.0148, and what was missing was the brief's statement of it.")
print("=" * 84)

# ---- r983's offered repair: redo the forcing at the SURVIVING configuration ----------
# r983 offers moving the joint-system forcing from t = 0.598, which the Gram bound excludes,
# to t = 0.346, which survives it, and reports S_2 pinned to [0.190183, 0.191406].  A repair
# is a claim like any other and is recomputed here before it is adopted.
print("\n" + "=" * 84)
print("r983's offered repair: the forcing at the SURVIVING configuration")
print("=" * 84)

Ni_s, tau_s = 0.218, 0.5 * 0.218 ** 1.5
t_s = 1 - 3 * Ni_s
# THE GRAM BOUND CAPS u FROM ABOVE AS WELL, which the note's interval u <= sqrt(t) does not:
# sum u_a^2 = 3 u^2 <= (5/3) t forces u <= sqrt(5t/9), and at this configuration THAT is the
# binding constraint, far tighter than sqrt(t).  Taking sqrt(t) as the top is what made a first
# pass of this screen report a window three times too wide.
lo_s = u_lo(Ni_s, tau_s)
hi_gram = np.sqrt(5 * t_s / 9)
hi_s = min(np.sqrt(t_s), hi_gram)
print(f"\n  note's own top  sqrt(t)      = {np.sqrt(t_s):.6f}")
print(f"  Gram bound's top sqrt(5t/9)  = {hi_gram:.6f}   <- BINDING")
us = np.linspace(lo_s, hi_s, 200001)
vals = Fi(us, Ni_s, 3 * Ni_s, tau_s)
u_star = float(us[int(np.argmin(vals))])

print(f"\n  surviving configuration: N_i = {Ni_s:.3f}, tau = {tau_s:.4f}, t = {t_s:.3f}")
print(f"  admissible interval: [{lo_s:.6f}, {hi_s:.6f}],  argmin at u* = {u_star:.6f}")

sum_u2 = 3 * u_star ** 2
print(f"\n  sum u_a^2 = 3 u*^2      = {sum_u2:.6f}")
print(f"  the x-free part says      <= t = {t_s:.6f}")
viol = sum_u2 - t_s
print(f"  violated by               = {viol:.6f}")
print(f"  Cauchy-Schwarz caps the x-part at 1.2 S_2, so S_2 >= {viol:.6f}/1.2 = {viol / 1.2:.6f}")

# the same computation across the whole admissible interval, which is what a RANGE means
s2_lo = (3 * lo_s ** 2 - t_s) / 1.2
s2_hi = (3 * hi_s ** 2 - t_s) / 1.2
print(f"\n  over the GRAM-ADMISSIBLE interval the forced S_2 runs [{s2_lo:.6f}, {s2_hi:.6f}]")
print(f"  r983 reports                                         [0.190183, 0.191406]")
print(f"  window width {100 * (s2_hi - s2_lo) / s2_lo:.2f} percent of the lower endpoint")
assert abs(s2_lo - 0.190183) < 2e-4, f"r983's LOWER endpoint does not validate: {s2_lo:.6f}"
assert s2_hi - s2_lo < 0.01, "the window should be narrow, which is r983's actual point"

assert viol > 0, "the x-free part must be violated for the forcing to say anything"
assert 3 * lo_s ** 2 <= 5 / 3 * t_s + 1e-12, "the surviving configuration must be Gram-admitted"
print("\n  the forcing is NON-VACUOUS at the surviving configuration  (asserted)")
print("  and the configuration is Gram-admitted, which t = 0.598 was not  (asserted)")

# ---- a THIRD figure the configuration mix-up carries: the scalar corollary's slack -----
# The note justifies "the joint system carries strictly more than the scalar corollary" by the
# corollary being slack by 0.2586.  That slack was measured at t = 0.598, which the Gram bound
# excludes.  Recompute it where the chain actually survives.
print("\n" + "=" * 84)
print("the scalar corollary's slack, at the EXCLUDED point and at the SURVIVING one")
print("=" * 84)

slack_excluded = 5 / 3 * 0.598 - 3 * 0.496 ** 2
slack_survivor = 5 / 3 * t_s - 3 * u_star ** 2
print(f"\n  at t = 0.598 (EXCLUDED):   (5/3)t = {5 / 3 * 0.598:.6f},  sum u^2 = {3 * 0.496 ** 2:.6f}"
      f"  ->  slack {slack_excluded:.6f}")
print(f"  at t = 0.346 (SURVIVES):   (5/3)t = {5 / 3 * t_s:.6f},  sum u^2 = {3 * u_star ** 2:.6f}"
      f"  ->  slack {slack_survivor:.6f}")
print(f"\n  the slack is smaller by a factor of {slack_excluded / slack_survivor:.0f}")

assert abs(slack_excluded - 0.2586) < 1e-3, f"the note's 0.2586 should reproduce, got {slack_excluded:.6f}"
assert slack_survivor < 0.01, f"the survivor's slack should be small, got {slack_survivor:.6f}"
print("\n  the note's 0.2586 REPRODUCES at the excluded point  (asserted)")
print("  and at the surviving point the corollary is slack by under 0.01  (asserted)")
print("\n  SO THE NOTE'S REASON FOR THE JOINT SYSTEM CARRYING MORE IS STATED AT A POINT THE")
print("  GRAM BOUND EXCLUDES.  Where the chain actually survives the scalar corollary is nearly")
print("  TIGHT, and the joint system's extra content there is a hundredth of what was claimed.")
