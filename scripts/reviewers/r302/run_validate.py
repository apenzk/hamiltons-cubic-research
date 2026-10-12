import sys, os, time
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from core import Geom
from points import sphere_product, c5_blowup, cpm, witness
from le import build_weyl, Le_matrix, HA_span, compression

def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open('agent_logs/r302-v3-branching.log', 'a') as f:
        f.write(line + "\n")

def analyse(name, g, W):
    t0 = time.time()
    B, sv = build_weyl(g)
    theta = g.P(W)
    Le = Le_matrix(g, W, B, sv, theta)
    asym = np.max(np.abs(Le - Le.T))
    e = B.T @ sv.vec(W)
    Pe = np.eye(B.shape[1]) - np.outer(e, e)
    ev = np.linalg.eigvalsh(Pe @ Le @ Pe)   # e is an eigenvector (Le e = e), so this is safe
    full_max = ev.max()
    C, As = HA_span(g, W, B, sv)
    U, M, s = compression(Le, C)
    Mev = np.linalg.eigvalsh(0.5 * (M + M.T))
    inv = np.linalg.norm(Le @ U - U @ (U.T @ Le @ U))
    log(f"{name:12s} n={g.n} dimW={B.shape[1]} theta={theta:.9f} |Le-Le^T|={asym:.1e} "
        f"lam_max(full,e-perp)={full_max:.9f}  dim V={U.shape[1]} lam_max(Sym0)={Mev.max():.9f} "
        f"nonInv={inv:.2e}  t={time.time()-t0:.1f}s")
    return dict(name=name, theta=theta, full=full_max, sym0=Mev.max(), spec=Mev, dimV=U.shape[1],
                B=B, sv=sv, Le=Le, C=C, U=U, M=M, g=g, W=W)

if __name__ == '__main__':
    log("[p1] validation run start")
    res = {}
    for nm, f in [("S3xS5", lambda: sphere_product(3, 5)),
                  ("CP4", lambda: cpm(4)),
                  ("witness_n8", witness),
                  ("S4xS4", lambda: sphere_product(4, 4)),
                  ("S3xS3", lambda: sphere_product(3, 3)),
                  ("CP2", lambda: cpm(2))]:
        g, W = f()
        res[nm] = analyse(nm, g, W)
    for nm in res:
        r = res[nm]
        vals = np.round(r['spec'], 9)
        u, c = np.unique(vals, return_counts=True)
        log(f"   {nm} Sym0 spectrum: " + ", ".join(f"{a:.6f}x{b}" for a, b in zip(u, c)))
