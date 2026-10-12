import numpy as np, sys
sys.path.insert(0, __file__.rsplit('/', 1)[0])
from screen_I73_pair_direction import pairs, structure_constants
rng = np.random.default_rng(1)
for n in (6, 7, 8):
    c = structure_constants(n); N = len(pairs(n)); k = 7
    def total(F):   # F: N x k orthonormal columns; sum over ordered i != j of ||[x_i,x_j]||^2
        B = np.einsum('abx,ai,bj->ijx', c, F, F)
        return np.sum(B**2)
    best = 0
    for start in range(12):
        F, _ = np.linalg.qr(rng.normal(size=(N, k))); f = total(F); step = 0.3
        for it in range(3000):
            G, _ = np.linalg.qr(F + step * rng.normal(size=(N, k))); g = total(G)
            if g > f: F, f = G, g
            elif it % 300 == 299: step *= 0.7
        best = max(best, f)
    print(f"n={n}: largest ordered 7-frame bracket total found = {best:.4f}  (vertex needs 56; so(5) construction gives 36)")
