"""
Does HP^2 move the ungraded frontier?

Reviewer 15 reports that three of the four P2b rows are UNGRADED (slack
S = 0.57..0.96), including HP^2 at theta = 1.115546702.  The recorded ungraded
ceiling in FINDINGS is 0.900828.  If HP^2 is genuinely ungraded, the frontier
moves from 0.9008 to 1.1155 and the gap to sqrt(3/2) = 1.224745 shrinks from
0.324 to 0.109 -- which matters a great deal, because the crux is exactly
"some constant separates the ungraded side from sqrt(3/2)".

For each P2b point this recomputes, independently:
  - the criticality residual and Ricci-flatness,
  - the FIRST BIANCHI residual (neither P2b script checked it),
  - the graded compression slack S = ||Ric(W_-)||^2 + 6 delta^2
                                     - theta tr(W_-) - tr(W_-^2),
  - the Bianchi defect delta^2.
S = 0 is the graded class; S > 0 is ungraded.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from p2b_reducible_isotropy import u_m_blocks
from p2b_wolf_grassmann import wolf_blocks, grassmann_blocks
from scipy.optimize import fsolve

SQ32 = np.sqrt(1.5)


def analyse(n, blocks, label):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt = build_alt_indices(L2)
    Pm = np.eye(blocks[0].shape[0]) - sum(blocks)
    basis = list(blocks) + [Pm]
    r = len(basis)

    def build(x):
        return sum(xi * B for xi, B in zip(x, basis))

    def resid(x):
        W = build(x); nr = np.linalg.norm(W)
        if nr < 1e-12:
            return [1e3] * r
        Wn = W / nr
        QW = Q_full(Wn, c); th = float(np.sum(Wn * QW))
        g = QW - th * Wn
        o = [float(np.sum(B * g)) / max(np.linalg.norm(B), 1e-30) for B in basis]
        return [o[i] - o[-1] for i in range(r - 1)] + [float(np.max(np.abs(ricci_from_mop(L2, Wn))))]

    rng = np.random.default_rng(3)
    best = None
    for _ in range(80):
        x, _i, ier, _m = fsolve(resid, rng.normal(size=r), full_output=True)
        if ier != 1:
            continue
        W = build(x)
        if np.linalg.norm(W) < 1e-8:
            continue
        Wn = W / np.linalg.norm(W)
        QW = Q_full(Wn, c); th = float(np.sum(Wn * QW))
        if th < 0:
            Wn, th = -Wn, -th; QW = Q_full(Wn, c)
        res = np.linalg.norm(QW - th * Wn) / max(np.linalg.norm(QW), 1e-30)
        if res > 1e-8:
            continue
        if best is None or th > best[0]:
            best = (th, Wn, res)
    if best is None:
        print(f"   {label:22s} n={n:3d}  no critical point")
        return
    th, W, res = best
    ric = float(np.max(np.abs(ricci_from_mop(L2, W))))
    d2 = float(delta2_and_grad(W, alt)[0])
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    rm = ricci_from_mop(L2, Wm)
    S = float(np.sum(rm * rm)) + 6 * d2 - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))
    tag = "GRADED" if abs(S) < 1e-8 else "UNGRADED"
    mark = "  <-- ABOVE the recorded ungraded ceiling 0.900828" if (S > 1e-8 and th > 0.900828) else ""
    print(f"   {label:22s} n={n:3d}  theta={th:.9f}  res={res:.1e}  |Ric|={ric:.1e}"
          f"  delta^2={d2:.6f}  S={S:+.6f}  {tag}{mark}")


print("Recomputing the P2b points, with the graded-compression slack S:")
print(f"(recorded ungraded ceiling 0.900828;  sqrt(3/2) = {SQ32:.9f})\n")
for m in (4, 5, 6, 7):
    n, blocks = u_m_blocks(m)
    analyse(n, blocks, f"CP^{m} (u({m}))")
for m in (2, 3):
    n, blocks, _w = wolf_blocks(m)
    analyse(n, blocks, f"Wolf sp(1)+sp({m})")
for (a, b) in ((2, 2), (2, 3)):
    n, blocks, _w = grassmann_blocks(a, b)
    analyse(n, blocks, f"Gr_C({a},{b})")
