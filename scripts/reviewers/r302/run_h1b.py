"""H1, stated so no representation theory is needed to check it:
V^k = {v in V : rho(x) v = 0 for all x in k(W)} is ONE isotypic component (the trivial one).
If L_e is scalar on isotypic components, M restricted to V^k is a scalar matrix."""
import sys, os, time
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from run_h1 import isotropy, rep_on_V, log
from le import build_weyl, Le_matrix, HA_span, compression
from points import sphere_product, c5_blowup, cpm, witness

def invariants(reps, d, tol=1e-8):
    A = np.vstack(reps) if reps else np.zeros((1, d))
    s = np.linalg.svd(A, compute_uv=False)
    scale = max(max((np.linalg.norm(R) for R in reps), default=1.0), 1e-12)
    r = int((s > tol * scale).sum())
    _, _, vt = np.linalg.svd(A)
    return vt[r:].T

def go(name, f):
    g, W = f()
    B, sv = build_weyl(g)
    th = g.P(W)
    Le = Le_matrix(g, W, B, sv, th)
    ks = isotropy(g, W)
    C, _ = HA_span(g, W, B, sv)
    U, M, _ = compression(Le, C)
    M = 0.5 * (M + M.T)
    reps = rep_on_V(g, B, sv, U, ks)
    K = invariants(reps, U.shape[1])
    if K.shape[1] == 0:
        log(f"{name:12s} dim k={len(ks)} dim V={U.shape[1]} dim V^k = 0")
        return
    Mk = K.T @ M @ K
    ev = np.linalg.eigvalsh(0.5 * (Mk + Mk.T))
    resid = np.linalg.norm(M @ K - K @ Mk)          # is V^k M-invariant (it must be)
    log(f"{name:12s} dim k={len(ks)} dim V={U.shape[1]} dim V^k={K.shape[1]} "
        f"M|_(V^k) eigenvalues = {np.round(ev, 6).tolist()}  (M-invariance resid {resid:.1e})")

if __name__ == '__main__':
    log("[p2b] H1: L_e on the TRIVIAL k-isotype")
    for nm, f in [("S3xS5", lambda: sphere_product(3, 5)),
                  ("S4xS4", lambda: sphere_product(4, 4)),
                  ("CP4", lambda: cpm(4)),
                  ("witness_n8", witness),
                  ("C5blowup", c5_blowup)]:
        go(nm, f)
