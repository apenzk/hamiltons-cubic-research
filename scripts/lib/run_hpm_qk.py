"""
Quaternionic-Kaehler (QK) symmetric space check: builds the algebraic curvature
tensor of a quaternionic space form HP^m (real dimension n=4m) explicitly on
R^n, using Pipeline C's conventions (curvature_operator.py, weyl_decomposition.py,
cp2_tensor.py's index-formula style), and tests whether its Weyl part is an
idempotent of Hamilton's Q map, comparing P/|W|^3 against sqrt(3/2) (Fox's
S^4(alpha) competitor) and the balanced sphere-product value.

FORMULA USED (stated explicitly, per task instructions).
For m>=1, build I,J,K: R^{4m} -> R^{4m} as a BLOCK-DIAGONAL hypercomplex
structure -- m copies of the standard R^4 quaternion left-multiplication
action by i,j,k stacked block-diagonally (i.e. R^{4m} = H^m as a left
H-module, I=J=K acting identically on every 4-block). This is the standard
model for the Sp(m)Sp(1)-invariant "quaternionic structure" on the tangent
space of HP^m (Besse, "Einstein Manifolds", Ch. 14 "Quaternion-Kaehler
Manifolds"; Ishihara, "Quaternion Kaehler manifolds", J. Diff. Geom. 9 (1974);
Salamon, "Quaternionic Kaehler manifolds", Invent. Math. 67 (1982)).

The curvature tensor of the quaternionic space form of quaternionic sectional
curvature c is (Besse 14.42 / Ishihara 1974, eq. for constant Q-sectional
curvature; the same structural form used by cp2_tensor.py for the complex
case, here summed over the three structures I,J,K instead of one J):

  R(X,Y,Z,W) = c1*( g(X,Z)g(Y,W) - g(X,W)g(Y,Z) )
             + c2 * sum_{A in {I,J,K}} [ (A(X,Z)A(Y,W) - A(X,W)A(Y,Z)) + 2 A(X,Y)A(Z,W) ]

(index convention/sign matched to cp2_tensor.py's cp2_tensor(), which was
independently Bianchi-validated there; A(X,Y) := g(AX,Y) is the fundamental
2-form of each of I,J,K). Each single-structure summand A in {I,J,K} is
individually of the exact algebraic shape validated by cp2_tensor.py's
bianchi_test (a genuine orthogonal complex structure's "complex space form"
tensor), so the SUM over I,J,K automatically satisfies the first Bianchi
identity too (Bianchi is linear) -- verified again numerically below as a
non-negotiable first check, not assumed.

The ratio c1:c2 is NOT free: for the actual (unique, up to overall scale)
Sp(m)Sp(1)-invariant symmetric-space curvature tensor of HP^m, group theory
forces a single ratio (any ratio gives an *Einstein* tensor automatically, by
Schur's lemma applied to the irreducible standard Sp(m)Sp(1)-representation on
R^{4m} -- Ricci built equivariantly from an Sp(m)Sp(1)-invariant curvature
tensor must itself be Sp(m)Sp(1)-invariant, hence proportional to g -- so
Einstein-ness alone does NOT pin down c1:c2).

FIRST ATTEMPT (rejected, kept as a documented dead end -- see findings/INDEX.md):
tried calibrating c1:c2 by forcing the Weyl tensor to vanish at m=1 (n=4),
reasoning that HP^1 is isometric to the round S^4. This FAILS as a
calibration: at n=4, Sp(1)xSp(1) = Spin(4) = SO(4) exactly (the classical
low-dimensional coincidence), so the 2-parameter family
c1*(g-KN-g) + c2*(Omega_I+Omega_J+Omega_K) is ALREADY Weyl-flat for EVERY
c1:c2 ratio (verified numerically below: |Weyl|=0 to machine precision at
c1=0,0.5,...,4.0, all simultaneously) -- an SO(4)-representation-theoretic
accident (Lambda^2 R^4 = Lambda^2_+ (+) Lambda^2_-, and any tensor built this
way is a scalar on each summand), not a nontrivial constraint. A numerical
bisection built on this criterion has nothing to lock onto and converges to
floating-point noise, not a real ratio.

CORRECT CALIBRATION USED: the ratio is instead fixed by the actual defining
property of a quaternionic space form (Ishihara 1974; Besse Ch. 14): its
sectional curvature is pinched in [c/4, c], with the maximum c achieved
exactly on "quaternionic lines" (2-planes of the form span(X, AX), A in
{I,J,K}) and the minimum c/4 achieved exactly on "totally real" 2-planes
orthogonal to the whole quaternionic 4-plane through X (e.g. two different
H-summands of R^{4m} = H^m). This is checked directly below by evaluating
sectional curvature K(X,Y) = -T(X,Y,Y,X) (sign flipped to match the
positive-curvature convention, consistent with the round-sphere sub-case
c2=0) on both kinds of planes as a function of c1 (c2 fixed at 1): the ratio
K_quaternionic-line / K_totally-real equals exactly 4.0 at c1=c2=1.0 (and only
there among the values tested), matching the textbook pinching ratio exactly.
c1=c2 is therefore used throughout as the correct, literature-matching ratio
for the genuine HP^m tensor -- confirmed independently of the flawed m=1 Weyl
argument, and incidentally the same "equal coefficient" convention already
used for the single-structure CP^2 case in cp2_tensor.py (alpha=alpha there).
"""
import numpy as np
from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, ricci_from_mop, mop_from_4tensor, norm, frob, P_value

SQRT_3_2 = np.sqrt(3.0 / 2.0)


def quaternion_block_generators(n, m):
    """I, J, K as n x n endomorphism matrices (n=4m), block-diagonal, each of
    the m 4x4 blocks carrying the IDENTICAL standard quaternion action
    (R^{4m} = H^m as a left H-module). Same per-block action/convention as
    run_cp2_quaternion.py's quaternion_generators (M[b,a] = <M e_a, e_b>)."""
    I = np.zeros((n, n)); J = np.zeros((n, n)); K = np.zeros((n, n))
    for b in range(m):
        b0, b1, b2, b3 = 4 * b, 4 * b + 1, 4 * b + 2, 4 * b + 3
        I[b1, b0] = 1.0; I[b0, b1] = -1.0
        I[b3, b2] = 1.0; I[b2, b3] = -1.0
        J[b2, b0] = 1.0; J[b0, b2] = -1.0
        J[b3, b1] = -1.0; J[b1, b3] = 1.0
        K[b3, b0] = 1.0; K[b0, b3] = -1.0
        K[b2, b1] = 1.0; K[b1, b2] = -1.0
    return I, J, K


def check_hypercomplex_relations(n, m):
    I, J, K = quaternion_block_generators(n, m)
    errs = {
        "I^2+Id": np.max(np.abs(I @ I + np.eye(n))),
        "J^2+Id": np.max(np.abs(J @ J + np.eye(n))),
        "K^2+Id": np.max(np.abs(K @ K + np.eye(n))),
        "IJ-K": np.max(np.abs(I @ J - K)),
        "JK-I": np.max(np.abs(J @ K - I)),
        "KI-J": np.max(np.abs(K @ I - J)),
        "IJ+JI": np.max(np.abs(I @ J + J @ I)),
    }
    return errs


def qk_tensor(n, m, c1, c2, ambient_block=None):
    """Build T(i,j,k,l) for the quaternionic-space-form-type curvature tensor
    on the 4m-dimensional hypercomplex block, zero outside if ambient_block
    covers a smaller set than range(n) (for the zero-padding experiment).
    ambient_block: iterable of indices where the 4m-dim structure lives
    (defaults to range(4m), i.e. no padding, n must equal 4m)."""
    if ambient_block is None:
        assert n == 4 * m
        ambient_block = list(range(4 * m))
    else:
        assert len(ambient_block) == 4 * m
    # Build I,J,K only on the 4m x 4m sub-block, embedded into n x n.
    Isub, Jsub, Ksub = quaternion_block_generators(4 * m, m)
    I = np.zeros((n, n)); J = np.zeros((n, n)); K = np.zeros((n, n))
    for a in range(4 * m):
        for b in range(4 * m):
            ia, ib = ambient_block[a], ambient_block[b]
            I[ia, ib] = Isub[a, b]
            J[ia, ib] = Jsub[a, b]
            K[ia, ib] = Ksub[a, b]
    Imat = I.T.copy(); Jmat = J.T.copy(); Kmat = K.T.copy()
    d = np.eye(n)
    blockset = set(ambient_block)

    def T(i, j, k, l):
        if not (i in blockset and j in blockset and k in blockset and l in blockset):
            return 0.0
        val = c1 * (d[i, k] * d[j, l] - d[i, l] * d[j, k])
        for A in (Imat, Jmat, Kmat):
            val += c2 * ((A[i, k] * A[j, l] - A[i, l] * A[j, k]) + 2 * A[i, j] * A[k, l])
        return val
    return T


def bianchi_check(n, m, c1, c2, ambient_block=None, sample=6):
    T = qk_tensor(n, m, c1, c2, ambient_block)
    idxs = list(range(min(n, sample)))
    maxerr = 0.0
    import itertools
    for i, j, k, l in itertools.product(idxs, repeat=4):
        val = T(i, j, k, l) + T(i, k, l, j) + T(i, l, j, k)
        maxerr = max(maxerr, abs(val))
    return maxerr


def analyze(n, m, c1, c2, ambient_block=None, label="", verbose=True):
    L2 = Lambda2(n)
    T = qk_tensor(n, m, c1, c2, ambient_block)
    Mop = mop_from_4tensor(L2, T)
    Ric = ricci_from_mop(L2, Mop)
    S = np.trace(Ric)
    # Einstein check: Ric - (S/n_eff) g on the support block should vanish.
    if ambient_block is None:
        support = list(range(4 * m))
    else:
        support = list(ambient_block)
    n_eff = len(support)
    ric_sub = Ric[np.ix_(support, support)]
    einstein_const = np.trace(ric_sub) / n_eff
    einstein_resid = np.max(np.abs(ric_sub - einstein_const * np.eye(n_eff)))
    off_support_ric = np.max(np.abs(Ric)) - np.max(np.abs(ric_sub)) if n > n_eff else 0.0

    Weyl, Ric2, S2 = weyl_from_mop(L2, Mop)
    Wn_norm = norm(Weyl)
    result = {
        "n": n, "m": m, "c1": c1, "c2": c2, "einstein_const": einstein_const,
        "einstein_resid": einstein_resid, "weyl_norm": Wn_norm,
    }
    if Wn_norm < 1e-9:
        result["P_normalized"] = 0.0
        result["idempotent_reldiff"] = None
        if verbose:
            print(f"[{label}] n={n} m={m} c1={c1:.4f} c2={c2:.4f}: "
                  f"Einstein const={einstein_const:.6f} (resid {einstein_resid:.2e}), "
                  f"WEYL IS ZERO (|W|={Wn_norm:.2e})")
        return result
    Q = Q_op(L2, Weyl)
    Pv = frob(Weyl, Q)
    Pnorm = Pv / Wn_norm ** 3
    Wunit = Weyl / Wn_norm
    Qu = Q_op(L2, Wunit)
    lam = frob(Wunit, Qu)
    reldiff = norm(Qu - lam * Wunit) / norm(Qu) if norm(Qu) > 0 else float('nan')
    result["P_normalized"] = Pnorm
    result["idempotent_reldiff"] = reldiff
    if verbose:
        print(f"[{label}] n={n} m={m} c1={c1:.4f} c2={c2:.4f}: "
              f"Einstein const={einstein_const:.6f} (resid {einstein_resid:.2e}), "
              f"|Weyl|={Wn_norm:.6f}, P/|W|^3={Pnorm:+.6f}, idempotent-reldiff={reldiff:.5f}")
    return result


def sphere_product_value(n):
    return np.sqrt(2 * (n - 1) * (n - 2) / n ** 2)


if __name__ == "__main__":
    print("=== 0. hypercomplex relations (m=2, n=8; should all be ~0) ===")
    for k, v in check_hypercomplex_relations(8, 2).items():
        print(f"  {k}: {v:.3e}")

    print("\n=== 1. Bianchi identity check for c1=c2=1.0, m=1,2,3 ===")
    for m in [1, 2, 3]:
        n = 4 * m
        err = bianchi_check(n, m, 1.0, 1.0, sample=min(n, 6))
        print(f"  m={m} n={n}: max Bianchi violation (sample) = {err:.2e}")

    print("\n=== 2a. dead end documented: at m=1 (n=4), Weyl=0 for EVERY c1:c2 ratio ===")
    print("    (SO(4)=Sp(1)xSp(1) accident -- cannot calibrate the ratio this way)")
    n = 4
    for c1 in [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0]:
        L2 = Lambda2(n)
        T = qk_tensor(n, 1, c1, 1.0)
        Mop = mop_from_4tensor(L2, T)
        Weyl, Ric, S = weyl_from_mop(L2, Mop)
        print(f"    c1={c1:.2f} c2=1.00: |Weyl|={norm(Weyl):.6e}  Ric_00={Ric[0,0]:.4f}")

    print("\n=== 2b. correct calibration: sectional-curvature pinching [c/4,c] at m=2 (n=8) ===")
    print("    K(quaternionic line)/K(totally-real plane) must equal exactly 4")
    for c1 in [0.0, 0.5, 1.0, 1.5, 2.0, 3.0]:
        T = qk_tensor(8, 2, c1, 1.0)
        Kq = -T(0, 1, 1, 0)   # quaternionic line: e1 = I e0
        Kr = -T(0, 4, 4, 0)   # totally real: e4 in a different H-summand
        ratio = Kq / Kr if abs(Kr) > 1e-12 else float('nan')
        print(f"    c1={c1:.2f} c2=1.00: K_quat={Kq:.4f}  K_real={Kr:.4f}  ratio={ratio:.4f}")
    c1_star = 1.0
    print(f"\n  ==> ratio = 4.0 exactly at c1=c2={c1_star:.1f}: this is the genuine HP^m ratio, used below.")

    print("\n=== 3. genuine HP^m tensor (c1=c1*, c2=1) at m=1,2,3,4: Einstein + Weyl idempotency ===")
    results = {}
    for m in [1, 2, 3, 4]:
        n = 4 * m
        res = analyze(n, m, c1_star, 1.0, label=f"HP^{m}")
        results[m] = res

    print("\n=== 4. P-value comparison table ===")
    print(f"{'m':>3} {'n':>4} {'P/|W|^3 (QK)':>14} {'idemp reldiff':>14} {'sqrt(3/2)':>10} {'sphere-prod':>12}")
    for m in [1, 2, 3, 4]:
        n = 4 * m
        r = results[m]
        pn = r.get("P_normalized")
        rd = r.get("idempotent_reldiff")
        pn_s = f"{pn:+.6f}" if pn is not None else "   (zero)"
        rd_s = f"{rd:.5f}" if rd is not None else "    n/a"
        print(f"{m:>3} {n:>4} {pn_s:>14} {rd_s:>14} {SQRT_3_2:>10.6f} {sphere_product_value(n):>12.6f}")

    print("\n=== 5. zero-padding experiment: embed HP^2 (n=8, m=2) into ambient N=12, zero outside ===")
    N = 12
    block = list(range(8))
    res_pad = analyze(N, 2, c1_star, 1.0, ambient_block=block, label="HP^2 padded into N=12")

    if res_pad.get("idempotent_reldiff") is not None and res_pad["idempotent_reldiff"] > 0.01:
        print("\n  Not idempotent once padded -- scanning c1:c2 ratio (Weyl-part-Ricci-flat analogue,")
        print("  mirroring the CP^2 case's s:t=1:-1 trick) for a ratio idempotent under the LARGER ambient Q.")
        best = None
        for c1_try in np.linspace(-2.0, 6.0, 33):
            L2 = Lambda2(N)
            T = qk_tensor(N, 2, c1_try, 1.0, ambient_block=block)
            Mop = mop_from_4tensor(L2, T)
            Weyl, Ric, S = weyl_from_mop(L2, Mop)
            nv = norm(Weyl)
            if nv < 1e-9:
                continue
            Q = Q_op(L2, Weyl)
            Pv = frob(Weyl, Q)
            Pnorm = Pv / nv ** 3
            Wu = Weyl / nv
            Qu = Q_op(L2, Wu)
            lam = frob(Wu, Qu)
            reldiff = norm(Qu - lam * Wu) / norm(Qu)
            print(f"    c1={c1_try:+.3f}: P/|W|^3={Pnorm:+.6f}  idemp-reldiff={reldiff:.5f}")
            if best is None or reldiff < best[1]:
                best = (c1_try, reldiff, Pnorm)
        print(f"\n  best found: c1={best[0]:+.4f}, reldiff={best[1]:.5f}, P/|W|^3={best[2]:+.6f}")
    else:
        print("  Padded tensor remains idempotent (or Weyl vanished); no scan needed.")

    print("\n=== summary ===")
    for m in [1, 2, 3, 4]:
        n = 4 * m
        r = results[m]
        pn = r.get("P_normalized")
        print(f"m={m} (n={n}): P/|W|^3 = {pn}, sqrt(3/2)={SQRT_3_2:.6f}, "
              f"sphere-product={sphere_product_value(n):.6f}")
