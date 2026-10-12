"""r281 Claim 1(c): what is M(s)=max P on the unit sphere of Weyl_s, for s=4..11?
Projected gradient ascent from random starts, in the Weyl_s coordinates.
grad P = 3 Q(W); project to the sphere.
"""
import sys, os, time
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', '..'))
from review_r30_core import weyl_basis, Q, P

rng = np.random.default_rng(2810)

def ascend(n, restarts=40, iters=3000):
    B = weyl_basis(n)                      # (d,N,N) orthonormal
    d = B.shape[0]
    best = -1e9; bestW = None
    for r in range(restarts):
        c = rng.normal(size=d); c /= np.linalg.norm(c)
        step = 0.05
        W = np.einsum('k,kij->ij', c, B)
        val = P(n, W)
        for it in range(iters):
            g = 3.0 * Q(n, W)
            gc = np.einsum('kij,ij->k', B, g)      # gradient in Weyl coords
            gc -= (gc @ c) * c                     # tangent to sphere
            ng = np.linalg.norm(gc)
            if ng < 1e-13:
                break
            c2 = c + step * gc / ng
            c2 /= np.linalg.norm(c2)
            W2 = np.einsum('k,kij->ij', c2, B)
            v2 = P(n, W2)
            if v2 > val:
                c, W, val = c2, W2, v2
                step *= 1.15
            else:
                step *= 0.5
                if step < 1e-14:
                    break
        if val > best:
            best, bestW = val, W
    return best, bestW

TARGET = np.sqrt(1.5)
print(f"sqrt(3/2) = {TARGET:.15f}")
for n in range(4, 12):
    t0 = time.time()
    rs = 40 if n <= 8 else (20 if n <= 10 else 10)
    it = 3000 if n <= 8 else 1500
    best, W = ascend(n, restarts=rs, iters=it)
    th0 = np.sqrt(2*(n-1)*(n-2))/n
    res = np.linalg.norm(Q(n, W) - best*W)
    print(f"  s={n:2d}  dim Weyl={weyl_basis(n).shape[0]:5d}  max P found = {best:.12f}"
          f"   (sqrt(3/2)={TARGET:.12f}, excess {best-TARGET:+.2e})   theta_0(s)={th0:.6f}"
          f"   crit resid={res:.1e}   [{time.time()-t0:.0f}s]")
