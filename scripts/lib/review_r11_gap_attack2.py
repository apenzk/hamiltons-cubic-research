"""
Stronger adversarial test of the ungraded gap.

The first version (review_r11_gap_attack.py) was too weak to conclude from: it
used Powell over an 84-dimensional space with 60 iterations after a full run was
killed for memory, and -- worse -- it could not distinguish "found only graded
critical points" from "converged to nothing", since both printed the same line.

This version fixes both.  It minimises, on the unit sphere of the Weyl subspace,

    g(W) = ||Q(W)||^2 - theta^2  +  lam (theta - theta_target)^2 ,   theta = <W,Q(W)>,

whose first part is exactly ||Q(W) - theta W||^2 for unit W, using the ANALYTIC
gradient

    grad ||Q||^2 = 4 B(W, Q(W)),      grad theta = 3 Q(W),
    grad g       = 4 B(W, Q(W)) - 6 theta Q(W) + 6 lam (theta - theta_target) Q(W),

with B the polarisation of Q.  Three Q-evaluations per gradient, so L-BFGS
converges properly instead of stalling.

Every converged point is then classified and COUNTED separately: graded (slack
zero) versus ungraded, with the maximum theta reported for each.  A run that
finds only graded points now says so, which is the distinction the first version
could not make.
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


def bil(X, Y, c):
    return 0.5 * (Q_full(X + Y, c) - Q_full(X, c) - Q_full(Y, c))


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
    res = np.sqrt(max(float(np.sum(QW * QW)) - th * th, 0.0)) / max(np.linalg.norm(QW), 1e-300)
    return th, S, S / max(scale, 1e-300), res


def hunt(n, targets, n_seeds=40, lam=8.0):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt_idx = build_alt_indices(L2)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    Nl = int(round(np.sqrt(Eflat.shape[1])))

    def unpack(x):
        x = x / np.linalg.norm(x)
        return x, (Eflat.T @ x).reshape(Nl, Nl)

    found = []
    for th_t in targets:
        def gval(x):
            x, W = unpack(x)
            QW = Q_full(W, c)
            th = float(np.sum(W * QW))
            return float(np.sum(QW * QW)) - th * th + lam * (th - th_t) ** 2

        def ggrad(x):
            nx = np.linalg.norm(x)
            xu, W = unpack(x)
            QW = Q_full(W, c)
            th = float(np.sum(W * QW))
            G = 4 * bil(W, QW, c) - 6 * th * QW + 6 * lam * (th - th_t) * QW
            g = Eflat @ G.reshape(-1)
            g = (g - (g @ xu) * xu) / nx          # sphere tangent, chain rule for x/|x|
            return g

        for seed in range(n_seeds):
            rng = np.random.default_rng(97 * seed + int(1000 * th_t))
            x0 = rng.normal(size=D)
            x0 /= np.linalg.norm(x0)
            r = minimize(gval, x0, jac=ggrad, method="L-BFGS-B",
                         options={"maxiter": 600, "ftol": 1e-16, "gtol": 1e-12})
            _, W = unpack(r.x)
            W = 0.5 * (W + W.T)
            W /= np.linalg.norm(W)
            th, S, Srel, res = slack_of(L2, W, c, alt_idx)
            if th < 0:
                W = -W
                th, S, Srel, res = slack_of(L2, W, c, alt_idx)
            ric = np.max(np.abs(ricci_from_mop(L2, W)))
            if res < 1e-7 and ric < 1e-9 and th > 1e-6:
                found.append((th_t, th, S, Srel))
    return found


for n in (6, 8):
    targets = [0.90, 1.00, 1.10, 1.20]
    f = hunt(n, targets)
    gr = [x for x in f if abs(x[3]) < 1e-6]
    un = [x for x in f if abs(x[3]) >= 1e-6]
    print(f"n={n}: {len(f)} converged critical points "
          f"({len(gr)} graded, {len(un)} ungraded)")
    if gr:
        print(f"        graded  : max theta = {max(x[1] for x in gr):.6f}")
    if un:
        mx = max(un, key=lambda x: x[1])
        print(f"        UNGRADED: max theta = {mx[1]:.6f}  (S={mx[2]:.6f})"
              f"   {'*** IN BAND ***' if mx[1] > 0.86 else ''}")
        for t in sorted({round(x[1], 6) for x in un}, reverse=True)[:6]:
            print(f"                  theta={t:.6f}")
    else:
        print("        UNGRADED: none converged at any pinned target")
print(f"\nband is (0.853, {SQ32:.6f}); an ungraded point inside it refutes the gap")
