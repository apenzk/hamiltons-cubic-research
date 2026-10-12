"""
Establish a VALID control before asking any gap question.

Three attempts to probe the slack gap have now failed their controls.  The root
error was using slack values taken from n=12 and n=8 points as targets at n=6 --
and the n=6 population found so far is 17 critical points, all graded, so those
targets may correspond to nothing in that dimension.

This does the prerequisite: find genuine UNGRADED critical points by plain
Levenberg-Marquardt with NO slack constraint, and record their slacks.  Only
those values are legitimate controls for a constrained solve at the same n.

Reports, per dimension, the full converged population split by slack, so the
question "does the ungraded set exist here, and where does its slack start" is
answered before anything is asked about a gap.
"""
import numpy as np
from scipy.optimize import least_squares

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from run_unconstrained_search import build_weyl_basis
import time


def state(L2, W, c, alt):
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    d2 = float(delta2_and_grad(W, alt)[0])
    rm = ricci_from_mop(L2, Wm)
    S = float(np.sum(rm * rm)) + 6 * d2 - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))
    res = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
    return th, S, res


def run(n, seeds=120):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt = build_alt_indices(L2)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    Nl = int(round(np.sqrt(Eflat.shape[1])))
    t0 = time.time()
    pts = []
    for s in range(seeds):
        rng = np.random.default_rng(20261 * s + n)
        x0 = rng.normal(size=D); x0 /= np.linalg.norm(x0)

        def F(x):
            xx = x / np.linalg.norm(x)
            W = (Eflat.T @ xx).reshape(Nl, Nl)
            W = 0.5 * (W + W.T)
            QW = Q_full(W, c)
            th = float(np.sum(W * QW))
            return (QW - th * W).reshape(-1)

        try:
            r = least_squares(F, x0, method="lm", xtol=1e-15, ftol=1e-15, max_nfev=3000)
        except Exception:
            continue
        x = r.x / np.linalg.norm(r.x)
        W = (Eflat.T @ x).reshape(Nl, Nl)
        W = 0.5 * (W + W.T)
        if np.linalg.norm(W) < 1e-10:
            continue
        W /= np.linalg.norm(W)
        th, S, res = state(L2, W, c, alt)
        if th < 0:
            W = -W
            th, S, res = state(L2, W, c, alt)
        ric = float(np.max(np.abs(ricci_from_mop(L2, W))))
        if res < 1e-9 and ric < 1e-9 and th > 1e-6:
            pts.append((S, th))
    gr = [p for p in pts if p[0] < 1e-8]
    un = sorted([p for p in pts if p[0] >= 1e-8])
    print(f"n={n:3d}  dim Weyl={D:4d}  seeds={seeds}  converged={len(pts)}"
          f"  graded={len(gr)}  ungraded={len(un)}   ({time.time()-t0:.0f}s)")
    if gr:
        print(f"      graded   theta range [{min(g[1] for g in gr):.6f}, {max(g[1] for g in gr):.6f}]")
    if un:
        print(f"      ungraded slacks, smallest first:")
        for S, th in un[:8]:
            print(f"        S={S:.6f}   theta={th:.6f}")
        print(f"      => smallest ungraded slack at n={n}: {un[0][0]:.6f}"
              f"   -- THIS is the valid control for a constrained solve here")
    else:
        print(f"      no ungraded critical point found at n={n} -- "
              f"a constrained probe here has no valid control")
    print(flush=True)


print("Finding genuine ungraded critical points by unconstrained LM.")
print("No gap question is asked until a valid same-dimension control exists.\n")
for n in (6, 8):
    run(n)
