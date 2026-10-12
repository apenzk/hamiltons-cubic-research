"""
Is there a critical point with slack exactly eps?  Solved as a SYSTEM, not a penalty.

The penalised search (p3_slack_eps.py) failed its own control: at eps = 0.30,
where a critical point is known to exist (smallest observed slack 0.303691), it
returned the WORST residual of the sweep, 2.4e-2.  Penalising (S - eps)^2
against the criticality residual makes the optimiser trade one for the other,
and Powell in dimension 84 serves neither.  That sweep is uninformative and is
recorded as such.

Here the two conditions are imposed together and solved by Levenberg-Marquardt
on the joint residual vector -- the method that reaches 1e-15 in this repo where
first-order searches stall at 1e-8:

    F(x) = [ vec( Q(W) - theta W ) ;  w * (S(W) - eps) ],    W = W(x)/||W(x)||.

The slack row is weighted by w so it cannot be traded away.  A converged root
with joint residual ~1e-12 IS a critical point with slack eps.

READ THE CONTROL FIRST.  eps values at and above 0.30 must converge; if they do
not, the solver is not fit for the question and nothing below is evidence.
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


def slack_of(L2, W, c, alt):
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    d2 = float(delta2_and_grad(W, alt)[0])
    rm = ricci_from_mop(L2, Wm)
    S = float(np.sum(rm * rm)) + 6 * d2 - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))
    return th, S, QW


def run(n, epss, seeds=10, w=30.0):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt = build_alt_indices(L2)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    Nl = int(round(np.sqrt(Eflat.shape[1])))
    print(f"n={n}  dim Weyl={D}   (weight on the slack row: {w})")
    print(f"   {'eps':>7} {'crit resid':>11} {'S achieved':>12} {'theta':>10}  verdict")
    for eps in epss:
        t0 = time.time()
        best = None
        for s in range(seeds):
            rng = np.random.default_rng(7919 * s + int(1e5 * eps))
            x0 = rng.normal(size=D); x0 /= np.linalg.norm(x0)

            def F(x):
                xx = x / np.linalg.norm(x)
                W = (Eflat.T @ xx).reshape(Nl, Nl)
                W = 0.5 * (W + W.T)
                th, S, QW = slack_of(L2, W, c, alt)
                return np.concatenate([(QW - th * W).reshape(-1), [w * (S - eps)]])

            try:
                r = least_squares(F, x0, method="lm", xtol=1e-15, ftol=1e-15,
                                  max_nfev=3000)
            except Exception:
                continue
            x = r.x / np.linalg.norm(r.x)
            W = (Eflat.T @ x).reshape(Nl, Nl)
            W = 0.5 * (W + W.T); W /= np.linalg.norm(W)
            th, S, QW = slack_of(L2, W, c, alt)
            if th < 0:
                W = -W
                th, S, QW = slack_of(L2, W, c, alt)
            ric = float(np.max(np.abs(ricci_from_mop(L2, W))))
            if ric > 1e-7 or th < 1e-6:
                continue
            res = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
            score = max(res, abs(S - eps))
            if best is None or score < best[0]:
                best = (score, res, S, th)
        if best is None:
            print(f"   {eps:>7.4f} {'--':>11} {'--':>12} {'--':>10}  nothing Ricci-flat converged"
                  f"   ({time.time()-t0:.0f}s)", flush=True)
            continue
        _sc, res, S, th = best
        hit = res < 1e-9 and abs(S - eps) < 1e-6
        print(f"   {eps:>7.4f} {res:>11.2e} {S:>12.6f} {th:>10.6f}  "
              f"{'CRITICAL POINT AT THIS SLACK' if hit else 'not reached'}"
              f"   ({time.time()-t0:.0f}s)", flush=True)


print("Joint LM solve: criticality AND slack = eps, as one system.")
print("Controls (eps >= 0.30) are listed FIRST -- if they fail, ignore the rest.\n")
run(6, [0.6734, 0.3037, 0.15, 0.05, 0.02, 0.005])
