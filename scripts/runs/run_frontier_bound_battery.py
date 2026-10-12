"""Adversarial battery for the FRONTIER BOUND target (agent task proof_frontier_bound):

    maximize delta^2(W) over critical points pinned at theta in
    {1.0, 1.1, 1.15, 1.20, sqrt(3/2)=1.2247..., 1.23}   at n = 6 and n = 8,

falsification-first for the statement "every critical point with theta > sqrt(3/2)
has delta^2 < 1/9 (ideally = 0)". A single accepted critical point (absolute
residual ||Q - theta W|| < 1e-7) with theta > sqrt(3/2) + 1e-6 and delta^2 > 1e-9
REFUTES the target and is the headline.

This is a thin driver over the validated frontier-sweep machinery
(run_frontier_sweep.sweep and its probes A/B/C/D/E), reused verbatim except for:
  * the PROBE A grid, replaced by the task's six pinned theta values;
  * an n=6-safe anchor builder (the stock one pads 8-dimensional objects --
    QK HP^2, SU(3) bi-invariant, the two saved n=8 violators -- which cannot
    exist at n=6 and would crash there);
  * a 10-digit anchor gate up front: Fox theta = sqrt(3/2) and delta^2 = 1/9,
    balanced-sphere theta = theta_0(n), all to <= 1e-10, else abort.

Reused, validated in their home scripts: setup/fox_weyl/sphere_weyl
(run_defect_penalty_test), theta0/delta2_and_grad (run_bianchi_defect_highp_seed),
build_alt_indices/alt_mop (run_bianchi_defect, Alt validated against the exact
scal(R^2+R^#) = |Ric|^2 + 6|Alt|^2 identity), Q_fast (run_unconstrained_search_n12,
validated bit-for-bit against Q_full and Q_op), defect_polish_loop/
polish_to_critical/su_m_kahler_weyl/fox_on_block (run_defect_max_hunt), and the
whole probe suite of run_frontier_sweep (which reproduced the known 3/25 violator
and both champions in its recorded runs).

Usage:  python3 run_frontier_bound_battery.py [6] [8]     (default: both)
"""
import sys
import numpy as np

import run_frontier_sweep as rfs
from run_defect_penalty_test import setup, fox_weyl, sphere_weyl
from run_bianchi_defect_highp_seed import theta0, delta2_and_grad, pad_weyl_to_n
from run_defect_max_hunt import su_m_kahler_weyl, fox_on_block, D0_EXACT
from curvature_operator import Lambda2
from weyl_decomposition import frob, norm

SQRT32 = np.sqrt(1.5)
TASK_GRID = [1.0, 1.1, 1.15, 1.20, float(SQRT32), 1.23]


def anchor_gate(n):
    """Fox theta and delta^2, and the balanced sphere, to 10 digits -- else abort."""
    ctx = setup(n, verbose=False)
    Wf = fox_weyl(ctx)
    Qf = ctx["Qfun"](Wf)
    th = frob(Wf, Qf)
    d2, _ = delta2_and_grad(Wf, ctx["alt_idx"])
    Ws = sphere_weyl(ctx, n // 2)
    ths = frob(Ws, ctx["Qfun"](Ws))
    checks = [("Fox theta - sqrt(3/2)", th - SQRT32),
              ("Fox residual", np.linalg.norm(Qf - th * Wf)),
              ("Fox delta^2 - 1/9", d2 - D0_EXACT),
              ("balanced sphere theta - theta_0", ths - theta0(n))]
    print(f"  ANCHOR GATE n={n}:")
    ok = True
    for lab, v in checks:
        print(f"    {lab:32s} {v:+.3e}")
        ok = ok and abs(v) < 1e-10
    if not ok:
        raise SystemExit("ANCHOR GATE FAILED -- machinery not trusted, aborting")
    print("    all anchors reproduce to 1e-10: machinery validated")


def build_anchors_small_n(n, ctx):
    """n=6-safe anchor list: every named critical point that exists at n<8."""
    out = []
    L2 = ctx["L2"]
    out.append(("Fox S^4(alpha)", fox_weyl(ctx)))
    for p in range(2, n // 2 + 1):
        out.append((f"sphere ({p},{n-p})", sphere_weyl(ctx, p)))
    for m in range(2, n // 2 + 1):
        L2m = Lambda2(2 * m)
        Wm = su_m_kahler_weyl(L2m, m)
        Wm = Wm / norm(Wm)
        out.append((f"su({m}) Kahler", Wm if 2 * m == n else pad_weyl_to_n(L2m, Wm, n)[1]))
    for k in range(1, n // 4 + 1):
        blocks = [list(range(4 * i, 4 * i + 4)) for i in range(k)]
        Wk = sum(fox_on_block(L2, b, ctx["Qfun"]) for b in blocks)
        out.append((f"Fox plateau k={k}", Wk / norm(Wk)))
    return out


def headline(n, pool):
    """The falsification read-out this battery exists for."""
    print("\n" + "=" * 104)
    print(f"  BATTERY HEADLINE at n={n}: critical points with theta > sqrt(3/2) + 1e-6")
    print("=" * 104)
    viol = [r for r in pool if r["theta"] > SQRT32 + 1e-6 and r["d2"] > 1e-9]
    high = [r for r in pool if r["theta"] > SQRT32 + 1e-6]
    for r in sorted(high, key=lambda r: -r["d2"])[:10]:
        print(f"    theta={r['theta']:.9f}  d2={r['d2']:.3e}  absres={r['absres']:.1e}  [{r['id']}]")
    if viol:
        print(f"  *** REFUTATION: {len(viol)} accepted critical point(s) with theta > sqrt(3/2)"
              f" and delta^2 > 0 -- the frontier-bound target is FALSE as stated ***")
        for r in viol:
            print(f"      theta={r['theta']:.12f} d2={r['d2']:.12f} absres={r['absres']:.2e} [{r['id']}]")
    elif high:
        print(f"  no accepted point above sqrt(3/2) carries any defect "
              f"(max d2 there: {max(r['d2'] for r in high):.2e}) -- target SUPPORTED at n={n}")
    else:
        print(f"  no accepted critical point at all with theta > sqrt(3/2) at n={n} "
              f"-- target VACUOUSLY SUPPORTED there (Fox is the top of the defective set)")
    # the six pinned bins, as the task specifies them
    print(f"\n  per-pin maxima (max d2 over accepted points with theta >= t - 5e-3):")
    for t in TASK_GRID:
        near = [r for r in pool if r["theta"] >= t - 5e-3]
        if near:
            best = max(near, key=lambda r: r["d2"])
            print(f"    t={t:.4f}:  F(t)={best['d2']:.9f}  at theta={best['theta']:.9f}  [{best['id']}]")
        else:
            print(f"    t={t:.4f}:  no accepted critical point with theta >= t")


def main():
    ns = [int(a) for a in sys.argv[1:]] or [6, 8]
    # thorough budget, task grid
    budget = dict(rfs.BUDGETS["thorough"])
    budget["targets"] = TASK_GRID
    rfs.BUDGETS["battery"] = budget
    orig_build_anchors = rfs.build_anchors
    for n in ns:
        anchor_gate(n)
        rfs.build_anchors = build_anchors_small_n if n < 8 else orig_build_anchors
        pool = rfs.sweep(n, "battery", seed=20260820 + n)
        headline(n, pool)
    rfs.build_anchors = orig_build_anchors


if __name__ == "__main__":
    main()
