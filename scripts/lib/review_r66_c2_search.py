"""Reviewer 66 / C2 attack: independent Levenberg-Marquardt search for an
isotropic subspace of so(n) of a prescribed dimension.

Residuals: omega(v_i,v_j,v_k) for i<j<k, plus sqrt(mu)*(V^T V - I) to hold the
frame orthonormal.  Analytic Jacobian.  Multi-start.  Reports the best residual
found at floor(n^2/4)+1 (the alleged impossible dimension) and at floor(n^2/4)
(the control).
"""
import sys, time, itertools
import numpy as np
from scipy.optimize import least_squares
from review_r66_core import omega_tensor


def make_problem(W, d, mu=4.0):
    N = W.shape[0]
    tri = list(itertools.combinations(range(d), 3))
    pairs = [(s, t) for s in range(d) for t in range(s, d)]
    ntri, npair = len(tri), len(pairs)

    def resid(x):
        V = x.reshape(N, d)
        C = np.einsum('abc,ai,bj,ck->ijk', W, V, V, V, optimize=True)
        r1 = np.array([C[i, j, k] for (i, j, k) in tri])
        G = V.T @ V - np.eye(d)
        r2 = np.sqrt(mu) * np.array([G[s, t] for (s, t) in pairs])
        return np.concatenate([r1, r2])

    def jac(x):
        V = x.reshape(N, d)
        M = np.einsum('abc,bj,ck->ajk', W, V, V, optimize=True)   # N x d x d
        J = np.zeros((ntri + npair, N * d))
        for r, (i, j, k) in enumerate(tri):
            blk = J[r].reshape(N, d)
            blk[:, i] += M[:, j, k]
            blk[:, j] -= M[:, i, k]
            blk[:, k] += M[:, i, j]
        for r, (s, t) in enumerate(pairs):
            blk = J[ntri + r].reshape(N, d)
            blk[:, s] += np.sqrt(mu) * V[:, t]
            blk[:, t] += np.sqrt(mu) * V[:, s]
        return J
    return resid, jac, N


def hunt(n, d, starts=40, seed=0, verbose=True):
    W, _ = omega_tensor(n)
    resid, jac, N = make_problem(W, d)
    rng = np.random.default_rng(seed)
    best = np.inf; bestx = None
    t0 = time.time()
    for s in range(starts):
        V0, _ = np.linalg.qr(rng.normal(size=(N, d)))
        sol = least_squares(resid, V0.ravel(), jac=jac, method='trf',
                            xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=4000)
        V = sol.x.reshape(N, d)
        Q, _ = np.linalg.qr(V)
        C = np.einsum('abc,ai,bj,ck->ijk', W, Q, Q, Q, optimize=True)
        mass = float(np.sum(C * C))
        if mass < best:
            best, bestx = mass, Q
        if verbose and (s % 10 == 9 or mass < 1e-18):
            print(f"    n={n} d={d} start {s+1}/{starts}: best 3-form mass {best:.3e} "
                  f"({time.time()-t0:.0f}s)", flush=True)
        if best < 1e-20:
            break
    return best, bestx


if __name__ == '__main__':
    ns = [int(a) for a in sys.argv[1:]] or [5, 6, 7]
    for n in ns:
        cap = n * n // 4
        print(f"\n### so({n}), N={n*(n-1)//2}, floor(n^2/4)={cap}", flush=True)
        for d, tag in [(cap, "CONTROL (should reach 0)"), (cap + 1, "TARGET  (C2 says impossible)")]:
            starts = 25 if n <= 6 else (14 if n == 7 else 8)
            best, V = hunt(n, d, starts=starts, seed=1000 + n)
            verdict = "FOUND isotropic" if best < 1e-18 else "no isotropic found"
            print(f"  d={d:3d} {tag}: best mass {best:.6e}  -> {verdict}", flush=True)
