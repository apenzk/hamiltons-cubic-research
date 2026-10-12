"""r229 claim 3 part b: the bound's real margin, once the normalisation is fixed.

Everything below is scale-invariant: p_3 and m are both cubed/linear in the same
scale, so the RATIO bound/actual does not depend on whether |W|^2 = 1 or |M|_F = 1.
Both normalisations are printed so the file's own numbers can be located.
"""
import numpy as np
from sympy import symbols, sqrt, Rational, simplify, nsimplify, limit, oo, radsimp

# closed forms from the record, verified numerically in r229_claim3.py
def data(n):
    m = n // 2
    A = 1.0 / (m * np.sqrt((m - 1) * (2 * m - 1)))
    om = np.array([m * A] * ((m - 1) * (m + 2)) + [-(m - 1) * A] * (m * m) + [-2 * m * (m - 1) * A])
    return om            # |M|_F = 1 normalisation: sum om^2 = 3

def p3min(m_, N, S):     # two-atom minimum with p_1=0, p_2=S, entries >= -m_
    return S * S / (N * m_) - m_ * S

print("SCALE-INVARIANT margin of the moment bound at the balanced sphere product")
print(f"{'n':>4} {'N=dimS20':>9} {'-min om':>10} {'cap':>10} {'cap/-min':>9} {'p3 actual':>11} "
      f"{'p3min@cap':>11} {'ratio':>7} {'theta gap':>10}")
for n in (12, 14, 16, 24, 40, 100, 400):
    om = data(n); N = n * (n + 1) // 2 - 1
    S = float(np.sum(om ** 2)); assert abs(S - 3) < 1e-9
    mm = -om.min(); t0 = np.sqrt(2 * (n - 1) * (n - 2)) / n; cap = n / (n - 1) * t0
    a3 = float(np.sum(om ** 3)); lo = p3min(cap, N, 3.0)
    # what the bound would give for theta if p_3(mu) were known exactly
    p3mu = 1.0 / ((n // 2) * np.sqrt((n // 2 - 1) * (n - 1)))
    th_true = 1.5 * p3mu - 0.5 * a3
    th_bd = 1.5 * p3mu - 0.5 * lo
    print(f"{n:>4} {N:>9} {mm:>10.6f} {cap:>10.6f} {cap/mm:>9.6f} {a3:>11.6f} {lo:>11.6f} "
          f"{lo/a3:>7.4f} {th_bd-th_true:>10.6f}")

print("\nthe file's four reported quantities, at n=12, in the file's own |W|^2=1 scale:")
om = data(12) / 2.0
print(f"   -min omega          true {-om.min():.6f}   file 'm ACTUAL'    0.067420   "
      f"ratio {(-om.min())/0.067420:.4f} = n-2")
print(f"   p_3(omega)          true {float(np.sum(om**3)):.6f}   file              +0.300581  "
      f"-> SIGN")
print(f"   cap (|M|=1 scale)        1.348400   in |W|^2=1 scale  {1.348400/2:.6f} "
      f"= -min omega EXACTLY")

print("\nPLANTED VIOLATION 1: if 0.067420 really were the support bound, the two-atom")
print("minimum would be a valid LOWER bound on p_3(omega).  Test it against the truth.")
for N in (77, 78):
    lo = p3min(0.067420, N, 0.75); a3 = float(np.sum(om ** 3))
    verdict = "HOLDS" if lo <= a3 + 1e-12 else "VIOLATED -> 0.067420 is not the support bound"
    print(f"   N={N}: p3min={lo:.6f}  vs actual p_3={a3:.6f}   {verdict}")

print("\nPLANTED VIOLATION 2: the bound with the TRUE support bound must hold at every n.")
bad = 0
for n in range(6, 200, 2):
    om = data(n); N = n * (n + 1) // 2 - 1
    lo = p3min(-om.min(), N, 3.0); a3 = float(np.sum(om ** 3))
    if lo > a3 + 1e-9: bad += 1; print(f"   VIOLATION at n={n}: {lo} > {a3}")
print(f"   checked n=6..198 even: {bad} violations")

print("\nPLANTED VIOLATION 3: the bound must be BREAKABLE by a spectrum that violates")
print("the support constraint -- a check that cannot fail is worth nothing.")
om = data(12); N = len(om); S = 3.0; m0 = -om.min()
for f in (1.0, 1.1, 1.3):
    m2 = m0 * f; r = S / (N * m2 * m2); k = int(round(N * r / (1 + r)))
    v = np.array([-m2] * k + [k * m2 / (N - k)] * (N - k))
    v = v - v.mean(); v = v * np.sqrt(S / np.sum(v ** 2))
    got = float(np.sum(v ** 3)); lo = p3min(m0, N, S)
    print(f"   support {m2:.4f} ({f:g}x): p_3 = {got:.6f} vs bound {lo:.6f}  "
          f"{'FIRES' if got < lo else 'holds'}")

print("\nSYMBOLIC: is the cap attained exactly at every balanced product?")
mS = symbols('m', positive=True)
A = 1 / (mS * sqrt((mS - 1) * (2 * mS - 1)))
minus_min = 2 * mS * (mS - 1) * A
cap = (2 * mS) / (2 * mS - 1) * sqrt(2 * (2 * mS - 1) * (2 * mS - 2)) / (2 * mS)
print("   -min(omega) - cap  =", radsimp(simplify(minus_min - cap)))
