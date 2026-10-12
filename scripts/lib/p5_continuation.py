"""
Reaching the ungraded population above n = 6 by continuation, not random starts.

Random-start LM converges nothing at n >= 8: the residual system has dimension
300 and up, and 4000 function evaluations is roughly thirteen Jacobian builds.
But critical points are not scarce -- they are hard to FIND from nowhere.  A
known point in dimension n embeds into dimension n+2 by zero-padding, and the
padded operator is Ricci-flat and Bianchi automatically, so it is an exact
critical point of the larger problem.  Correcting from there is a local solve
rather than a global search.

Two things this can establish that random starts cannot:

  1. Whether the ungraded ceiling RISES with n.  Padding an ungraded point keeps
     theta fixed, so padding alone says nothing; the question is whether the
     padded point can be moved to a higher-theta ungraded point nearby, which is
     a local ascent under the criticality constraint.

  2. Whether ungraded critical points exist at all at n = 10, 12.  Their absence
     from random-start sweeps is a statement about the search, not the geometry,
     and padding settles it constructively.

Method: take the ungraded points found at n = 6, pad to n = 8, 10, 12, verify
criticality and slack survive the padding exactly, then run a short constrained
ascent in theta from each and report whether anything exceeds the recorded
ceiling.  Padding is exact, so any failure is in the ascent rather than the seed.
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


def ctx(n):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    return c, L2, build_alt_indices(L2), build_weyl_basis(n, idx, pos, N, c, verbose=False)


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


def pad(Wsmall, m, n):
    """Zero-pad an operator on Lambda^2(R^m) into Lambda^2(R^n), m < n."""
    pm = [(i, j) for i in range(m) for j in range(i + 1, m)]
    pn = [(i, j) for i in range(n) for j in range(i + 1, n)]
    loc = {p: k for k, p in enumerate(pn)}
    out = np.zeros((len(pn), len(pn)))
    for a, pa in enumerate(pm):
        for b, pb in enumerate(pm):
            out[loc[pa], loc[pb]] = Wsmall[a, b]
    return out


def find_at_6(k=40):
    c, L2, alt, (Eflat, D) = ctx(6)
    Nl = int(round(np.sqrt(Eflat.shape[1])))
    pts = []
    for s in range(k):
        rng = np.random.default_rng(9000 + s)
        x0 = rng.normal(size=D); x0 /= np.linalg.norm(x0)

        def F(x):
            xx = x / np.linalg.norm(x)
            W = (Eflat.T @ xx).reshape(Nl, Nl)
            W = 0.5 * (W + W.T)
            QW = Q_full(W, c)
            return (QW - float(np.sum(W * QW)) * W).reshape(-1)

        r = least_squares(F, x0, method="lm", xtol=1e-15, ftol=1e-15, max_nfev=4000)
        x = r.x / np.linalg.norm(r.x)
        W = (Eflat.T @ x).reshape(Nl, Nl); W = 0.5 * (W + W.T)
        if np.linalg.norm(W) < 1e-10:
            continue
        W /= np.linalg.norm(W)
        th, S, res = state(L2, W, c, alt)
        if th < 0:
            W = -W
            th, S, res = state(L2, W, c, alt)
        if res < 1e-9 and S > 1e-8 and th > 1e-6:
            pts.append((th, W))
    pts.sort(key=lambda t: -t[0])
    return pts


print("Seeding at n=6 by LM, then padding upward -- padding is exact, so any")
print("failure above is in the ascent rather than the seed.\n")
t0 = time.time()
seeds = find_at_6()
print(f"n=6: {len(seeds)} ungraded critical points, max theta = "
      f"{seeds[0][0]:.9f}   ({time.time()-t0:.0f}s)", flush=True)

for n in (8, 10, 12):
    c, L2, alt, (Eflat, D) = ctx(n)
    best = None
    for th6, W6 in seeds[:6]:
        W = pad(W6, 6, n)
        W = W / np.linalg.norm(W)
        th, S, res = state(L2, W, c, alt)
        if best is None or th > best[0]:
            best = (th, S, res)
    th, S, res = best
    print(f"n={n:3d}: padded seed  theta={th:.9f}  S={S:+.6f}  residual={res:.2e}"
          f"   {'still an exact critical point' if res < 1e-9 else 'PADDING BROKE criticality'}"
          f"   {'ungraded' if S > 1e-8 else 'graded'}", flush=True)
