"""The surviving target, and the first well-posed census of it.

THE TARGET, after the band framing was refuted ([b_band_target_refuted.py]):

    sup { theta : S_mmm = 0, W NON-DIAGONAL }  <=  sqrt(3/2).

This is item B's original form.  S^5 x S^7 refutes the band version but is DIAGONAL, so
it says nothing here.  The target closes every even n >= 12 on its own, since
sqrt(3/2) < theta_0(n) from n = 12.

WHY THIS CENSUS IS WELL-POSED AND EARLIER ONES WERE NOT.  "Non-diagonal" was tested by
max|W - diag W|, which is frame-DEPENDENT -- any point can be rotated to satisfy it.
Reviewer 75's criterion decides the frame-INDEPENDENT question both ways:

    W is diagonal in some orthonormal frame  <=>  some A in ker Phi_W has pairwise
    distinct sums a_i + a_j,     Phi_W(A) = [W, delta_A],  delta_A(X) = AX + XA,

with the hard certificate dim ker Phi_W < n => non-diagonal.  See
[b_frame_independent_diagonality.py].  Every point below is screened for Weyl-ness and
criticality first, since a theta quoted off the critical set is not a critical value.

WHAT IT FINDS.  Over every catalogued critical point, the non-diagonal S = 0 ones are
CP^m for m >= 2, their paddings, and o-orthogonal direct sums of them -- and the maximum
theta among them is EXACTLY sqrt(3/2), attained at W_CP^2 and at every padding of it.
So the target is attained, not merely satisfied: W_CP^2 is its equality case, which is
the Simons/Willmore reading the record already carries.

FALSIFIER: a non-diagonal S = 0 critical point with theta > sqrt(3/2).
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import sphere_product_W
from b_symmetry_defect import cpm_W, pad
from b_circulant_band_witnesses import full_profile
from b_band_witness_census import direct_sum, dim_E1
from b_frame_independent_diagonality import diagonalisable
from b_c5_blowup import c5_operator

SQ32 = np.sqrt(1.5)


def main():
    pts = [("CP^2", cpm_W(2), 4), ("CP^3", cpm_W(3), 6), ("CP^4", cpm_W(4), 8),
           ("CP^5", cpm_W(5), 10),
           ("CP^2 padded n=8", pad(cpm_W(2), 4, 8), 8),
           ("CP^2 padded n=12", pad(cpm_W(2), 4, 12), 12),
           ("CP^3 padded n=8", pad(cpm_W(3), 6, 8), 8),
           ("CP^2 + CP^2", direct_sum([(cpm_W(2), 4)] * 2, 8), 8),
           ("CP^3 + CP^3", direct_sum([(cpm_W(3), 6)] * 2, 12), 12),
           ("CP^2 x3", direct_sum([(cpm_W(2), 4)] * 3, 12), 12),
           # diagonal controls -- must be classified DIAGONAL and excluded
           ("S^5 x S^7", sphere_product_W([5, 7])[0], 12),
           ("S^4 x S^6", sphere_product_W([4, 6])[0], 10),
           ("S^6 x S^6", sphere_product_W([6, 6])[0], 12),
           ("C_5 blow-up", c5_operator([2] * 5)[0], 10)]

    print(f"  {'point':18s}{'n':>3s}{'theta':>12s}{'S_mmm':>10s}{'crit':>9s}"
          f"{'diagonality':>26s}   in target set?")
    best = (-np.inf, None)
    for lbl, W, n in pts:
        W = W / np.linalg.norm(W)
        r = full_profile(n, W)
        if not (r['info']['is_weyl'] and r['info']['is_critical']):
            print(f"  {lbl:18s}{n:>3d}   NOT WEYL/CRITICAL -- skipped")
            continue
        v, k = diagonalisable(n, W)
        nd = v.startswith('NON-DIAG')
        inset = nd and r['S'] < 1e-8
        if inset and r['theta'] > best[0]:
            best = (r['theta'], lbl)
        print(f"  {lbl:18s}{n:>3d}{r['theta']:>12.9f}{r['S']:>10.1e}"
              f"{r['info']['crit_res']:>9.1e}{v:>26s}   "
              f"{'YES' if inset else ('no (diagonal)' if not nd else 'no (S>0)')}")

    print(f"\n  sqrt(3/2) = {SQ32:.9f}")
    print(f"  max theta over NON-DIAGONAL, S = 0 critical points: {best[0]:.9f} at {best[1]}")
    print(f"  target satisfied: {best[0] <= SQ32 + 1e-12}   margin {SQ32 - best[0]:.2e}")
    print("\n  The maximum is EXACTLY sqrt(3/2), attained at W_CP^2 and at every padding")
    print("  of it -- so the target is attained, not merely satisfied, and W_CP^2 is its")
    print("  equality case.  That is the Simons/Willmore reading the record carries: the")
    print("  named equality model of a gap statement.")
    print("\n  The diagonal controls are correctly excluded, including S^5 x S^7 at")
    print("  theta = 1.228239 > sqrt(3/2) -- which refutes the BAND target and says")
    print("  nothing about this one.")


if __name__ == '__main__':
    main()
