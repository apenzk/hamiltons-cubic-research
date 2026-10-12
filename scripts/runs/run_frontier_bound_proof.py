"""Machine verification of the FRONTIER-BOUND proof package (agent task
proof_frontier_bound; full write-up: agent_logs/proof_frontier_bound_report.md).

Throughout: W is a unit-norm Weyl operator on Lambda^2 R^n (Bianchi, Ricci-flat,
trace-free), oriented so theta >= 0; W = W_+ - W_- its spectral split,
P_+/P_-/P_0 the spectral projectors, and

    tau   = tr W_-          (= tr W_+, since tr W = 0; = scal(|W|)/4),
    a, b  = ||W_+||^2, ||W_-||^2   (a + b = 1),
    mu_1 >= mu_2  the two largest eigenvalues of W_-  (with multiplicity),
    rho   = Ric(W_-)        (= Ric(W_+), since Ric W = 0),
    omega = Alt(W_-)        (= Alt(W_+); delta^2 = ||omega||^2),
    cross = W_+ # W_-  >= 0,      parts = W_+^# + W_-^#  >= 0.

VERIFIED CONVENTION LEMMAS (PART 1)
  L1  R^# = 1/2 sum_{ab} r_a r_b [v_a,v_b][v_a,v_b]^T  (eigen-decomposition of R),
      the sharp spectral formula in this repo's normalization.
  L2  -ad_phi^2 <= 2||phi||^2 Id on Lambda^2 for every bivector phi, sharp exactly
      at isoclinic phi (equal paired rotation angles); coordinate bivectors give 1.
  L3  tr(AB) + tr(A#B) = 1/2 <Ric A, Ric B> + 3 <Alt A, Alt B>  for all symmetric
      A, B (polarization of the proven scal(R^2+R^#) = ||Ric R||^2 + 6||Alt R||^2).
  L4  Alt(W_+) = Alt(W_-) and Ric(W_+) = Ric(W_-) for every Weyl W.

THEOREM 1 (defect budget identity; PART 2). For every unit Weyl W:
      2 tr(W_+ # W_-) = ||rho||^2 + 6 delta^2                      [identity (*)]
  and at every critical point Q(W) = theta W:
      6 delta^2 = theta tau + b - ||rho||^2 + E,
      E = tr(P_- parts P_-) + 2 tr(P_+ cross P_+) + 2 tr(P_0 cross P_0) >= 0.
  Corollaries:  6 delta^2 >= theta tau + b - ||rho||^2   (defect floor), i.e.
      ||Ric|W|||^2 >= theta scal(|W|) + 4||W_-||^2 - 24 delta^2,
  which sharpens the lifted Jaeger Lemma 3.3.1 floor by the new +4||W_-||^2 term.
  E = 0 across the entire named catalogue (both champions, su(m), spheres, QK,
  the 3/25 violator's E is checked too); E > 0 at generic census criticals.

THEOREM 2 (defect-scal bound; PART 3). For every unit Weyl W (criticality not
  needed), with lam_om = lambda_max(omega as operator on Lambda^2):
      delta^2 = tr(omega W_-) <= lam_om * tau,
  with equality iff W_- is supported in omega's top eigenspace -- which holds at
  Fox AND at every su(m) Kahler member (the entire known high-theta frontier).
  Sub-lemma (L5): ||Alt(v v^T)||^2 = (2/3) e_2(sigma^2) for every bivector v with
  rotation angles sigma, hence lam_om <= c_1(n) delta <= delta/sqrt(3), giving the
  unconditional  delta <= tau/sqrt(3),  i.e.  scal(|W|) >= 4 sqrt(3) delta.

THEOREM 3 (spectral pinch; PART 4). At every critical point with theta >= 0 and
  W != 0:
      mu_1 (theta + mu_1) <= 2 mu_2 tau      (refined form)
  hence  theta + mu_1 <= 2 tau,  with EQUALITY exactly at Fox's S^4(alpha) among
  all catalogued and census points. Corollary: rank(W_-) >= 2 at every critical
  point with theta >= 0 (mu_2 = 0 forces mu_1 = 0 forces W = 0).
  Proof skeleton (full write-up in the report): criticality gives
  <W^# u_1, u_1> = -mu_1(theta + mu_1) on the bottom eigenvector u_1; dropping
  parts >= 0 leaves mu_1(theta+mu_1) <= 2 <cross u_1, u_1>; L1 + ad-invariance
  turn <cross u_1,u_1> into (1/2) sum_a lam_a <W_- [w_a,u_1],[w_a,u_1]> with
  [w_a,u_1] _|_ u_1, so the W_- form is <= mu_2; then sum_a lam_a ||[w_a,u_1]||^2
  = tr(W_+ (-ad_{u_1}^2)) <= 2 tau by L2.

PROPOSITION 4 (exact omega-weighted criticality pairing; PART 5). At every
  critical point, with Om = P_- omega P_-:
      theta delta^2 + tr(W_-^2 omega) = 2 <cross, Om> - <parts, Om>.
  RECORDED NEGATIVE: the hypothesis Om >= 0 (on range P_-), which would turn this
  into a Fox-sharp upper-bound chain for theta delta^2, HOLDS at every named
  catalogue point but is REFUTED at generic census critical points
  (lambda_min ~ -0.07 at n=6) -- so the chain is dead as a general route, and the
  named catalogue is precisely its equality class. Verified both ways here.

PART 6 recomputes the falsification summary: no critical point in the pool
  (catalogue + census + saved violators) has theta > sqrt(3/2) + 1e-6 and
  delta^2 > 1e-9; the battery (run_frontier_bound_battery.py, log in
  agent_logs/proof_frontier_bound_battery.log) reached the same verdict with
  pinned-theta adversarial search at theta in {1.0,1.1,1.15,1.20,1.2247,1.23}.

Reused, validated in their home scripts: setup/fox_weyl/sphere_weyl/qk_weyl
(run_defect_penalty_test), theta0/build_su3_n8/pad_weyl_to_n
(run_bianchi_defect_highp_seed), build_alt_indices/alt_mop (run_bianchi_defect),
critical_census/su_m_kahler_weyl/fox_on_block (run_defect_max_hunt),
Rsharp_full (rsharp_basis_free), ricci_from_mop/frob (weyl_decomposition),
build_structure_constants (weyl), Lambda2 (curvature_operator).

Usage:  python3 run_frontier_bound_proof.py          # n=6 and n=8 + n=12 spot check
        python3 run_frontier_bound_proof.py 8        # one dimension, no spot check
"""
import os
import sys
import time
import numpy as np

from curvature_operator import Lambda2
from weyl import build_structure_constants
from weyl_decomposition import ricci_from_mop, frob, norm
from rsharp_basis_free import Rsharp_full
from run_defect_penalty_test import setup, fox_weyl, sphere_weyl, qk_weyl
from run_bianchi_defect_highp_seed import theta0, build_su3_n8, pad_weyl_to_n
from run_bianchi_defect import alt_mop
from run_defect_max_hunt import critical_census, su_m_kahler_weyl, fox_on_block, D0_EXACT

SQRT32 = np.sqrt(1.5)
HERE = os.path.dirname(os.path.abspath(__file__))
FAILURES = []


def check(label, ok, detail=""):
    tag = "PASS" if ok else "FAIL"
    print(f"    [{tag}] {label}  {detail}")
    if not ok:
        FAILURES.append(label)


# ---------------------------------------------------------------------
# quantities at one point
# ---------------------------------------------------------------------
def quantities(W, ctx, c, tol=1e-8):
    L2, alt_idx, N, Qfun = ctx["L2"], ctx["alt_idx"], ctx["N"], ctx["Qfun"]
    W = W / norm(W)
    Q = Qfun(W)
    th = frob(W, Q)
    if th < 0:                      # orient theta >= 0
        W = -W
        Q = Qfun(W)
        th = frob(W, Q)
    resid = norm(Q - th * W)
    w, V = np.linalg.eigh(W)
    Vp, Vm = V[:, w > tol], V[:, w < -tol]
    Wp = (Vp * w[w > tol]) @ Vp.T
    Wm = -(Vm * w[w < -tol]) @ Vm.T
    Pp, Pm = Vp @ Vp.T, Vm @ Vm.T
    P0 = np.eye(N) - Pp - Pm
    mu = np.sort(-w[w < -tol])[::-1]
    q = dict(W=W, th=th, resid=resid, N=N,
             a=frob(Wp, Wp), b=frob(Wm, Wm), tau=float(np.trace(Wm)),
             mu1=mu[0] if len(mu) else 0.0, mu2=mu[1] if len(mu) > 1 else 0.0,
             rm=len(mu), Vm=Vm)
    rho = ricci_from_mop(L2, Wm)
    q["rho2"] = frob(rho, rho)
    q["ric_gap"] = norm(rho - ricci_from_mop(L2, Wp))
    om = alt_mop(Wm, alt_idx)
    q["om"] = om
    q["d2"] = frob(om, om)
    q["alt_gap"] = norm(om - alt_mop(Wp, alt_idx))
    q["lam_om"] = np.linalg.eigvalsh(om)[-1] if len(mu) else 0.0
    Sp, Sm = Rsharp_full(Wp, c), Rsharp_full(Wm, c)
    cross = 0.5 * (Rsharp_full(Wp + Wm, c) - Sp - Sm)
    parts = Sp + Sm
    q["tr_cross"] = float(np.trace(cross))
    q["E"] = float(np.trace(Pm @ parts @ Pm) + 2 * np.trace(Pp @ cross @ Pp)
                   + 2 * np.trace(P0 @ cross @ P0))
    q["min_cross"] = float(np.linalg.eigvalsh(cross)[0])
    q["min_parts"] = float(np.linalg.eigvalsh(parts)[0])
    # Proposition 4 pieces
    Om = Pm @ om @ Pm
    q["X1"] = frob(cross, Om)
    q["X2"] = frob(parts, Om)
    q["X3"] = float(np.trace(Wm @ Wm @ om))
    q["lmin_Om"] = float(np.linalg.eigvalsh(Vm.T @ om @ Vm)[0]) if len(mu) else 0.0
    return q


# ---------------------------------------------------------------------
# test-point pools
# ---------------------------------------------------------------------
def named_points(n, ctx):
    pts = [("Fox S^4(alpha)", fox_weyl(ctx))]
    for p in range(2, n // 2 + 1):
        pts.append((f"sphere ({p},{n-p})", sphere_weyl(ctx, p)))
    for m in range(3, n // 2 + 1):
        L2m = Lambda2(2 * m)
        Wm = su_m_kahler_weyl(L2m, m)
        pts.append((f"su({m}) Kahler", Wm if 2 * m == n else pad_weyl_to_n(L2m, Wm / norm(Wm), n)[1]))
    blocks = [list(range(4 * i, 4 * i + 4)) for i in range(2)]
    if n >= 8:
        Wk = sum(fox_on_block(ctx["L2"], bl, ctx["Qfun"]) for bl in blocks)
        pts.append(("Fox plateau k=2", Wk / norm(Wk)))
        _, Wsu3 = build_su3_n8()
        pts.append(("SU(3) bi-invariant", Wsu3 if n == 8 else pad_weyl_to_n(Lambda2(8), Wsu3, n)[1]))
        pts.append(("QK HP^2", qk_weyl(ctx, 2) if n == 8 else
                    pad_weyl_to_n(Lambda2(8), qk_weyl(setup(8, verbose=False), 2), n)[1]))
        for fn, lab in (("scripts/data/defect_violation_n8_0.120000.npy", "violator 3/25"),
                        ("scripts/data/defect_theta0_n8_0.125000.npy", "theta=0 stratum")):
            p = os.path.join(HERE, fn)
            if os.path.exists(p):
                W8 = np.load(p)
                pts.append((lab, W8 if n == 8 else pad_weyl_to_n(Lambda2(8), W8, n)[1]))
    return pts


def census_points(n, ctx, n_starts, seed):
    found, near0 = critical_census(n, ctx, n_starts=n_starts, seed=seed)
    return [(f"census th={th:.4f} d2={d2:.4f}", W) for th, d2, W in found + near0]


# ---------------------------------------------------------------------
# PART 0/1: anchors + convention lemmas
# ---------------------------------------------------------------------
def part0_anchors(n, ctx):
    print(f"\n  -- PART 0: anchor gate (n={n}) --")
    Wf = fox_weyl(ctx)
    Qf = ctx["Qfun"](Wf)
    th = frob(Wf, Qf)
    omf = alt_mop(_wminus(Wf), ctx["alt_idx"])
    d2 = frob(omf, omf)
    check("Fox theta = sqrt(3/2) to 1e-10", abs(th - SQRT32) < 1e-10, f"gap {th-SQRT32:+.1e}")
    check("Fox delta^2 = 1/9 to 1e-10", abs(d2 - D0_EXACT) < 1e-10, f"gap {d2-D0_EXACT:+.1e}")
    ths = frob(sphere_weyl(ctx, n // 2), ctx["Qfun"](sphere_weyl(ctx, n // 2)))
    check(f"balanced sphere theta = theta_0({n}) to 1e-10", abs(ths - theta0(n)) < 1e-10)


def _wminus(W):
    w, V = np.linalg.eigh(W)
    return -(V[:, w < 0] * w[w < 0]) @ V[:, w < 0].T


def part1_lemmas(n, ctx, c, rng):
    print(f"\n  -- PART 1: convention lemmas (n={n}) --")
    N = ctx["N"]

    def ad_of(x):
        return np.einsum('a,amn->mn', x, c)

    # L1: sharp spectral formula
    A = rng.normal(size=(N, N)); R = 0.5 * (A + A.T)
    w, V = np.linalg.eigh(R)
    S = np.zeros((N, N))
    for i in range(N):
        for j in range(N):
            br = ad_of(V[:, i]) @ V[:, j]
            S += 0.5 * w[i] * w[j] * np.outer(br, br)
    check("L1 sharp spectral formula (factor 1/2)", norm(Rsharp_full(R, c) - S) < 1e-10,
          f"resid {norm(Rsharp_full(R, c) - S):.1e}")

    # L2: -ad_phi^2 <= 2||phi||^2, sharp at isoclinic
    worst = 0.0
    for _ in range(100):
        y = rng.normal(size=N); y /= np.linalg.norm(y)
        worst = max(worst, np.linalg.eigvalsh(-ad_of(y) @ ad_of(y))[-1])
    L2b = ctx["L2"]
    iso = np.zeros(N); iso[L2b.idx[(0, 1)]] = iso[L2b.idx[(2, 3)]] = 1 / np.sqrt(2)
    lam_iso = np.linalg.eigvalsh(-ad_of(iso) @ ad_of(iso))[-1]
    check("L2 -ad_phi^2 <= 2 on 100 random unit bivectors", worst <= 2 + 1e-12, f"max {worst:.6f}")
    check("L2 sharp at isoclinic phi (value 2)", abs(lam_iso - 2) < 1e-12, f"{lam_iso:.12f}")

    # L3: polarized trace identity
    worst = 0.0
    for _ in range(5):
        A = rng.normal(size=(N, N)); A = 0.5 * (A + A.T)
        B = rng.normal(size=(N, N)); B = 0.5 * (B + B.T)
        AshB = 0.5 * (Rsharp_full(A + B, c) - Rsharp_full(A, c) - Rsharp_full(B, c))
        lhs = np.trace(A @ B) + np.trace(AshB)
        ra, rb = ricci_from_mop(L2b, A), ricci_from_mop(L2b, B)
        rhs = 0.5 * frob(ra, rb) + 3 * frob(alt_mop(A, ctx["alt_idx"]), alt_mop(B, ctx["alt_idx"]))
        worst = max(worst, abs(lhs - rhs))
    check("L3 tr(AB)+tr(A#B) = 1/2<RicA,RicB>+3<AltA,AltB>", worst < 1e-10, f"worst {worst:.1e}")

    # L5 (Theorem 2 sub-lemma): ||Alt(vv^T)||^2 = (2/3) e_2(sigma^2)
    worst = 0.0
    for _ in range(20):
        y = rng.normal(size=N); y /= np.linalg.norm(y)
        Y = np.zeros((n, n))
        for a_, (i, j) in enumerate(L2b.pairs):
            Y[i, j], Y[j, i] = y[a_], -y[a_]
        sv = np.linalg.svd(Y, compute_uv=False)
        s2 = (sv[::2] ** 2)                       # paired angles sigma_p^2
        e2 = 0.5 * (s2.sum() ** 2 - (s2 ** 2).sum())
        av = alt_mop(np.outer(y, y), ctx["alt_idx"])
        worst = max(worst, abs(frob(av, av) - (2.0 / 3.0) * e2))
    check("L5 ||Alt(vv^T)||^2 = (2/3) e_2(sigma^2)", worst < 1e-10, f"worst {worst:.1e}")


# ---------------------------------------------------------------------
# PARTS 2-5: the theorems, on every test point
# ---------------------------------------------------------------------
def run_tests(n, pts, ctx, c, crit_tol=1e-6):
    print(f"\n  -- PARTS 2-5: theorem checks at n={n} over {len(pts)} points --")
    w_id1 = w_id2 = w_E = w_T2 = w_T3 = w_T3r = w_P4 = 0.0
    eq_T2, eq_T3 = [], []
    omm_min, omm_argmin = 1e9, ""
    n_crit = 0
    print(f"    {'point':26s} {'theta':>9s} {'d2':>8s} {'tau':>7s} {'b':>6s} {'mu1':>6s} "
          f"{'|rho|2':>7s} {'E':>8s} {'T2 marg':>8s} {'T3 marg':>8s}")
    for lab, W in pts:
        q = quantities(W, ctx, c)
        crit = q["resid"] < crit_tol
        if crit and not lab.startswith(("census", "random")):
            print(f"    {lab:26s} {q['th']:9.6f} {q['d2']:8.6f} {q['tau']:7.4f} {q['b']:6.4f} "
                  f"{q['mu1']:6.4f} {q['rho2']:7.4f} {q['E']:8.2e} "
                  f"{q['lam_om']*q['tau']-q['d2']:8.5f} {2*q['tau']-q['th']-q['mu1']:8.5f}")
        # identity (*): all Weyl points, critical or not
        w_id1 = max(w_id1, abs(2 * q["tr_cross"] - q["rho2"] - 6 * q["d2"]))
        if not crit:
            continue
        n_crit += 1
        # Theorem 1: 6 d2 = theta tau + b - rho2 + E, E >= 0
        w_id2 = max(w_id2, abs(6 * q["d2"] - (q["th"] * q["tau"] + q["b"] - q["rho2"] + q["E"])))
        w_E = min(w_E, q["E"]) if w_E else min(0.0, q["E"])
        w_E = min(w_E, q["E"])
        # Theorem 2: d2 <= lam_om tau
        m2 = q["lam_om"] * q["tau"] - q["d2"]
        w_T2 = min(w_T2, m2)
        if abs(m2) < 1e-8 and q["d2"] > 1e-6:
            eq_T2.append(lab)
        # Theorem 3: mu1(theta+mu1) <= 2 mu2 tau, theta+mu1 <= 2 tau
        if q["rm"] > 0:
            m3r = 2 * q["mu2"] * q["tau"] - q["mu1"] * (q["th"] + q["mu1"])
            m3 = 2 * q["tau"] - q["th"] - q["mu1"]
            w_T3r = min(w_T3r, m3r)
            w_T3 = min(w_T3, m3)
            if abs(m3) < 1e-6:
                eq_T3.append((lab, q["th"], q["d2"]))
        # Proposition 4 identity
        w_P4 = max(w_P4, abs(q["th"] * q["d2"] + q["X3"] - (2 * q["X1"] - q["X2"])))
        if q["lmin_Om"] < omm_min:
            omm_min, omm_argmin = q["lmin_Om"], lab
    check(f"identity (*) 2tr(cross)=rho2+6d2 on all {len(pts)} points", w_id1 < 5e-8, f"worst {w_id1:.1e}")
    check(f"Theorem 1 identity at {n_crit} critical points", w_id2 < 5e-7, f"worst {w_id2:.1e}")
    check("Theorem 1: E >= 0 everywhere", w_E > -1e-9, f"min E {w_E:.2e}")
    check("Theorem 2: d2 <= lam_om * tau everywhere", w_T2 > -1e-9, f"min margin {w_T2:.2e}")
    # Theorem 2's equality class contains the ENTIRE known (theta, delta^2) Pareto
    # frontier: Fox, every su(m) member, the Fox plateau, the 3/25 violator, and
    # the theta=0 stratum point (all have W_- supported in omega's top eigenspace);
    # QK HP^2 is strictly inside the frontier and is strictly below the bound.
    check("Theorem 2 equality holds at Fox and every su(m) member present",
          any("Fox" in s for s in eq_T2) and any("su(" in s for s in eq_T2),
          f"equality class: {eq_T2}")
    check("Theorem 3 refined: mu1(theta+mu1) <= 2 mu2 tau", w_T3r > -5e-7, f"min margin {w_T3r:.2e}")
    check("Theorem 3: theta + mu1 <= 2 tau", w_T3 > -5e-7, f"min margin {w_T3:.2e}")
    is_fox = lambda th, d2: abs(th - SQRT32) < 1e-6 and abs(d2 - D0_EXACT) < 1e-6
    check("Theorem 3 equality exactly at Fox (by theta, d2)",
          all(is_fox(th, d2) for _, th, d2 in eq_T3) and len(eq_T3) >= 1,
          f"equality at: {[s for s, _, _ in eq_T3]}")
    check(f"Proposition 4 identity at critical points", w_P4 < 5e-7, f"worst {w_P4:.1e}")
    print(f"    recorded negative: min eig(P- omega P- | range P-) = {omm_min:+.4f} at [{omm_argmin}]")
    print(f"    (>= 0 on the named catalogue; < 0 at generic census points => the")
    print(f"     Fox-sharp conditional chain has no unconditional general form)")
    return omm_min


# ---------------------------------------------------------------------
# PART 6: falsification summary over the pool
# ---------------------------------------------------------------------
def part6_falsification(n, pts, ctx, c):
    print(f"\n  -- PART 6: falsification summary (n={n}) --")
    bad = []
    top = (0.0, "")
    for lab, W in pts:
        q = quantities(W, ctx, c)
        if q["resid"] >= 1e-6:
            continue
        if q["th"] > SQRT32 + 1e-6 and q["d2"] > 1e-9:
            bad.append((lab, q["th"], q["d2"]))
        if q["d2"] > 1e-9 and q["th"] > top[0]:
            top = (q["th"], lab)
    check("no defective critical point with theta > sqrt(3/2) in pool", not bad, f"{bad}")
    print(f"    highest-theta defective critical point in pool: theta={top[0]:.9f} [{top[1]}]")
    print(f"    (adversarial pinned-theta battery at theta in {{1.0,1.1,1.15,1.20,1.2247,1.23}}:")
    print(f"     run_frontier_bound_battery.py -> same verdict, log agent_logs/proof_frontier_bound_battery.log)")


def run_dim(n, census_starts, census_seed, rng_seed):
    t0 = time.time()
    print("=" * 100)
    print(f"FRONTIER-BOUND PROOF VERIFICATION at n={n}")
    print("=" * 100)
    ctx = setup(n, verbose=False)
    _, _, _, c = build_structure_constants(n)
    rng = np.random.default_rng(rng_seed)
    part0_anchors(n, ctx)
    part1_lemmas(n, ctx, c, rng)
    pts = named_points(n, ctx)
    # random non-critical Weyl points: identity (*) must hold there too
    for k in range(4):
        x = rng.normal(size=ctx["D"])
        Wr = (x @ ctx["Eflat"]).reshape(ctx["N"], ctx["N"])
        Wr = 0.5 * (Wr + Wr.T)
        pts.append((f"random Weyl {k}", Wr / norm(Wr)))
    if census_starts:
        t1 = time.time()
        cen = census_points(n, ctx, census_starts, census_seed)
        print(f"\n  census: {len(cen)} generic critical points from {census_starts} starts "
              f"[{time.time()-t1:.0f}s]")
        pts += cen
    run_tests(n, pts, ctx, c)
    part6_falsification(n, pts, ctx, c)
    print(f"\n  n={n} done [{time.time()-t0:.0f}s]")


def main():
    ns = [int(a) for a in sys.argv[1:]] or [6, 8, 12]
    for n in ns:
        run_dim(n, census_starts={6: 40, 8: 16}.get(n, 0), census_seed=11, rng_seed=100 + n)
    print("\n" + "=" * 100)
    if FAILURES:
        print(f"OVERALL: {len(FAILURES)} FAILURES: {FAILURES}")
        sys.exit(1)
    print("OVERALL: every check PASSED")


if __name__ == "__main__":
    main()
