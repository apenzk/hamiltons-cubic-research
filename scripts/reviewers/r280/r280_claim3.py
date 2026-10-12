"""r280: does Theta_5 = sqrt(3/2) hold, and is F_5 the right object?

(1) F_5 = (3/2)||W||^6 - 9 tr(W^3)^2 equals (3/2)||W||^6 - P(W)^2 on Weyl_5,
    because P = 3 tr(W^3) there (Lovelock collapse).  So F_5 >= 0 on Weyl_5 is
    EXACTLY the statement Theta_5 <= sqrt(3/2).
(2) numerical falsification attempt: projected gradient ascent of P on the unit
    sphere of Weyl_5 from many random starts.  Any value above sqrt(3/2) refutes.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import Q, P, weyl_basis, normalize

rng = np.random.default_rng(1280)

def run(n, starts=200, iters=4000):
    B = weyl_basis(n); D = B.shape[0]
    G = B.reshape(D, -1)                      # orthonormal rows
    best = -np.inf; bestW = None
    for s in range(starts):
        c = rng.standard_normal(D); c /= np.linalg.norm(c)
        for t in range(iters):
            W = (c @ G).reshape(B.shape[1], B.shape[2])
            g = 3.0 * (G @ Q(n, W).ravel())   # gradient of P in coordinates
            g -= (g @ c) * c
            ng = np.linalg.norm(g)
            if ng < 1e-13: break
            c = c + 0.05 * g / ng
            c /= np.linalg.norm(c)
        W = (c @ G).reshape(B.shape[1], B.shape[2])
        v = P(n, W)
        if v > best: best, bestW = v, W
    return best, bestW

for n in (4, 5):
    b, W = run(n)
    r = np.linalg.norm(Q(n, W) - b * W)
    F5 = 1.5 - 9 * np.trace(np.linalg.matrix_power(W, 3))**2
    print(f"n={n}: best P over 200 ascents = {b:.12f}   sqrt(3/2)={np.sqrt(1.5):.12f}"
          f"   excess={b-np.sqrt(1.5):+.3e}   crit residual={r:.2e}   F_5(best)={F5:+.3e}")
