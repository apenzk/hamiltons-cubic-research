"""r283 claim 2(b,d): frame-minimal off-diagonal mass, minimised over O(n) by BFGS.

Positive control: a randomly rotated S^3 x S^3 must come back to 0.
"""
import numpy as np, itertools, sys
from scipy.linalg import expm
from scipy.optimize import minimize
sys.path.insert(0, 'scripts/reviewers/r283')
from c2_instruments import fs_weyl, op_from_tensor, normalise, pairs_of, padded_cp2, sphere_product, lam2

def offdiag(A): return float(np.linalg.norm(A - np.diag(np.diag(A))))

def min_mass(A, n, starts=12, seed=1, scale=1.0):
    rng = np.random.default_rng(seed)
    P = pairs_of(n)
    iu = np.triu_indices(n, 1)
    def obj(v):
        X = np.zeros((n, n)); X[iu] = v; X = X - X.T
        L = lam2(expm(X), n, P)
        return offdiag(L @ A @ L.T)
    best = np.inf
    for _ in range(starts):
        v0 = rng.normal(size=len(iu[0])) * scale
        r = minimize(obj, v0, method='BFGS', options={'maxiter': 3000, 'gtol': 1e-12})
        best = min(best, float(r.fun))
    return best

if __name__ == "__main__":
    for m in (4, 5):
        W, n = fs_weyl(m); A = normalise(op_from_tensor(W, n))
        print(f"CP^{m}  (n={n}): frame-minimal off-diagonal mass = {min_mass(A, n):.6f}", flush=True)
    A = padded_cp2(8)
    print(f"padded W_CP2 (n=8): {min_mass(A, 8):.6f}", flush=True)
    A, n = sphere_product(3, 3)
    P = pairs_of(6)
    rng = np.random.default_rng(7); X = rng.normal(size=(6, 6)); X = X - X.T
    L = lam2(expm(X), 6, P); Arot = L @ A @ L.T
    print(f"CONTROL rotated S^3xS^3: start {offdiag(Arot):.6f} -> {min_mass(Arot, 6):.2e}", flush=True)
