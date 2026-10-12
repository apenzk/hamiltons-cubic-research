"""RETRACTED HEADLINE.  The band's hard stratum is INHABITED -- by CP^m for every m >= 3.

This file was written to argue that every band witness is diagonal or o-decomposable, so
that item B would split into "the hard stratum is empty" versus "its inhabitant has never
been exhibited".  Gate 2 (Reviewer 73) refuted it with points that were already in this
project's own tables:

    CP^3  n=6   theta=1.054093  dim m=6  < cap 9   S=1e-30  dim E(1)=1  off-diag 0.264
    CP^4  n=8   theta=0.986013  dim m=12 < cap 16  S=5e-30  dim E(1)=1  off-diag 0.197
    CP^5  n=10  theta=0.948683  dim m=20 < cap 25  S=8e-29  dim E(1)=1  off-diag 0.158

Each condition is provable.  dim m = m(m-1) = dim so(2m) - dim u(m), so m is the tangent
space of the symmetric pair SO(2m)/U(m) and [m,m] is inside u(m), perpendicular to m,
giving S = 0.  3 <= m(m-1) < m^2 = floor((2m)^2/4) for every m >= 3.  The top eigenvalue
is simple and its eigenvector is the Kahler form, of bivector rank 2m >= 6, so W is
non-diagonal in EVERY orthonormal frame.  And dim E(1) = 1 with a wide margin.

CP^2 is what hid it: it escapes at the LOWER end, dim m = 2 < 3, and it was used here as
the indecomposable control.

WHAT THE FILE STILL ESTABLISHES, and it is worth keeping:
  * the direct-sum construction and its proof (claim 3 below), CONFIRMED at Gate 2 and
    proved analytically there, including for unequal block sizes;
  * dim E(1) >= k for a k-fold sum, with equality measured;
  * that both named constructions yield only diagonal or decomposable witnesses -- which
    is a fact about those two constructions and NOT about all constructions, as the
    original docstring claimed.

Original text follows.

---

Every constructible band witness is diagonal or o-decomposable -- and both are capped.

THE BAND is {S = 0, 3 <= dim m < floor(n^2/4)}, and item B's whole content is its
NON-DIAGONAL half.  This file asks a prior question: what is actually IN it?

TWO CONSTRUCTIONS EXHAUST WHAT IS KNOWN.

  (1) Circulant critical points -- [b_circulant_band_witnesses.py] finds 9 in the band.
      Every one is DIAGONAL, and diagonal S = 0 points are item B1's territory.

  (2) o-orthogonal DIRECT SUMS.  If W_1, ..., W_k are critical Weyl tensors on disjoint
      coordinate blocks with the SAME theta, their equally-weighted sum is critical:
      Q is block-diagonal with no cross terms, so Q(W) = theta' W with theta' = theta/sqrt(k).
      S = 0 survives because [v, w] = 0 across blocks.  These ARE non-diagonal whenever a
      summand is, and they land in the band -- but they are o-DECOMPOSABLE, which is item
      B2's territory, where a point is capped by its own pieces and can never be extremal.

  The equal-theta hypothesis is necessary only for the EQUALLY WEIGHTED sum.  Criticality
  forces a_i theta_i = theta', so a_i proportional to 1/theta_i makes ANY collection of
  critical Weyl blocks critical, with theta' = (sum_i theta_i^-2)^-1/2.  Gate 2 exhibited
  CP^2 + S^3xS^5 at n = 12 with weights (0.673380, 0.739296): criticality residual
  1.3e-15, theta = 0.824719312 matching the formula, S = 1.2e-28, dim m = 17 < 36 -- in
  the band.  The equal-weight version is what fails, at 3.9e-2, and this file's original
  reading of that failure drew the wrong lesson.

  NON-DIAGONALITY IS TESTED WRONGLY HERE.  max|W - diag W| is FRAME-DEPENDENT, and it is
  the only frame-dependent condition in the stratum's definition, so any point can be
  rotated to satisfy it -- Gate 2 rotated the C_5 blow-up by a generic g in SO(10) and
  got a hard-stratum point with Delta = 12 > 0, hence NOT graded, escaping step H too.
  The correct test is frame-independent: the simple top eigenvector has bivector rank
  greater than 2.

THE CENSUS.  dim E(1) of L_e counts the o-summands (the record: every o-summand lies in
E(1), so dim E(1) = 1 proves indecomposability).  Measured, it equals the summand count
exactly -- 2, 2, 3 -- against 1 at the indecomposable controls CP^2 and S^3xS^5.

SO THE HARD STRATUM HAS NO KNOWN WITNESS.  Non-diagonal AND o-indecomposable AND S = 0
AND 3 <= dim m < floor(n^2/4): nothing in the catalogue, nothing either construction
produces.  That is worth more than another bound, because it splits item B in two:

    either the hard stratum is EMPTY, and the band closes by B1 (diagonal) plus B2
    (decomposable) with no new inequality at all,
    or it is not, and the object that inhabits it has never been exhibited.

FALSIFIER: a witness that is non-diagonal, has dim E(1) = 1, S = 0, and dim m in range.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, sphere_product_W, weyl_basis
from b_symmetry_defect import cpm_W
from review_r34_core import Le_matrix
from b_circulant_band_witnesses import full_profile

SQ32 = np.sqrt(1.5)


def embed(Wsmall, n0, n, off):
    p0, _ = pair_index(n0)
    p1, i1 = pair_index(n)
    W = np.zeros((len(p1), len(p1)))
    for a, (i, j) in enumerate(p0):
        for b, (k, l) in enumerate(p0):
            W[i1[(i + off, j + off)], i1[(k + off, l + off)]] = Wsmall[a, b]
    return W


def direct_sum(pieces, n):
    tot, off = None, 0
    for Ws, n0 in pieces:
        E = embed(Ws / np.linalg.norm(Ws), n0, n, off)
        off += n0
        tot = E if tot is None else tot + E
    return tot / np.linalg.norm(tot)


def dim_E1(n, W, theta):
    B = weyl_basis(n)
    L = Le_matrix(W / theta, n, B)
    ev = np.linalg.eigvalsh(0.5 * (L + L.T))
    return int((np.abs(ev - 1.0) < 1e-8).sum())


def main():
    cases = [
        ("CP^2 + CP^2", direct_sum([(cpm_W(2), 4)] * 2, 8), 8),
        ("CP^2 + CP^2 -> n=10", direct_sum([(cpm_W(2), 4)] * 2, 10), 10),
        ("CP^2 x3", direct_sum([(cpm_W(2), 4)] * 3, 12), 12),
        ("CP^3 + CP^3", direct_sum([(cpm_W(3), 6)] * 2, 12), 12),
        ("S3xS3 + S3xS3", direct_sum([(sphere_product_W([3, 3])[0], 6)] * 2, 12), 12),
        ("CP^2 + S3xS5  [unequal theta]",
         direct_sum([(cpm_W(2), 4), (sphere_product_W([3, 5])[0], 8)], 12), 12),
        ("CP^2  [control]", cpm_W(2), 4),
        ("S^3xS^5  [control]", sphere_product_W([3, 5])[0], 8),
    ]
    print(f"  {'point':32s}{'n':>3s}{'theta':>10s}{'d':>4s}{'cap':>5s}{'S':>9s}"
          f"{'dimE(1)':>9s}  band  crit  shape")
    for lbl, W, n in cases:
        r = full_profile(n, W)
        cap = (n * n) // 4
        crit = r['info']['is_critical']
        k = dim_E1(n, W / np.linalg.norm(W), r['theta']) if crit else -1
        inb = r['S'] < 1e-8 and 3 <= r['d'] < cap
        off = float(np.abs(W - np.diag(np.diag(W))).max())
        shape = ("non-diag" if off > 1e-9 else "diagonal") + \
                (", DECOMPOSABLE" if k > 1 else (", indecomposable" if k == 1 else ""))
        print(f"  {lbl:32s}{n:>3d}{r['theta']:>10.6f}{r['d']:>4d}{cap:>5d}{r['S']:>9.1e}"
              f"{(k if k >= 0 else 0):>9d}  {'YES' if inb else ' . '}"
              f"  {'ok' if crit else 'NO'}  {shape}")
    print("\n  dim E(1) equals the summand count exactly (2, 2, 3) and is 1 at both")
    print("  indecomposable controls, so the census is reading what it claims to read.")
    print("\n  *** THE HEADLINE THIS FILE WAS WRITTEN FOR IS RETRACTED. ***")
    print("  Both named constructions yield only diagonal or o-decomposable witnesses --")
    print("  but that is a fact about those two constructions, not about all of them.")
    print("  The hard stratum IS inhabited: CP^m for every m >= 3 is non-diagonal,")
    print("  o-indecomposable, has S = 0 and dim m = m(m-1) < m^2 = the cap.  CP^3 and")
    print("  CP^4 were already in this project's tables.  See the header.")


if __name__ == '__main__':
    main()
