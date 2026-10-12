"""Reviewer 46: the closed form for TWO-EIGENVALUE critical points, without
assuming h is a subalgebra.

W = beta Pi_h + alpha Pi_m,  alpha < 0 < beta,  r beta + d alpha = 0.
Write sigma_k for the sum of c_{abg}^2 over ORDERED triples with exactly k
indices in m.  Then, with kappa = 2(n-2) the Casimir constant,

    (1/3) sigma_1 + (2/3) sigma_2 +      sigma_3 = d kappa
         sigma_0 + (2/3) sigma_1 + (1/3) sigma_2 = r kappa

and the two block equations of Q(W) = theta W give theta as an explicit
function of (d, sigma_1, sigma_3) alone.  sigma_3 is the structural slack
S_mmm; sigma_1 is the OTHER grading defect, simultaneously [h,h] -> m and
[h,m] -> h by total antisymmetry.  Z_2-graded means sigma_1 = sigma_3 = 0.
"""
import numpy as np
import sympy as sp
from review_r46_core import (structure_constants, negative_part, P_of, Q_of,
                             slack_structural, slack_hhm)
from review_r46_t3_hunt import (petersen, clebsch, perfect_matching,
                                complete_bipartite, srg_point, diag_operator)


def symbolic():
    n, d, r, N, s1, s3, th = sp.symbols('n d r N sigma_1 sigma_3 theta', positive=True)
    kap = 2 * (n - 2)
    s2 = sp.Rational(3, 2) * (d * kap - s3) - sp.Rational(1, 2) * s1
    s0 = r * kap - sp.Rational(2, 3) * s1 - sp.Rational(1, 3) * s2
    al = -1
    be = d / r
    trh = sp.Rational(1, 2) * (be**2 * s0 + al * be * sp.Rational(2, 3) * s1
                               + al**2 * sp.Rational(1, 3) * s2)
    trm = sp.Rational(1, 2) * (be**2 * sp.Rational(1, 3) * s1
                               + al * be * sp.Rational(2, 3) * s2 + al**2 * s3)
    eq_h = sp.Eq(be**2 + trh / r, th * be)
    eq_m = sp.Eq(al**2 + trm / d, th * al)
    th_m = sp.simplify(sp.solve(eq_m, th)[0])
    th_h = sp.simplify(sp.solve(eq_h, th)[0])
    print("theta from the m-block equation:")
    sp.pprint(sp.simplify(th_m))
    print()
    print("theta from the h-block equation:")
    sp.pprint(sp.simplify(th_h))
    print()
    compat = sp.simplify(sp.together(th_m - th_h))
    print("consistency condition (must vanish), numerator:")
    sp.pprint(sp.factor(sp.numer(sp.simplify(compat)).subs(r, N - d)))
    print()
    # specialise to the graded case sigma_1 = sigma_3 = 0
    print("graded case sigma_1 = sigma_3 = 0:")
    sp.pprint(sp.simplify(th_m.subs({s1: 0, s3: 0})))
    print("  (and the h-equation then forces:)")
    sp.pprint(sp.factor(sp.numer(sp.simplify(compat.subs({s1: 0, s3: 0}))).subs(r, N - d)))
    print()
    return th_m, th_h, (n, d, r, N, s1, s3)


def sigmas(c, W, tol=1e-9):
    _, Pm, _, _ = negative_part(W, tol)
    Ph = np.eye(W.shape[0]) - Pm
    def proj(P1, P2, P3):
        t = np.einsum('abg,ax->xbg', c, P1, optimize=True)
        t = np.einsum('xbg,by->xyg', t, P2, optimize=True)
        t = np.einsum('xyg,gz->xyz', t, P3, optimize=True)
        return float(np.sum(t * t))
    s0 = proj(Ph, Ph, Ph)
    s1 = 3 * proj(Ph, Ph, Pm)
    s2 = 3 * proj(Ph, Pm, Pm)
    s3 = proj(Pm, Pm, Pm)
    return s0, s1, s2, s3


def check(name, n, W, th_m, syms):
    (nn, dd, rr, NN, ss1, ss3) = syms
    c = structure_constants(n)
    W = W / np.linalg.norm(W)
    th = P_of(c, W)
    if th < 0:
        W, th = -W, -th
    N = W.shape[0]
    ev = np.linalg.eigvalsh(W)
    d = int((ev < -1e-9).sum())
    r = N - d
    s0, s1, s2, s3 = sigmas(c, W)
    kap = 2 * (n - 2)
    ok1 = abs(s1 / 3 + 2 * s2 / 3 + s3 - d * kap)
    ok2 = abs(s0 + 2 * s1 / 3 + s2 / 3 - r * kap)
    # theta from the formula, then rescale: the formula uses alpha = -1
    alpha = ev[0]
    pred = float(th_m.subs({nn: n, dd: d, rr: r, NN: N, ss1: s1, ss3: s3}))
    pred_scaled = pred * abs(alpha)
    print(f"{name:22s} n={n:3d} d={d:4d} r={r:4d}  sigma_1={s1:9.2f} sigma_3={s3:9.2f}  "
          f"casimir checks {ok1:.1e},{ok2:.1e}")
    print(f"{'':22s} theta measured = {th:.9f}   from the closed form = {pred_scaled:.9f}  "
          f"diff {abs(th-pred_scaled):.2e}")
    print(f"{'':22s} eigenvalues: {alpha:.6f} (x{d}), {ev[-1]:.6f} (x{r})  "
          f"two-eigenvalue: {np.allclose(ev, np.where(ev<0, alpha, ev[-1]), atol=1e-9)}")
    return th, s1, s3, d


if __name__ == "__main__":
    th_m, th_h, syms = symbolic()
    print("=== the closed form against measured two-eigenvalue critical points ===")
    tests = [("S^4xS^4 (K_{4,4})", complete_bipartite(4, 4)),
             ("S^6xS^6 (K_{6,6})", complete_bipartite(6, 6)),
             ("Cartan/matching n=8", perfect_matching(8)),
             ("Cartan/matching n=12", perfect_matching(12)),
             ("Petersen n=10", petersen()),
             ("Clebsch n=16", clebsch())]
    for name, A in tests:
        n = A.shape[0]
        lam, _, _ = srg_point(A)
        W = diag_operator(n, {(i, j): lam[i, j] for i in range(n) for j in range(i + 1, n)})
        check(name, n, W, th_m, syms)
        print()


# --------------------------------------------------------------------------
# The consistency condition, solved and exploited.
#
#   sigma_1 = 3 sigma_3 + (6 d / n) (n^2 - 4 d)
#
# so at a two-eigenvalue critical point the two grading defects are LINEARLY
# DEPENDENT.  Consequences, all immediate:
#   * graded (sigma_1 = sigma_3 = 0)  <=>  dim m = n^2/4;
#   * S = 0 (sigma_3 = 0) with dim m != n^2/4 forces sigma_1 > 0: an ungraded
#     point with zero slack, at EVERY admissible dim m below n^2/4;
#   * sigma_1 >= 0 gives  S = 0  =>  dim m <= n^2/4,
#     and dim m > n^2/4 gives the lower bound S = sigma_3 >= (2d/n)(4d - n^2).

def law(n, d, s3):
    return 3.0 * s3 + (6.0 * d / n) * (n * n - 4.0 * d)


def theta_hat(n, d, s3):
    """Normalised theta of the two-eigenvalue critical point with these data."""
    N = n * (n - 1) // 2
    r = N - d
    s1 = law(n, d, s3)
    raw = (d * (n - 2) - r) / r - s1 * (d + r) / (6.0 * r * r) \
        - s3 / (2.0 * r) - s3 / (2.0 * d)
    return raw * np.sqrt(r / (d * N))


def scan():
    print()
    print("=== the two-eigenvalue law  sigma_1 = 3 sigma_3 + (6d/n)(n^2 - 4d) ===")
    for (name, n, d, s3) in (("S^4xS^4", 8, 16, 0.0), ("S^6xS^6", 12, 36, 0.0),
                             ("matching n=8", 8, 24, 192.0), ("matching n=12", 12, 60, 960.0),
                             ("Petersen", 10, 15, 0.0), ("Clebsch", 16, 40, 0.0)):
        print(f"  {name:14s} n={n:3d} d={d:4d} s3={s3:8.1f} -> law predicts "
              f"sigma_1 = {law(n,d,s3):9.1f};  theta_hat = {theta_hat(n,d,s3):.9f}")
    print()
    print("=== how high can an UNGRADED two-eigenvalue critical point with S = 0 go? ===")
    print("    (S = 0 forces dim m <= n^2/4, with equality exactly at the graded point)")
    print(f"  {'n':>4} {'theta_0':>10} {'d=n^2/4':>8} {'best d != n^2/4':>16} "
          f"{'best theta_hat':>15} {'ratio':>7}")
    for n in (8, 10, 12, 14, 16, 20, 24, 40):
        N = n * (n - 1) // 2
        th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
        dstar = n * n // 4
        best, bd = -9e9, None
        for d in range(1, min(N, dstar + 1)):
            if d == dstar:
                continue
            t = theta_hat(n, d, 0.0)
            if t > best:
                best, bd = t, d
        print(f"  {n:4d} {th0:10.6f} {dstar:8d} {bd:16d} {best:15.9f} {best/th0:7.4f}")
    print()
    print("  (this bound is over the ADMISSIBLE range of d only; whether a critical")
    print("   point actually exists at a given d is a separate, stronger question.)")


if __name__ == "__main__":
    scan()
