"""Reviewer 49: a second, larger witness above sqrt(3)/2 -- n = 20."""
import sys, time
import numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r49_core as C

t = time.time()
n = 20
WA = C.normalize(C.sphere_product((8, 8)))     # theta_0(16)
WB = C.fox_cp2(4)
tA = C.Pval(16, WA); tB = C.Pval(4, WB)
pred = 1.0 / np.sqrt(1 / tA**2 + 1 / tB**2)
print(f"blocks: S^8xS^8 on 16 coords theta_A={tA:.9f} (theta_0(16)={np.sqrt(2*15*14)/16:.9f}), "
      f"W_CP2 on 4 coords theta_B={tB:.9f}", flush=True)
W = (pred / tA) * C.embed(WA, 16, n, tuple(range(16))) + \
    (pred / tB) * C.embed(WB, 4, n, (16, 17, 18, 19))
W = C.normalize(W)
res, th = C.crit_residual(n, W)
print(f"predicted {pred:.12f}   measured {th:.12f}   diff {abs(pred-th):.1e}   resid {res:.1e}",
      flush=True)
print(f"|Ricci|={np.abs(C.ricci(n,W)).max():.1e}  |Bianchi|={np.abs(C.bianchi(n,W)).max():.1e}",
      flush=True)
print(f"sqrt(3)/2 = {np.sqrt(3)/2:.12f}  EXCESS = {th-np.sqrt(3)/2:+.9f}   "
      f"theta_0(20) = {np.sqrt(2*19*18)/20:.9f}  ratio {th/(np.sqrt(2*19*18)/20):.6f}", flush=True)
print(f"[{time.time()-t:.0f}s]", flush=True)
