"""The B-band target is FALSE.  Witness: S^5 x S^7 at n = 12, exactly.

THE TARGET, as plan.md stated it: prove theta <= sqrt(3/2) on the band
{S_mmm = 0, 3 <= dim m < floor(n^2/4)}.  It is false, and the counterexample is a point
this project has known for months.

S^5 x S^7 at n = 12:
    theta   = 1.228239158  >  sqrt(3/2) = 1.224744871
    dim m   = 35  <  36 = floor(144/4)          -- in the band
    S_mmm   = 0.0e+00 exactly                    -- m is the cross-block 2-planes, the
                                                    tangent space of so(5)+so(7), so
                                                    [m,m] is inside h
    crit    = 4.1e-16,  Weyl residuals 0
EXACT, not numerical: theta^2 = 264/175 and 264/175 - 3/2 = 3/350 > 0.

IT IS AN INFINITE FAMILY, closed in form.  For a two-block sphere product,

    theta^2(S^p x S^q) = 2 (p-1)(q-1)(n-1) / ( p q (n-2) ),      n = p + q,

which reproduces every measured value to 4.4e-16 and gives theta_0(n)^2 at p = q.  Band
membership is dim m = pq < floor(n^2/4), i.e. EXACTLY p != q: every unbalanced two-block
sphere product is a band point, while balanced ones sit AT the cap and are outside.  With
p = s-1, q = s+1, n = 2s the target fails iff s^3 - 7s^2 + 7s - 3 > 0, i.e. at every
n >= 12 -- which is exactly the range where the target was wanted, since sqrt(3/2) <
theta_0(n) first holds at n = 12.  theta^2 -> 2 as n -> oo, so NO constant below sqrt(2)
bounds theta on the band: the target cannot be repaired by enlarging the constant, only
by replacing it with theta_0(n), which is the full conjecture with zero margin.

WHY IT WAS MISSED.  All three pieces were in the record, never joined: FINDINGS already
stated S^5 x S^7 = 1.228239 > sqrt(3/2); it separately defined the band; and it separately
recorded that two-block sphere products have S = 0.

WHAT SURVIVES.  Conjecture A itself is untouched -- 1.228239 < theta_0(12) = 1.236033.
And the ORIGINAL, narrower form of item B survives: sup{theta : S = 0, NON-DIAGONAL}
<= sqrt(3/2).  S^5 x S^7 is diagonal by construction, so it is no counterexample to that.
The band framing broke the target by folding the diagonal points in.

FALSIFIER: the closed form failing, or S^5 x S^7 turning out not to satisfy S = 0 or the
dimension bound.
"""
import numpy as np, sys
from fractions import Fraction as F
sys.path.insert(0, 'scripts/lib')
from review_r30_core import sphere_product_W
from b_circulant_band_witnesses import full_profile

SQ32 = np.sqrt(1.5)


def theta_sq_exact(p, q):
    n = p + q
    return F(2 * (p - 1) * (q - 1) * (n - 1), p * q * (n - 2))


def main():
    print("=== the witness, and the family ===")
    print(f"  {'point':14s}{'n':>3s}{'theta':>13s}{'exact th^2':>13s}{'d':>5s}{'cap':>5s}"
          f"{'S_mmm':>9s}{'crit':>9s}  verdict")
    bad = []
    for p, q in [(5, 7), (4, 8), (3, 9), (4, 6), (6, 8), (5, 9), (7, 9), (11, 13), (6, 6)]:
        n = p + q
        W, _ = sphere_product_W([p, q])
        W = W / np.linalg.norm(W)
        r = full_profile(n, W)
        cap = (n * n) // 4
        t2 = theta_sq_exact(p, q)
        assert abs(float(t2) ** 0.5 - r['theta']) < 1e-14, "closed form failed"
        inb = r['S'] < 1e-8 and 3 <= r['d'] < cap
        above = t2 > F(3, 2)
        if inb and above:
            bad.append((p, q, n, r['theta']))
        print(f"  S^{p} x S^{q}"[:16].ljust(16) + f"{n:>3d}{r['theta']:>13.9f}"
              f"{str(t2):>13s}{r['d']:>5d}{cap:>5d}{r['S']:>9.1e}"
              f"{r['info']['crit_res']:>9.1e}  "
              + ("BAND, ABOVE sqrt(3/2)" if (inb and above)
                 else ("band, below" if inb else "at the cap -- not in band")))

    print(f"\n  sqrt(3/2) = {SQ32:.9f};  S^5 x S^7 exceeds it by {F(264,175)-F(3,2)} "
          f"in theta^2 -- exact rational arithmetic, no tolerance involved.")
    print(f"  band points found above the threshold here: {len(bad)}")

    print("\n=== the target fails at every even n >= 12, along p = s-1, q = s+1 ===")
    print(f"  {'n':>4s}{'theta^2':>14s}{'theta':>13s}{'theta/theta_0':>15s}  above sqrt(3/2)?")
    for s in range(4, 13):
        n = 2 * s
        t2 = theta_sq_exact(s - 1, s + 1)
        th = float(t2) ** 0.5
        th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
        print(f"  {n:>4d}{str(t2):>14s}{th:>13.6f}{th/th0:>15.6f}"
              f"  {'YES' if t2 > F(3,2) else 'no'}")
    print("\n  theta^2 -> 2 as n -> oo, so no constant below sqrt(2) bounds theta on the")
    print("  band.  The target is unrepairable by enlarging the constant.")
    print("\n  WHAT SURVIVES: Conjecture A (1.228239 < theta_0(12) = 1.236033), and the")
    print("  ORIGINAL narrower item B -- sup{theta : S = 0, NON-DIAGONAL} <= sqrt(3/2).")
    print("  S^5 x S^7 is diagonal by construction and refutes only the band framing.")


if __name__ == '__main__':
    main()
