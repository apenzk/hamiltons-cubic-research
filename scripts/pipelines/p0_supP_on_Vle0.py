"""
sup P over the admissible W_2 subspace, by ascent rather than sampling.

The coupled bound charges theta_0(n) ~ 1.28 for P(W_2) in its s^3 term, on the
grounds that theta_0 caps P everywhere.  But W_2 is confined to
V_{<=0} = ker F_u + (strictly negative eigenspaces), and random sampling there
returns |P| ~ 0.09 -- two orders below the cap.  Sampling underestimates suprema
badly in high dimension (Reviewer 18 found a 17-44x miss doing exactly that), so
this maximises P by projected gradient ascent instead.

If sup P on V_{<=0} is genuinely small, the s^3 term nearly vanishes and the
alpha ~ 0.295 window closes for every n rather than only n = 12, 14.

Reported alongside: the same ascent restricted to ker and to the negative part
separately, and the criticality residual of the maximiser, since a maximiser of
P over a subspace is a critical point only if the subspace happens to contain
its gradient.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix

SQ32 = np.sqrt(1.5)


def ascend(basis, Eflat, c, Nl, rng, restarts=14, iters=400):
    """Maximise |P| over unit vectors of a subspace: the gradient of P at W is
    3 Q(W), so projected ascent is y <- basis^T Q(W(y)), renormalised."""
    best, arg = 0.0, None
    k = basis.shape[1]
    for _ in range(restarts):
        y = rng.normal(size=k); y /= np.linalg.norm(y)
        for _ in range(iters):
            W = (Eflat.T @ (basis @ y)).reshape(Nl, Nl)
            W = 0.5 * (W + W.T)
            nw = np.linalg.norm(W)
            if nw < 1e-300:
                break
            W /= nw
            g = basis.T @ (Eflat @ Q_full(W, c).reshape(-1))
            ng = np.linalg.norm(g)
            if ng < 1e-300:
                break
            y = g / ng
        W = (Eflat.T @ (basis @ y)).reshape(Nl, Nl)
        W = 0.5 * (W + W.T); W /= max(np.linalg.norm(W), 1e-300)
        v = abs(float(np.sum(W * Q_full(W, c))))
        if v > best:
            best, arg = v, W
    return best, arg


def run(n):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    u, th, _ = fox_point(n, L2, Eflat, c)
    Nl = u.shape[0]
    M = F_matrix(u, c, Eflat)
    ev, V = np.linalg.eigh(M)
    r = ev / SQ32
    Vker = V[:, np.abs(r) < 1e-8]
    Vneg = V[:, r < -1e-8]
    Vle0 = V[:, r < 1e-8]
    rng = np.random.default_rng(17)
    t0 = np.sqrt(2.0 * (n - 1) * (n - 2)) / n
    out = {}
    for name, B in (("V_{<=0}", Vle0), ("ker only", Vker), ("negative only", Vneg)):
        v, W = ascend(B, Eflat, c, Nl, rng)
        res = np.nan
        if W is not None:
            QW = Q_full(W, c); thw = float(np.sum(W * QW))
            res = np.linalg.norm(QW - thw * W) / max(np.linalg.norm(QW), 1e-300)
        out[name] = v
        print(f"n={n:3d}  sup|P| on {name:14s} = {v:.6f}   (theta_0={t0:.6f}, "
              f"ratio {v/t0:.4f})   crit-resid {res:.1e}")
    print(flush=True)
    return out


if __name__ == "__main__":
    for n in (10, 12, 14):
        run(n)
