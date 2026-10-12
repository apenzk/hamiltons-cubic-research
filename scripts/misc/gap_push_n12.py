"""P1 step (i), part 2: the converging gap search at n=12 -- never run before.

n=12 is the dimension the conjecture is about, and the ungraded population has
only ever been sampled at n=6 (where Fox's basin swallows everything) and n=8.
Uses run_unconstrained_search_n12's BLAS-fast Q (validated bit-for-bit against
the trusted slow path there) so the 1638-dimensional space is tractable.
"""
import numpy as np
from scipy.optimize import minimize
from weyl import build_structure_constants
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from run_unconstrained_search import build_weyl_basis
from run_unconstrained_search_n12 import build_Cflat, Q_fast

SQ32 = np.sqrt(1.5)
n = 12
idx, pos, N, c = build_structure_constants(n)
L2 = Lambda2(n); alt = build_alt_indices(L2)
Cflat_mp = build_Cflat(c)
Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=True)
print(f"n={n}, dim(Weyl)={D}, Eflat {Eflat.nbytes/1e6:.0f} MB", flush=True)

def Qf(W):
    return Q_fast(W, Cflat_mp, N)

def bilf(X, Y):
    return 0.5 * (Qf(X + Y) - Qf(X) - Qf(Y))

def analyse(W):
    QW = Qf(W); th = float(np.sum(W * QW))
    ev, V = np.linalg.eigh(W); neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    d2 = delta2_and_grad(W, alt)[0]
    r = ricci_from_mop(L2, Wm)
    scale = float(np.sum(r * r)) + 6 * d2
    S = scale - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))
    res = np.sqrt(max(float(np.sum(QW * QW)) - th * th, 0.0)) / max(np.linalg.norm(QW), 1e-300)
    return th, S, S / max(scale, 1e-300), res

def unpack(x):
    x = x / np.linalg.norm(x); return x, (x @ Eflat).reshape(N, N)

lam = 8.0
allpts = []
for th_t in [0.90, 1.00, 1.10, 1.18, 1.236]:
    def gval(x):
        _, W = unpack(x); QW = Qf(W); th = float(np.sum(W * QW))
        return float(np.sum(QW * QW)) - th * th + lam * (th - th_t) ** 2
    def ggrad(x):
        nx = np.linalg.norm(x); xu, W = unpack(x)
        QW = Qf(W); th = float(np.sum(W * QW))
        G = 4 * bilf(W, QW) - 6 * th * QW + 6 * lam * (th - th_t) * QW
        g = Eflat @ G.reshape(-1); return (g - (g @ xu) * xu) / nx
    hits = []
    for seed in range(14):
        rng = np.random.default_rng(31337 * seed + int(1000 * th_t))
        x0 = rng.normal(size=D); x0 /= np.linalg.norm(x0)
        r = minimize(gval, x0, jac=ggrad, method="L-BFGS-B",
                     options={"maxiter": 500, "ftol": 1e-16, "gtol": 1e-13})
        _, W = unpack(r.x); W = 0.5 * (W + W.T); W /= np.linalg.norm(W)
        th, S, Srel, res = analyse(W)
        if th < 0:
            W = -W; th, S, Srel, res = analyse(W)
        ric = np.max(np.abs(ricci_from_mop(L2, W)))
        if res < 1e-6 and ric < 1e-9 and th > 1e-6:
            hits.append((th, S, Srel)); allpts.append((th, S, Srel))
    un = [h for h in hits if abs(h[2]) >= 1e-6]; gr = [h for h in hits if abs(h[2]) < 1e-6]
    print(f"  target {th_t:.3f}: {len(hits):>2} critical ({len(gr):>2} graded, {len(un):>2} ungraded)"
          f"  max ungraded theta = {max((h[0] for h in un), default=0.0):.6f}", flush=True)

un = [p for p in allpts if abs(p[2]) >= 1e-6]; gr = [p for p in allpts if abs(p[2]) < 1e-6]
print(f"\nn=12 total: {len(allpts)} critical ({len(gr)} graded, {len(un)} ungraded)")
print(f"graded   max theta = {max((p[0] for p in gr), default=0):.6f}   (theta_0(12)=1.236033)")
if un:
    b = max(un, key=lambda p: p[0])
    print(f"UNGRADED max theta = {b[0]:.6f}  (S={b[1]:.6f})   sqrt(3/2)={SQ32:.6f}")
    print(f"UNGRADED min slack = {min(p[1] for p in un):.6f}")
else:
    print("UNGRADED: none converged at any target")
