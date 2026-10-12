"""Does B1 + B2 + H cover every KNOWN band point?  A census with corrected definitions.

THE CLAIM UNDER TEST, which is the repaired form of a claim already retracted once:
every band point this project knows is covered by one of

    B1  diagonal in some orthonormal frame        (the diagonal half, granted for even n >= 12)
    B2  o-decomposable, dim E(1) > 1              (capped by its own pieces, never extremal)
    H   graded                                    (S_mmm = 0 and S_mpp = 0)

The band is {S_mmm = 0, 3 <= dim m < floor(n^2/4)}.  This does NOT prove
theta <= sqrt(3/2) there -- B1 is granted only for the diagonal case and H needs its own
hypotheses -- but it says where an uncovered point would have to live, which is what the
retracted "the stratum is empty" was trying and failing to say.

DEFINITIONS USED, all corrected after Gate 2:
  * diagonality is FRAME-INDEPENDENT.  A point is recorded diagonal only when a
    diagonalising frame is known by construction; a simple eigenvalue with an eigenvector
    of bivector rank > 2 proves non-diagonality.  Where neither applies the verdict is
    "undetermined", never "diagonal" -- see [b_frame_independent_diagonality.py].
  * criticality is screened, since Lemma-24-adjacent statements have no content off the
    critical set -- see [critical_screened] in [weyl_screen.py].
  * gradedness is S_mmm = 0 AND S_mpp = 0, both measured, with the kernel reported,
    since the Delta lemma needs ker W = 0.

FALSIFIER: a band point covered by none of the three, or one whose coverage rests on an
"undetermined" diagonality verdict.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import sphere_product_W
from b_symmetry_defect import cpm_W, phis, pad
from b_circulant_band_witnesses import full_profile
from b_band_witness_census import dim_E1, direct_sum
from b_frame_independent_diagonality import simple_eigen_ranks
from b_c5_blowup import c5_operator

TOL = 1e-9


def grading(n, W):
    """(S_mmm, S_mpp, dim ker)."""
    W = W / np.linalg.norm(W)
    lam, V = np.linalg.eigh(W)
    P = phis(n)
    v = np.einsum('ag,gij->aij', V.T, P)
    br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
    T = (0.5 * np.einsum('abij,cij->abc', br, v)) ** 2
    m, p, z = lam < -TOL, lam > TOL, np.abs(lam) <= TOL
    return (float(T[np.ix_(m, m, m)].sum()), float(T[np.ix_(m, p, p)].sum()), int(z.sum()))


def main():
    # (label, W, n, known-diagonalising-frame?)
    pts = [("CP^3", cpm_W(3), 6, False), ("CP^4", cpm_W(4), 8, False),
           ("CP^5", cpm_W(5), 10, False),
           ("C_5 blow-up", c5_operator([2] * 5)[0], 10, True),
           ("S^4 x S^6", sphere_product_W([4, 6])[0], 10, True),
           ("S^3 x S^7", sphere_product_W([3, 7])[0], 10, True),
           ("S^3 x S^5", sphere_product_W([3, 5])[0], 8, True),
           ("S^2 x S^8", sphere_product_W([2, 8])[0], 10, True),
           ("CP^2 + CP^2", direct_sum([(cpm_W(2), 4)] * 2, 8), 8, False),
           ("CP^3 + CP^3", direct_sum([(cpm_W(3), 6)] * 2, 12), 12, False),
           ("CP^2 x3", direct_sum([(cpm_W(2), 4)] * 3, 12), 12, False),
           ("CP^3 padded n=8", pad(cpm_W(3), 6, 8), 8, False)]

    print(f"  {'point':17s}{'n':>3s}{'theta':>10s}{'d':>4s}{'cap':>5s}{'S_mmm':>9s}"
          f"{'S_mpp':>9s}{'ker':>5s}{'dimE1':>6s}  diag        covered by")
    uncovered = []
    for lbl, W, n, known_diag in pts:
        W = W / np.linalg.norm(W)
        r = full_profile(n, W)
        cap = (n * n) // 4
        if not (r['S'] < 1e-8 and 3 <= r['d'] < cap):
            continue                                  # not a band point
        crit = r['info']['is_critical']
        k = dim_E1(n, W, r['theta']) if crit else -1
        Smmm, Smpp, kerdim = grading(n, W)
        simp = simple_eigen_ranks(n, W)
        if known_diag:
            diag = "yes (constr)"
        elif any(rk > 2 for _, rk in simp):
            diag = "NO (proved)"
        else:
            diag = "undetermined"
        cover = []
        if diag == "yes (constr)":
            cover.append("B1")
        if k > 1:
            cover.append("B2")
        if Smmm < 1e-8 and Smpp < 1e-8:
            cover.append("H")
        if not cover:
            uncovered.append(lbl)
        print(f"  {lbl:17s}{n:>3d}{r['theta']:>10.6f}{r['d']:>4d}{cap:>5d}{Smmm:>9.1e}"
              f"{Smpp:>9.1e}{kerdim:>5d}{k:>6d}  {diag:12s} "
              f"{('+'.join(cover) if cover else '*** NONE ***')}")

    print(f"\n  band points examined: covered by B1/B2/H except {len(uncovered)}"
          + ("" if not uncovered else ": " + ", ".join(uncovered)))
    print("  Coverage is NOT a proof that theta <= sqrt(3/2) there -- B1 is granted only")
    print("  for the diagonal case and H carries its own hypotheses.  It says where an")
    print("  uncovered point would have to live, which is all the retracted claim was")
    print("  ever entitled to say.")


if __name__ == '__main__':
    main()
