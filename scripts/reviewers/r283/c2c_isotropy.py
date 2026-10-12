"""r283 claim 2(c): is padded W_CP2's isotropy the block U(2) x O(n-4) the
unitary-isotropy argument asks for, and does a reflection ever sit in it?"""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/reviewers/r283')
from c2_instruments import padded_cp2, pairs_of, fs_weyl, op_from_tensor, normalise

def ad_lambda2(X, n, P):
    """action of X in so(n) on Lambda^2 (derivative of the Lambda^2 rep)."""
    D = np.zeros((len(P), len(P)))
    idx = {p: a for a, p in enumerate(P)}
    for b, (k, l) in enumerate(P):
        for i in range(n):
            if i != k:
                p = (min(i, k), max(i, k)); s = 1.0 if i < k else -1.0
                D[idx[p], b] += s * X[i, k] * 1.0 if False else 0.0
    # explicit: (X.w)_{kl} = sum_i X_{ik} w_{il} + X_{il} w_{ki} ... build by basis image
    D = np.zeros((len(P), len(P)))
    for b, (k, l) in enumerate(P):
        M = np.zeros((n, n)); M[k, l] = 1.0; M[l, k] = -1.0
        Mp = X @ M + M @ X.T
        Mp = X @ M - M @ X
        for a, (i, j) in enumerate(P):
            D[a, b] = Mp[i, j]
    return D

def isotropy_dim(W, n):
    P = pairs_of(n)
    basis = []
    for i in range(n):
        for j in range(i + 1, n):
            X = np.zeros((n, n)); X[i, j] = 1.0; X[j, i] = -1.0
            basis.append(X)
    rows = []
    for X in basis:
        D = ad_lambda2(X, n, P)
        rows.append((D @ W - W @ D).ravel())
    Ares = np.array(rows)
    r = np.linalg.matrix_rank(Ares, tol=1e-9)
    return len(basis) - r

if __name__ == "__main__":
    for n in (6, 8, 10):
        W = padded_cp2(n)
        print(f"padded W_CP2 at n={n}: dim isotropy = {isotropy_dim(W, n)}"
              f"  (u(2)+so(n-4) = {4 + (n-4)*(n-5)//2})")
    for m in (2, 3, 4):
        Wt, n = fs_weyl(m); A = normalise(op_from_tensor(Wt, n))
        print(f"CP^{m} at n={n}: dim isotropy = {isotropy_dim(A, n)}  (u({m}) = {m*m})")
