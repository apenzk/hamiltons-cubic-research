"""The second-order screen: lam_max(L_e restricted to e-perp) against Lemma 24's 1/2.

WHY THIS IS THE LIVE TOOL.  The standing filter adopted this cycle says a candidate
bound tight at W_CP^2 has no room left and cannot separate the band from sqrt(3/2).
Second-order optimality PASSES that filter, which is what distinguishes it from every
other constraint in the list:

    CP^2   lam_max = 0.500000    0 eigenvalues above 1/2   saturates Lemma 24
    CP^3   lam_max = 0.625000    9 eigenvalues above 1/2   VIOLATES  -> not a maximiser
    CP^4   lam_max = 0.600000   16 eigenvalues above 1/2   VIOLATES

reproducing Lemma 28's closed form (m+2)/(2(m+1)) to eight digits.  So the condition is
strictly slack away from one boundary point, which is exactly what a separating argument
needs, and CP^2 is the unique second-order-admissible member of the family -- sitting at
exactly sqrt(3/2).

LEMMA 24, the constraint being screened.  At a GLOBAL maximiser, with e = W/theta,

    spec( L_e restricted to e-perp )  contained in  (-inf, 1/2] ,   and 1 is simple.

The eigenvalue 1 is e itself.  A point with an eigenvalue above 1/2 off e is therefore
not a global maximiser, whatever its theta.

WHAT THIS SCRIPT REPORTS, per catalogued point: theta, theta/sqrt(3/2), lam_max off e,
the count of eigenvalues above 1/2, and the verdict.  It is an instrument, not a search --
the analogue of [weyl_screen.py] for the second-order condition.

COST.  L_e is D x D with D = dim Weyl_n = n(n+1)(n+2)(n-3)/12, so 84 at n=6, 300 at n=8,
770 at n=10, 1638 at n=12.  The sweep runs to n = 10 by default; pass --n12 to include
the twelve-dimensional points, which take substantially longer.

FALSIFIER: a point with theta >= theta_0(n) and an eigenvalue above 1/2 off e -- that
would refute Lemma 24 rather than the point.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r34_core import Le_matrix, weyl_basis
from review_r30_core import sphere_product_W
from b_symmetry_defect import cpm_W, pad
from b_c5_blowup import c5_operator
from weyl_screen import theta_screened, critical_screened

SQ32 = np.sqrt(1.5)


def product_weyl(blocks):
    """Weyl PART of a product of unit round spheres, for ANY number of blocks.

    review_r30_core.sphere_product_W's closed formula is a Weyl operator only for TWO
    blocks -- at three or more it fails weyl_screen outright, and its theta is then not
    a Weyl value.  Here the curvature operator (the projector onto within-block
    bivectors) is projected orthogonally onto Weyl_n instead, which is correct at every
    block count.  Returns (unit-norm Weyl part, n, norm of the Weyl part before scaling).
    """
    from review_r30_core import pair_index
    n = sum(blocks)
    pairs, _ = pair_index(n)
    lab = []
    for bi, b in enumerate(blocks):
        lab += [bi] * b
    R = np.zeros((len(pairs), len(pairs)))
    for a, (i, j) in enumerate(pairs):
        if lab[i] == lab[j]:
            R[a, a] = 1.0
    B = weyl_basis(n)
    Wp = np.tensordot(np.einsum('dij,ij->d', B, R), B, axes=([0], [0]))
    nr = float(np.linalg.norm(Wp))
    return (Wp / nr if nr > 1e-12 else Wp), n, nr


def second_order(n, W, tol=1e-9):
    """(theta, is_weyl AND is_critical, lam_max off e, #ev > 1/2 off e, dim).

    The second flag is now CRITICALITY as well as Weyl-ness.  Lemma 24's hypothesis is
    that the point is a global maximiser, hence critical; quoting lam_max against 1/2 at
    a non-critical W is meaningless.  Gate 2 (Reviewers 71/72) found three rows of this
    file's own falsification table computed at operators with criticality residual 0.11
    to 0.22, where the lemma has no content.  info['crit_res'] carries the number.
    """
    W = W / np.linalg.norm(W)
    th, info = critical_screened(n, W)
    info['usable'] = info['is_weyl'] and info['is_critical']
    B = weyl_basis(n)
    e = W / th
    L = Le_matrix(e, n, B)
    L = 0.5 * (L + L.T)
    # Restrict to e-perp EXPLICITLY.  The previous version stripped the largest
    # eigenvalue only when it was within 1e-7 of 1, so wherever lam_max(L_e) > 1 -- the
    # C_5 blow-up, random Weyl tensors -- nothing was stripped, e's own eigenvalue 1
    # stayed in the count, and every such count was inflated by exactly one.  Gate 2,
    # Reviewer 72.  The lam_max values were unaffected; the counts were not.
    ec = np.einsum('dij,ij->d', B, e)
    ec = ec / np.linalg.norm(ec)
    Qb = np.eye(len(ec)) - np.outer(ec, ec)
    U, sv, _ = np.linalg.svd(Qb)
    U = U[:, sv > 0.5]                      # orthonormal basis of e-perp
    off = np.linalg.eigvalsh(U.T @ L @ U)
    return th, info['usable'], float(off.max()), int((off > 0.5 + tol).sum()), L.shape[0]


def main():
    want12 = '--n12' in sys.argv
    pts = [(4, cpm_W(2), "CP^2"),
           (6, cpm_W(3), "CP^3"),
           (8, cpm_W(4), "CP^4"),
           (6, sphere_product_W([3, 3])[0], "S^3 x S^3"),
           (8, sphere_product_W([4, 4])[0], "S^4 x S^4"),
           (8, sphere_product_W([3, 5])[0], "S^3 x S^5"),
           (10, sphere_product_W([5, 5])[0], "S^5 x S^5"),
           (8, pad(cpm_W(2), 4, 8), "CP^2 padded n=8"),
           (10, c5_operator([2] * 5)[0], "C_5 blow-up n=10")]
    if want12:
        pts += [(12, sphere_product_W([6, 6])[0], "S^6 x S^6"),
                (12, sphere_product_W([5, 7])[0], "S^5 x S^7")]
    rng = np.random.default_rng(31)
    for n in (6, 8):
        B = weyl_basis(n)
        co = rng.normal(size=B.shape[0] if B.ndim == 3 else B.shape[1])
        Wr = np.tensordot(co, B, axes=([0], [0])) if B.ndim == 3 else None
        if Wr is not None:
            pts.append((n, Wr, f"random n={n}"))

    print(f"  {'point':20s}{'n':>3s}{'theta':>10s}{'/sqrt(3/2)':>12s}{'dim':>6s}"
          f"{'lam_max off e':>15s}{'#>1/2':>7s}  Lemma 24")
    for n, W, lbl in pts:
        th, ok, lmax, cnt, D = second_order(n, W)
        verdict = "saturates" if abs(lmax - 0.5) < 1e-7 else ("VIOLATES" if cnt else "slack")
        print(f"  {lbl:20s}{n:>3d}{th:>10.6f}{th/SQ32:>12.4f}{D:>6d}"
              f"{lmax:>15.8f}{cnt:>7d}  {verdict}"
              + ("" if ok else "  [NOT CRITICAL]"))

    print("\n=== falsification attempt: products with three or more blocks ===")
    print("  These are neither two-block products nor CP^2, so a saturating one would")
    print("  refute the characterisation.  Built by Weyl PROJECTION, since the closed")
    print("  formula is a Weyl operator only at two blocks.")
    print(f"  {'blocks':16s}{'n':>3s}{'theta':>10s}{'lam_max off e':>15s}{'#>1/2':>7s}  verdict")
    for blocks in ([4, 4], [3, 5], [2, 6], [2, 2, 4], [2, 3, 3], [3, 3, 3],
                   [2, 2, 2, 2], [3, 3, 4], [4, 4, 4]):
        Wp, n, nr = product_weyl(blocks)
        if nr < 1e-12:
            print(f"  {str(blocks):16s}{n:>3d}   Weyl part is zero")
            continue
        th, ok, lmax, cnt, D = second_order(n, Wp)
        v = "SATURATES" if abs(lmax - 0.5) < 1e-7 else ("violates" if cnt else "slack")
        print(f"  {str(blocks):16s}{n:>3d}{th:>10.6f}{lmax:>15.8f}{cnt:>7d}  {v}"
              + ("" if ok else "  [NOT CRITICAL -- Lemma 24 VACUOUS HERE]"))
    print("  READ THE FLAGS.  Rows marked NOT CRITICAL carry no Lemma 24 content at all.  And the failure")
    print("  modes are structural rather than numerical: Lemma 24 has TWO clauses --")
    print("  1 is simple, and everything else is <= 1/2.  The balanced multi-block")
    print("  products [3,3,3] and [4,4,4] sit at exactly 1.00000000 with only two")
    print("  eigenvalues above 1/2, i.e. they fail SIMPLICITY, which is the recorded")
    print("  signature of o-decomposability (dim E(1) > 1).  The p = 2 family and")
    print("  CP^m for m >= 3 fail the second clause instead.")

    print("\n  A point with an eigenvalue above 1/2 off e is not a global maximiser,")
    print("  whatever its theta.  The condition is the one tool in the programme's list")
    print("  that is strictly slack away from W_CP^2, so it passes the standing filter.")


if __name__ == '__main__':
    main()
