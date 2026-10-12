"""
The idempotent gap at the defect frontier -- proof machinery, falsification
search, and Peirce/fusion structure.

TARGET (open): every critical point W of P on the unit Weyl sphere with
theta = P(W) > sqrt(3/2) has Alt(W_-) = 0 (zero Bianchi defect), i.e.
sup{theta : W critical, delta^2(W) > 0} = sqrt(3/2), attained only on the
Fox orbit.

WHAT THIS FILE PROVES AND VERIFIES (each step machine-checked below):

  THEOREM (graded compression inequality).  Let W be Weyl, ||W|| arbitrary,
  and critical: Q(W) = W^2 + W# = theta W.  Write W = W_+ - W_- (spectral
  parts, both PSD, W_+ W_- = 0), m = tr W_- = tr W_+ (Lambda^2-trace-free),
  rho = Ric(W_-) = Ric(W_+), delta^2 = ||Alt(W_-)||^2.  Then

      theta * tr(W_-) + tr(W_-^2)  <=  ||rho||^2 + 6 delta^2,          (GC)

  with equality iff BOTH
      (a) W_+ # W_- is supported on the negative eigenspace E_-, and
      (b) E_- \subseteq ker(W_+^#) \cap ker(W_-^#).
  Via the rank-one expansion  A#B = (1/2) sum_ij a_i b_j [u_i,v_j][u_i,v_j]^T
  (verified in part 0), (a)+(b) say exactly that the nonzero eigenspaces of W
  are Z2-GRADED under the so(n) bracket with E_- odd:
      [E_+,E_+] _|_ E_-,   [E_-,E_-] _|_ E_-,   [E_+,E_-] \subseteq E_-.
  (weighted by the nonzero eigenvalues; precise form is (a),(b)).

  PROOF (five steps, each verified in part 0/1):
   1. Bilinearity of #:  W# = W_+^# - 2 W_+#W_- + W_-^#.
   2. Criticality compressed on E_-:  P_- W# P_- = -theta W_- - W_-^2
      (W^2 and theta W are block-diagonal in W's eigenbasis), hence the
      OPERATOR IDENTITY
        2 P_-(W_+#W_-)P_- = P_-(W_+^# + W_-^#)P_- + theta W_- + W_-^2.  (*)
   3. #-positivity: A,B PSD => A#B PSD (rank-one expansion, coefficients
      a_i b_j >= 0).  So tracing (*):
        2 tr(P_-(W_+#W_-)P_-) >= theta m + tr(W_-^2).
   4. Partial traces of a PSD operator are bounded by the full trace:
        tr(P_-(W_+#W_-)P_-) <= tr(W_+#W_-).
   5. The trace of the cross term is an IDENTITY (no criticality): polarizing
      the proven scal identity  2 tr(R^2+R#) = ||Ric R||^2 + 6||Alt R||^2
      (reviews/INDEX.md Reviewers 6/9, proven via the 3/2-Gram identity) and using
      W_+ W_- = 0, Ric W = 0, Alt W = 0 (so Ric W_+ = Ric W_- = rho and
      Alt W_+ = Alt W_- with norm^2 = delta^2):
        2 tr(W_+#W_-) = ||rho||^2 + 6 delta^2.
      Chaining 3 -> 4 -> 5 gives (GC).  Equality forces zero traces of the
      PSD compressions dropped in 3 and 4; for a PSD operator A, tr(PAP)=0
      iff AP=0, which gives (a),(b) exactly.                          QED

  SHARPNESS.  Equality holds at EVERY 2-block sphere product (balanced or
  not: E_+ = so(p)+so(q), E_- = the mixed block m; symmetric-pair grading),
  at the Fox point S^4(alpha) (quaternion grading of (w1; w2,w3)), and at
  CP^3 at n=6 (symmetric pair so(6) = u(3) + m).  It is strict at 3-block
  sphere products ([m_12,m_23] hits m_13), at the so(5)-spin violator
  (anti-graded: [E_+,E_+] c E_-), and generically.  So (GC) is the first
  PROVEN single inequality that is sharp at both champions simultaneously
  (the defect-penalty candidate has the same sharpness pattern but is
  conjectural).

  COROLLARY (no criticality): tr(W_+^#)+tr(W_-^#) = ||rho||^2 + 6 delta^2
  - ||W||^2 >= 0, i.e.  ||Ric(W_-)||^2 + 6 delta^2 >= ||W||^2  for EVERY
  Weyl operator.

  The corollary of (GC) used against the target:  at every critical point
      theta <= ( ||rho||^2 + 6 delta^2 - tr(W_-^2) ) / tr(W_-),
  exact at both champions.  (GC) alone does not close the gap statement --
  ||rho||^2 is not yet controlled by (theta, delta^2) -- see the report.

WHAT THIS FILE TESTS ADVERSARIALLY (falsify-first):
  Part 2 searches n=6 and n=8 for a critical point with theta > sqrt(3/2)
  and delta^2 > 0 (pinning theta by penalty, seeding from perturbed Fox,
  perturbed spheres, mixtures, randoms).  Finding one refutes the target.

PEIRCE/FUSION STRUCTURE (empirical, part 3): the full spectrum of the
multiplication operator L_u = (1/2)(uH+Hu) + u#H on Weyl space at Fox and at
the balanced sphere product (n=8), the eigenvalue clusters, and the fusion
table: which eigenspace products land in which eigenspaces.

REUSE (validated machinery, documented per repo convention):
  - review_r10_defectmax_independent.py: ctx, alt_mop, sharp4, spectral_split,
    delta2, qfun, theta_resid, bracket_vec, fox_weyl, sphere_weyl, su_m_kahler,
    so5_so4_point, random_weyl, pad_mop  (Reviewer 10's independently
    validated implementations; anchors revalidated in part 0 here).
  - rsharp_basis_free.Q_full, curvature_operator.{Lambda2,Q_op},
    weyl_decomposition.{ricci_from_mop, weyl_from_mop, frob, norm},
    weyl.build_structure_constants.
  - run_unconstrained_search.build_weyl_basis (orthonormal Weyl basis).
  - run_defect_max_hunt.{smooth_delta2_and_grad, resid_and_grad} and
    run_bianchi_defect.build_alt_indices for the search gradients.
  - run_hpm_qk.qk_tensor (HP^2), run_bianchi_defect_highp_seed.build_su3_n8
    and pad_weyl_to_n (SU(3) bi-invariant).

Usage:
    python3 run_idempotent_gap_proof.py 0      # validation + proof steps
    python3 run_idempotent_gap_proof.py 1      # catalogue table for (GC)
    python3 run_idempotent_gap_proof.py 2      # falsification search
    python3 run_idempotent_gap_proof.py 3      # fusion tables at n=8
    python3 run_idempotent_gap_proof.py all
"""
import sys
import time

import numpy as np

from curvature_operator import Lambda2, Q_op
from weyl_decomposition import (weyl_from_mop, ricci_from_mop, mop_from_4tensor,
                                frob, norm)
from rsharp_basis_free import Q_full
from review_r10_defectmax_independent import (
    ctx, mat4_from_mop, mop_from_mat4, alt_mop, sharp4, spectral_split,
    delta2, qfun, theta_resid, bracket_vec, pad_mop, fox_weyl, sphere_weyl,
    su_m_kahler, so5_so4_point, random_weyl)

SQ32 = np.sqrt(1.5)
LOG = "../agent_logs/proof_idempotent_gap.log"


def heartbeat(msg):
    stamp = time.strftime("%F %T")
    line = f"{stamp} [run_idempotent_gap_proof] {msg}"
    print(f"### {line}", flush=True)
    try:
        with open(LOG, "a") as fh:
            fh.write(line + "\n")
    except OSError:
        pass


# =====================================================================
# core helpers
# =====================================================================
def sharp_bilinear(cx, A, B):
    """A#B = (1/2)((A+B)^# - A^# - B^#)."""
    return 0.5 * (sharp4(cx, A + B) - sharp4(cx, A) - sharp4(cx, B))


def eig_projectors(W, tol=1e-8):
    """orthogonal projectors onto positive / negative / kernel eigenspaces."""
    w, V = np.linalg.eigh(W)
    Pp = (V[:, w > tol]) @ (V[:, w > tol]).T
    Pm = (V[:, w < -tol]) @ (V[:, w < -tol]).T
    P0 = (V[:, np.abs(w) <= tol]) @ (V[:, np.abs(w) <= tol]).T
    return Pp, Pm, P0


def gc_diagnostics(cx, W, theta=None):
    """everything in the graded-compression inequality at one operator.

    Returns dict with theta, resid, m, vm, rho2, d2, lhs, rhs, margin,
    c_plus, c_zero, s_minus, op_resid (residual of the operator identity (*)),
    cross_tr_resid (identity check 2tr(cross) = rho2 + 6 d2)."""
    L2 = cx["L2"]
    th, res = theta_resid(cx, W)
    if theta is not None:
        th = theta
    Wp, Wm, _ = spectral_split(W)
    m = np.trace(Wm)
    vm = np.trace(Wm @ Wm)
    rho = ricci_from_mop(L2, Wm)
    rho2 = frob(rho, rho)
    Aq = alt_mop(cx, Wm)
    d2 = frob(Aq, Aq)
    cross = sharp_bilinear(cx, Wp, Wm)
    selfs = sharp4(cx, Wp) + sharp4(cx, Wm)
    Pp, Pm, P0 = eig_projectors(W)
    c_plus = np.trace(Pp @ cross @ Pp)
    c_zero = np.trace(P0 @ cross @ P0)
    s_minus = np.trace(Pm @ selfs @ Pm)
    lhs = th * m + vm
    rhs = rho2 + 6.0 * d2
    op_resid = norm(2.0 * Pm @ cross @ Pm - Pm @ selfs @ Pm - th * Wm - Wm @ Wm)
    cross_tr = 2.0 * np.trace(cross) - rhs
    return dict(theta=th, resid=res, m=m, vm=vm, rho2=rho2, d2=d2,
                lhs=lhs, rhs=rhs, margin=rhs - lhs,
                c_plus=c_plus, c_zero=c_zero, s_minus=s_minus,
                op_resid=op_resid, cross_tr_resid=cross_tr)


def gc_row(label, cx, W, theta=None):
    d = gc_diagnostics(cx, W, theta)
    print(f"  {label:34s} th={d['theta']:+.6f} res={d['resid']:.1e} "
          f"d2={d['d2']:.6f} |rho|2={d['rho2']:.6f} "
          f"lhs={d['lhs']:.6f} rhs={d['rhs']:.6f} margin={d['margin']:+.2e} "
          f"[c+={d['c_plus']:.2e} c0={d['c_zero']:.2e} s-={d['s_minus']:.2e}] "
          f"opres={d['op_resid']:.1e} xtr={d['cross_tr_resid']:.1e}")
    return d


# ---------------- extra constructions ----------------
def cp_m_weyl(cx):
    """Fubini-Study CP^{m} Weyl operator on R^{2m} (n = 2m): constant
    holomorphic sectional curvature tensor, Weyl-projected, unit norm."""
    n, L2 = cx["n"], cx["L2"]
    m = n // 2
    J = np.zeros((n, n))
    for k in range(m):
        J[k, m + k] = -1.0
        J[m + k, k] = 1.0

    def T(i, j, k, l):
        d = lambda a, b: 1.0 if a == b else 0.0
        return (d(i, k) * d(j, l) - d(i, l) * d(j, k)
                + J[i, k] * J[j, l] - J[i, l] * J[j, k] + 2.0 * J[i, j] * J[k, l])

    Mop = mop_from_4tensor(L2, T)
    W, _, _ = weyl_from_mop(L2, Mop)
    W = W / norm(W)
    if frob(W, qfun(cx)(W)) < 0:
        W = -W
    return W


def multiblock_sphere_weyl(cx, parts):
    """Weyl part of the Einstein product of round spheres S^{p1} x ... (n = sum p_i)."""
    n, L2 = cx["n"], cx["L2"]
    assert sum(parts) == n
    starts = np.cumsum([0] + list(parts))
    blk = np.zeros(n, dtype=int)
    for b, (s, p) in enumerate(zip(starts[:-1], parts)):
        blk[s:s + p] = b
    Mop = np.zeros((cx["N"], cx["N"]))
    for a, (i, j) in enumerate(cx["idx"]):
        if blk[i] == blk[j]:
            Mop[a, a] = 1.0 / (parts[blk[i]] - 1)
    W, _, _ = weyl_from_mop(L2, Mop)
    W = W / norm(W)
    if frob(W, qfun(cx)(W)) < 0:
        W = -W
    return W


def fox_plateau_2block(cx):
    """balanced sum of two Fox blocks on disjoint R^4's (n >= 8)."""
    W = (fox_weyl(cx, block=(0, 1, 2, 3)) + fox_weyl(cx, block=(4, 5, 6, 7))) / np.sqrt(2)
    return W


# =====================================================================
# PART 0 -- validation + machine verification of every proof step
# =====================================================================
def part0():
    heartbeat("part 0 start: validation + proof-step verification")
    print("=" * 78)
    print("PART 0: anchors, and machine verification of each step of (GC)")
    print("=" * 78)
    rng = np.random.default_rng(20260820)

    # --- anchors, 10 digits ---
    for n in (6, 8):
        cx = ctx(n)
        W = fox_weyl(cx)
        th, res = theta_resid(cx, W)
        d2 = delta2(cx, W)
        print(f"  Fox anchor n={n}:  theta={th:.10f} (sqrt(3/2)={SQ32:.10f}) "
              f"res={res:.1e}  delta^2={d2:.10f} (1/9={1/9:.10f})")
        assert abs(th - SQ32) < 1e-10 and abs(d2 - 1 / 9) < 1e-10 and res < 1e-12
    for n, p in ((8, 4), (12, 6)):
        cx = ctx(n)
        W = sphere_weyl(cx, p)
        th, res = theta_resid(cx, W)
        th0 = np.sqrt(2.0 * (n - 1) * (n - 2)) / n
        d2 = delta2(cx, W)
        print(f"  balanced sphere n={n}: theta={th:.10f} (theta_0={th0:.10f}) "
              f"res={res:.1e}  delta^2={d2:.1e}")
        assert abs(th - th0) < 1e-10 and d2 < 1e-20 and res < 1e-12
    heartbeat("part 0: anchors pass")

    # --- step V1: rank-one sharp formula  (uu^T)#(vv^T) = 1/2 [u,v][u,v]^T ---
    print("\n  V1: rank-one # formula (basis of #-positivity + range statement)")
    worst = 0.0
    for n in (5, 6):
        cx = ctx(n)
        N = cx["N"]
        for _ in range(6):
            u = rng.normal(size=N); v = rng.normal(size=N)
            lhs = sharp_bilinear(cx, np.outer(u, u), np.outer(v, v))
            br = bracket_vec(cx, u, v)
            worst = max(worst, norm(lhs - 0.5 * np.outer(br, br)))
    print(f"    max |(uu^T)#(vv^T) - (1/2)[u,v][u,v]^T| = {worst:.2e}")
    assert worst < 1e-10

    # --- step V2: #-positivity on random PSD pairs ---
    print("  V2: A,B PSD => A#B PSD")
    wmin = 0.0
    for n in (6, 7):
        cx = ctx(n)
        N = cx["N"]
        for _ in range(8):
            X = rng.normal(size=(N, N)); A = X @ X.T
            Y = rng.normal(size=(N, N)); B = Y @ Y.T
            ev = np.linalg.eigvalsh(sharp_bilinear(cx, A, B))
            wmin = min(wmin, ev[0] / max(1.0, ev[-1]))
    print(f"    min normalized eigenvalue of A#B over 16 PSD pairs = {wmin:.2e}")
    assert wmin > -1e-12

    # --- step V3: polarized scal identity ---
    print("  V3: 2tr(A#B) = <RicA,RicB> + 6<AltA,AltB> - tr(AB+BA)  (all symmetric A,B)")
    worst = 0.0
    for n in (6, 7):
        cx = ctx(n)
        L2, N = cx["L2"], cx["N"]
        for _ in range(5):
            A = rng.normal(size=(N, N)); A = 0.5 * (A + A.T)
            B = rng.normal(size=(N, N)); B = 0.5 * (B + B.T)
            lhs = 2.0 * np.trace(sharp_bilinear(cx, A, B))
            rhs = (frob(ricci_from_mop(L2, A), ricci_from_mop(L2, B))
                   + 6.0 * frob(alt_mop(cx, A), alt_mop(cx, B))
                   - np.trace(A @ B + B @ A))
            worst = max(worst, abs(lhs - rhs) / max(1.0, abs(rhs)))
    print(f"    max relative residual = {worst:.2e}")
    assert worst < 1e-12

    # --- step V4: the cross-trace identity on random Weyl ---
    print("  V4: 2tr(W_+#W_-) = ||Ric W_-||^2 + 6 delta^2  (every Weyl W)")
    worst = 0.0
    cmin = np.inf
    for n in (6, 7, 8):
        cx = ctx(n)
        for _ in range(4):
            W = random_weyl(cx, rng)
            Wp, Wm, _ = spectral_split(W)
            cross = sharp_bilinear(cx, Wp, Wm)
            rho = ricci_from_mop(cx["L2"], Wm)
            d2 = delta2(cx, W)
            lhs = 2.0 * np.trace(cross)
            rhs = frob(rho, rho) + 6.0 * d2
            worst = max(worst, abs(lhs - rhs) / rhs)
            cmin = min(cmin, rhs)  # corollary check: >= ||W||^2 = 1
    print(f"    max relative residual = {worst:.2e}")
    print(f"    corollary ||Ric W_-||^2 + 6 d2 >= 1 on random unit Weyl: min = {cmin:.4f}")
    assert worst < 1e-12 and cmin >= 1.0 - 1e-12

    # --- step V5: bilinearity W# = W_+^# - 2 cross + W_-^# ---
    print("  V5: sharp bilinearity on the spectral split")
    cx = ctx(7)
    W = random_weyl(cx, rng)
    Wp, Wm, _ = spectral_split(W)
    r = norm(sharp4(cx, W) - (sharp4(cx, Wp) - 2.0 * sharp_bilinear(cx, Wp, Wm)
                              + sharp4(cx, Wm)))
    print(f"    residual = {r:.2e}")
    assert r < 1e-10

    # --- step V6: the operator identity (*) at the champions ---
    print("  V6: operator identity 2P-(W+#W-)P- = P-(W+^#+W-^#)P- + th W- + W-^2")
    for lab, cx, W in (("Fox n=8", ctx(8), fox_weyl(ctx(8))),
                       ("sphere (4,4) n=8", ctx(8), sphere_weyl(ctx(8), 4)),
                       ("sphere (5,7) n=12", ctx(12), sphere_weyl(ctx(12), 5))):
        d = gc_diagnostics(cx, W)
        print(f"    {lab:22s} op-identity residual = {d['op_resid']:.2e} "
              f"(criticality res {d['resid']:.1e})")
        assert d["op_resid"] < 1e-10
    heartbeat("part 0 done: all proof steps verified")


# =====================================================================
# PART 1 -- the catalogue table for (GC), equality diagnostics
# =====================================================================
def part1():
    heartbeat("part 1 start: (GC) across the catalogue")
    print("=" * 78)
    print("PART 1: (GC)  theta*trW- + trW-^2 <= ||Ric W-||^2 + 6 delta^2")
    print("        margin = rhs - lhs = 2c+ + 2c0 + s-   (each >= 0; 0 iff graded)")
    print("=" * 78)
    rows = []

    cx6 = ctx(6)
    rows.append(("Fox S4(a)            n=6 ", cx6, fox_weyl(cx6)))
    rows.append(("sphere (3,3)         n=6 ", cx6, sphere_weyl(cx6, 3)))
    rows.append(("sphere (2,4)         n=6 ", cx6, sphere_weyl(cx6, 2)))
    rows.append(("su(3) Kahler         n=6 ", cx6, su_m_kahler(cx6)[0]))
    rows.append(("CP^3                 n=6 ", cx6, cp_m_weyl(cx6)))

    cx8 = ctx(8)
    rows.append(("Fox S4(a)            n=8 ", cx8, fox_weyl(cx8)))
    rows.append(("sphere (4,4)         n=8 ", cx8, sphere_weyl(cx8, 4)))
    rows.append(("sphere (3,5)         n=8 ", cx8, sphere_weyl(cx8, 3)))
    rows.append(("sphere (2,6)         n=8 ", cx8, sphere_weyl(cx8, 2)))
    rows.append(("3-block sphere 3+3+2 n=8 ", cx8, multiblock_sphere_weyl(cx8, (3, 3, 2))))
    rows.append(("Fox plateau 2-block  n=8 ", cx8, fox_plateau_2block(cx8)))
    rows.append(("su(4) Kahler         n=8 ", cx8, su_m_kahler(cx8)[0]))
    try:
        Wv = np.load("scripts/data/defect_violation_n8_0.120000.npy")
        Wv = Wv / norm(Wv)
        rows.append(("violator 3/25        n=8 ", cx8, Wv))
    except OSError:
        Wv = None
        print("  (violator .npy not found; skipped)")
    try:
        Wt0 = np.load("scripts/data/defect_theta0_n8_0.125000.npy")
        rows.append(("theta=0 stratum      n=8 ", cx8, Wt0 / norm(Wt0)))
    except OSError:
        print("  (theta=0 stratum .npy not found; skipped)")
    try:
        from run_bianchi_defect_highp_seed import build_su3_n8
        _, Wsu3 = build_su3_n8()
        rows.append(("SU(3) bi-invariant   n=8 ", cx8, Wsu3))
    except Exception as e:  # noqa: BLE001
        print(f"  (SU(3) bi-invariant skipped: {e})")
    try:
        from run_hpm_qk import qk_tensor
        L28 = cx8["L2"]
        T = qk_tensor(8, 2, 1.0, 1.0)
        Mop = mop_from_4tensor(L28, T)
        Whp, _, _ = weyl_from_mop(L28, Mop)
        Whp = Whp / norm(Whp)
        if frob(Whp, qfun(cx8)(Whp)) < 0:
            Whp = -Whp
        rows.append(("HP^2 QK              n=8 ", cx8, Whp))
    except Exception as e:  # noqa: BLE001
        print(f"  (HP^2 skipped: {e})")

    cx12 = ctx(12)
    rows.append(("Fox S4(a)            n=12", cx12, fox_weyl(cx12)))
    rows.append(("sphere (6,6)         n=12", cx12, sphere_weyl(cx12, 6)))
    rows.append(("sphere (5,7)         n=12", cx12, sphere_weyl(cx12, 5)))
    if Wv is not None:
        rows.append(("violator padded      n=12", cx12, pad_mop(cx8, cx12, Wv)))

    results = {}
    for label, cx, W in rows:
        results[label] = gc_row(label, cx, W)

    # non-critical stress: does (GC) with theta := P(W) fail off the critical set?
    print("\n  Off-critical stress (theta := P(W), not critical -- is criticality load-bearing?)")
    rng = np.random.default_rng(7)
    worst_margin = np.inf
    for _ in range(30):
        W = random_weyl(ctx(6), rng)
        d = gc_diagnostics(ctx(6), W)
        worst_margin = min(worst_margin, d["margin"])
    print(f"    min margin over 30 random unit Weyl (n=6): {worst_margin:+.4f}")

    # directed minimization of the margin over the unit Weyl sphere at n=6
    print("    directed minimization of margin over unit Weyl sphere (n=6):")
    from run_unconstrained_search import build_weyl_basis
    from weyl import build_structure_constants
    idx, pos, N, c = (ctx(6)["idx"], ctx(6)["pos"], ctx(6)["N"], ctx(6)["c"])
    Eflat, D = build_weyl_basis(6, idx, pos, N, c, verbose=False)

    L26 = ctx(6)["L2"]
    Qf6 = qfun(ctx(6))

    def margin_of_x(x):
        x = x / np.linalg.norm(x)
        W = (x @ Eflat).reshape(N, N)
        W = 0.5 * (W + W.T)
        # cheap margin: no sharp needed
        Wp, Wm, _ = spectral_split(W)
        rho = ricci_from_mop(L26, Wm)
        Aq = alt_mop(ctx(6), Wm)
        P = frob(W, Qf6(W))
        return (frob(rho, rho) + 6.0 * frob(Aq, Aq)
                - P * np.trace(Wm) - np.trace(Wm @ Wm))

    from scipy.optimize import minimize
    best = np.inf
    starts = []
    rng2 = np.random.default_rng(3)
    for s in range(3):
        starts.append(("random%d" % s, rng2.normal(size=D)))
    xfox6 = Eflat @ fox_weyl(ctx(6)).reshape(-1)
    xsp6 = Eflat @ sphere_weyl(ctx(6), 3).reshape(-1)
    for sig in (0.05, 0.2):
        starts.append((f"fox+{sig}", xfox6 + sig * rng2.normal(size=D)))
        starts.append((f"sph+{sig}", xsp6 + sig * rng2.normal(size=D)))
    for lab, x0 in starts:
        r = minimize(margin_of_x, x0, method="L-BFGS-B", jac=None,
                     options=dict(maxiter=300, ftol=1e-14, gtol=1e-10))
        print(f"      start {lab:10s}: min margin {r.fun:+.8f}")
        best = min(best, r.fun)
    print(f"    best (most negative) margin found: {best:+.6f}")
    print("    -> negative = criticality is load-bearing for (GC); "
          "nonnegative = (GC) may hold unconditionally with theta := P(W)")
    heartbeat(f"part 1 done: directed off-critical margin min = {best:+.6f}")
    return results


# =====================================================================
# PART 2 -- falsification search: theta > sqrt(3/2) with delta^2 > 0
# =====================================================================
def part2(ns=(6, 8), seed=20260820):
    heartbeat(f"part 2 start: falsification search at n in {ns}")
    print("=" * 78)
    print("PART 2: adversarial search for a critical point with theta > sqrt(3/2)")
    print("        and delta^2 > 0.  Finding one REFUTES the gap target.")
    print("=" * 78)
    from run_unconstrained_search import build_weyl_basis
    from run_defect_max_hunt import resid_and_grad, smooth_delta2_and_grad
    from run_bianchi_defect import build_alt_indices

    rng = np.random.default_rng(seed)
    summary = []
    for n in ns:
        cx = ctx(n)
        L2, N, c = cx["L2"], cx["N"], cx["c"]
        Qf = qfun(cx)
        Eflat, D = build_weyl_basis(n, cx["idx"], cx["pos"], N, c, verbose=True)
        alt_idx = build_alt_indices(L2)

        def unflat(x):
            W = (x @ Eflat).reshape(N, N)
            return 0.5 * (W + W.T)

        def to_x(W):
            return Eflat @ W.reshape(-1)

        def state(x):
            x = x / np.linalg.norm(x)
            W = unflat(x)
            Qm = Qf(W)
            P = frob(W, Qm)
            return x, W, Qm, P

        theta_targets = [SQ32 + 1e-3, 1.28, 1.35]
        d_targets = [0.005, 0.03]

        # seed pool
        seeds = []
        Wfox = fox_weyl(cx)
        xfox = to_x(Wfox)
        for sig in (0.05, 0.15, 0.3, 0.5):
            for _ in range(2):
                seeds.append(("fox-pert%.2f" % sig,
                              xfox + sig * rng.normal(size=D)))
        Wsp = sphere_weyl(cx, n // 2)
        xsp = to_x(Wsp)
        for sig in (0.1, 0.3):
            seeds.append(("sph-pert%.2f" % sig, xsp + sig * rng.normal(size=D)))
        for tmix in (0.3, 0.6):
            seeds.append(("fox-sph-mix%.1f" % tmix,
                          (1 - tmix) * xfox + tmix * xsp + 0.05 * rng.normal(size=D)))
        for k in range(6):
            seeds.append((f"random{k}", rng.normal(size=D)))

        from scipy.optimize import minimize

        def penalized_fg(xraw, tt, dt, wres, Aw, Bw, eps):
            nx = np.linalg.norm(xraw)
            x = xraw / nx
            W = unflat(x)
            Qm = Qf(W)
            P = frob(W, Qm)
            R, gR = resid_and_grad(W, Qm, P, Qf)
            d2, gD = smooth_delta2_and_grad(W, alt_idx, eps)
            pen_t = max(0.0, tt - P)
            pen_d = max(0.0, dt - d2)
            f = wres * R + Aw * pen_t ** 2 + Bw * pen_d ** 2
            gW = (wres * gR - Aw * 2.0 * pen_t * 3.0 * Qm
                  - Bw * 2.0 * pen_d * gD)
            g = Eflat @ gW.reshape(-1)
            g = (g - np.dot(g, x) * x) / nx
            return f, g

        def resid_fg(xraw):
            nx = np.linalg.norm(xraw)
            x = xraw / nx
            W = unflat(x)
            Qm = Qf(W)
            P = frob(W, Qm)
            R, gR = resid_and_grad(W, Qm, P, Qf)
            g = Eflat @ gR.reshape(-1)
            g = (g - np.dot(g, x) * x) / nx
            return R, g

        found = []
        t0 = time.time()
        for (tt, dt) in [(a, b) for a in theta_targets for b in d_targets]:
            for lab, x0 in seeds:
                x = np.array(x0, dtype=float)
                x /= np.linalg.norm(x)
                for eps in (1e-2, 1e-3):
                    r = minimize(penalized_fg, x, args=(tt, dt, 3.0, 30.0, 30.0, eps),
                                 jac=True, method="L-BFGS-B",
                                 options=dict(maxiter=400, ftol=1e-16, gtol=1e-12))
                    x = r.x / np.linalg.norm(r.x)
                # polish: pure criticality residual
                r = minimize(resid_fg, x, jac=True, method="L-BFGS-B",
                             options=dict(maxiter=3000, ftol=1e-18, gtol=1e-14))
                x = r.x / np.linalg.norm(r.x)
                W = unflat(x)
                Qm = Qf(W)
                P = frob(W, Qm)
                res = norm(Qm - P * W)
                d2f = delta2(cx, W)
                if res < 1e-7:
                    found.append((P, d2f, res, lab, tt, dt))
        found.sort(key=lambda r: -r[0])
        print(f"\n  n={n}: {len(found)} converged critical points "
              f"({time.time()-t0:.0f}s).  Top by theta:")
        hits = 0
        for (P, d2f, res, lab, tt, dt) in found[:12]:
            flag = "  <-- WOULD REFUTE" if (P > SQ32 + 1e-6 and d2f > 1e-8) else ""
            if flag:
                hits += 1
            print(f"    theta={P:+.8f}  d2={d2f:.3e}  res={res:.1e} "
                  f"seed={lab:16s} (tt={tt:.3f}, dt={dt:.3f}){flag}")
        best_def = max((r for r in found if r[1] > 1e-8), default=None,
                       key=lambda r: r[0])
        if best_def:
            print(f"  best DEFECTIVE critical theta at n={n}: {best_def[0]:.8f} "
                  f"(d2={best_def[1]:.4e})  [sqrt(3/2)={SQ32:.8f}]")
        summary.append((n, found, best_def, hits))
        heartbeat(f"part 2: n={n} done, {len(found)} converged, "
                  f"best defective theta = "
                  f"{best_def[0] if best_def else float('nan'):.8f}, refute-hits={hits}")
    return summary


# =====================================================================
# PART 2b -- theta-PINNED residual-floor scan (closes the trap that the
# self-consistent theta penalty is tangentially impotent at critical points)
# =====================================================================
def part2b(ns=(6, 8), seed=31, dt=0.01):
    heartbeat(f"part 2b start: theta-pinned scan at n in {ns}")
    print("=" * 78)
    print("PART 2b: min ||Q(W) - theta_t W||^2 + 30*relu(0.01 - delta^2)^2 over")
    print("         the unit Weyl sphere at FIXED theta_t > sqrt(3/2).")
    print("         A floor ~0 with delta^2 >= 0.01 would REFUTE the gap target.")
    print("=" * 78)
    from run_unconstrained_search import build_weyl_basis
    from run_defect_max_hunt import smooth_delta2_and_grad
    from run_bianchi_defect import build_alt_indices
    from scipy.optimize import minimize

    rng = np.random.default_rng(seed)
    for n in ns:
        cx = ctx(n)
        N, c = cx["N"], cx["c"]
        Qf = qfun(cx)
        Eflat, D = build_weyl_basis(n, cx["idx"], cx["pos"], N, c, verbose=True)
        alt_idx = build_alt_indices(cx["L2"])

        def unflat(x):
            W = (x @ Eflat).reshape(N, N)
            return 0.5 * (W + W.T)

        def pinned_fg(xraw, tt, Bw, eps):
            nx = np.linalg.norm(xraw)
            x = xraw / nx
            W = unflat(x)
            Qm = Qf(W)
            r = Qm - tt * W
            f0 = frob(r, r)
            # d/dW ||Q - tt W||^2 = 4 B(W,r) - 2 tt r
            Bwr = 0.5 * (Qf(W + r) - Qm - Qf(r))
            gW = 4.0 * Bwr - 2.0 * tt * r
            d2, gD = smooth_delta2_and_grad(W, alt_idx, eps)
            pen = max(0.0, dt - d2)
            f = f0 + Bw * pen ** 2
            gW = gW - Bw * 2.0 * pen * gD
            g = Eflat @ gW.reshape(-1)
            g = (g - np.dot(g, x) * x) / nx
            return f, g

        xfox = Eflat @ fox_weyl(cx).reshape(-1)
        seeds = [xfox + 0.1 * rng.normal(size=D), xfox + 0.3 * rng.normal(size=D)]
        seeds += [rng.normal(size=D) for _ in range(4)]
        print(f"\n  n={n}: floor of the pinned+defect objective per theta_t "
              f"(6 seeds each):")
        for tt in (SQ32, 1.235, 1.25, 1.28, 1.32, 1.36, 1.40):
            best = (np.inf, None)
            for x0 in seeds:
                x = np.array(x0) / np.linalg.norm(x0)
                for eps in (1e-2, 1e-3):
                    rr = minimize(pinned_fg, x, args=(tt, 30.0, eps), jac=True,
                                  method="L-BFGS-B",
                                  options=dict(maxiter=600, ftol=1e-18, gtol=1e-14))
                    x = rr.x / np.linalg.norm(rr.x)
                W = unflat(x)
                Qm = Qf(W)
                f0 = norm(Qm - tt * W) ** 2
                d2 = delta2(cx, W)
                pen = max(0.0, dt - d2)
                ftot = f0 + 30.0 * pen ** 2
                if ftot < best[0]:
                    best = (ftot, (f0, d2, frob(W, Qm)))
            f0, d2, P = best[1]
            flag = "  <-- WOULD REFUTE" if (f0 < 1e-12 and d2 > 1e-4
                                            and tt > SQ32 + 1e-6) else ""
            print(f"    theta_t={tt:.6f}: floor={best[0]:.3e} "
                  f"(resid^2={f0:.3e}, d2={d2:.4f}, P={P:+.6f}){flag}")
        heartbeat(f"part 2b: n={n} scan done")


# =====================================================================
# PART 3 -- Peirce spectrum and fusion tables of L_u at n=8
# =====================================================================
def build_L_matrix(cx, u, Eflat, D):
    """L_u in the orthonormal Weyl basis: L_ij = <E_i, B(u, E_j)>."""
    N = cx["N"]
    Qf = qfun(cx)
    Qu = Qf(u)
    L = np.zeros((D, D))
    for j in range(D):
        Ej = Eflat[j].reshape(N, N)
        Bj = 0.5 * (Qf(u + Ej) - Qu - Qf(Ej))
        L[:, j] = Eflat @ Bj.reshape(-1)
    return 0.5 * (L + L.T)


def fusion_table(cx, u, name, Eflat, D, tol_cluster=1e-6, tol_fuse=1e-7,
                 samples=4, rng=None):
    N = cx["N"]
    Qf = qfun(cx)
    th, res = theta_resid(cx, u)
    print(f"\n  --- {name}: theta = {th:.8f}, criticality residual {res:.1e} ---")
    L = build_L_matrix(cx, u, Eflat, D)
    w, V = np.linalg.eigh(L)
    # cluster
    clusters = []
    for i, val in enumerate(w):
        if clusters and abs(val - clusters[-1][0][-1]) < tol_cluster:
            clusters[-1][0].append(val)
            clusters[-1][1].append(i)
        else:
            clusters.append(([val], [i]))
    print(f"  L_u spectrum on Weyl space (D={D}): {len(clusters)} clusters")
    xu = Eflat @ u.reshape(-1)
    for vals, idxs in clusters:
        mu = np.mean(vals)
        # is u itself in this cluster?
        proj_u = np.linalg.norm(V[:, idxs].T @ xu)
        tag = "  <- contains u (eigenvalue theta)" if proj_u > 0.9 else ""
        print(f"    mu = {mu:+.8f}  (mu/theta = {mu/th:+.6f})  mult = {len(idxs)}{tag}")
    print(f"  Peirce cap check: second largest eigenvalue = {w[-2]:+.8f} "
          f"vs theta/2 = {th/2:+.8f} (cap margin {th/2 - w[-2]:+.2e})")
    # fusion table
    if rng is None:
        rng = np.random.default_rng(0)
    K = len(clusters)
    mus = [np.mean(v) for v, _ in clusters]
    table = np.zeros((K, K, K))
    for a in range(K):
        for b in range(a, K):
            ia, ib = clusters[a][1], clusters[b][1]
            for _ in range(samples):
                va = V[:, ia] @ rng.normal(size=len(ia)); va /= np.linalg.norm(va)
                vb = V[:, ib] @ rng.normal(size=len(ib)); vb /= np.linalg.norm(vb)
                Wa = (va @ Eflat).reshape(N, N); Wa = 0.5 * (Wa + Wa.T)
                Wb = (vb @ Eflat).reshape(N, N); Wb = 0.5 * (Wb + Wb.T)
                Bab = 0.5 * (Qf(Wa + Wb) - Qf(Wa) - Qf(Wb))
                xab = Eflat @ Bab.reshape(-1)
                for cc in range(K):
                    comp = np.linalg.norm(V[:, clusters[cc][1]].T @ xab)
                    table[a, b, cc] = max(table[a, b, cc], comp)
    print("  fusion table (rows: mu_a * mu_b -> allowed target eigenspaces):")
    for a in range(K):
        for b in range(a, K):
            tgts = [f"{mus[cc]:+.4f}" for cc in range(K) if table[a, b, cc] > tol_fuse]
            print(f"    V({mus[a]:+.4f}) * V({mus[b]:+.4f}) -> "
                  f"{{{', '.join(tgts) if tgts else '0'}}}")
    return clusters, table, mus, th


def part3():
    heartbeat("part 3 start: fusion tables at n=8")
    print("=" * 78)
    print("PART 3: Peirce spectrum + fusion rules of L_u on Weyl space, n=8")
    print("=" * 78)
    from run_unconstrained_search import build_weyl_basis
    cx = ctx(8)
    Eflat, D = build_weyl_basis(8, cx["idx"], cx["pos"], cx["N"], cx["c"],
                                verbose=True)
    rng = np.random.default_rng(11)
    out = {}
    out["fox"] = fusion_table(cx, fox_weyl(cx), "Fox S4(alpha), n=8", Eflat, D,
                              rng=rng)
    out["sphere"] = fusion_table(cx, sphere_weyl(cx, 4),
                                 "balanced sphere (4,4), n=8", Eflat, D, rng=rng)
    heartbeat("part 3 done")
    return out


# =====================================================================
# PART 4 -- structure equations on the equality (graded) class
# =====================================================================
def ric_action(cx, A, h):
    """(A.h)_ab = sum_{j,k} A_{ajbk} h_{jk} (4-tensor action on sym matrices)."""
    R4 = mat4_from_mop(cx, A)
    return np.einsum('ajbk,jk->ab', R4, h, optimize=True)


def gram4(cx, X, Y):
    """Gram(X,Y)_ab = sum_{jkl} X_{ajkl} Y_{bjkl} of two pair-matrices as 4-tensors."""
    X4, Y4 = mat4_from_mop(cx, X), mat4_from_mop(cx, Y)
    return np.einsum('ajkl,bjkl->ab', X4, Y4, optimize=True)


def part4():
    heartbeat("part 4 start: graded structure equations")
    print("=" * 78)
    print("PART 4: at EQUALITY points of (GC) the compressions upgrade to the")
    print("        operator equations")
    print("          (E1)  W+^# + W-^#  =  theta W+ - W+^2   (supported on E+)")
    print("          (E2)  2 W+ # W-    =  theta W- + W-^2   (supported on E-)")
    print("        with corollary a_max(W+) <= theta, and the Ricci contraction")
    print("          (E2R) theta rho + Ric(W-^2) = |W|.rho + 3 Gram(Alt W-)")
    print("=" * 78)
    rng = np.random.default_rng(5)

    # pin the Gram normalization: D(R) = Ric(Q(R)) - R.Ric(R) =? (3/2) Gram(AltR)
    cx = ctx(6)
    N = cx["N"]
    M = rng.normal(size=(N, N)); M = 0.5 * (M + M.T)
    L2 = cx["L2"]
    D_direct = ricci_from_mop(L2, Q_full(M, cx["c"])) - ric_action(cx, M, ricci_from_mop(L2, M))
    A = alt_mop(cx, M)
    G = gram4(cx, A, A)
    r = norm(D_direct - 1.5 * G) / norm(D_direct)
    print(f"  Gram normalization check D(R) = (3/2)Gram(AltR): rel resid {r:.2e}")
    assert r < 1e-12

    def check_point(label, cx, W):
        th, res = theta_resid(cx, W)
        Wp, Wm, _ = spectral_split(W)
        cross = sharp_bilinear(cx, Wp, Wm)
        selfs = sharp4(cx, Wp) + sharp4(cx, Wm)
        e1 = norm(selfs - (th * Wp - Wp @ Wp))
        e2 = norm(2.0 * cross - (th * Wm + Wm @ Wm))
        amax = np.max(np.linalg.eigvalsh(Wp))
        L2 = cx["L2"]
        rho = ricci_from_mop(L2, Wm)
        Om = alt_mop(cx, Wm)
        e2r = norm(th * rho + ricci_from_mop(L2, Wm @ Wm)
                   - ric_action(cx, Wp + Wm, rho) - 3.0 * gram4(cx, Om, Om))
        print(f"  {label:26s} |E1|={e1:.2e} |E2|={e2:.2e} |E2R|={e2r:.2e} "
              f"a_max={amax:.6f} theta={th:.6f} a_max<=theta: {amax <= th + 1e-12}")
        return e1, e2

    print("\n  equality-class points (expect E1, E2, E2R ~ 0):")
    cx6, cx8 = ctx(6), ctx(8)
    check_point("Fox n=8", cx8, fox_weyl(cx8))
    check_point("sphere (4,4) n=8", cx8, sphere_weyl(cx8, 4))
    check_point("sphere (3,5) n=8", cx8, sphere_weyl(cx8, 3))
    check_point("CP^3 n=6", cx6, cp_m_weyl(cx6))
    check_point("su(3) Kahler n=6", cx6, su_m_kahler(cx6)[0])
    from run_hpm_qk import qk_tensor
    T = qk_tensor(8, 2, 1.0, 1.0)
    Whp, _, _ = weyl_from_mop(cx8["L2"], mop_from_4tensor(cx8["L2"], T))
    Whp = Whp / norm(Whp)
    if frob(Whp, qfun(cx8)(Whp)) < 0:
        Whp = -Whp
    check_point("HP^2 n=8", cx8, Whp)

    print("\n  non-graded points (expect E1, E2 strictly nonzero):")
    check_point("3-block sphere n=8", cx8, multiblock_sphere_weyl(cx8, (3, 3, 2)))
    try:
        Wv = np.load("scripts/data/defect_violation_n8_0.120000.npy")
        check_point("violator 3/25 n=8", cx8, Wv / norm(Wv))
    except OSError:
        pass
    from run_bianchi_defect_highp_seed import build_su3_n8
    _, Wsu3 = build_su3_n8()
    check_point("SU(3) bi-inv n=8", cx8, Wsu3)
    heartbeat("part 4 done")


# =====================================================================
# PART 5 -- the defect carrier |u| in the Peirce decomposition
# =====================================================================
def part5():
    heartbeat("part 5 start: defect carrier in the Peirce decomposition")
    print("=" * 78)
    print("PART 5: Weyl projection of |u| decomposed into L_u eigenspaces (n=8)")
    print("=" * 78)
    from run_unconstrained_search import build_weyl_basis
    cx = ctx(8)
    N = cx["N"]
    L2 = cx["L2"]
    Eflat, D = build_weyl_basis(8, cx["idx"], cx["pos"], N, cx["c"], verbose=False)

    for name, u in (("Fox S4(alpha)", fox_weyl(cx)),
                    ("balanced sphere (4,4)", sphere_weyl(cx, 4))):
        th, res = theta_resid(cx, u)
        L = build_L_matrix(cx, u, Eflat, D)
        w, V = np.linalg.eigh(L)
        _, Wm, _ = spectral_split(u)
        absu = u + 2.0 * Wm
        Wproj, _, _ = weyl_from_mop(L2, absu - alt_mop(cx, absu))
        x = Eflat @ Wproj.reshape(-1)
        xu = Eflat @ u.reshape(-1)
        print(f"\n  {name}: theta={th:.8f}  ||P_W|u|||={np.linalg.norm(x):.6f} "
              f"<P_W|u|,u>={np.dot(x, xu):.6f}  delta^2={delta2(cx, u):.6f}")
        # cluster projections
        clusters = []
        for i, val in enumerate(w):
            if clusters and abs(val - clusters[-1][0][-1]) < 1e-6:
                clusters[-1][0].append(val); clusters[-1][1].append(i)
            else:
                clusters.append(([val], [i]))
        for vals, idxs in clusters:
            mu = np.mean(vals)
            comp = np.linalg.norm(V[:, idxs].T @ x)
            if comp > 1e-10:
                print(f"    component in V(mu/theta={mu/th:+.6f}, mult {len(idxs)}): "
                      f"norm {comp:.8f}")
    heartbeat("part 5 done")


# =====================================================================
def main():
    args = sys.argv[1:] or ["all"]
    t0 = time.time()
    if "0" in args or "all" in args:
        part0()
    if "1" in args or "all" in args:
        part1()
    if "2" in args or "all" in args:
        part2()
    if "2b" in args or "all" in args:
        part2b()
    if "5" in args or "all" in args:
        part5()
    if "4" in args or "all" in args:
        part4()
    if "3" in args or "all" in args:
        part3()
    heartbeat(f"run complete in {time.time()-t0:.0f}s")


if __name__ == "__main__":
    main()
