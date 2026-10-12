"""CP^m satisfies theta < sqrt(3/2) for every m >= 3 -- proved, not covered.

The band-coverage census recorded CP^3, CP^4, CP^5 and padded CP^3 as "covered by H".
That reading is wrong, and the correction is stronger than the claim.

STEP H SAYS: every GRADED critical point with theta > sqrt(3/2) is a sphere product.
Its hypothesis is theta > sqrt(3/2).  At CP^m with m >= 3 that hypothesis is FALSE, so H
says nothing there -- vacuously.  These points do not need covering: they are already
below the threshold the band target asks for.

THE PROOF, from Lemma 28's closed form theta^2 = (m+1)(2m-1) / (3m(m-1)):

    theta^2 < 3/2
      <=>  2(m+1)(2m-1) < 9m(m-1)
      <=>  4m^2 + 2m - 2  <  9m^2 - 9m
      <=>  0 < 5m^2 - 11m + 2 .

The quadratic has roots (11 +- sqrt(121-40))/10 = (11 +- 9)/10 = 2 and 1/5, so it is
positive for every m > 2.  Hence theta(CP^m) < sqrt(3/2) at every m >= 3, the closest
case being m = 3 at theta^2 = 10/9 = 1.111... against 3/2.

Checked in exact rational arithmetic and against the operator, residual <= 1.1e-16.

WHAT THIS SETTLES, and what it does not.  Item (ii) of the band's owed work -- "H's
hypotheses must be checked at CP^{m>=3}" -- is closed: H is not needed there.  It does
NOT close the band, because the target is a statement about ALL of it, and every point
here is one this project already knew.

FALSIFIER: the closed form failing against the operator at any m, or 5m^2-11m+2 <= 0 for
some m >= 3.
"""
import sys
from fractions import Fraction as F
sys.path.insert(0, 'scripts/lib')

SQ32_SQ = F(3, 2)


def theta_sq(m):
    """Lemma 28's closed form, exact."""
    return F((m + 1) * (2 * m - 1), 3 * m * (m - 1))


def main():
    import numpy as np
    from b_symmetry_defect import cpm_W
    from weyl_screen import critical_screened

    print("  Lemma 28:  theta^2 = (m+1)(2m-1) / (3m(m-1))")
    print(f"  {'m':>3s}{'n':>4s}{'theta^2 (exact)':>17s}{'theta':>11s}{'measured':>11s}"
          f"{'resid':>9s}{'crit':>6s}   theta^2 < 3/2 ?")
    for m in (3, 4, 5, 6):
        n = 2 * m
        t2 = theta_sq(m)
        th = float(t2) ** 0.5
        meas, info = critical_screened(n, cpm_W(m))
        print(f"  {m:>3d}{n:>4d}{str(t2):>17s}{th:>11.6f}{meas:>11.6f}"
              f"{abs(th - meas):>9.1e}{('ok' if info['is_critical'] else 'NO'):>6s}"
              f"   {'YES' if t2 < SQ32_SQ else 'NO'}")

    print("\n  PROOF for every m >= 3:")
    print("    theta^2 < 3/2  <=>  2(m+1)(2m-1) < 9m(m-1)  <=>  0 < 5m^2 - 11m + 2,")
    print("    whose roots are (11 +- 9)/10 = 2 and 1/5, so it is positive for m > 2.")
    for m in (3, 4, 10, 100, 10000):
        v = 5 * m * m - 11 * m + 2
        assert v > 0
        print(f"      m = {m:<6d}  5m^2 - 11m + 2 = {v:<12d} > 0"
              f"   theta^2 = {float(theta_sq(m)):.6f}")
    print("\n  So H is NOT needed at CP^{m>=3}: its hypothesis theta > sqrt(3/2) is false")
    print("  there.  The coverage census's 'covered by H' for those rows is the wrong")
    print("  reading -- being BELOW the threshold is stronger than being covered.")
    print("\n  And no catalogued band point exceeds sqrt(3/2) at all: the maximum is")
    print("  1.185854 at S^4 x S^6.  The target holds on everything known; it is the")
    print("  unknown that needs a proof.")


if __name__ == '__main__':
    main()
