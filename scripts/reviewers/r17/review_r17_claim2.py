"""Reviewer 17: audit of p3b's predictor-corrector (Claim 2).

p3b calls a corrected point "MOVED OFF the orbit" when |W'-W_0| > 0.05.  W_0's
orbit is 9- (11-) dimensional, so a corrector free to slide along it lands far
from the POINT W_0 while sitting on the orbit.  Every corrected point is
re-measured against the ORBIT here: min over SO(6) of |g W' g^T - W_0|, plus the
sorted spectrum (an orbit invariant), plus a hard corrector that keeps iterating
past the point where MINPACK's LM gives up.
"""
import numpy as np
from scipy.linalg import expm
from scipy.optimize import least_squares, minimize

from curvature_operator import Lambda2
from review_r11_graded_law import weyl_sphere_product_mop
from run_defect_max_hunt import su_m_kahler_weyl
from rsharp_basis_free import Q_full
from review_r17_obstruction import Ctx, analyse, Qbil, rho_lambda2


def orbit_distance(ctx, W0, W1, seed=0, nstart=4):
    """min over SO(n) of |g.W1.g^T - W0|_F, g acting on Lambda^2 (local solve)."""
    n = ctx.n
    tri = [(i, j) for i in range(n) for j in range(i + 1, n)]
    RH = []
    for (i, j) in tri:
        A = np.zeros((n, n)); A[i, j] = 1.0; A[j, i] = -1.0
        RH.append(rho_lambda2(A, ctx.pairs, ctx.pidx))
    RH = np.array(RH)

    def f(p):
        g = expm(np.tensordot(p, RH, axes=1))
        return float(np.linalg.norm(g @ W1 @ g.T - W0))

    rng = np.random.default_rng(seed)
    best = f(np.zeros(len(tri)))
    for k in range(nstart):
        p0 = np.zeros(len(tri)) if k == 0 else 0.05 * rng.standard_normal(len(tri))
        r = minimize(f, p0, method="BFGS", options=dict(maxiter=3000, gtol=1e-14))
        r = minimize(f, r.x, method="Nelder-Mead",
                     options=dict(maxiter=6000, maxfev=6000, xatol=1e-14, fatol=1e-16))
        best = min(best, float(r.fun))
    return best


def p3b_corrector(ctx, y0):
    """Verbatim p3b corrector: ambient residual, scipy 'lm', max_nfev=2000."""
    Eflat, Nl, c = ctx.Eflat, ctx.N, ctx.c

    def F(x):
        xx = x / np.linalg.norm(x)
        Wl = (Eflat.T @ xx).reshape(Nl, Nl)
        Wl = 0.5 * (Wl + Wl.T)
        Ql = Q_full(Wl, c)
        return (Ql - float(np.sum(Wl * Ql)) * Wl).reshape(-1)

    r = least_squares(F, y0, method="lm", xtol=1e-15, ftol=1e-15, max_nfev=2000)
    x = r.x / np.linalg.norm(r.x)
    Wl = ctx.mat(x); Wl /= np.linalg.norm(Wl)
    return Wl


def hard_corrector(ctx, x0, gauge=None, w0=None, iters=400, verbose=False):
    """Damped Gauss-Newton with an analytic Jacobian and truncated-SVD steps.
    Runs a fixed number of iterations -- no early termination."""
    D = ctx.D
    x = x0 / np.linalg.norm(x0)
    Es = [ctx.mat(np.eye(D)[b]) for b in range(D)]

    def resid(x):
        Wl = ctx.mat(x); Wl = Wl / np.linalg.norm(Wl)
        Ql = Q_full(Wl, ctx.c)
        q = ctx.coord(Ql); wl = ctx.coord(Wl)
        r = q - float(q @ wl) * wl
        if gauge is not None:
            r = np.concatenate([r, gauge.T @ (x / np.linalg.norm(x) - w0)])
        return r, Wl, q, wl

    for it in range(iters):
        r, Wl, q, wl = resid(x)
        th = float(q @ wl)
        J = np.zeros((len(r), D))
        for b in range(D):
            h = Es[b]
            g = 2.0 * ctx.coord(Qbil(Wl, h, ctx.c))
            col = g - 3.0 * float(q @ np.eye(D)[b]) * wl - th * np.eye(D)[b]
            J[:D, b] = col
        if gauge is not None:
            J[D:, :] = gauge.T
        U, s, Vt = np.linalg.svd(J, full_matrices=False)
        keep = s > 1e-11 * s[0]
        step = -(Vt[keep].T @ ((U[:, keep].T @ r) / s[keep]))
        # simple backtracking on |r|
        n0 = np.linalg.norm(r)
        lam = 1.0
        for _ in range(40):
            xn = x + lam * step
            xn /= np.linalg.norm(xn)
            rn = resid(xn)[0]
            if np.linalg.norm(rn) < n0:
                x = xn
                break
            lam *= 0.5
        else:
            break
        if verbose and it % 50 == 0:
            print(f"      it {it:4d} |F|={np.linalg.norm(rn):.3e}")
    Wl = ctx.mat(x); Wl /= np.linalg.norm(Wl)
    return Wl


def report(ctx, W0, th0, W1, tag, do_orbit=True):
    Q1 = Q_full(W1, ctx.c)
    th1 = float(np.sum(W1 * Q1))
    if th1 < 0:
        W1, th1 = -W1, -th1
        Q1 = Q_full(W1, ctx.c)
    q = ctx.coord(Q1)
    res_proj = np.linalg.norm(q - th1 * ctx.coord(W1))
    e0 = np.sort(np.linalg.eigvalsh(W0)); e1 = np.sort(np.linalg.eigvalsh(W1))
    sd = np.max(np.abs(e0 - e1))
    dpt = np.linalg.norm(W1 - W0)
    dorb = orbit_distance(ctx, W0, W1) if do_orbit else float('nan')
    print(f"    {tag:30s} res={res_proj:.2e} dth={th1-th0:+.1e} |W'-W0|={dpt:.4f}"
          f"  d(W',orbit)={dorb:.3e}  max|dspec|={sd:.3e}")
    return dorb, sd, res_proj


def main():
    ctx = Ctx(6)
    L2 = Lambda2(6)
    for name, Wm in [("S^3 x S^3", weyl_sphere_product_mop(L2, 3, 3)),
                     ("su(3) Kahler", su_m_kahler_weyl(L2, 3))]:
        st = analyse(name, ctx, Wm)
        W0, th0, w, B, T, Ob = (st[k] for k in ("W", "th", "w", "B", "T", "Ob"))
        orb_full = B @ Ob
        print(f"\n#### {name}: p3b corrected points, re-measured against the ORBIT ####")
        for a in range(min(T.shape[1], 6)):
            v = B @ T[:, a]
            print(f"  direction {a}:")
            W1 = p3b_corrector(ctx, w + 0.2 * v)
            report(ctx, W0, th0, W1, "p3b corrector (as written)")
            W2 = hard_corrector(ctx, ctx.coord(W1))
            report(ctx, W0, th0, W2, "+ hard Gauss-Newton, 400 its")
        print(flush=True)


if __name__ == "__main__":
    main()
