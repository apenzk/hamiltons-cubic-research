"""
Does the ungraded ceiling theta <= 0.900828 hold above n = 8?

The recorded ceiling was measured mostly at n = 6 and 8, and two different
search methods returned DISJOINT populations at n = 6 -- one all-graded, one
all-ungraded -- so no single sweep is a census.  The ceiling matters because the
gap it leaves, 0.324 against sqrt(3/2), is what makes the ungraded half a loose
problem rather than a tight one; if it rises with n the whole framing changes.

Method: unconstrained Levenberg-Marquardt on the criticality residual, which is
what actually reached machine-zero residuals here, from many random starts.  Each
converged point is screened -- unit norm, Ricci-flat, criticality residual, then
the graded-compression slack S computed independently -- and reported by class.

This is a lower bound on the true ceiling: an ascent finds what it can reach, so
a ceiling that survives many starts is evidence, never proof.  Reported per n:
how many converged, the split by class, and the largest theta on each side.

DOES NOT SCALE -- read before reusing.

Unconstrained LM at max_nfev = 4000 converges nothing at n = 8 (dim 300),
n = 10 (dim 770) or n = 12 (dim 1638): 0 of 80, 0 of 60, 0 of 40.  At dim 300
that budget is roughly thirteen Jacobian builds, far short of convergence.  The
same approach found 113 critical points at n = 6 (dim 84), so the method works
only in the smallest dimension.

CONSEQUENCE.  The recorded ungraded ceiling theta <= 0.900828 rests on sweeps at
n = 6 and 8; whether it rises with n is UNMEASURED, and reaching the ungraded
population at n >= 10 needs a different method -- a sparse or matrix-free
Jacobian, a continuation from known points, or a structured ansatz rather than
random starts.
"""
import numpy as np
from scipy.optimize import least_squares
import time

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from run_unconstrained_search import build_weyl_basis

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


def run(n, seeds, seed0=101):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt = build_alt_indices(L2)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    Nl = int(round(np.sqrt(Eflat.shape[1])))
    t0 = time.time()
    gr, un = [], []
    for s in range(seeds):
        rng = np.random.default_rng(seed0 * s + n)
        x0 = rng.normal(size=D); x0 /= np.linalg.norm(x0)

        def F(x):
            xx = x / np.linalg.norm(x)
            W = (Eflat.T @ xx).reshape(Nl, Nl)
            W = 0.5 * (W + W.T)
            QW = Q_full(W, c)
            return (QW - float(np.sum(W * QW)) * W).reshape(-1)

        try:
            r = least_squares(F, x0, method="lm", xtol=1e-15, ftol=1e-15, max_nfev=4000)
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
            (gr if abs(S) < 1e-8 else un).append(th)
        if (s + 1) % 20 == 0:
            print(f"      [n={n}] seed {s+1}/{seeds}: {len(gr)} graded, {len(un)} ungraded,"
                  f" {time.time()-t0:.0f}s", flush=True)
    print(f"n={n:3d}  dim={D:5d}  converged {len(gr)+len(un)} of {seeds}"
          f"   graded {len(gr)}  ungraded {len(un)}   ({time.time()-t0:.0f}s)")
    if gr:
        print(f"      max graded   theta = {max(gr):.9f}")
    if un:
        un.sort()
        print(f"      max ungraded theta = {max(un):.9f}"
              f"   (recorded ceiling 0.900828)"
              f"   {'*** CEILING BREACHED ***' if max(un) > 0.900828 + 1e-6 else 'below the ceiling'}")
        print(f"      top five ungraded: {[round(t,6) for t in un[-5:]]}")
    print(flush=True)


if __name__ == "__main__":
    for n, k in ((8, 80), (10, 60), (12, 40)):
        run(n, k)
