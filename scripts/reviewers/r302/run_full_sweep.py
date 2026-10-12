"""Non-diagonal sweep: every critical point of P on the FULL Weyl_n at n = 6, 7,
through the precomputed trilinear tensor.  Tests V3 directly."""
import sys, os, time
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from core import Geom
from le import build_weyl, Le_matrix, HA_span, compression, SymVec
from sweep import full_tensor, solve_full
from defect import Delta
from run_h1 import log

def run(n, tries, seed):
    t0 = time.time()
    g = Geom(n)
    B, sv = build_weyl(g)
    T = full_tensor(g, B, sv)
    log(f"[p7] n={n} dim Weyl={B.shape[1]} tensor built in {time.time()-t0:.0f}s")
    sols = solve_full(T, tries=tries, seed=seed)
    seen = {}
    for th, x in sols:
        seen.setdefault(round(th, 7), []).append(x)
    log(f"[p7] n={n}: {len(sols)}/{tries} converged, {len(seen)} distinct theta values ({time.time()-t0:.0f}s)")
    viol, bad, badS = 0, [], []
    reported = {}
    for th, xs in sorted(seen.items(), key=lambda kv: -kv[0]):
        x = xs[0]
        W = sv.mat(B @ x)
        res = np.linalg.norm(g.Q(W) - g.P(W) * W)
        D = Delta(g, W)
        Le = Le_matrix(g, W, B, sv, g.P(W))
        e = B.T @ sv.vec(W)
        Pe = np.eye(B.shape[1]) - np.outer(e, e)
        full = np.linalg.eigvalsh(Pe @ Le @ Pe).max()
        C, _ = HA_span(g, W, B, sv)
        U, M, _ = compression(Le, C)
        s0 = np.linalg.eigvalsh(0.5 * (M + M.T)).max() if U.shape[1] else -np.inf
        reported[th] = (D, full, s0, res)
        if D > 1e-7 and full <= 0.5 + 1e-9:
            bad.append((th, D, full))
        if D > 1e-7 and s0 <= 0.5 + 1e-9:
            badS.append((th, D, full, s0))
    npos = sum(1 for v in reported.values() if v[0] > 1e-7)
    log(f"[p7] n={n}: {npos} theta-classes with Delta>0 | V3 counterexamples: {len(bad)} | "
        f"Sym_0 fails to certify: {len(badS)}")
    for th, v in sorted(reported.items(), key=lambda kv: -kv[0])[:10]:
        log(f"     theta={th:.6f} res={v[3]:.1e} Delta={v[0]:8.4f} lam_max={v[1]:.6f} Sym0={v[2]:.6f}")
    for b in bad:
        log(f"     *** V3 COUNTEREXAMPLE theta={b[0]:.6f} Delta={b[1]:.4f} lam_max={b[2]:.6f}")
    for b in badS:
        log(f"     *** Sym_0 FAILS theta={b[0]:.6f} Delta={b[1]:.4f} lam_max={b[2]:.6f} Sym0={b[3]:.6f}")

if __name__ == '__main__':
    run(6, 90, 11)
