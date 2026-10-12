"""
Does the ungraded ceiling move under local ascent from padded seeds?

Padding gives exact ungraded critical points at n = 8, 10, 12 but preserves
theta, so it settles existence and not the bound.  The tractable form of the
ceiling question is local: start at a padded ungraded critical point and ascend
theta while STAYING critical and STAYING ungraded.

Objective on the unit sphere of Weyl_n:

    F(W) = ||Q(W) - theta W||^2 / ||Q(W)||^2  -  mu * theta   subject to S > 0,

with the criticality residual weighted heavily so the walk tracks the critical
set rather than leaving it, and the slack checked after each stage rather than
penalised, since penalising S was what made an earlier attempt collapse onto the
graded set.

Reported per dimension: the seed's theta, the best theta reached with residual
still below 1e-8 and S still positive, and whether the recorded ceiling
0.900828 is exceeded.  An ascent is a LOWER bound on what is reachable, so
exceeding the ceiling refutes it while failing to does not confirm it.
"""
import numpy as np
from scipy.optimize import minimize
import time

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from run_unconstrained_search import build_weyl_basis
from p5_continuation import ctx, state, pad, find_at_6

CEIL = 0.900828


def run(n, seeds, mus=(0.05, 0.2, 0.8), iters=250):
    c, L2, alt, (Eflat, D) = ctx(n)
    Nl = int(round(np.sqrt(Eflat.shape[1])))
    t0 = time.time()
    best = None
    for th6, W6 in seeds:
        W0 = pad(W6, 6, n)
        W0 = W0 / np.linalg.norm(W0)
        x0 = Eflat @ W0.reshape(-1)
        for mu in mus:
            def F(x):
                x = x / np.linalg.norm(x)
                W = (Eflat.T @ x).reshape(Nl, Nl)
                W = 0.5 * (W + W.T)
                QW = Q_full(W, c)
                th = float(np.sum(W * QW))
                res = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
                return res * res - mu * th

            r = minimize(F, x0, method="Powell",
                         options={"maxiter": iters, "xtol": 1e-9, "ftol": 1e-11})
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
            if res < 1e-8 and ric < 1e-8 and S > 1e-8:
                if best is None or th > best[0]:
                    best = (th, S, res)
    seed_th = max(t for t, _ in seeds)
    if best is None:
        print(f"n={n:3d}  seed theta={seed_th:.9f}   ascent kept nothing critical and ungraded"
              f"   ({time.time()-t0:.0f}s)", flush=True)
        return
    th, S, res = best
    print(f"n={n:3d}  seed theta={seed_th:.9f}  ->  best {th:.9f}"
          f"  S={S:+.4f}  res={res:.1e}   ceiling {CEIL}"
          f"   {'*** CEILING BREACHED ***' if th > CEIL + 1e-6 else 'below the ceiling'}"
          f"   ({time.time()-t0:.0f}s)", flush=True)


if __name__ == "__main__":
    print("Local ascent in theta from padded ungraded seeds, staying critical and ungraded.\n")
    s6 = find_at_6()
    print(f"n=6 seeds: {len(s6)} ungraded, max theta = {s6[0][0]:.9f}\n", flush=True)
    for n in (8, 10):
        run(n, s6[:4])
