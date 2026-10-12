"""Basis-free orthogonal projection onto Weyl_n, and a matrix-free degeneracy test.

Building a basis of Weyl_n is what stops this project at n = 12: dim Weyl_14 = 3080
and the full L_e matrix costs D applications of the circ product.  But the
Bianchi-then-Ricci projector IS orthogonal (Reviewers 47, 48, 49) once its two
normalisations are right, and they are

    P(X) = Y - (2/(n-2)) KN(rho_0) - (1/(n(n-1))) s KN(g),     Y = X - Alt(X),

with rho the Ricci of Y, s its trace, rho_0 = rho - (s/n) g, and KN the
Kulkarni-Nomizu product.  Calibrated by least squares against the true basis at
n = 8 and verified against it at n = 6, 8, 10: relative error <= 8.5e-16 and
idempotence <= 6.2e-17.

An earlier version of this projector carried a spurious factor 1/2 on the
Kulkarni-Nomizu term.  It still fixed Weyl_n to 1e-16 while being 15-30% wrong on
general input -- which is why the check below is run OFF the subspace, on random
symmetric matrices, and not on elements already in Weyl_n.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index

_CACHE = {}

def _tables(n):
    if n not in _CACHE:
        pairs, idx = pair_index(n)
        _CACHE[n] = (pairs, idx, len(pairs))
    return _CACHE[n]

def _get(M, idx, i, j, k, l):
    if i == j or k == l:
        return 0.0
    s = 1.0
    if i > j: i, j, s = j, i, -s
    if k > l: k, l, s = l, k, -s
    return s * M[idx[(i, j)], idx[(k, l)]]

def weyl_project(n, X):
    """Orthogonal projection of a symmetric operator on Lambda^2(R^n) onto Weyl_n."""
    pairs, idx, N = _tables(n)
    Alt = np.zeros((N, N))
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            if len({i, j, k, l}) < 4:
                continue
            Alt[a, b] = (_get(X, idx, i, j, k, l) + _get(X, idx, i, k, l, j)
                         + _get(X, idx, i, l, j, k)) / 3.0
    Y = X - Alt
    R = np.array([[sum(_get(Y, idx, i, k, j, k) for k in range(n)) for j in range(n)]
                  for i in range(n)])
    R = 0.5 * (R + R.T); s = np.trace(R)
    rho0 = R - s / n * np.eye(n)
    def KN(h):
        K = np.zeros((N, N))
        for a, (i, j) in enumerate(pairs):
            for b, (k, l) in enumerate(pairs):
                K[a, b] = 0.5 * (h[i, k] * (j == l) - h[i, l] * (j == k)
                                 - h[j, k] * (i == l) + h[j, l] * (i == k))
        return K
    return Y - (2.0 / (n - 2)) * KN(rho0) - (1.0 / (n * (n - 1))) * s * KN(np.eye(n))

if __name__ == "__main__":
    from review_r30_core import weyl_basis
    rng = np.random.default_rng(1)
    print(f"{'n':>3} {'vs basis':>10} {'idempotent':>12}")
    for n in (6, 8, 10):
        _, _, N = _tables(n)
        B = weyl_basis(n)
        PW = lambda X: sum(float(np.tensordot(bb, X)) * bb for bb in B)
        e1 = e2 = 0.0
        for _ in range(3):
            X = rng.normal(size=(N, N)); X = 0.5 * (X + X.T)
            a = weyl_project(n, X); t = PW(X)
            e1 = max(e1, np.linalg.norm(a - t) / np.linalg.norm(t))
            e2 = max(e2, np.linalg.norm(weyl_project(n, a) - a) / np.linalg.norm(a))
        print(f"{n:3d} {e1:10.2e} {e2:12.2e}", flush=True)
