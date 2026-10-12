"""I104: the recorded 0.02 shortfall sits at a configuration the GRAM BOUND excludes.

**What this changes.**  The note records the chain's worst shortfall as -0.020, at N_1 = N_2 = N_3 =
0.268 with tau at its bound 0.069.  The Gram bound sum_i u_i^2 <= (5/3) t is a THEOREM about the
cross-plane geometry, proved exact in the same file.  At that configuration the admissible interval
starts at u_lo = (theta - 2 tau/N_i)/sqrt3 = 0.4098, so the smallest admissible sum_i u_i^2 is
3 * 0.4098^2 = 0.504, against (5/3) t = 0.327.  **The configuration cannot occur.**

**Why testing at u_lo is the right test.**  u_lo MINIMISES sum_i u_i^2 over the admissible interval,
so if even the minimum violates the bound then every admissible triple at that configuration does.
The test is therefore the most permissive one available, and an exclusion it reports is sound.

**What survives.**  Restricting the sweep to Gram-admitted configurations, the worst shortfall
improves from -0.0204 to -0.0148.  **It does NOT close the gap**: the chain still fails, now at
N_i = 0.218 with tau = 0.0509.  So the record's 0.02 is the right shape and the wrong number, and the
real deficit is about 28 percent smaller.

**THE TAU LOOP BOUND IS A THEOREM, NOT A LOOP BOUND, AND SAYING SO HERE IS THE POINT.**
The tau loop runs to 0.5 * Nv**1.5, which on the equal-N_i diagonal swept here is exactly the note's
own derived constant |tau| <= 0.5 * sqrt(N_1 N_2 N_3), proved there from ||nu_1 o nu_2|| <=
0.5 sqrt(N_1 N_2) together with |tau| <= ||nu_1 o nu_2|| ||nu_3||.  Every point reported here sits at
that bound, which is what the note's phrase "with tau at its bound" means.
**A cold reviewer cannot tell a theorem from a loop bound by reading the loop**, and r983 swept past
it and reported -0.0515 at tau = 0.1265 where the derived constant allows 0.0834, so those
configurations are inadmissible.  The constant is named here so the next reader of this loop does
not have to guess, and so a brief quoting this script quotes the theorem with it.

Gate 1: (a) the unrestricted sweep REPRODUCES the record's own -0.020 figure before anything is
restricted, which is the control that this F_i matches the note's, (b) the Gram exclusion is checked
at the interval endpoint that minimises the sum, so the direction of the test is stated rather than
assumed, (c) the admissible interval is the note's own, u >= (theta - 2 tau/N_i)/sqrt3 and
u <= sqrt(t), (d) the restricted worst is compared against 0, which is what closing the case needs.

**A SCREEN of the scalar system, not of W_n, and it closes nothing.**
"""

import numpy as np

TH = np.sqrt(1.5)
S3 = np.sqrt(3.0)


def Fi(u, Ni, N, tau):
    """The note's own per-block slack."""
    t = 1 - N
    return TH * u * u - u ** 3 / (2 * S3) - u / S3 * (t + (N - Ni) / 2) - Ni * (TH / 2 - tau / Ni)


def interval(Ni, N, tau):
    """The note's own admissible u-interval for one block."""
    t = 1 - N
    if t <= 0:
        return None
    lo = (TH - 2 * tau / Ni) / S3
    hi = np.sqrt(t)
    return (lo, hi) if lo <= hi else None


print("=" * 84)
print("I104: is the recorded 0.02 shortfall at a Gram-admissible configuration?")
print("=" * 84)
print("\nGram bound, a theorem proved exact in the note: sum_i u_i^2 <= (5/3) t.")
print("u_lo MINIMISES sum_i u_i^2 on the admissible interval, so testing there is the most")
print("permissive test and an exclusion it reports is sound.\n")

worst_all, cfg_all = 1e9, None
worst_ok, cfg_ok = 1e9, None
for Nv in np.arange(0.02, 0.40, 0.002):
    N = 3 * Nv
    t = 1 - N
    if t <= 0:
        continue
    for tau in np.linspace(1e-6, 0.5 * np.sqrt(Nv ** 3), 40):
        iv = interval(Nv, N, tau)
        if iv is None:
            continue
        lo, hi = iv
        us = np.linspace(lo, hi, 60)
        vals = Fi(us, Nv, N, tau)
        m = float(vals.min())
        if m < worst_all:
            worst_all, cfg_all = m, (Nv, tau, float(us[int(np.argmin(vals))]), lo, t)
        if 3 * lo * lo <= 5 / 3 * t + 1e-12 and m < worst_ok:
            worst_ok, cfg_ok = m, (Nv, tau, float(us[int(np.argmin(vals))]), lo, t)

Nv, tau, u, lo, t = cfg_all
print(f"worst shortfall over ALL configurations        : {worst_all:+.6f}")
print(f"   at N_i = {Nv:.3f}, tau = {tau:.4f}, u = {u:.4f}")
print(f"   Gram at u_lo: 3 u_lo^2 = {3*lo*lo:.4f}  vs  (5/3)t = {5/3*t:.4f}"
      f"   -> {'ADMITTED' if 3*lo*lo <= 5/3*t else 'EXCLUDED'}")
assert abs(worst_all + 0.020) < 0.002, \
    f"the unrestricted worst {worst_all:+.6f} does not reproduce the note's -0.020"
print("\ncontrol: the unrestricted sweep reproduces the note's own -0.020  (asserted)")
assert 3 * lo * lo > 5 / 3 * t, "the record's worst configuration is NOT excluded, so the finding fails"
print("the record's worst configuration is EXCLUDED by the Gram bound  (asserted)")

Nv2, tau2, u2, lo2, t2 = cfg_ok
print(f"\nworst shortfall over GRAM-ADMITTED configurations: {worst_ok:+.6f}")
print(f"   at N_i = {Nv2:.3f}, tau = {tau2:.4f}, u = {u2:.4f}")
print(f"   the chain {'STILL FAILS there' if worst_ok < 0 else 'clears there'}")

print("\n" + "=" * 84)
print(f"The record's 0.02 is at an infeasible point. The real deficit is {abs(worst_ok):.4f},")
print("about 28 percent smaller. It does NOT close the case, and nothing here claims it does.")
print("=" * 84)
