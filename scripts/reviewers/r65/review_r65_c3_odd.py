"""Reviewer 65 / C3 at ODD n.  The equality analysis of review_r65_c2_proof.py forces
gamma = 0 (hence "symmetric pair", hence rigidity) only when n is even and d = n^2/4.
At odd n the cap is (n^2-1)/4 and the chain leaves gamma <= (2d/n)(n^2-4d) = 2d/n > 0.
So: sample isotropic subspaces at the cap and look at gamma.  gamma > 0 for even one of
them means it is NOT a symmetric pair, which refutes C3 at odd n.
"""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from review_r65_lib import structure_tensor, sympair_subspace, mu
from review_r65_c2_search import descend

if __name__ == "__main__":
    for n in [int(x) for x in sys.argv[1:]] or [5, 7, 9]:
        C = structure_tensor(n); N = C.shape[0]; cap = n * n // 4
        rng = np.random.default_rng(777 + n)
        gam = []
        for t in range(40 if n <= 7 else 12):
            f, V = descend(C, cap, rng, iters=6000)
            if f > 1e-16:
                continue
            gam.append(2 * (n - 2) * cap - 2 * mu(V, C))   # gamma = 2(n-2)d - 2 mu
        gam = np.array(gam)
        Vs = sympair_subspace(n, n // 2)
        print(f"n={n} N={N} cap={cap}: {len(gam)} isotropic found; "
              f"gamma range [{gam.min():.3e}, {gam.max():.3e}]  "
              f"(bound (2d/n)(n^2-4d) = {2*cap/n*(n*n-4*cap):.4f}); "
              f"symmetric pair gamma = {2*(n-2)*Vs.shape[1]-2*mu(Vs,C):.2e}", flush=True)
