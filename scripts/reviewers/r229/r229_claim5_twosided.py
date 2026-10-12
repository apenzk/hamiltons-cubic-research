"""r229 claim 5b: what the moment route actually needs.

The file says the route needs a TIGHT UPPER BOUND ON m = -min omega.  It already
has one.  The projection estimate mu <= sqrt(2(n-2)/(n-1)) = n theta_0(n)/(n-1) is
unconditional (bispectral.md, reviewer 131) and is attained WITH EQUALITY at every
balanced sphere product.  So that input is not the missing one.

What is missing is information about the TOP of the omega-spectrum.  At the
extremiser the spectrum is three-valued, {-m, -(m-1)A, +M} with M = m/(n-2), and
that is the KKT shape of the TWO-SIDED moment problem: mass at the lower bound,
mass at the upper bound, and interior values at roots of one quadratic.  So test
whether adding an upper support constraint makes the moment bound SHARP.
"""
import numpy as np

def two_sided_min(N, m, M, S, amax=3):
    """min sum x^3 s.t. sum x = 0, sum x^2 = S, -m <= x <= M.
    KKT: a atoms at -m, c atoms at +M, the rest at the two roots of one quadratic."""
    best = (np.inf, None)
    for a in range(0, amax + 1):
        for c in range(0, N - a):
            rem = N - a - c
            if rem < 1: continue
            s1 = a * m - c * M
            s2 = S - a * m * m - c * M * M
            if s2 < -1e-12: continue
            if rem == 1:
                r = s1
                if abs(r * r - s2) < 1e-9 and -m - 1e-9 <= r <= M + 1e-9:
                    v = -a * m ** 3 + c * M ** 3 + r ** 3
                    if v < best[0]: best = (v, (a, rem, 0, c, r, None))
                continue
            for b in range(1, rem):
                d = rem - b
                A_ = b + b * b / d; B_ = -2 * b * s1 / d; C_ = s1 * s1 / d - s2
                disc = B_ * B_ - 4 * A_ * C_
                if disc < 0: continue
                for sg in (+1, -1):
                    r1 = (-B_ + sg * np.sqrt(disc)) / (2 * A_)
                    r2 = (s1 - b * r1) / d
                    if not (-m - 1e-9 <= r1 <= M + 1e-9): continue
                    if not (-m - 1e-9 <= r2 <= M + 1e-9): continue
                    v = -a * m ** 3 + c * M ** 3 + b * r1 ** 3 + d * r2 ** 3
                    if v < best[0]: best = (v, (a, b, d, c, r1, r2))
    return best

def spec(n):
    mm = n // 2
    A = 1.0 / (mm * np.sqrt((mm - 1) * (2 * mm - 1)))
    return np.array([mm * A] * ((mm - 1) * (mm + 2)) + [-(mm - 1) * A] * (mm * mm)
                    + [-2 * mm * (mm - 1) * A])

print("does an UPPER support bound make the moment problem sharp at the extremiser?")
print("(all at |M|_F = 1, so p_2 = 3; N = dim S^2_0)\n")
print(f"{'n':>4} {'N':>5} {'m':>9} {'M=m/(n-2)':>10} {'one-sided':>11} {'two-sided':>11} "
      f"{'true p3':>11} {'two/true':>9}")
for n in (12, 14, 16, 20):
    om = spec(n); N = len(om); S = 3.0
    m = -om.min(); M = om.max(); t = float(np.sum(om ** 3))
    one = S * S / (N * m) - m * S
    two, st = two_sided_min(N, m, M, S)
    print(f"{n:>4} {N:>5} {m:>9.6f} {M:>10.6f} {one:>11.6f} {two:>11.6f} {t:>11.6f} "
          f"{two/t:>9.4f}")

print("\nstructure of the two-sided minimiser at n=12 against the true spectrum:")
om = spec(12); N = len(om)
two, st = two_sided_min(N, -om.min(), om.max(), 3.0)
a, b, d, c, r1, r2 = st
print(f"   minimiser: {a} at -m={-(-om.min()):.6f}, {b} at {r1:.6f}, "
      f"{d} at {r2 if r2 is None else round(r2,6)}, {c} at +M={om.max():.6f}")
v, cc = np.unique(np.round(om, 9), return_counts=True)
print(f"   truth    : 1 at {v[0]:.6f}, {cc[1]} at {v[1]:.6f}, {cc[2]} at {v[2]:.6f}")
print(f"   two-sided minimum {two:.6f}  vs  true p_3 {np.sum(om**3):.6f}")

print("\nPLANTED VIOLATION: relax the upper bound and the minimum must fall strictly")
print("below the truth, or the constraint is doing nothing.")
for f in (1.0, 1.02, 1.2, 2.0, 5.0):
    two, _ = two_sided_min(N, -om.min(), om.max() * f, 3.0)
    t = float(np.sum(om ** 3))
    tag = "== truth (SHARP)" if abs(two - t) < 1e-8 else f"below truth by {t-two:.4f}"
    print(f"   M x{f:>5}: min = {two:>11.6f}   {tag}")

print("\nCONSEQUENCE for theta, at n=12 (theta_0 = 1.236033, true p_3(mu) = 0.0224731):")
p3mu = 1.0 / (6 * np.sqrt(5 * 11))
om = spec(12); N = len(om); m = -om.min(); M = om.max()
one = 9.0 / (N * m) - 3 * m
two, _ = two_sided_min(N, m, M, 3.0)
for lab, lo in (("one-sided", one), ("two-sided", two), ("truth", float(np.sum(om ** 3)))):
    print(f"   {lab:>10}: p_3^min = {lo:>10.6f} -> theta <= {1.5*p3mu - 0.5*lo:.6f}")
