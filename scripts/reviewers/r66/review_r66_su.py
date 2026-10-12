"""Reviewer 66: the su(k) branch of the induction, checked independently.

The so(n) proof consumes Phi(su(k)) = (k^2+k-2)/2 through the u(m_j) factors of
a centralizer, so that value is load-bearing.  Here su(k) is built from scratch
(skew-Hermitian traceless, <X,Y> = -tr(XY)), the Cartan 3-form is formed, and
the same Levenberg-Marquardt search is run at Phi(su(k)) and Phi(su(k))+1.
The lower bound is the symmetric pair su(k)/so(k): m = i * (real symmetric
traceless), of dimension k(k+1)/2 - 1 = (k^2+k-2)/2.
"""
import itertools, sys
import numpy as np
from scipy.optimize import least_squares


def su_basis(k):
    B = []
    for a in range(k):
        for b in range(a + 1, k):
            M = np.zeros((k, k), complex); M[a, b] = 1; M[b, a] = -1
            B.append(M / np.sqrt(2))
            M = np.zeros((k, k), complex); M[a, b] = 1j; M[b, a] = 1j
            B.append(M / np.sqrt(2))
    for a in range(1, k):
        d = np.zeros(k); d[:a] = 1; d[a] = -a
        M = 1j * np.diag(d) / np.sqrt(a * (a + 1))
        B.append(M)
    return B


def ip_su(X, Y):
    return float(np.real(-np.trace(X @ Y)))


def su_omega(k):
    B = su_basis(k)
    d = len(B)
    G = np.array([[ip_su(X, Y) for Y in B] for X in B])
    assert np.abs(G - np.eye(d)).max() < 1e-10, np.abs(G - np.eye(d)).max()
    W = np.zeros((d, d, d))
    for a in range(d):
        for b in range(d):
            C = B[a] @ B[b] - B[b] @ B[a]
            for c in range(d):
                W[a, b, c] = ip_su(C, B[c])
    return W, B


def sym_pair(k):
    """m = i * traceless real symmetric, in the su(k) basis above."""
    B = su_basis(k)
    mats = []
    for a in range(k):
        for b in range(a + 1, k):
            M = np.zeros((k, k), complex); M[a, b] = 1j; M[b, a] = 1j
            mats.append(M / np.sqrt(2))
    for a in range(1, k):
        d = np.zeros(k); d[:a] = 1; d[a] = -a
        mats.append(1j * np.diag(d) / np.sqrt(a * (a + 1)))
    V = np.array([[ip_su(M, X) for X in B] for M in mats]).T
    return V


def hunt(W, d, starts, seed, mu=4.0):
    N = W.shape[0]
    tri = list(itertools.combinations(range(d), 3))
    pairs = [(s, t) for s in range(d) for t in range(s, d)]

    def resid(x):
        V = x.reshape(N, d)
        C = np.einsum('abc,ai,bj,ck->ijk', W, V, V, V, optimize=True)
        G = V.T @ V - np.eye(d)
        return np.concatenate([[C[i, j, k] for (i, j, k) in tri],
                               np.sqrt(mu) * np.array([G[s, t] for (s, t) in pairs])])

    def jac(x):
        V = x.reshape(N, d)
        M = np.einsum('abc,bj,ck->ajk', W, V, V, optimize=True)
        J = np.zeros((len(tri) + len(pairs), N * d))
        for r, (i, j, k) in enumerate(tri):
            blk = J[r].reshape(N, d)
            blk[:, i] += M[:, j, k]; blk[:, j] -= M[:, i, k]; blk[:, k] += M[:, i, j]
        for r, (s, t) in enumerate(pairs):
            blk = J[len(tri) + r].reshape(N, d)
            blk[:, s] += np.sqrt(mu) * V[:, t]; blk[:, t] += np.sqrt(mu) * V[:, s]
        return J

    rng = np.random.default_rng(seed)
    best = np.inf
    for s in range(starts):
        V0, _ = np.linalg.qr(rng.normal(size=(N, d)))
        sol = least_squares(resid, V0.ravel(), jac=jac, method='trf',
                            xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=4000)
        Q, _ = np.linalg.qr(sol.x.reshape(N, d))
        C = np.einsum('abc,ai,bj,ck->ijk', W, Q, Q, Q, optimize=True)
        best = min(best, float(np.sum(C * C)))
        if best < 1e-20:
            break
    return best


if __name__ == '__main__':
    for k in [int(a) for a in sys.argv[1:]] or [2, 3]:
        W, B = su_omega(k)
        N = W.shape[0]
        phi = (k * k + k - 2) // 2
        V = sym_pair(k)
        C = np.einsum('abc,ai,bj,ck->ijk', W, V, V, V, optimize=True)
        print(f"su({k}): dim={N}, Phi={phi}; symmetric pair su/so dim={V.shape[1]} "
              f"mass={np.sum(C*C):.1e}", flush=True)
        for d, tag in [(phi, "control"), (phi + 1, "TARGET")]:
            if d > N:
                continue
            b = hunt(W, d, 40 if k <= 3 else 12, seed=100 + k)
            print(f"  d={d} {tag}: best mass {b:.4e} -> "
                  f"{'isotropic FOUND' if b < 1e-18 else 'none found'}", flush=True)
