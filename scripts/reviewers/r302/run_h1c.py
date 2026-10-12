"""The sharpest form of the H1 refutation: at a Delta>0 critical point with TRIVIAL isotropy
k(W)=0, Sym_0(R^n) is 35 copies of the trivial k-representation, i.e. ONE isotypic component.
H1 then predicts a single value of L_e.  Measured: eight."""
import sys, os
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from core import Geom
from sweep import solve_diag, canon
from le import build_weyl, Le_matrix, HA_span, compression
from defect import Delta
from run_h1 import log

if __name__ == '__main__':
    g, found = solve_diag(8, tries=500, seed=8)
    seen = {}
    for th, lam in found:
        seen.setdefault(canon(g, lam, th), lam)
    B, sv = build_weyl(g)
    target = None
    for k, lam in sorted(seen.items(), key=lambda kv: -kv[0][0]):
        if abs(k[0] - 0.555683) < 1e-5:
            target = lam
    W = np.diag(target); th = g.P(W)
    log(f"[p2c] n=8, theta={th:.9f}, crit_res={np.linalg.norm(g.Q(W)-th*W):.2e}, "
        f"|Ric|={np.max(np.abs(g.ric(W))):.2e}, Delta={Delta(g,W):.6f}")
    rows = []
    for a in range(g.N):
        v = np.zeros(g.N); v[a] = 1.0
        DX = g.D(g.to_mat(v))
        rows.append((DX @ W - W @ DX).ravel())
    s = np.linalg.svd(np.array(rows).T, compute_uv=False)
    log(f"      isotropy map singular values, smallest five: {np.round(s[-5:], 8).tolist()}  "
        f"(||W||=1, so these are absolute) -> dim k(W) = {int((s <= 1e-8).sum())}")
    Le = Le_matrix(g, W, B, sv, th)
    C, _ = HA_span(g, W, B, sv)
    U, M, _ = compression(Le, C)
    ev = np.linalg.eigvalsh(0.5 * (M + M.T))
    u, c = np.unique(np.round(ev, 7), return_counts=True)
    e = B.T @ sv.vec(W); Pe = np.eye(B.shape[1]) - np.outer(e, e)
    log(f"      dim V = {U.shape[1]}; with k = 0 that is ONE isotypic component of multiplicity {U.shape[1]}")
    log(f"      L_e on it: " + ", ".join(f"{a:.6f}x{b}" for a, b in zip(u, c)))
    log(f"      lam_max(L_e|e-perp) = {np.linalg.eigvalsh(Pe@Le@Pe).max():.9f}")
    log("      H1 predicts ONE value.  Measured: %d." % len(u))
