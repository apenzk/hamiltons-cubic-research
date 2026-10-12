"""I104: does UNEQUAL N_i admit a worse configuration than the equal-N_i diagonal?

**Why it matters.**  Every figure in [the I104 note](../../reviews/2026-09-14-I104-tau-positive.md)
is measured on the equal-N_i diagonal, which is the sweep's own hypothesis and which
commit 269f871e already flags as owing a reviewer.  If unequal N_i admits a worse
configuration then the 0.0148 deficit is itself unpriced, and every source measured
against it was measured against the wrong number.

**The object, quoted from the note's own line 25.**  With theta^2 = 3/2, t = 1 - N,
N = N_1+N_2+N_3, and |tau| <= sqrt(N_1 N_2 N_3)/2, the per-block slack is

    F_i(u) = theta u^2 - u^3/(2 sqrt3) - (u/sqrt3)(t + (N - N_i)/2) - N_i(theta/2 - tau/N_i)

on the admissible interval (theta - 2 tau/N_i)/sqrt3 <= u <= sqrt(t).  The chain fails
where the LARGEST block's slack is negative, so the quantity swept is

    worst(N_1,N_2,N_3) = max_i  min_u  F_i(u),

minimised over the grid.  More negative is worse.

**Gate 1.** (a) the equal-N_i diagonal must reproduce the recorded -0.020422 at
N_i = 0.278 with tau at its bound, which is the control that this F is the recorded one;
(b) the answer is compared against that number in both directions rather than printed.

**A SCREEN.  It tests one hypothesis and closes nothing by itself.**
"""
import numpy as np
from itertools import product

TH = np.sqrt(1.5)
S3 = np.sqrt(3.0)


def worst_block(N1, N2, N3, ngrid=400):
    Ns = (N1, N2, N3)
    N = N1 + N2 + N3
    t = 1.0 - N
    if t <= 0:
        return None
    tau = 0.5 * np.sqrt(N1 * N2 * N3)
    best = -np.inf                       # max over blocks of (min over u)
    for Ni in Ns:
        lo = (TH - 2.0 * tau / Ni) / S3
        hi = np.sqrt(t)
        if lo > hi:
            return None                  # block admits no u, configuration excluded
        u = np.linspace(lo, hi, ngrid)
        F = (TH * u**2 - u**3 / (2 * S3)
             - u / S3 * (t + (N - Ni) / 2.0)
             - Ni * (TH / 2.0 - tau / Ni))
        best = max(best, F.min())
    return best


def main():
    ctrl = worst_block(0.278, 0.278, 0.278)
    print(f"CONTROL, equal N_i = 0.278, tau at its bound: {ctrl:+.6f}")
    print("  the note records -0.020422 at this point")
    if ctrl is None or abs(ctrl - (-0.020422)) > 5e-4:
        print("  CONTROL FAILED, the formula is not the recorded one; nothing below is reported")
        return 1
    print("  CONTROL PASSED\n")

    grid = np.linspace(0.20, 0.33, 27)
    worst, arg = np.inf, None
    diag_worst = np.inf
    for a, b, c in product(grid, repeat=3):
        v = worst_block(a, b, c)
        if v is None:
            continue
        if a == b == c:
            diag_worst = min(diag_worst, v)
        if v < worst:
            worst, arg = v, (a, b, c)

    print(f"worst on the EQUAL-N diagonal : {diag_worst:+.6f}")
    print(f"worst over the FULL grid      : {worst:+.6f}  at N = "
          f"({arg[0]:.3f}, {arg[1]:.3f}, {arg[2]:.3f})")
    spread = max(arg) - min(arg)
    print(f"\nthe grid minimiser is {'the diagonal' if spread < 1e-9 else f'OFF-DIAGONAL, spread {spread:.3f}'}")
    print(f"unequal N_i buys {diag_worst - worst:+.6f} of extra shortfall")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
