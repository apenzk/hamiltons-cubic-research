"""Berger's inequality on Weyl_n -- a classical pointwise constraint the record lacks.

WHERE IT CAME FROM.  Chasing the ingredient [b_lambda_weighted_bound.py] is missing --
control of |lam_min| on the band -- led to [Ge arXiv:2607.18216], whose sharp estimates
rest on the generalized Berger inequality of Ni-Wilking.  Ge's own theorem is vacuous on
Weyl_n (it needs nonnegative sectional curvature, which with zero scalar curvature forces
flatness), but the CLASSICAL Berger inequality carries no sign hypothesis at all:

  for an algebraic curvature tensor with sectional curvatures in [k, K] and any
  orthonormal four-frame,        |R(e1,e2,e3,e4)|  <=  (2/3) (K - k).

WHY IT IS WORTH HAVING.  It constrains R's OFF-DIAGONAL component against the RANGE of
its sectional curvature.  That is a different kind of constraint from the block masses,
pair caps and row marginals of T whose class Reviewers 67/68 proved has a ceiling of
1.60/2.29/2.49 at n = 6, 8, 12 -- those are all statements about T's marginals, and this
one is not.  The off-diagonal component is also exactly what <W, W^#> is built from, and
[fence post 11] records that the # term carries almost all of theta where theta is large.

WHAT THIS SCRIPT DOES -- screening, not search.
  (1) verifies the inequality at random orthonormal four-frames on catalogued and random
      Weyl tensors, with K_max and K_min estimated from random 2-planes.  Sampling
      UNDERSTATES the range, so the right-hand side is too small and the test is
      conservative: a pass is stronger than it looks, a violation would need checking.
  (2) reports the ratio of the observed off-diagonal maximum to the Berger bound.
      ** THE SAMPLED RATIO IS A LOWER BOUND AND NOTHING MORE. ** Sampling understates
      both the numerator and the denominator, so the column is biased downward by an
      uncontrolled amount.  Reviewers 71 and 72 computed the EXACT ratios by L-BFGS over
      the Grassmannian and over orthonormal four-frames, independently and agreeing:

          exactly 1.000 at CP^2, CP^3, CP^4, CP^5 and HP^2 -- Berger is TIGHT there,
          exactly 0.750 at S^3xS^3, S^6xS^6 and the C_5 blow-up.

      The docstring of this file once quoted 0.970 and 0.858 against "0.45-0.72
      elsewhere".  Those were sampled, and they were also drawn with a per-process
      random seed, so no run reproduces them.  The true contrast is 0.75 against 1.00.
  (3) reports (K_max - K_min) against lam_max - lam_min, which is what would connect it
      to the |lam_min| question.

FALSIFIER: a four-frame violating the inequality (would mean the convention here is
wrong, since Berger is a theorem).
"""
import numpy as np, sys, zlib
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, weyl_basis, sphere_product_W
from b_symmetry_defect import cpm_W
from b_theta3_identification import tensor_of
from b_c5_blowup import c5_operator
from weyl_screen import theta_screened


def _seed(label):
    """Deterministic seed from a label.

    This replaced ``abs(hash(label)) % 2**31``.  CPython salts str.__hash__ per process
    (PYTHONHASHSEED), so that idiom draws a DIFFERENT sample on every run -- and the
    ratios this file's docstring once quoted, 0.970 at CP^3 and 0.858 at CP^4, came from
    a run nobody can reproduce.  Reviewers 71 and 72 both flagged it; two fresh runs give
    0.967/0.809 and 0.945/0.796.  crc32 is stable across processes and machines.
    """
    return zlib.crc32(label.encode()) & 0x7FFFFFFF


def sec_range(n, R, K=200000, seed=0):
    """(K_min, K_max) over random 2-planes; sampling understates the range."""
    rng = np.random.default_rng(seed)
    X = rng.normal(size=(K, n)); X /= np.linalg.norm(X, axis=1, keepdims=True)
    Y = rng.normal(size=(K, n))
    Y -= np.einsum('ki,ki->k', Y, X)[:, None] * X
    Y /= np.linalg.norm(Y, axis=1, keepdims=True)
    s = np.einsum('ijkl,ki,kj,kk2,kl2->k', R, X, Y, X, Y,
                  optimize=True) if False else np.einsum(
        'ijkl,ai,aj,ak,al->a', R, X, Y, X, Y, optimize=True)
    return float(s.min()), float(s.max())


def offdiag_max(n, R, K=40000, seed=1):
    """max |R(e1,e2,e3,e4)| over random orthonormal four-frames."""
    rng = np.random.default_rng(seed)
    best = 0.0
    for _ in range(0, K, 4000):
        G = rng.normal(size=(4000, n, 4))
        Q, _ = np.linalg.qr(G)                        # (4000, n, 4) orthonormal columns
        v = np.einsum('ijkl,ai,aj,ak,al->a', R, Q[:, :, 0], Q[:, :, 1],
                      Q[:, :, 2], Q[:, :, 3], optimize=True)
        best = max(best, float(np.abs(v).max()))
    return best


def main():
    pts = [(6, sphere_product_W([3, 3])[0], "S^3 x S^3"),
           (12, sphere_product_W([6, 6])[0], "S^6 x S^6"),
           (6, cpm_W(3), "CP^3"), (8, cpm_W(4), "CP^4"),
           (10, c5_operator([2] * 5)[0], "C_5 blow-up")]
    rng = np.random.default_rng(7)
    for n in (6, 8):
        B = weyl_basis(n)
        for t in range(2):
            co = rng.normal(size=B.shape[0])
            pts.append((n, np.tensordot(co, B, axes=([0], [0])), f"random n={n} #{t}"))

    print(f"  {'point':18s}{'n':>3s}{'theta':>10s}{'K_min':>9s}{'K_max':>9s}"
          f"{'lam_min':>9s}{'lam_max':>9s}{'max|R1234|':>11s}{'Berger':>9s}{'ratio>=':>9s}  ok?")
    worst = 0.0
    for n, W, lbl in pts:
        W = W / np.linalg.norm(W)
        th, info = theta_screened(n, W)
        R = tensor_of(n, W)
        kmin, kmax = sec_range(n, R, seed=_seed(lbl))
        od = offdiag_max(n, R, seed=_seed(lbl) + 1)
        lam = np.linalg.eigvalsh(W)
        berger = (2.0 / 3.0) * (kmax - kmin)
        ok = od <= berger + 1e-9
        worst = max(worst, od - berger)
        print(f"  {lbl:18s}{n:>3d}{th:>10.6f}{kmin:>9.4f}{kmax:>9.4f}"
              f"{lam[0]:>9.4f}{lam[-1]:>9.4f}{od:>11.6f}{berger:>9.4f}"
              f"{od/berger:>8.3f}  {'yes' if ok else 'NO'}")
    print(f"\n  worst excess over the Berger bound: {worst:.2e}  (negative = never violated)")
    print("  The ratio column is a LOWER BOUND -- sampling understates both sides.")
    print("  Exact values (Gate 2, Reviewers 71 and 72, independently): Berger is")
    print("  EXACTLY TIGHT, ratio 1.000, at CP^2, CP^3, CP^4, CP^5 and HP^2, and")
    print("  exactly 0.750 at S^3xS^3, S^6xS^6 and the C_5 blow-up.  The true contrast")
    print("  is 0.75 against 1.00, much narrower than the 0.45-0.72 once recorded.")
    print()
    print("  BUT THE ROUTE THIS WAS CHASING IS DEAD, and the K/lam columns say why.")
    print("  Berger constrains SECTIONAL curvature, and at the Kahler points sectional")
    print("  curvature does not see lam_min: K_min = -0.079 against lam_min = -0.211 at")
    print("  CP^3, and -0.042 against -0.141 at CP^4 -- factors of 2.7 and 3.3.  The")
    print("  minimising bivector there is NON-DECOMPOSABLE (the Kahler form direction),")
    print("  so no 2-plane witnesses it.  Any machinery phrased in sectional curvature")
    print("  is therefore blind to |lam_min| at exactly the points that matter.")
    print()
    print("=== and QUANTITATIVELY, the best Berger can do is far too weak ===")
    print("  Put a unit bivector in canonical form, xi = sum_i sig_i e_{2i-1}^e_{2i} with")
    print("  sum sig_i^2 = 1 and at most r = floor(n/2) terms, the planes P_i mutually")
    print("  orthogonal.  Then <W xi, xi> = sum_i sig_i^2 K(P_i) + sum_{i/=j} sig_i sig_j")
    print("  R(e_{2i-1},e_{2i},e_{2j-1},e_{2j}), and each off-diagonal term sits on an")
    print("  orthonormal FOUR-frame, so Berger applies to it.  With ||sig||_1 <= sqrt(r):")
    print()
    print("      |lam_min|  <=  |K_min| + (2/3)(K_max - K_min)(r - 1) ,  r = floor(n/2).")
    print()
    print(f"  {'point':18s}{'n':>3s}{'|lam_min|':>11s}{'Berger bd':>11s}{'slack':>8s}"
          f"{'needed':>9s}{'short by':>10s}")
    for n, W, lbl in pts:
        W = W / np.linalg.norm(W); R = tensor_of(n, W)
        kmin, kmax = sec_range(n, R, seed=_seed(lbl))
        lam = np.linalg.eigvalsh(W); r = n // 2
        bd = abs(kmin) + (2.0 / 3.0) * (kmax - kmin) * (r - 1)
        need = np.sqrt(1.5) / (n - 1)      # what the theta <= sqrt(3/2) bound would need
        print(f"  {lbl:18s}{n:>3d}{abs(lam[0]):>11.6f}{bd:>11.6f}"
              f"{bd/abs(lam[0]):>8.2f}x{need:>9.4f}{bd/need:>9.1f}x")
    print()
    print("  The 'needed' column is sqrt(3/2)/(n-1), the value of |lam_min| at which the")
    print("  lambda-weighted bound would give theta <= sqrt(3/2) with Delta = 0.  Berger's")
    print("  best overshoots it by the factor in the last column, and that factor GROWS")
    print("  with n because the (r - 1) term does.  So the route is closed quantitatively")
    print("  as well as structurally.")


if __name__ == '__main__':
    main()
