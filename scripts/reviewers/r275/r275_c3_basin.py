"""r275 claim 3(b): is the ascent's plateau the global maximum of F?
Basin-hopping at n=6 and n=8: from the best point found, take a large random kick
and re-ascend, accepting only improvements.  400 kicks per dimension, kick sizes
0.2 .. 1.6 (a kick of 2 is antipodal), so the whole sphere is in reach.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from r275_geo import Geo
from r275_c3_falsifier import ascent_A, ascent_B

for n in (6, 8):
    g = Geo(n); rng = np.random.default_rng(4242 + n)
    W = np.load(f"scripts/reviewers/r275/r275_bestF_n{n}.npy")
    best = g.F(W); bW = W.copy()
    hist = {}
    for k in range(400):
        sc = float(rng.uniform(0.2, 1.6))
        A = rng.standard_normal((g.N, g.N)); P = g.proj_weyl(0.5 * (A + A.T)); P /= np.linalg.norm(P)
        X = g.proj_weyl(bW + sc * P); X /= np.linalg.norm(X)
        X, v = ascent_A(g, X, iters=1200)
        X, v = ascent_B(g, X, maxiter=400)
        hist[round(v, 6)] = hist.get(round(v, 6), 0) + 1
        if v > best + 1e-12:
            best, bW = v, X
    top = sorted(hist.items(), reverse=True)[:6]
    print(f"n={n}  400 basin-hops   best={best:.9f}   distinct local values (top 6): {top}")
