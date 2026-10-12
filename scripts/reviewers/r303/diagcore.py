"""The n x n diagonal picture, built from the definitions only."""
import numpy as np
from itertools import combinations


def V_basis(n):
    """Orthonormal (Frobenius) basis of V = {hollow symmetric, M 1 = 0}."""
    rows = []
    for (a, b) in combinations(range(n), 2):
        E = np.zeros((n, n)); E[a, b] = E[b, a] = 1.0
        rows.append(E.ravel())
    A = np.array(rows)                      # hollow symmetric, dim C(n,2)
    # row-sum constraints in that coordinate system
    C = []
    for i in range(n):
        r = np.zeros(n * n)
        for j in range(n):
            if j != i:
                r[i * n + j] = 1.0
        C.append(r)
    C = np.array(C) @ A.T                   # (n, C(n,2))
    _, s, vt = np.linalg.svd(C)
    ns = vt[int(np.sum(s > 1e-9)):]
    B = np.einsum('kp,pq->kq', ns, A).reshape(-1, n, n)
    flat = B.reshape(len(B), -1)
    q, _ = np.linalg.qr(flat.T)
    return q.T.reshape(-1, n, n)


def Phi(M):
    return M * M + M @ M


def theta_of(M):
    """P(W) for W=diag(M) with tr M^2 = 2, i.e. |W|=1."""
    return 0.5 * (np.sum(M ** 3) + np.trace(M @ M @ M))


def proj_V(X, B):
    return np.einsum('k,kij->ij', np.einsum('kij,ij->k', B, X), B)


def crit_residual(M, B):
    return proj_V(Phi(M), B) - theta_of(M) * M


def crit_residual_strong(M):
    """the record's form: off-diagonal Phi = theta M (multiplier v = 0)."""
    R = Phi(M) - theta_of(M) * M
    np.fill_diagonal(R, 0.0)
    return R


def Lop(M, N):
    """L(N) = hollow( M o N + (MN+NM)/2 ) -- the n x n second-order operator."""
    X = M * N + 0.5 * (M @ N + N @ M)
    X = X.copy()
    np.fill_diagonal(X, 0.0)
    return X


def L_matrix(M, B):
    """L in the orthonormal basis B of V."""
    cols = [np.einsum('kij,ij->k', B, Lop(M, Bk)) for Bk in B]
    return np.array(cols).T


def defect(M, tol=1e-9):
    """Delta = sum over positive edges of g_ab = 2||M_a - M_b||^2 - 4 M_ab^2."""
    n = len(M)
    s = np.sum(M * M, axis=1)
    G = M @ M
    tot = 0.0
    for a in range(n):
        for b in range(a + 1, n):
            if M[a, b] > tol:
                tot += 2 * (s[a] + s[b]) - 4 * G[a, b] - 4 * M[a, b] ** 2
    return tot
