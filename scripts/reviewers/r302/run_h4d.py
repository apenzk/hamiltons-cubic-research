"""H4 as a correlation: does Delta>0 => small k => fine decomposition => a piece clears 1/2?
Measured across the diagonal critical classes at n=8, which is where the witness lives."""
import sys, os, time
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from core import Geom
from sweep import solve_diag, canon
from le import build_weyl, Le_matrix, HA_span, compression
from defect import Delta
from run_h1 import isotropy, rep_on_V, log

if __name__ == '__main__':
    n = 8
    g, found = solve_diag(n, tries=500, seed=8)
    seen = {}
    for th, lam in found:
        seen.setdefault(canon(g, lam, th), lam)
    B, sv = build_weyl(g)
    log(f"[p8] H4 correlation at n={n}: {len(seen)} classes")
    log(f"     {'theta':>9} {'Delta':>9} {'dim k':>6} {'dim V':>6} {'#L_e vals':>10} {'Sym0 max':>10} {'lam_max':>10}")
    rows = []
    for k, lam in sorted(seen.items(), key=lambda kv: -kv[0][0]):
        W = np.diag(lam); th = g.P(W)
        D = Delta(g, W)
        Le = Le_matrix(g, W, B, sv, th)
        ks = isotropy(g, W)
        e = B.T @ sv.vec(W); Pe = np.eye(B.shape[1]) - np.outer(e, e)
        full = np.linalg.eigvalsh(Pe @ Le @ Pe).max()
        C, _ = HA_span(g, W, B, sv)
        U, M, _ = compression(Le, C)
        nv = len(np.unique(np.round(np.linalg.eigvalsh(0.5 * (M + M.T)), 7))) if U.shape[1] else 0
        s0 = np.linalg.eigvalsh(0.5 * (M + M.T)).max() if U.shape[1] else float('nan')
        rows.append((th, D, len(ks), U.shape[1], nv, s0, full))
    for r in rows:
        log(f"     {r[0]:9.6f} {r[1]:9.4f} {r[2]:6d} {r[3]:6d} {r[4]:10d} {r[5]:10.6f} {r[6]:10.6f}")
    pos = [r for r in rows if r[1] > 1e-7]
    if pos:
        ks_ = [r[2] for r in pos]; lm = [r[6] for r in pos]
        log(f"     Delta>0 classes: dim k ranges {min(ks_)}..{max(ks_)}, lam_max {min(lm):.4f}..{max(lm):.4f}")
        cc = np.corrcoef(ks_, lm)[0, 1] if len(pos) > 2 else float('nan')
        log(f"     correlation(dim k, lam_max) over Delta>0 classes = {cc:+.4f}")
