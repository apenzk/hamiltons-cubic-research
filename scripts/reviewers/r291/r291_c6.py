"""C6: maximise theta over the diagonal locus, with and without S_mmm = 0 and Delta > 0."""
import sys, numpy as np
sys.path.insert(0,'scripts/lib'); sys.path.insert(0,'scripts/reviewers/r291')
from r291_core import *

def grad_theta(M):
    return 3.0*(M*M + M@M)      # d theta / d M_ab (a<b), as a symmetric matrix

def ascent(n, B, v0, iters=4000, step=0.05):
    """projected gradient ascent of theta on the unit sphere of the locus."""
    v = v0/np.linalg.norm(v0)
    for t in range(iters):
        M = vec_to_M(n, v)
        G = grad_theta(M)
        g = np.array([G[i,j] for (i,j) in pairs_of(n)])
        g = (g @ B.T) @ B                      # project onto the locus
        g = g - (g@v)*v                        # tangent to the sphere
        ng = np.linalg.norm(g)
        if ng < 1e-13: break
        v = v + step*g/ng
        v = (v @ B.T) @ B
        v = v/np.linalg.norm(v)
        step = max(step*0.999, 1e-6)
    return v

rng = np.random.default_rng(1291)
print(f"{'n':>3s}{'theta_0':>11s}{'best theta':>12s}{'S':>7s}{'Delta':>9s}"
      f"{'best with S=0':>15s}{'Delta':>9s}{'best S=0,D>0':>14s}{'gap':>10s}")
for n in (4,5,6,7,8,9,10,12):
    B = locus_basis(n)
    th0 = np.sqrt(2*(n-1)*(n-2))/n
    best=(-9,None); bestS0=(-9,None); bestS0D=(-9,None)
    for r in range(80 if n<=10 else 40):
        v = ascent(n, B, rng.normal(size=B.shape[0])@B)
        M = vec_to_M(n, v); M = M/np.sqrt(0.5*np.sum(M*M))
        th = theta_diag(M)
        D,tot,S,_,_ = defect_diag(n, M)
        if th>best[0]: best=(th,M,S,D)
        if S<1e-9 and th>bestS0[0]: bestS0=(th,M,S,D)
        if S<1e-9 and D>1e-9 and th>bestS0D[0]: bestS0D=(th,M,S,D)
    print(f"{n:>3d}{th0:>11.6f}{best[0]:>12.6f}{best[2]:>7.1f}{best[3]:>9.3e}"
          f"{bestS0[0]:>15.6f}{bestS0[3]:>9.3e}{bestS0D[0]:>14.6f}{best[0]-th0:>+10.2e}")
