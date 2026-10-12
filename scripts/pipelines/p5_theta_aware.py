"""
Is the surviving regularity true, and is it the repair?

The sharp (II)-side bound theta <= RHS is valid and Fox-sharp but does not
separate: (S^m)^3 drives RHS above sqrt(3/2).  What was recorded as the lead is a
TWO-SIDED regularity -- in all data so far, every point with RHS >= sqrt(3/2) has
theta <= 0.916.

If that holds, it IS the repair.  The bound fails to separate only where
RHS >= sqrt(3/2), and at exactly those points theta is already far below the
target, so

    theta <= RHS                     where RHS < sqrt(3/2)
    theta <= 0.916 < sqrt(3/2)       where RHS >= sqrt(3/2)

separates everywhere.  The question is whether the regularity survives contact
with a population it was not read off.

This measures (theta, RHS) at every critical point reachable at n = 6 -- the
one dimension where random-start LM finds them in quantity -- and reports the
joint picture: the largest theta among points with RHS >= sqrt(3/2), and the
smallest RHS among points with theta > 0.916.  Either would refute it.

RHS is recomputed here in rho = Ric(W_-) variables, following the independent
form used by the reviewer who refuted the separation, rather than the original.
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

SQ32 = np.sqrt(1.5)


def measure(L2, W, c, alt):
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    d2 = float(delta2_and_grad(W, alt)[0])
    rho = ricci_from_mop(L2, Wm)
    nr2 = float(np.sum(rho * rho))
    if nr2 < 1e-14:
        return None
    Sh = rho / np.sqrt(nr2)
    trSh4 = float(np.trace(np.linalg.matrix_power(Sh, 4)))
    e2 = 0.0
    RicWm2 = ricci_from_mop(L2, Wm @ Wm)
    rhs = (np.sqrt(2) * np.sqrt(max(1 - trSh4, 0.0)) * np.sqrt(max(1 - e2, 0.0))
           - float(np.sum(RicWm2 * rho)) / nr2
           + 12.0 * d2 * float(np.linalg.eigvalsh(rho)[-1]) / nr2)
    rm = ricci_from_mop(L2, Wm)
    S = float(np.sum(rm * rm)) + 6 * d2 - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))
    res = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
    return th, rhs, S, res


def run(n=6, seeds=160):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt = build_alt_indices(L2)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    Nl = int(round(np.sqrt(Eflat.shape[1])))
    pts = []
    for s in range(seeds):
        rng = np.random.default_rng(4242 * s + n)
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
        m = measure(L2, W, c, alt)
        if m is None:
            continue
        th, rhs, S, res = m
        if th < 0:
            W = -W
            m = measure(L2, W, c, alt)
            if m is None:
                continue
            th, rhs, S, res = m
        if res < 1e-9 and th > 1e-6:
            pts.append((th, rhs, S))
    hi = [p for p in pts if p[1] >= SQ32]
    big = [p for p in pts if p[0] > 0.916]
    print(f"n={n}  {len(pts)} critical points   ({sum(1 for p in pts if p[2] > 1e-8)} ungraded)")
    print(f"   theta range [{min(p[0] for p in pts):.6f}, {max(p[0] for p in pts):.6f}]"
          f"   RHS range [{min(p[1] for p in pts):.6f}, {max(p[1] for p in pts):.6f}]")
    print(f"   points with RHS >= sqrt(3/2): {len(hi)}"
          + (f"   max theta among them = {max(p[0] for p in hi):.6f}"
             f"   {'*** REGULARITY BREACHED ***' if hi and max(p[0] for p in hi) > 0.916 else 'consistent (<= 0.916)'}"
             if hi else "   -- none, so the regularity is untested here"))
    print(f"   points with theta > 0.916: {len(big)}"
          + (f"   min RHS among them = {min(p[1] for p in big):.6f}"
             f"   {'*** REGULARITY BREACHED ***' if big and min(p[1] for p in big) >= SQ32 else 'consistent (RHS < sqrt(3/2))'}"
             if big else "   -- none"))


if __name__ == "__main__":
    run()
