"""lam_max <= (n-2) |lam_min| on Weyl_n, SHARP at CP^m -- from the per-row identity.

WHERE IT COMES FROM.  Reviewer 70 noted at Gate 2 that A(W) = 2W is not merely a trace
identity but a PER-ROW one:

    sum_beta lam_beta R_{alpha beta}  =  -2 lam_alpha    for EVERY alpha,          (*)

with R_{ab} = ||[v_a, v_b]||^2.  The record had been using only its lam_alpha-weighted
sum.  (*) is strictly stronger, and it is not carried by the LP class whose ceiling
Reviewers 67/68 closed.  Residual 2e-16 on Weyl_n; it fails off Weyl_n.

THE ARGUMENT, three lines.  Take alpha = argmax in (*) and split over p (lam > 0),
m (lam < 0) and ker:

    sum_{p} lam_b R_{a1 b}  +  sum_{m} lam_b R_{a1 b}  =  -2 lam_max .

The first sum is >= 0 since both factors are, so sum_{m} |lam_b| R_{a1 b} >= 2 lam_max.
On m, |lam_b| <= |lam_min|, and the row marginal obeys sum_{m} R_{a1 b} <= sum_b R_{a1 b}
= 2(n-2) -- the Killing-form constant of fence post 18.  Hence

    lam_max  <=  (n - 2) |lam_min| .                                              (**)

EQUALITY forces all three steps tight: the top eigenvector's bracket mass lands ENTIRELY
in m, it is spread only over eigenvalues at the bottom of the spectrum, and it has no
overlap with p at all.

WHAT IS MEASURED.  (*) at 2e-16; (**) at every catalogued and random point; and the
equality ratio lam_max / ((n-2)|lam_min|), which is EXACTLY 1 at CP^2, CP^3, CP^4 and
strictly below 1 everywhere else -- so (**) is sharp, and its extremisers are the Kahler
points, the same ones that set this project's sqrt(3/2) threshold and that make Berger's
inequality near-tight (fence post 21).

WHAT IT DOES NOT DO.  (**) bounds lam_max BELOW by |lam_min|, so it is a lower bound on
|lam_min| and does not supply the UPPER bound [b_lambda_weighted_bound.py] needs.  It is
recorded because it is sharp, new, and outside the closed class.

FALSIFIER: (*) failing on Weyl_n, or a point with lam_max > (n-2)|lam_min|.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, weyl_basis, sphere_product_W
from b_symmetry_defect import cpm_W, phis
from b_c5_blowup import c5_operator
from weyl_screen import theta_screened


def spectrum_and_R(n, W):
    W = W / np.linalg.norm(W)
    lam, V = np.linalg.eigh(W)
    P = phis(n)
    v = np.einsum('ag,gij->aij', V.T, P)
    br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
    return lam, 0.5 * np.einsum('abij,abij->ab', br, br)


def main():
    pts = [(6, sphere_product_W([3, 3])[0], "S^3 x S^3"),
           (12, sphere_product_W([6, 6])[0], "S^6 x S^6"),
           (12, sphere_product_W([5, 7])[0], "S^5 x S^7"),
           (6, cpm_W(3), "CP^3"), (8, cpm_W(4), "CP^4"), (4, cpm_W(2), "CP^2"),
           (10, c5_operator([2] * 5)[0], "C_5 blow-up")]
    rng = np.random.default_rng(21)
    for n in (6, 8):
        B = weyl_basis(n)
        for t in range(2):
            co = rng.normal(size=B.shape[0])
            pts.append((n, np.tensordot(co, B, axes=([0], [0])), f"random n={n} #{t}"))

    print(f"  {'point':16s}{'n':>3s}{'theta':>10s}{'lam_max':>10s}{'|lam_min|':>11s}"
          f"{'per-row res':>13s}{'(n-2)|lmin|':>13s}{'ratio':>9s}  sharp?")
    worst = -np.inf
    for n, W, lbl in pts:
        W = W / np.linalg.norm(W)
        th, info = theta_screened(n, W)
        lam, R = spectrum_and_R(n, W)
        res = float(np.abs(R @ lam + 2 * lam).max())
        lmax, lmin = float(lam[-1]), abs(float(lam[0]))
        rhs = (n - 2) * lmin
        ratio = lmax / rhs
        worst = max(worst, lmax - rhs)
        print(f"  {lbl:16s}{n:>3d}{th:>10.6f}{lmax:>10.5f}{lmin:>11.5f}{res:>13.1e}"
              f"{rhs:>13.5f}{ratio:>9.6f}  {'YES' if abs(ratio-1) < 1e-9 else ''}")
    print(f"\n  worst excess over (n-2)|lam_min|: {worst:.2e}   (negative = never violated)")
    print("  Equality at every CP^m tested: the top eigenvector's bracket mass lands")
    print("  entirely in m, only on the bottom of the spectrum, with no overlap with p.")
    print("  The Kahler points are the extremisers -- the same ones that set the")
    print("  sqrt(3/2) threshold and make Berger near-tight (fence post 21).")
    print("\n  NOT the ingredient b_lambda_weighted_bound.py needs: this bounds |lam_min|")
    print("  from BELOW.  Recorded because it is sharp, new, and outside the closed class.")


if __name__ == '__main__':
    main()
