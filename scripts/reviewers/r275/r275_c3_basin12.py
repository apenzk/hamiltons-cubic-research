"""r275 claim 3(b) at the dimension that matters: basin-hopping at n=12."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from r275_geo import Geo
from r275_c3_falsifier import ascent_A, ascent_B

n = 12
g = Geo(n); rng = np.random.default_rng(7712)
W = np.load(f"scripts/reviewers/r275/r275_bestF_n{n}.npy")
best = g.F(W); bW = W.copy(); hist = {}
for k in range(60):
    sc = float(rng.uniform(0.2, 1.6))
    A = rng.standard_normal((g.N, g.N)); P = g.proj_weyl(0.5 * (A + A.T)); P /= np.linalg.norm(P)
    X = g.proj_weyl(bW + sc * P); X /= np.linalg.norm(X)
    X, v = ascent_A(g, X, iters=1200)
    X, v = ascent_B(g, X, maxiter=400)
    hist[round(v, 6)] = hist.get(round(v, 6), 0) + 1
    if v > best + 1e-12:
        best, bW = v, X
print(f"n=12  60 basin-hops   best={best:.9f}   distinct local values: {sorted(hist.items(), reverse=True)}")
