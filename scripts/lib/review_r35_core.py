"""Reviewer 35: independent rebuild of Weyl_n, Q, the circle product and L_e.

Built only from the definitions in findings/INDEX.md / the review brief.  Nothing is
imported from b_*.py or review_r3*.py.

Conventions (from the brief):
  so(n) orthonormal basis  phi_ij = E_ij - E_ji  (i<j),  <X,Y> = 1/2 tr(X^T Y)
  A_a = ad(phi_a) on so(n) ~= Lambda^2(R^n) ~= R^N,  N = n(n-1)/2
  (W^#)_ab = -1/2 tr(A_a W A_b W),   Q(W) = W^2 + W^#
  X o Y = 1/2(XY+YX) + sharp_bilin(X,Y),  sharp_bilin_ab = -1/4 (T_ab + T_ba),
  T_ab = tr(A_a X A_b Y)
  critical W: Q(W) = theta W,  e = W/theta,  L_e X = e o X.
"""
import numpy as np
from functools import lru_cache

# ---------------------------------------------------------------- basis of so(n)
@lru_cache(maxsize=None)
def pairs_of(n):
    P = [(i, j) for i in range(n) for j in range(i + 1, n)]
    idx = {p: a for a, p in enumerate(P)}
    return tuple(P), idx

def phi(n, i, j):
    M = np.zeros((n, n)); M[i, j] = 1.0; M[j, i] = -1.0
    return M

@lru_cache(maxsize=None)
def adjoints(n):
    """A[a] = matrix of ad(phi_a) on R^N in the orthonormal basis phi."""
    P, idx = pairs_of(n)
    N = len(P)
    B = [phi(n, i, j) for (i, j) in P]
    A = np.zeros((N, N, N))
    for a in range(N):
        for m in range(N):
            C = B[a] @ B[m] - B[m] @ B[a]
            # expand C in the orthonormal basis:  coeff = <C, phi_kl> = C_kl
            for b, (k, l) in enumerate(P):
                if C[k, l] != 0.0:
                    A[a, b, m] = C[k, l]
    return A            # A[a] @ v  ==  ad(phi_a) v

# ---------------------------------------------------------------- inner product
def ip(X, Y):
    return 0.5 * np.tensordot(X, Y, axes=([0, 1], [0, 1]))

# ---------------------------------------------------------------- sharp / Q / circ
def sharp_bilin(n, X, Y):
    A = adjoints(n); N = A.shape[0]
    AX = A @ X                     # AX[a] = A_a X
    AY = A @ Y                     # AY[b] = A_b Y
    # T_ab = tr(A_a X A_b Y) = sum_{c,d} (A_a X)_{cd} (A_b Y)_{dc}
    T = AX.reshape(N, -1) @ np.transpose(AY, (0, 2, 1)).reshape(N, -1).T
    return -0.25 * (T + T.T)

def sharp(n, X):
    return sharp_bilin(n, X, X)

def Q(n, X):
    return X @ X + sharp(n, X)

def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(n, X, Y)

# ---------------------------------------------------------------- Weyl_n
@lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal (w.r.t. <,> = 1/2 tr) basis of Weyl_n as a tuple of N x N matrices."""
    P, idx = pairs_of(n)
    N = len(P)
    # Frobenius-orthonormal coordinates on S^2(R^N):
    #   X = sum_a x_aa E_aa + sum_{a<b} x_ab (E_ab+E_ba)/sqrt2
    cidx = {}
    c = 0
    for a in range(N):
        cidx[(a, a)] = c; c += 1
    for a in range(N):
        for b in range(a + 1, N):
            cidx[(a, b)] = c; c += 1
    V = c
    rt2 = np.sqrt(2.0)

    def add(row, p, q, s):
        """row += s * X[p][q]  expressed in the coordinates."""
        if p == q:
            row[cidx[(p, p)]] += s
        else:
            row[cidx[(min(p, q), max(p, q))]] += s / rt2

    def ent(i, j):
        """index and sign of the basis bivector e_i ^ e_j"""
        return (idx[(i, j)], 1.0) if i < j else (idx[(j, i)], -1.0)

    rows = []
    # first Bianchi: W(e_i^e_j, e_k^e_l) + W(e_i^e_k, e_l^e_j) + W(e_i^e_l, e_j^e_k) = 0
    for i in range(n):
        for j in range(i + 1, n):
            for k in range(j + 1, n):
                for l in range(k + 1, n):
                    row = np.zeros(V)
                    for (a1, b1), (a2, b2) in (((i, j), (k, l)), ((i, k), (l, j)), ((i, l), (j, k))):
                        p, sp = ent(a1, b1); q, sq = ent(a2, b2)
                        add(row, p, q, sp * sq)
                    rows.append(row)
    # Ricci-flat: sum_k W(e_i^e_k, e_j^e_k) = 0
    for i in range(n):
        for j in range(i, n):
            row = np.zeros(V)
            for k in range(n):
                if k == i or k == j:
                    continue
                p, sp = ent(i, k); q, sq = ent(j, k)
                add(row, p, q, sp * sq)
            rows.append(row)

    M = np.array(rows)
    U, S, Vt = np.linalg.svd(M, full_matrices=True)
    tol = max(M.shape) * np.finfo(float).eps * (S[0] if S.size else 1.0) * 10
    rank = int((S > tol).sum())
    Ns = Vt[rank:]
    out = []
    for row in Ns:
        X = np.zeros((N, N))
        for a in range(N):
            X[a, a] = row[cidx[(a, a)]]
        for a in range(N):
            for b in range(a + 1, N):
                v = row[cidx[(a, b)]] / rt2
                X[a, b] = v; X[b, a] = v
        out.append(X * rt2)          # Frobenius-unit  =>  <X,X> = 1/2 ; rescale
    return tuple(out)

def weyl_dim_formula(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12

# ---------------------------------------------------------------- sphere products
def W_sphere_product(p, q):
    """Weyl operator of S^p x S^q, unnormalised, as a diagonal N x N matrix."""
    n = p + q
    P, idx = pairs_of(n)
    d = np.zeros(len(P))
    for a, (i, j) in enumerate(P):
        if j < p:      d[a] = 1.0 / (p * (p - 1))
        elif i >= p:   d[a] = 1.0 / (q * (q - 1))
        else:          d[a] = -1.0 / (p * q)
    return np.diag(d)

def unit_and_theta(n, W):
    Wn = W / np.sqrt(ip(W, W))
    QW = Q(n, Wn)
    th = ip(Wn, QW)
    res = np.linalg.norm(QW - th * Wn) / np.linalg.norm(Wn)
    return Wn, th, res

# ---------------------------------------------------------------- L_e on Weyl_n
def Le_matrix(n, e, B=None):
    if B is None:
        B = weyl_basis(n)
    D = len(B)
    Bf = np.array([b.ravel() for b in B])          # D x N^2 ; <X,Y> = 1/2 X.Y
    A = adjoints(n); N = A.shape[0]
    Ae = np.transpose(A @ e, (0, 2, 1)).reshape(N, -1)     # (A_b e)^T flattened
    M = np.empty((D, D))
    for c, X in enumerate(B):
        AX = (A @ X).reshape(N, -1)
        T = AX @ Ae.T
        Z = 0.5 * (e @ X + X @ e) - 0.25 * (T + T.T)
        M[:, c] = 0.5 * (Bf @ Z.ravel())
    return M

# ---------------------------------------------------------------- so(p)+so(q) action
def gen_matrices(n, B, plane_list):
    """G_a X = [A_a, X] restricted to Weyl_n, for a = index of each plane."""
    A = adjoints(n)
    D = len(B); Bf = np.array([b.ravel() for b in B])
    P, idx = pairs_of(n)
    out = []
    for (i, j) in plane_list:
        a = idx[(i, j)]
        G = np.empty((D, D))
        for c, X in enumerate(B):
            Z = A[a] @ X - X @ A[a]
            G[:, c] = 0.5 * (Bf @ Z.ravel())
        out.append(G)
    return out
