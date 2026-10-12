import numpy as np, sys
sys.path.insert(0, __file__.rsplit('/', 1)[0])
from screen_I73_pair_direction import pairs, structure_constants
rng = np.random.default_rng(0)
for n in (7, 8, 9):
    c = structure_constants(n); N = len(pairs(n))
    def topsum(x, r):
        adx = np.einsum('abx,a->xb', c, x)            # ad_X in the orthonormal basis
        ev = np.sort(np.linalg.eigvalsh(-adx @ adx))[::-1]
        return ev[:r].sum()
    best = {r: 0 for r in (1, 2, 3, 4, 5, 6)}
    for trial in range(3000):
        x = rng.normal(size=N); x /= np.linalg.norm(x)
        for r in best: best[r] = max(best[r], topsum(x, r))
    # local ascent on r = 6 from the best random point
    for r in (1, 2, 4, 6):
        x = rng.normal(size=N); x /= np.linalg.norm(x); f = topsum(x, r)
        for it in range(4000):
            y = x + 0.05 * rng.normal(size=N); y /= np.linalg.norm(y); g = topsum(y, r)
            if g > f: x, f = y, g
        best[r] = max(best[r], f)
    print(f"n={n}: sampled/ascended max of top-r sums of -ad_X^2:", {r: round(v, 4) for r, v in best.items()},
          " claimed kappa_1,2,4,6 = 2,4,6,8")
