"""theta is not the UNIFORM SINGLE-PLANE third moment of sectional curvature.

SCOPE CORRECTED AFTER GATE 2.  What this file establishes is exactly one thing, and
the record over-read it once already.  Reviewers 69 and 70 computed the moments
EXACTLY -- Wishart determinant moment plus an Isserlis/Wick contraction -- and:

  * the primary argument here is CONFIRMED and stronger than stated.  S^3 x S^3 and
    CP^3 agree in theta to 2e-16 and their third moments are in the ratio EXACTLY
    13.5 (not "about 13 at 265 sigma": there are no standard errors).
  * Psi_3 = a tr(W^3) + b <W,W#> with a/b = -14 EXACTLY for n >= 6, residual 5e-19.
    The Monte-Carlo range -10.8 to -13.9 reported below is superseded by that.
  * the SECONDARY argument -- "theta lies outside the span of the moments at every
    order" -- is REFUTED.  Reviewer 69 built the three-plane correlation
    Phi = E[sec(x,y) sec(y,z) sec(z,x)], a second cubic invariant with a/b = -1/2,
    and since the cubic invariants on Weyl_n (n >= 6) are 2-dimensional,
        theta = c_n Psi_3 + (5/72) Phi ,   c_n = 1050, 2310, 4620 at n = 6, 7, 8,
    exact out-of-sample.  theta IS a closed form in sectional-curvature moments.
  * it is also false at n = 4, 5, where the cubic invariants are 1-dimensional.

The Monte Carlo below is kept because it is what was actually run when the claim was
made, and because it falsifies the third-moment reading on its own.  For any new
work use exact moments, not this.

Original header follows.

---

theta is NOT the third moment of sectional curvature.  Correction to this record.

WHAT WAS RECORDED, AND WHY IT WAS WRONG.  [b_theta3_identification.py] establishes
Theta_3(W) = 32 theta(W) for Weingart's stable cubic Theta_3 = <q(R) * R, R>.  His
2024 paper says of it, verbatim, that the third moment of sectional curvature "IS
RELATED TO the cubic polynomial Theta_3".  That was glossed here as an identification,
and the gloss reached plan.md and findings/INDEX.md as "Conjecture A restates as: the third
moment of sectional curvature is maximised by the balanced sphere product".  It does
not.  "Related to" was carrying real weight.

THE REFUTATION, and it needs no fitting.  On Ricci-flat W the cubic invariants are
spanned by tr(W^3) and <W, W^#>, and theta is their SUM.  A different point of that
2-plane is a different invariant.  S^3 x S^3 and CP^3 have

    theta = 1.054093  both, identical to six decimals,

while their third moments of sec differ by a factor of about 14.  Two points with the
same theta and different third moment cannot be related by any function, so no
normalisation rescues the identification.

The two invariants separate them because the split of theta differs:
    S^3 x S^3 :  tr(W^3) = 0.105409 ,  <W,W#> = 0.948683
    CP^3      :  tr(W^3) = 0.544614 ,  <W,W#> = 0.509478

WHAT IS MEASURED.  E[sec^k] over uniform 2-planes, sec(Sigma) = <W B, B> with
B = x ^ y a unit bivector, by Monte Carlo over K samples with the standard error
reported.  Monte Carlo is legitimate here because it FALSIFIES a written claim; the
gap is two orders of magnitude larger than the reported error.

FALSIFIER for this refutation: the two third moments agreeing within a few standard
errors once K is raised.
"""
import numpy as np, sys, zlib
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, weyl_basis, sphere_product_W
from b_symmetry_defect import cpm_W
from weyl_screen import theta_screened

K_DEFAULT = 2_000_000


def _seed(label):
    """Deterministic seed from a label.

    This replaced ``abs(hash(label)) % 2**31``.  CPython salts str.__hash__ per process
    (PYTHONHASHSEED), so that idiom draws a DIFFERENT sample on every run -- and the
    ratios this file's docstring once quoted, 0.970 at CP^3 and 0.858 at CP^4, came from
    a run nobody can reproduce.  Reviewers 71 and 72 both flagged it; two fresh runs give
    0.967/0.809 and 0.945/0.796.  crc32 is stable across processes and machines.
    """
    return zlib.crc32(label.encode()) & 0x7FFFFFFF


def sec_moments(n, W, K=K_DEFAULT, seed=0):
    """(E[sec], E[sec^2], E[sec^3]) over uniform 2-planes, and the s.e. of the third."""
    rng = np.random.default_rng(seed)
    pairs, _ = pair_index(n)
    I = np.array([p[0] for p in pairs]); J = np.array([p[1] for p in pairs])
    tot = np.zeros(3); tot3sq = 0.0; done = 0
    for chunk in range(0, K, 250_000):
        k = min(250_000, K - chunk)
        X = rng.normal(size=(k, n)); X /= np.linalg.norm(X, axis=1, keepdims=True)
        Y = rng.normal(size=(k, n))
        Y -= np.einsum('ki,ki->k', Y, X)[:, None] * X
        Y /= np.linalg.norm(Y, axis=1, keepdims=True)
        B = X[:, I] * Y[:, J] - X[:, J] * Y[:, I]
        s = np.einsum('ka,ab,kb->k', B, W, B)
        tot += np.array([s.sum(), (s ** 2).sum(), (s ** 3).sum()])
        tot3sq += (s ** 6).sum(); done += k
    m = tot / done
    var3 = tot3sq / done - m[2] ** 2
    return m, float(np.sqrt(max(var3, 0.0) / done))


def main():
    pts = []
    for b in ([3, 3], [4, 4], [3, 5]):
        W, _ = sphere_product_W(b)
        pts.append((sum(b), W / np.linalg.norm(W), f"S^{b[0]} x S^{b[1]}"))
    for m in (3, 4):
        pts.append((2 * m, cpm_W(m), f"CP^{m}"))

    print("=== the refutation: same theta, different third moment ===")
    print(f"  {'point':16s}{'n':>3s}{'theta':>11s}{'tr W^3':>11s}{'<W,W#>':>11s}"
          f"{'E[sec^3]':>14s}{'s.e.':>10s}")
    rows = []
    for n, W, lbl in pts:
        th, info = theta_screened(n, W)
        tr3 = float(np.trace(W @ W @ W))
        m, se = sec_moments(n, W, seed=_seed(lbl))
        rows.append((lbl, n, th, tr3, th - tr3, m[2], se))
        print(f"  {lbl:16s}{n:>3d}{th:>11.6f}{tr3:>11.6f}{th - tr3:>11.6f}"
              f"{m[2]:>14.6e}{se:>10.1e}")

    a = next(r for r in rows if r[0].startswith('S^3 x S^3'))
    b = next(r for r in rows if r[0] == 'CP^3')
    gap = abs(a[5] - b[5]); err = np.hypot(a[6], b[6])
    print(f"\n  S^3 x S^3 and CP^3:  theta {a[2]:.6f} vs {b[2]:.6f}  (identical)")
    print(f"  third moments {a[5]:.6e} vs {b[5]:.6e}   ratio {b[5]/a[5]:.2f}x")
    print(f"  gap {gap:.3e} against combined s.e. {err:.3e}  =  {gap/err:.0f} sigma")
    print("\n  So theta is NOT a function of the third moment of sec, and the recorded")
    print("  restatement of Conjecture A in those terms is withdrawn.  What survives is")
    print("  Theta_3 = 32 theta, which is exact, and fence post 19, which follows from it.")

    print("\n=== the stronger consequence: NO moment combination reaches theta ===")
    print("  On unit-norm Ricci-flat W the moments give:")
    print("    Psi_1 = E[sec] = 0        (Ricci-flat, so scalar curvature vanishes)")
    print("    Psi_2 = E[sec^2]          quadratic, hence CONSTANT on the unit sphere")
    print("    Psi_3 = E[sec^3]          the only degree-3 quantity available")
    print("  Higher moments are degree >= 4 and cannot make a cubic; products with Psi_1")
    print("  vanish.  So every degree-3 invariant built from moments is c * Psi_3 + const,")
    print("  and theta is reachable ONLY if Psi_3 is proportional to theta, i.e. only if")
    print("  the fit Psi_3 = a tr(W^3) + b <W,W#> has a/b = 1.  Measuring a/b:")
    rng = np.random.default_rng(90210)
    for n in (6, 8):
        sub = []
        B = weyl_basis(n)
        for t in range(6):
            co = rng.normal(size=B.shape[0])
            Wt = np.tensordot(co, B, axes=([0], [0])); Wt /= np.linalg.norm(Wt)
            th, _ = theta_screened(n, Wt); tr3 = float(np.trace(Wt @ Wt @ Wt))
            mm, _ = sec_moments(n, Wt, K=1_000_000, seed=1000 + 17 * n + t)
            sub.append((tr3, th - tr3, mm[2], mm[0]))
        A = np.array([[r[0], r[1]] for r in sub]); y = np.array([r[2] for r in sub])
        sol, _, rank, _ = np.linalg.lstsq(A, y, rcond=None)
        resid = np.abs(A @ sol - y).max()
        e1 = max(abs(r[3]) for r in sub)
        print(f"    n={n:2d}  a={sol[0]:+.4e}  b={sol[1]:+.4e}   a/b = {sol[0]/sol[1]:+.3f}"
              f"   (theta needs +1.000)   rank={rank}  max|resid|={resid:.1e}"
              f"   max|Psi_1|={e1:.1e}")
    print("\n  a/b is nowhere near +1, so theta lies outside the span of the sectional-")
    print("  curvature moments at every order.  The moments literature cannot deliver a")
    print("  closed form for theta.  Fence post 20.")
    print("\n  HONEST CAVEAT on this last fit: a/b is Monte-Carlo noisy and has ranged")
    print("  from -10.8 to -13.9 across runs, so its VALUE is not a result.  Its sign and")
    print("  order of magnitude are stable, and the fence post rests on the same-theta")
    print("  pair above -- 265 sigma, no fitting -- not on this number.")


if __name__ == '__main__':
    main()
