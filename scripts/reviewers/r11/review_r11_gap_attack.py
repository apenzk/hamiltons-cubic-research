"""
Adversarial test of the ungraded gap, per the standing review rule.

review_r11_ungraded_frontier.py measured every ungraded critical point the repo
can produce and found them all at theta <= 0.852944, against sqrt(3/2) = 1.224745
-- an empty band of width 0.37.  The claim that closes the core is

        S(W) > 0  ==>  theta(W) <= c   for some c < sqrt(3/2),

so the way to attack it is to hunt INSIDE the band: look for a critical point
with theta pinned in (0.86, 1.22) that is genuinely ungraded (S > 0).  Finding
one refutes the gap; failing to, from many starts and several pinned values, is
evidence for it.

Objective, minimised on the unit sphere of the Weyl subspace:

    F(W) = ||Q(W) - theta W||^2 / ||Q(W)||^2  +  (theta - theta_target)^2
           -  mu * min(S(W), S_cap)

The last term REWARDS ungradedness, so the search is actively pushed away from
the graded solutions (sphere products, Fox, the Kaehler family) that otherwise
populate this range -- i.e. it is biased towards refuting the gap, not
confirming it.  Anything returned is then screened: Ricci-flat, unit norm,
criticality residual, and S computed independently.
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

SQ32 = np.sqrt(1.5)


def slack_of(L2, W, c, alt_idx):
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    d2 = delta2_and_grad(W, alt_idx)[0]
    r = ricci_from_mop(L2, Wm)
    scale = float(np.sum(r * r)) + 6 * d2
    S = scale - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))
    res = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
    return th, d2, S, S / max(scale, 1e-300), res


def run(n, targets, n_seeds=6, mu=0.6, S_cap=0.5):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt_idx = build_alt_indices(L2)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    Nl = int(round(np.sqrt(Eflat.shape[1])))
    hits = []
    for th_t in targets:
        best = None
        for seed in range(n_seeds):
            rng = np.random.default_rng(1000 * seed + int(100 * th_t))
            x0 = rng.normal(size=D)
            x0 /= np.linalg.norm(x0)

            def F(x):
                x = x / np.linalg.norm(x)
                W = (Eflat.T @ x).reshape(Nl, Nl)
                QW = Q_full(W, c)
                th = float(np.sum(W * QW))
                r = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
                ev, V = np.linalg.eigh(W)
                neg = ev < 0
                Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
                d2 = delta2_and_grad(W, alt_idx)[0]
                ric = ricci_from_mop(L2, Wm)
                S = (float(np.sum(ric * ric)) + 6 * d2
                     - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm)))
                return r * r + (th - th_t) ** 2 - mu * min(max(S, 0.0), S_cap)

            res = minimize(F, x0, method="Powell",
                           options={"maxiter": 60, "xtol": 1e-6, "ftol": 1e-8})
            x = res.x / np.linalg.norm(res.x)
            W = (Eflat.T @ x).reshape(Nl, Nl)
            W = 0.5 * (W + W.T)
            W = W / np.linalg.norm(W)
            th, d2, S, Srel, r = slack_of(L2, W, c, alt_idx)
            if th < 0:
                W = -W
                th, d2, S, Srel, r = slack_of(L2, W, c, alt_idx)
            ric = np.max(np.abs(ricci_from_mop(L2, W)))
            ok = r < 1e-6 and ric < 1e-8
            if ok and Srel > 1e-6 and best is None or (
                    ok and Srel > 1e-6 and best is not None and th > best[0]):
                best = (th, S, Srel, r)
        if best is None:
            print(f"  n={n} theta_target={th_t:4.2f}:  no genuinely ungraded critical point found")
        else:
            th, S, Srel, r = best
            print(f"  n={n} theta_target={th_t:4.2f}:  theta={th:.6f}  S={S:.6f}  resid={r:.1e}"
                  f"   {'*** IN BAND ***' if 0.86 < th < SQ32 else ''}")
            hits.append((n, th, S))
    return hits


print("Hunting inside the empty band (0.853, 1.2247) for an UNGRADED critical point.")
print("The objective rewards slack, so the search is biased towards refuting the gap.\n")
allhits = []
for n in (6,):
    allhits += run(n, [0.95, 1.10, 1.20])

band = [h for h in allhits if 0.86 < h[1] < SQ32]
print("\n" + "=" * 70)
if band:
    print(f"GAP REFUTED: {len(band)} ungraded critical point(s) inside the band")
    for n, th, S in band:
        print(f"   n={n}  theta={th:.6f}  S={S:.6f}")
else:
    print("No ungraded critical point found inside the band, from any pinned target,")
    print("under an objective that actively rewards ungradedness. Evidence for the gap,")
    print("not a proof of it.")
