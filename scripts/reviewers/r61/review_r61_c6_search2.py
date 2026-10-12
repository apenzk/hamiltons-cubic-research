"""Reviewer 61 / C6, second and harder attempt.  Is there W in Weyl_m with at
most TWO negative eigenvalues and dim U = m?  Feasibility is posed as

    minimise  V(a) = sum_{i>=3} max(0,-lam_i)^2      (violation of '<=2 negative')
    subject to lam_min(X_N X_N^T + X_{N-1} X_{N-1}^T) >= tau     (full support)

with tau swept up to its ceiling 4/m; V -> 0 at tau > 0 is a witness.  Run at
m = 6 and 8, where witnesses are known, as calibration, then at m = 10, 12."""
import numpy as np, sys, time
from scipy.optimize import minimize
from review_r61_core import weyl_basis, vec_to_skew, theta, ricci_defect, bianchi_defect
from review_r61_c5 import dimU


def pieces(a, B, m):
    W = np.einsum('k,kij->ij', a, B)
    n = np.linalg.norm(W)
    if n < 1e-12:
        return None
    W /= n
    lam, V = np.linalg.eigh(W)
    X0 = vec_to_skew(V[:, 0], m); X1 = vec_to_skew(V[:, 1], m)
    S = X0 @ X0.T + X1 @ X1.T
    return W, lam, float(np.linalg.eigvalsh(S)[0])


def obj(a, B, m, tau, nu):
    p = pieces(a, B, m)
    if p is None:
        return 10.0
    W, lam, lmin = p
    V = float(np.sum(np.minimum(lam[2:], 0.0) ** 2))
    return V + nu * max(0.0, tau - lmin) ** 2


def run(m, taus, starts, seed):
    B = weyl_basis(m)
    rng = np.random.default_rng(seed)
    out = []
    for tau in taus:
        best = None
        for s in range(starts):
            a = rng.normal(size=B.shape[0]); a /= np.linalg.norm(a)
            for nu in (10.0, 1e3, 1e5, 1e7):
                r = minimize(obj, a, args=(B, m, tau, nu), method='L-BFGS-B',
                             options={'maxiter': 300, 'maxfun': 400000})
                a = r.x
            W, lam, lmin = pieces(a, B, m)
            V = float(np.sum(np.minimum(lam[2:], 0.0) ** 2))
            nneg = int((lam < -1e-8).sum())
            if best is None or (max(0.0, tau-lmin), V) < (best[0], best[1]):
                best = (max(0.0, tau-lmin), V, nneg, lmin, theta(W, m), W.copy(), lam)
        gap, V, nneg, lmin, th, W, lam = best
        du, _ = dimU(W)
        print(f"  m={m} tau={tau:.4f}: violation={V:.3e} tau-gap={gap:.2e} #neg={nneg}"
              f" lam_min(S)={lmin:.4f} dimU={du} theta={th:+.5f}")
        sys.stdout.flush()
        out.append((tau, V, nneg, lmin, du))
    return out


if __name__ == '__main__':
    for m, starts in [(6, 12), (8, 10), (10, 6), (12, 4)]:
        ceil = 4.0/m
        taus = [0.0, 0.15*ceil, 0.35*ceil, 0.6*ceil, 0.9*ceil, ceil]
        print(f"=== m={m}, ceiling of lam_min(S) is 4/m = {ceil:.4f} ===")
        sys.stdout.flush()
        run(m, taus, starts, seed=2000+m)
