import sys, os, time
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from sweep import solve_diag, canon
from core import Geom
from le import build_weyl, Le_matrix, HA_span, compression
from defect import Delta
from run_h1 import log

def analyse_point(g, W, B, sv):
    th = g.P(W)
    Le = Le_matrix(g, W, B, sv, th)
    e = B.T @ sv.vec(W)
    Pe = np.eye(B.shape[1]) - np.outer(e, e)
    full = np.linalg.eigvalsh(Pe @ Le @ Pe).max()
    C, _ = HA_span(g, W, B, sv)
    U, M, _ = compression(Le, C)
    s0 = np.linalg.eigvalsh(0.5 * (M + M.T)).max() if U.shape[1] else -np.inf
    return th, full, s0, np.trace(M) / max(U.shape[1], 1)

def run(n, tries, seed=0):
    t0 = time.time()
    g, found = solve_diag(n, tries=tries, seed=seed)
    seen = {}
    for th, lam in found:
        k = canon(g, lam, th)
        if k not in seen:
            seen[k] = lam
    log(f"[p4] n={n}: {len(found)}/{tries} converged, {len(seen)} distinct classes  ({time.time()-t0:.0f}s)")
    B, sv = build_weyl(g)
    rows = []
    for k, lam in sorted(seen.items(), key=lambda kv: -kv[0][0]):
        W = np.diag(lam)
        D = Delta(g, W)
        th, full, s0, avg = analyse_point(g, W, B, sv)
        rows.append((th, D, full, s0, avg))
    bad = [r for r in rows if r[1] > 1e-7 and r[2] <= 0.5 + 1e-9]
    bad_s0 = [r for r in rows if r[1] > 1e-7 and r[3] <= 0.5 + 1e-9]
    npos = sum(1 for r in rows if r[1] > 1e-7)
    log(f"[p4] n={n}: {npos} classes with Delta>0; V3 counterexamples (full lam_max<=1/2): {len(bad)}; "
        f"Sym_0 max<=1/2: {len(bad_s0)}")
    for r in sorted(rows, key=lambda r: -r[0])[:14]:
        log(f"     theta={r[0]:.6f} Delta={r[1]:9.4f} lam_max={r[2]:.6f} Sym0={r[3]:.6f} Sym0avg={r[4]:.6f}")
    for r in bad_s0:
        log(f"     *** Sym_0 FAILS TO CERTIFY: theta={r[0]:.6f} Delta={r[1]:.4f} lam_max={r[2]:.6f} Sym0={r[3]:.6f}")
    for r in bad:
        log(f"     *** V3 COUNTEREXAMPLE: theta={r[0]:.6f} Delta={r[1]:.4f} lam_max={r[2]:.6f}")
    return rows

if __name__ == '__main__':
    for n, tr in [(6, 400), (7, 400), (8, 500), (9, 400), (10, 300)]:
        run(n, tr, seed=n)
