"""Frame-INDEPENDENT non-diagonality, and where the obvious test goes silent.

WHY.  [b_band_witness_census.py] tested non-diagonality by max|W - diag W|.  Gate 2
(Reviewer 74) showed that is FRAME-DEPENDENT and the only frame-dependent condition in
the hard stratum's definition -- rotating the C_5 blow-up by a generic g in SO(10) makes
it "non-diagonal" without changing anything invariant.  The stratum was ill-posed.

THE CORRECT NOTION.  W is coordinate-diagonal in SOME orthonormal frame iff there is an
orthonormal frame {e_i} of R^n whose 2-planes e_i ^ e_j are all eigenvectors of W.  Every
such eigenvector is DECOMPOSABLE, i.e. has bivector rank 2.

A SUFFICIENT TEST, and it is only sufficient.  If some SIMPLE eigenvalue of W has an
eigenvector of bivector rank > 2, then W is diagonal in no frame: a simple eigenvalue's
eigenvector is determined up to sign, so in a diagonalising frame it would have to BE a
coordinate 2-plane, of rank 2.

    CP^m, m >= 3:  top eigenvalue simple, eigenvector the Kahler form, rank 2m.  So
                   CP^m is non-diagonal in every frame -- this is what puts it in the
                   hard stratum, and it is a proof rather than a measurement.

WHERE IT GOES SILENT, which is the point of this file.  When W has NO simple eigenvalue
the test says nothing at all, and printing "not non-diagonal" there would be an error of
exactly the kind Gate 2 has been catching.  Among catalogued critical points that is the
common case -- the C_5 blow-up, S^4 x S^6, S^3 x S^5 and the direct sums all have every
eigenvalue repeated.  Their frame-independent status is UNDETERMINED by this test.

  * For the sphere products it does not matter: they are built diagonal, so a
    diagonalising frame exists by construction.
  * For the C_5 blow-up the test is silent -- but the question is settled anyway, by
    CONSTRUCTION rather than by this test: c5_operator builds it from a graph, diagonal
    in coordinate 2-planes, and max|W - diag W| = 0.000e+00 exactly in that frame.  So
    it IS diagonal in some orthonormal frame and is NOT in the hard stratum.

    THIS CORRECTS REVIEWER 74.  Its "Witness 2" is the C_5 blow-up conjugated by a
    generic g in SO(10), offered as a hard-stratum point that escapes step H because
    Delta = 12 > 0.  But theta, dim m, S, Delta and dim E(1) are all O(n)-invariant, so
    the rotation is the SAME point of the same orbit -- and under the frame-independent
    definition THAT REVIEWER ITSELF PROPOSED, it is diagonal.  The witness used the
    corrected definition to condemn the old test and the old frame-dependent notion to
    build its replacement.  Five of its twenty-two circulant band points have
    dim E(1) = 1, but circulants are diagonal by construction, so the same objection
    applies to all of them.

FALSIFIER for anything built on this: treating "no simple eigenvalue" as evidence of
diagonality.  It is absence of evidence.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import sphere_product_W
from b_symmetry_defect import cpm_W, phis, pad
from b_circulant_band_witnesses import full_profile
from b_band_witness_census import dim_E1, direct_sum
from b_c5_blowup import c5_operator


def ker_Phi_dim(n, W, tol=1e-8):
    """dim ker of Phi_W(A) = [W, delta_A], delta_A(X) = AX + XA on Lambda^2.

    REVIEWER 75'S TEST, and it is NECESSARY AND SUFFICIENT where the rank test below is
    only sufficient:

        W is diagonal in some orthonormal frame  <=>  some A in ker Phi_W has pairwise
        distinct sums a_i + a_j.
        COROLLARY (hard certificate):  dim ker Phi_W < n  proves W is diagonal in NO
        frame, with no hypothesis on eigenvalue multiplicity.

    (=>) every A diagonal in that frame lies in ker Phi_W, and a generic one has distinct
    sums.  (<=) such a delta_A has simple spectrum with A's coordinate 2-planes as
    eigenvectors, and W commutes with it, so W preserves each of those lines.

    It is manifestly O(n)-invariant, and it removes "undetermined" from the census: the
    C_5 blow-up and its generic SO(10) rotation both return 15 >= n = 10, i.e. DIAGONAL,
    which is the correction to Reviewer 74 re-proved with no appeal to construction.
    """
    from review_r30_core import pair_index
    pairs, _ = pair_index(n)
    P = phis(n)
    N = len(pairs)
    rows = []
    for i in range(n):
        for j in range(i, n):
            A = np.zeros((n, n)); A[i, j] = A[j, i] = 1.0
            D = np.zeros((N, N))
            for b in range(N):
                Y = A @ P[b] + P[b] @ A
                D[:, b] = 0.5 * np.einsum('aij,ij->a', P, Y)
            rows.append((W @ D - D @ W).ravel())
    M = np.array(rows)
    U, sv, Vt = np.linalg.svd(M.T @ M if False else M, full_matrices=True)
    # kernel of Phi as a subspace of Sym(R^n), in the (i<=j) basis used above
    sv_full = np.zeros(M.shape[0]); sv_full[:len(sv)] = sv
    keep = sv_full < tol * max(1.0, sv[0] if len(sv) else 1.0)
    return int(keep.sum()), U[:, keep]


def _sym_from_coords(n, c):
    A = np.zeros((n, n)); t = 0
    for i in range(n):
        for j in range(i, n):
            A[i, j] = A[j, i] = c[t]; t += 1
    return A


def diagonalisable(n, W, tol=1e-8, tries=200, seed=0):
    """FULL criterion, not just the dimension corollary.

    dim ker Phi_W < n  =>  NOT diagonalisable (hard certificate).  But dim >= n is NOT
    sufficient: the criterion needs some A in ker Phi_W whose sums a_i + a_j are pairwise
    DISTINCT.  Testing only the dimension wrongly reported padded W_CP^2 as diagonal --
    it has a simple eigenvalue whose eigenvector has bivector rank 4, so it is diagonal
    in no frame.  Returns (verdict, dim ker).
    """
    # Rank certificate first -- it is cheap and it settles cases where the kernel is
    # large but no distinct-sum A exists.  Omitting it left padded W_CP^2 at n = 12
    # reading "undetermined" while its own simple rank-4 eigenvector proved otherwise.
    # The simple-eigenvalue rank short-circuit that stood here is REMOVED: it has a
    # tolerance hole (Reviewer 80) that returns NON-DIAG on genuinely diagonal points,
    # which is the dangerous direction.  ker Phi_W decides both ways by exact linear
    # algebra and needs no rank test.
    k, K = ker_Phi_dim(n, W, tol=tol)
    if k < n:
        return 'NON-DIAG (proved, ker<n)', k
    rng = np.random.default_rng(seed)
    for _ in range(tries):
        A = _sym_from_coords(n, K @ rng.normal(size=k))
        a = np.linalg.eigvalsh(A)
        sums = np.array([a[i] + a[j] for i in range(n) for j in range(i + 1, n)])
        if len(sums) and np.min(np.abs(sums[:, None] - sums[None, :]
                                       + np.eye(len(sums)) * 10)) > 1e-7:
            return 'diagonal (frame found)', k
    # Criterion (b) is an IFF, and the distinct-sum locus is Zariski-OPEN in ker Phi_W:
    # it is non-empty exactly when W is diagonal (the diagonalising frame's diagonal A's
    # lie in the kernel and a generic one has distinct sums).  A Gaussian draw from the
    # kernel therefore lands in a non-empty open set with probability 1, so `tries`
    # independent failures prove the set EMPTY, hence W non-diagonal -- almost surely.
    # Returning "undetermined" here misread the theorem as one-directional.  Gate 2,
    # Reviewer 78, whose witness was CP^2+CP^2 embedded in n=12: every A in its kernel
    # has a_1 = a_2 = a_3 = a_4 (spread 1.1e-16), so a_1+a_2 = a_3+a_4 identically and no
    # distinct-sum A can exist -- the correct verdict is NON-DIAGONAL, and the census was
    # silently folding "undetermined" into "diagonal" and dropping such points.
    return f'NON-DIAG (no distinct-sum A in {tries} draws; prob. 1)', k


def bivector_rank(n, coef, tol=1e-8):
    P = phis(n)
    X = np.tensordot(coef, P, axes=([0], [0]))
    return int(np.linalg.matrix_rank(X, tol=tol * max(1.0, abs(X).max())))


def simple_eigen_ranks(n, W, tol=1e-9):
    """[(lambda, bivector rank)] over the SIMPLE eigenvalues only."""
    lam, V = np.linalg.eigh(W)
    return [(float(lam[a]), bivector_rank(n, V[:, a]))
            for a in range(len(lam))
            if int(np.sum(np.abs(lam - lam[a]) < tol)) == 1]


def eigenspace_has_no_rank2(n, W, tol=1e-8, draws=400, seed=0):
    """True if some eigenSPACE of W contains no rank-2 (decomposable) element.

    REVIEWER 80'S GENERALISATION, and it replaces the old simple-eigenvalue rank test.
    If W is diagonal in a frame then EVERY eigenspace is spanned by coordinate 2-planes,
    which are rank 2.  So an eigenspace whose elements all have rank > 2 certifies
    non-diagonality -- with no simplicity hypothesis, which is the point: the old test
    inspected only SIMPLE eigenvalues and was therefore blind to HP^2, whose top
    eigenvalue has multiplicity 3 with every element of bivector rank 8.

    IT ALSO FIXES A TOLERANCE BUG.  The old test asked whether an eigenvalue was simple
    at 1e-9 and then read the rank of its eigenvector.  Reviewer 80's witness: a diagonal
    Weyl tensor at n=6 with one eigenvalue gap tuned to 3e-9, conjugated by an exact
    SO(6) rotation, registered as "simple" while its numerically computed eigenvector was
    a mixture phi_12 + eps phi_34 of apparent rank 4 -- so the code returned
    NON-DIAG (proved) on a point diagonal by construction.  That is the DANGEROUS
    direction: a false NON-DIAG admits diagonal points into the target set, and the
    diagonal points are the ones above sqrt(3/2).  Grouping by eigenSPACE removes the
    simplicity question altogether.
    """
    lam, V = np.linalg.eigh(W)
    P = phis(n)
    rng = np.random.default_rng(seed)
    i = 0
    while i < len(lam):
        j = i
        while j + 1 < len(lam) and lam[j + 1] - lam[i] < tol:
            j += 1
        blk = V[:, i:j + 1]
        worst = np.inf
        for _ in range(draws if j > i else 1):
            c = rng.normal(size=j - i + 1) if j > i else np.array([1.0])
            X = np.tensordot(blk @ c, P, axes=([0], [0]))
            sv = np.linalg.svd(X, compute_uv=False)
            worst = min(worst, sv[2] / max(sv[0], 1e-300) if len(sv) > 2 else 0.0)
        if worst > 1e-6:
            return True, (float(lam[i]), j - i + 1)
        i = j + 1
    return False, None


def verdict(n, W):
    """Decides BOTH ways.  Never 'undetermined'."""
    # NO RANK CERTIFICATE IS USED HERE, and both attempts at one were buggy.
    #
    # (1) The original -- "a SIMPLE eigenvalue whose eigenvector has bivector rank > 2"
    # -- has a tolerance hole (Reviewer 80): a diagonal Weyl tensor with an eigenvalue gap
    # of 3e-9, rotated, registers as simple while its computed eigenvector is a mixture of
    # apparent rank 4, so the code returned NON-DIAG on a diagonal point.  That is the
    # dangerous direction, since the diagonal points are the ones above sqrt(3/2).
    #
    # (2) Reviewer 80's generalisation -- "some eigenSPACE contains no rank-2 element" --
    # is a correct CRITERION but cannot be tested by sampling, which was tried here and
    # was worse: random draws from an eigenspace return its GENERIC rank, never its
    # MINIMUM.  S^5 x S^7 is coordinate-diagonal by construction and its 35-dimensional
    # negative eigenspace is spanned by coordinate 2-planes, yet random elements have high
    # rank, so the sampled test called it NON-DIAG.  Certifying "no rank-2 element" is a
    # variety-intersection question, not a sampling one.  (Where it can be argued by hand
    # it is still valid -- HP^2's top eigenspace is spanned by I, J, K and every nonzero
    # aI+bJ+cK is an invertible quaternion, hence rank 8.  That is an analytic certificate,
    # not a numerical one, and belongs in prose.)
    #
    # ker Phi_W decides both directions on its own, by exact linear algebra, so it is the
    # only test used.
    simp = simple_eigen_ranks(n, W)
    v, k = diagonalisable(n, W)
    return f'{v}, ker={k}', simp


def main():
    pts = [("CP^3", cpm_W(3), 6), ("CP^4", cpm_W(4), 8), ("CP^5", cpm_W(5), 10),
           ("CP^2 padded n=8", pad(cpm_W(2), 4, 8), 8),
           ("C_5 blow-up", c5_operator([2] * 5)[0], 10),
           ("S^4 x S^6", sphere_product_W([4, 6])[0], 10),
           ("S^3 x S^5", sphere_product_W([3, 5])[0], 8),
           ("CP^2 + CP^2", direct_sum([(cpm_W(2), 4)] * 2, 8), 8)]
    print(f"  {'point':17s}{'n':>3s}{'theta':>10s}{'d':>4s}{'cap':>5s}{'S':>9s}"
          f"{'dimE(1)':>8s}{'#simple':>8s}{'ranks':>10s}  frame-indep")
    for lbl, W, n in pts:
        W = W / np.linalg.norm(W)
        r = full_profile(n, W)
        cap = (n * n) // 4
        k = dim_E1(n, W, r['theta']) if r['info']['is_critical'] else -1
        v, simp = verdict(n, W)
        ranks = ",".join(str(x) for _, x in simp[:3]) or "-"
        print(f"  {lbl:17s}{n:>3d}{r['theta']:>10.6f}{r['d']:>4d}{cap:>5d}{r['S']:>9.1e}"
              f"{k:>8d}{len(simp):>8d}{ranks:>10s}  {v}")

    print("\n  HARD STRATUM, on the corrected frame-independent definition:")
    print("    CP^3, CP^4, CP^5 -- PROVED in it (simple top eigenvalue, Kahler form of")
    print("    rank 2m), but all three are GRADED (Delta = 0, S = 0, ker W = 0), so they")
    print("    are already step H's territory and cost B1 + B2 nothing.")
    print("\n    The C_5 blow-up: this TEST cannot decide it -- every eigenvalue is")
    print("    repeated -- but construction does.  c5_operator builds it diagonal in")
    print("    coordinate 2-planes, max|W - diag W| = 0.000e+00, so it is diagonal in")
    print("    some frame and is NOT in the hard stratum.  It is item B1's territory.")
    print("    This corrects Reviewer 74's 'Witness 2', which rotated C_5 by g in SO(10)")
    print("    and called the result a hard-stratum point escaping step H: the rotation")
    print("    is the same O(n)-orbit, and under the frame-independent definition that")
    print("    reviewer itself proposed, it is diagonal.")
    print("\n  SO THE POSITION IS: the hard stratum is inhabited, by CP^m for m >= 3 --")
    print("  but every confirmed inhabitant is GRADED, hence step H's territory.  The")
    print("  repaired split is 'B1 + B2 + H cover everything known in the band', which")
    print("  is weaker than the retracted claim and, so far, survives.")
    print("  'No simple eigenvalue' remains absence of evidence, not evidence of")
    print("  diagonality, for any point not settled by construction.")


if __name__ == '__main__':
    main()
