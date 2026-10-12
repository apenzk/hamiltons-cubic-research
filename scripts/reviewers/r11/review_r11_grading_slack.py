"""
The next target, made concrete: quantify the slack in the graded compression
inequality and ask whether it controls theta.

(GC), proven at every critical point:   theta tr(W-) + tr(W-^2)  <=  ||Ric(W-)||^2 + 6 delta^2
with equality exactly on the Z_2-graded class.  Define the SLACK

    S(W) := ||Ric(W-)||^2 + 6 delta^2 - theta tr(W-) - tr(W-^2)   >= 0,

so S = 0 exactly when W is graded.  The graded half of the core is now settled
across the classical families (every graded critical point above sqrt(3/2) is a
sphere product, all defect-free).  What is left is the ungraded half, S > 0,
where nothing yet exploits the slack.

Every ungraded critical point catalogued so far has a strikingly LOW theta --
the largest is the SU(3) bi-invariant at 0.837, against sqrt(3/2) = 1.2247.  If
that is not a coincidence, the closing statement has the same shape as the
defect-penalty conjecture that worked one level up:

        theta  <=  Theta(S),   Theta decreasing,  Theta(0) = the graded bound.

This script measures (S, theta) across the catalogue to see whether such a
relation is even plausible, and what Theta would have to look like.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, mop_from_4tensor, ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from run_defect_max_hunt import su_m_kahler_weyl
from run_cp2_ricci_flat import cp2_block_st_tensor
from run_hpm_qk import qk_tensor
from review_r11_graded_law import weyl_sphere_product_mop, unit, orient

SQ32 = np.sqrt(1.5)


def slack(L2, W, c, alt_idx):
    """S = ||Ric(W-)||^2 + 6 delta^2 - theta tr(W-) - tr(W-^2), and its parts."""
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T        # W- = -(negative part), PSD
    d2 = delta2_and_grad(W, alt_idx)[0]
    ric = ricci_from_mop(L2, Wm)
    S = float(np.sum(ric * ric)) + 6 * d2 - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))
    return th, d2, S


def graded_defect(L2, W):
    """Direct measure of how far the eigenspaces are from being Z_2-graded:
    the fraction of [m, m] that lands back in m."""
    ev, V = np.linalg.eigh(W)
    cols = V[:, ev < -1e-9]
    Pm = cols @ cols.T
    mats = [L2.vec_to_matrix(cols[:, i]) for i in range(cols.shape[1])]
    inside = tot = 0.0
    for i in range(len(mats)):
        for j in range(len(mats)):
            v = L2.matrix_to_vec(mats[i] @ mats[j] - mats[j] @ mats[i])
            tot += float(v @ v)
            inside += float(v @ (Pm @ v))
    return inside / max(tot, 1e-300)


print(f"{'critical point':<28} {'n':>3} {'theta':>11} {'delta^2':>10} "
      f"{'slack S':>11} {'[m,m] in m':>11}  graded?")
print("-" * 92)
rows = []
for n in (6, 8, 12):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt_idx = build_alt_indices(L2)
    m = n // 2
    cands = [(f"balanced S^{m}xS^{m}", weyl_sphere_product_mop(L2, m, n - m)),
             ("Fox S^4(alpha)",
              weyl_from_mop(L2, mop_from_4tensor(L2, cp2_block_st_tensor(n, 1, -1)))[0]),
             (f"su({m}) Kaehler", su_m_kahler_weyl(L2, m))]
    if n % 4 == 0:
        cands.append((f"QK HP^{n//4}",
                      weyl_from_mop(L2, mop_from_4tensor(L2, qk_tensor(n, n // 4, 1.0, 1.0)))[0]))
    if n >= 8:
        p1 = 2
        cands.append((f"unbalanced S^{p1}xS^{n-p1}", weyl_sphere_product_mop(L2, p1, n - p1)))
    for label, W in cands:
        W = unit(W)
        W, th = orient(W, c)
        th, d2, S = slack(L2, W, c, alt_idx)
        g = graded_defect(L2, W)
        tag = "yes" if abs(S) < 1e-8 else "NO"
        print(f"{label:<28} {n:>3} {th:>11.6f} {d2:>10.6f} {S:>11.6f} {g:>11.3e}  {tag}")
        rows.append((th, S, label))

print("-" * 92)
ungraded = [(t, S, l) for t, S, l in rows if S > 1e-8]
graded = [(t, S, l) for t, S, l in rows if S <= 1e-8]
print(f"graded points   : {len(graded)},  max theta = {max(t for t,_,_ in graded):.6f}")
if ungraded:
    print(f"ungraded points : {len(ungraded)}, max theta = {max(t for t,_,_ in ungraded):.6f}")
    print(f"   (the target would be a decreasing Theta with theta <= Theta(S); "
          f"sqrt(3/2) = {SQ32:.6f})")
else:
    print("ungraded points : none in this catalogue slice -- "
          "the ungraded population sits at low theta and needs the search scripts to reach")
