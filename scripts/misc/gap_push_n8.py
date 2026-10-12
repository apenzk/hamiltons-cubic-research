"""P1 step (i), part 1: push the converging gap search hard at n=8.

The ungraded ceiling has already moved once (0.853 -> 0.9008) when the optimiser
was fixed. This asks whether it moves again under more seeds and finer pinning,
which is the difference between a real gap and an artifact of search coverage.
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
from review_r11_gap_attack2 import bil, slack_of

SQ32 = np.sqrt(1.5)
n = 8
idx, pos, N, c = build_structure_constants(n)
L2 = Lambda2(n); alt = build_alt_indices(L2)
Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
Nl = int(round(np.sqrt(Eflat.shape[1])))
print(f"n={n}, dim(Weyl)={D}")

def unpack(x):
    x = x / np.linalg.norm(x); return x, (Eflat.T @ x).reshape(Nl, Nl)

targets = [0.88, 0.92, 0.96, 1.00, 1.05, 1.10, 1.15, 1.20, 1.24]
lam = 8.0
allpts = []
for th_t in targets:
    def gval(x):
        _, W = unpack(x); QW = Q_full(W, c); th = float(np.sum(W*QW))
        return float(np.sum(QW*QW)) - th*th + lam*(th-th_t)**2
    def ggrad(x):
        nx = np.linalg.norm(x); xu, W = unpack(x)
        QW = Q_full(W, c); th = float(np.sum(W*QW))
        G = 4*bil(W, QW, c) - 6*th*QW + 6*lam*(th-th_t)*QW
        g = Eflat @ G.reshape(-1); return (g - (g@xu)*xu)/nx
    hits = []
    for seed in range(120):
        rng = np.random.default_rng(7919*seed + int(1000*th_t))
        x0 = rng.normal(size=D); x0 /= np.linalg.norm(x0)
        r = minimize(gval, x0, jac=ggrad, method="L-BFGS-B",
                     options={"maxiter": 800, "ftol": 1e-16, "gtol": 1e-13})
        _, W = unpack(r.x); W = 0.5*(W+W.T); W /= np.linalg.norm(W)
        th, S, Srel, res = slack_of(L2, W, c, alt)
        if th < 0:
            W = -W; th, S, Srel, res = slack_of(L2, W, c, alt)
        ric = np.max(np.abs(ricci_from_mop(L2, W)))
        if res < 1e-7 and ric < 1e-9 and th > 1e-6:
            hits.append((th, S, Srel))
            allpts.append((th, S, Srel))
    un = [h for h in hits if abs(h[2]) >= 1e-6]
    gr = [h for h in hits if abs(h[2]) < 1e-6]
    mx = max((h[0] for h in un), default=0.0)
    print(f"  target {th_t:.2f}: {len(hits):>3} critical ({len(gr):>2} graded, {len(un):>3} ungraded)"
          f"   max ungraded theta = {mx:.6f}" + ("  <-- IN BAND" if mx > 0.9009 else ""))

un = [p for p in allpts if abs(p[2]) >= 1e-6]
gr = [p for p in allpts if abs(p[2]) < 1e-6]
print(f"\ntotal: {len(allpts)} critical points ({len(gr)} graded, {len(un)} ungraded)")
print(f"graded   max theta = {max((p[0] for p in gr), default=0):.6f}")
if un:
    best = max(un, key=lambda p: p[0])
    print(f"UNGRADED max theta = {best[0]:.6f}   (S={best[1]:.6f})")
    print(f"UNGRADED min slack = {min(p[1] for p in un):.6f}")
    vals = sorted({round(p[0], 5) for p in un}, reverse=True)[:12]
    print(f"top distinct ungraded values: {vals}")
print(f"\nprevious recorded ceiling 0.900828; sqrt(3/2) = {SQ32:.6f}")
