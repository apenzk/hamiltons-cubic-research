"""The exact theta formula, and which of its terms controls the ungraded gap.

Rearranging the slack definition gives, at every critical point,

    theta * tr(W-)  =  ||Ric(W-)||^2 + 6 delta^2 - tr(W-^2) - S ,

with S = T1 + 2T2 + T3 >= 0 the slack.  So slack enters NEGATIVELY: for fixed
Ricci/defect/trace data, being ungraded costs theta directly.  That is the shape
the crux needs -- what is missing is control of the other terms.

This tabulates every term across graded and ungraded critical points, to see
empirically which one moves when S turns on.  Facts available for bounding:
  * Ric(W-) is PSD with tr Ric(W-) = 2 tr(W-)  (scal = 2 tr, scal = tr Ric),
    hence ||Ric(W-)||^2 <= 4 tr(W-)^2, with equality iff Ric(W-) is rank one;
  * delta^2 <= 1/4 (proven elsewhere in FINDINGS);
  * tr(W) = 0, so tr(W+) = tr(W-), and ||W+||^2 + ||W-||^2 = 1.
"""
import numpy as np
from scipy.optimize import least_squares
from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, mop_from_4tensor, ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad, build_su3_n8
from run_hpm_qk import qk_tensor
from run_unconstrained_search import build_weyl_basis
from review_r11_graded_law import unit, orient
from review_r11_ungraded_frontier import multiblock_weyl
from review_r11_slack_decomp import terms, lm_critical

rows = []
for n in (6, 8, 12):
    idx, pos_, N, c = build_structure_constants(n)
    L2 = Lambda2(n); alt = build_alt_indices(L2)
    cands = []
    for blocks in ([2, 2, n - 4], [3, 3, n - 6]):
        if all(b >= 2 for b in blocks) and sum(blocks) == n:
            Wb = multiblock_weyl(L2, blocks)
            if Wb is not None and np.linalg.norm(Wb) > 1e-9:
                cands.append((f"sph{tuple(blocks)}", Wb))
    m = n // 2
    a = 1.0 / (m - 1)
    d = np.zeros(L2.N)
    for k, (i, j) in enumerate(L2.pairs):
        if (i < m) == (j < m): d[k] = a
    cands.append((f"balanced S^{m}xS^{m}", weyl_from_mop(L2, np.diag(d))[0]))
    if n % 4 == 0:
        cands.append((f"HP^{n//4}", weyl_from_mop(L2, mop_from_4tensor(L2, qk_tensor(n, n//4, 1., 1.)))[0]))
    if n == 8:
        cands.append(("SU(3)bi", build_su3_n8()[1]))
        for f, lab in (("scripts/data/defect_violation_n8_0.120000.npy", "3/25 violator"),
                       ("scripts/data/gap_band_point_n8.npy", "0.9008 witness")):
            try: cands.append((lab, np.load(f)))
            except Exception: pass
    for label, W in cands:
        W = unit(np.asarray(W, float)); W, _ = orient(W, c)
        th, S, T1, T2, T3, res = terms(L2, W, c, alt)
        if res > 1e-7 or th <= 1e-6: continue
        ev, V = np.linalg.eigh(W); neg = ev < 0
        Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
        R = ricci_from_mop(L2, Wm)
        rows.append((n, label, th, S, float(np.sum(R*R)),
                     6*delta2_and_grad(W, alt)[0], float(np.trace(Wm@Wm)),
                     float(np.trace(Wm))))
    if n == 6:
        Eflat, D = build_weyl_basis(n, idx, pos_, N, c, verbose=False)
        got = 0
        for seed in range(40):
            if got >= 4: break
            W = lm_critical(n, c, Eflat, D, N, seed)
            th, S, T1, T2, T3, res = terms(L2, W, c, alt)
            if res > 1e-12 or th <= 1e-3 or S < 1e-6: continue
            got += 1
            ev, V = np.linalg.eigh(W); neg = ev < 0
            Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
            R = ricci_from_mop(L2, Wm)
            rows.append((n, f"generic LM #{got}", th, S, float(np.sum(R*R)),
                         6*delta2_and_grad(W, alt)[0], float(np.trace(Wm@Wm)),
                         float(np.trace(Wm))))

print(f"{'point':<24} {'theta':>9} {'S':>8} {'|Ric-|^2':>9} {'6d^2':>7} {'trW-^2':>8}"
      f" {'trW-':>7} {'4trW-^2':>8} {'check':>9}")
print("-"*98)
for n, label, th, S, ric2, d6, tw2, tw in sorted(rows, key=lambda r: -r[2]):
    chk = (ric2 + d6 - tw2 - S) / tw - th
    print(f"{label+f' n={n}':<24} {th:>9.5f} {S:>8.4f} {ric2:>9.4f} {d6:>7.4f} {tw2:>8.4f}"
          f" {tw:>7.4f} {4*tw*tw:>8.4f} {chk:>9.1e}")
print("-"*98)
gr=[r for r in rows if r[3]<1e-8]; un=[r for r in rows if r[3]>=1e-8]
print(f"graded   ({len(gr)}): theta up to {max(r[2] for r in gr):.5f};  ||Ric-||^2/(4 trW-^2) in "
      f"[{min(r[4]/(4*r[7]**2) for r in gr):.3f}, {max(r[4]/(4*r[7]**2) for r in gr):.3f}]")
if un:
    print(f"ungraded ({len(un)}): theta up to {max(r[2] for r in un):.5f};  ||Ric-||^2/(4 trW-^2) in "
          f"[{min(r[4]/(4*r[7]**2) for r in un):.3f}, {max(r[4]/(4*r[7]**2) for r in un):.3f}]")
