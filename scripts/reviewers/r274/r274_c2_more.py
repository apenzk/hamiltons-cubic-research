"""r274: harder search for max (tr(M^3)+||M#||_F)/theta_0 over unit Weyl_n, n=12..18."""
import numpy as np, sys, time
sys.path.insert(0, __file__.rsplit('/',1)[0])
from r274_weyl import Geo
from r274_c2_opt import ascend, rand_weyl, theta0
for n in (12, 14, 16, 18):
    g = Geo(n); rng = np.random.default_rng(999+n); t=time.time()
    best=-9; bM=None
    for s in range(25):
        M,v = ascend(g, rand_weyl(g,rng), 'F', iters=4000, eta0=0.1)
        if v/theta0(n) > best: best, bM = v/theta0(n), M
    S=g.sharp(bM); ip=float(np.sum(S*bM)); nS=np.linalg.norm(S)
    print(f"n={n:>2} max F = {best:.6f}   theta={float(np.trace(bM@bM@bM))+ip:.6f}"
          f"  theta/th0={(float(np.trace(bM@bM@bM))+ip)/theta0(n):.6f}  cos={ip/nS:.6f}  ({time.time()-t:.0f}s)", flush=True)
    np.save(f"scripts/reviewers/r274/bestF2_n{n}.npy", bM)
