"""
P0 step (2), decisive test: is the tubular neighbourhood of SO(n).W_CP2 still
harmless at n >= 12, given that Nienhaus's PROOF of Thm 4.17 does not extend?

His proof bounds gamma = sqrt(2/3)P(W) by minimizing

    g(phi) = (c - cos^3 phi - 3 alpha cos phi sin^2 phi) / sin^3 phi,

with the numerator constant c = 1 -- i.e. the a priori bound P <= sqrt(3/2) on
ALL of Weyl^1_n.  That holds only while W_CP2 is the global maximizer, i.e.
n <= 11.  For n >= 12 the sphere product overtakes it and the correct constant is
c_n = sqrt(2/3) theta_0(n) > 1.  Minimising with general c gives

    (1-alpha) x^2 - c x + alpha = 0,   x = cos phi_0,

(reducing to Nienhaus's cos phi_0 = alpha/(1-alpha) at c=1), and at c=1 the
closing estimate g_1(1/3) = 0 EXACTLY -- so any c > 1 breaks it at alpha = 1/3.

The estimate failing does not mean the conclusion fails.  This measures the
conclusion directly: the true maximum of P over the tube
    { cos(phi) u + sin(phi) W : 0 < phi <= pi/6,  W unit, W perp (Ru + T_u orbit) }
against sqrt(3/2) and against theta_0(n).
"""
import numpy as np
from scipy.optimize import minimize

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix, orbit_dim

SQ32 = np.sqrt(1.5)
R23 = np.sqrt(2.0 / 3.0)


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def gamma_cap(alpha, c):
    """max of sqrt(2/3)P(W) consistent with the a priori cap c, via g(phi_0)."""
    disc = c * c - 4 * alpha * (1 - alpha)
    if disc < 0:
        return np.inf
    x = (c - np.sqrt(disc)) / (2 * (1 - alpha))
    x = min(max(x, -0.999999), 0.999999)
    s2 = 1 - x * x
    return (c + (3 * alpha - 1) * x ** 3 - 3 * alpha * x) / s2 ** 1.5


def run(n, n_rand=400, n_opt=12, seed=0):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    u, th, res = fox_point(n, L2, Eflat, c)
    Nl = u.shape[0]
    uv = Eflat @ u.reshape(-1)

    _, orb = orbit_dim(u, n, L2, Eflat)
    A = np.vstack([uv[None, :], orb])
    V = np.linalg.svd(A)[2][np.linalg.matrix_rank(A, tol=1e-8):].T   # D x k, orthonormal
    k = V.shape[1]

    M = F_matrix(u, c, Eflat)
    Mv = V.T @ M @ V
    alpha_max = R23 * np.linalg.eigvalsh(Mv)[-1]

    def f_of(y, phi):
        y = y / np.linalg.norm(y)
        W = (Eflat.T @ (V @ y)).reshape(Nl, Nl)
        Wc = np.cos(phi) * u + np.sin(phi) * W
        return float(np.sum(Wc * Q_full(Wc, c)))

    rng = np.random.default_rng(seed)
    phis = np.linspace(1e-3, np.pi / 6, 40)
    best_rand = -9.0
    gmax = -9.0
    for _ in range(n_rand):
        y = rng.normal(size=k)
        y /= np.linalg.norm(y)
        W = (Eflat.T @ (V @ y)).reshape(Nl, Nl)
        gmax = max(gmax, R23 * abs(float(np.sum(W * Q_full(W, c)))))
        for p in phis:
            best_rand = max(best_rand, f_of(y, p))

    # adversarial: maximise P over the whole tube (phi and direction jointly)
    best_opt, arg = -9.0, None
    for s in range(n_opt):
        rng2 = np.random.default_rng(1000 + s)
        z0 = np.concatenate([rng2.normal(size=k), [rng2.uniform(0.05, np.pi / 6)]])
        def neg(z):
            phi = min(max(z[-1], 1e-6), np.pi / 6)
            return -f_of(z[:-1], phi)
        r = minimize(neg, z0, method="Powell",
                     options={"maxiter": 4000, "xtol": 1e-9, "ftol": 1e-11})
        if -r.fun > best_opt:
            best_opt = -r.fun
            arg = min(max(r.x[-1], 1e-6), np.pi / 6)

    t0 = theta0(n)
    cn = R23 * t0
    print(f"n={n:3d}  dim Weyl={D}  transverse dim k={k}  theta(u)={th:.9f}")
    print(f"      alpha_max (predicted 1/3) = {alpha_max:.12f}   [Thm 4.14 (c)]")
    print(f"      gamma_max over transverse slice = {gmax:.9f}   (a priori cap c_n = {cn:.9f})")
    print(f"      sup P over tube, random grid      = {best_rand:.9f}")
    print(f"      sup P over tube, adversarial opt  = {best_opt:.9f}  at phi={arg:.4f} (pi/6={np.pi/6:.4f})")
    print(f"      sqrt(3/2) = {SQ32:.9f}   theta_0({n}) = {t0:.9f}")
    verdict = ("TUBE HARMLESS: sup P < sqrt(3/2) <= theta_0"
               if best_opt < SQ32 - 1e-9 else
               "sup P exceeds sqrt(3/2)" + ("  but still < theta_0" if best_opt < t0 else "  AND theta_0 -- CONJECTURE A THREATENED"))
    print(f"      ==> {verdict}")
    # where Nienhaus's own estimate stands
    g1 = lambda a, cc: 0.75 * (3 * a - 1) - a + (np.sqrt(3) / 4) * gamma_cap(a, cc)
    print(f"      Nienhaus closing estimate g1(1/3): c=1 -> {g1(1/3.,1.0):+.9f}"
          f"   c=c_n -> {g1(1/3.,cn):+.9f}   (needs < 0)\n")
    return best_opt, t0


for n in (10, 12, 14):
    run(n)
