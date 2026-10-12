"""
Is there a critical point with SMALL POSITIVE slack?

The previous attempt (p3_slack_gap.py) penalised mu*max(S,0), which drives
S -> 0 -- and S = 0 IS the graded set, so the search collapsed onto graded
points rather than probing just outside them.  Its "zero ungraded found" is a
consequence of the objective, not evidence about the gap.  Recorded and fixed.

The right question is a TARGETED one: for a sequence of small eps > 0, does a
critical point with S = eps exist?  Objective on the unit sphere:

    F(W) = ||Q(W) - theta W||^2 / ||Q(W)||^2  +  lam * (S(W) - eps)^2

so the search is pulled to slack exactly eps, neither zero nor large.  If the
criticality residual can be driven to zero while S sits at eps = 0.01, the
graded set is NOT separated and the reformulation dies.  If the residual stalls
for every small eps but converges for eps above some threshold, that threshold
is the slack gap.

Reported per eps: the best (smallest) criticality residual achieved, and the
slack and theta there.  A residual that stays >> 1e-8 means no critical point
with that slack was reachable.
"""
import numpy as np
from scipy.optimize import minimize

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from run_unconstrained_search import build_weyl_basis
import time

SQ32 = np.sqrt(1.5)


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


def run(n, epss, seeds=8, lam=20.0):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt = build_alt_indices(L2)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    Nl = int(round(np.sqrt(Eflat.shape[1])))
    print(f"n={n}  dim Weyl={D}")
    for eps in epss:
        t0 = time.time()
        best = None
        for s in range(seeds):
            rng = np.random.default_rng(100 * s + int(1e4 * eps))
            x0 = rng.normal(size=D); x0 /= np.linalg.norm(x0)

            def F(x):
                x = x / np.linalg.norm(x)
                W = (Eflat.T @ x).reshape(Nl, Nl)
                W = 0.5 * (W + W.T)
                th, S, res = state(L2, W, c, alt)
                return res * res + lam * (S - eps) ** 2

            r = minimize(F, x0, method="Powell",
                         options={"maxiter": 250, "xtol": 1e-8, "ftol": 1e-10})
            x = r.x / np.linalg.norm(r.x)
            W = (Eflat.T @ x).reshape(Nl, Nl)
            W = 0.5 * (W + W.T); W /= np.linalg.norm(W)
            th, S, res = state(L2, W, c, alt)
            if th < 0:
                W = -W
                th, S, res = state(L2, W, c, alt)
            ric = float(np.max(np.abs(ricci_from_mop(L2, W))))
            if ric > 1e-7:
                continue
            if best is None or res < best[2]:
                best = (th, S, res)
        if best is None:
            print(f"   eps={eps:<7.4f}  nothing Ricci-flat converged   ({time.time()-t0:.0f}s)")
            continue
        th, S, res = best
        mark = "CRITICAL POINT AT THIS SLACK" if res < 1e-7 else "no critical point reachable"
        print(f"   eps={eps:<7.4f}  best resid={res:.2e}  S={S:+.6f}  theta={th:.6f}"
              f"   {mark}   ({time.time()-t0:.0f}s)", flush=True)


print("Targeting small POSITIVE slack, not zero slack.\n")
run(6, [0.005, 0.02, 0.05, 0.15, 0.30])
