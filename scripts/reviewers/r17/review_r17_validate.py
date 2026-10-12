"""Reviewer 17: validate the second-order branching formula against an EXACT branch.

The SO(n) orbit through W_0 is a genuine curve of critical points, so the whole
Lyapunov-Schmidt expansion must close on it exactly:
    W(t) = exp(t rho) W_0 exp(-t rho),  v = W'(0), u = W''(0)/2
must satisfy   L(u) + G(v) = theta_2 W_0   with   L = Pi_W DQ(W_0) - theta_0,
and in particular Pi_ker G(v) = 0 and theta(t) = theta_0.
"""
import numpy as np
from scipy.linalg import expm
from curvature_operator import Lambda2
from review_r11_graded_law import weyl_sphere_product_mop
from run_defect_max_hunt import su_m_kahler_weyl
from rsharp_basis_free import Q_full
from review_r17_obstruction import Ctx, analyse, Qbil, rho_lambda2


def check(name, st, ctx):
    W, th, w, B, Lmat, ker = st["W"], st["th"], st["w"], st["B"], st["Lmat"], st["ker"]
    n = ctx.n
    rng = np.random.default_rng(7)
    A = rng.standard_normal((n, n)); A = A - A.T
    rho = rho_lambda2(A, ctx.pairs, ctx.pidx)
    v_m = rho @ W - W @ rho
    u_m = 0.5 * (rho @ (rho @ W - W @ rho) - (rho @ W - W @ rho) @ rho)
    v, u = ctx.coord(v_m), ctx.coord(u_m)
    print(f"\n--- {name}: exact orbit branch as a positive control ---")
    print(f"  |v|                                   = {np.linalg.norm(v):.4f}")
    print(f"  order-1 residual |L v|                = {np.linalg.norm(Lmat @ v):.3e}")
    G = ctx.coord(Qbil(v_m, v_m, ctx.c))
    r2 = Lmat @ u + G
    th2 = float(r2 @ w)
    print(f"  order-2 residual |L u + G(v) - c W_0| = {np.linalg.norm(r2 - th2 * w):.3e}   (c={th2:.3e})")
    print(f"  predicted c = theta_2                 = {0.0:.3e} (theory: theta_2 = 0)")
    print(f"  |Pi_ker G(v)|                         = {np.linalg.norm(ker.T @ (B.T @ G)):.3e}")
    print(f"  <G(v),W_0> vs theta_0|v|^2/2          = {float(G @ w):.6f} vs {th*np.linalg.norm(v)**2/2:.6f}")
    # exact finite-t check that theta is constant along the orbit
    ts = [0.05, 0.2, 0.5]
    for t in ts:
        g = expm(t * rho)
        Wt = g @ W @ g.T
        Qt = Q_full(Wt, ctx.c)
        tht = float(np.sum(Wt * Qt))
        res = np.linalg.norm(ctx.coord(Qt) - tht * ctx.coord(Wt))
        print(f"  t={t:<5} |W(t)-W_0|={np.linalg.norm(Wt-W):.4f}  theta={tht:.12f}  crit.resid={res:.2e}")


if __name__ == "__main__":
    ctx6 = Ctx(6)
    L2_6 = Lambda2(6)
    for nm, Wm in [("S^3 x S^3", weyl_sphere_product_mop(L2_6, 3, 3)),
                   ("su(3) Kahler", su_m_kahler_weyl(L2_6, 3))]:
        st = analyse(nm, ctx6, Wm)
        check(nm, st, ctx6)
