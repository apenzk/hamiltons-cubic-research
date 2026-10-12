"""Reviewer 41 -- independent implementation of the Weyl / Q / L_e machinery.

Written from the definitions only.  Nothing under review is imported.

Conventions (as handed in the brief):
  so(n) orthonormal basis  phi_ij = E_ij - E_ji  (i<j),  <X,Y> = 1/2 tr(X^T Y)
  (A_a)_{mn} = c_{amn}, i.e. ad(phi_a) written in the phi basis
  Weyl_n     = { W symmetric on Lambda^2 : first Bianchi, Ricci-flat }
  W^#_{ab}   = -1/2 tr(A_a W A_b W)
  Q(W)       = W^2 + W^#
  sharp_bilin(X,Y)_{ab} = -1/4 (T_ab + T_ba),  T_ab = tr(A_a X A_b Y)
  X o Y      = 1/2 (XY + YX) + sharp_bilin(X,Y)
  e          = W/theta,  L_e X = e o X
"""
import numpy as np
import itertools


# ---------------------------------------------------------------- so(n) basis
def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def phi_basis(n):
    P = pairs(n)
    N = len(P)
    phi = np.zeros((N, n, n))
    for a, (i, j) in enumerate(P):
        phi[a, i, j] = 1.0
        phi[a, j, i] = -1.0
    return P, phi


def ip_so(X, Y):
    """<X,Y> = 1/2 tr(X^T Y) on so(n) matrices."""
    return 0.5 * np.tensordot(X, Y, axes=([-2, -1], [-2, -1]))


def structure_A(n):
    """A[a][m,n] = c_{amn} with ad(phi_a) phi_q = sum_p c_{a p q} phi_p."""
    P, phi = phi_basis(n)
    N = len(P)
    A = np.zeros((N, N, N))
    for a in range(N):
        # [phi_a, phi_q] for all q, at once
        br = phi[a] @ phi - phi @ phi[a]          # (N,n,n)
        # coefficients on phi_p:  1/2 tr(phi_p^T br_q)
        A[a] = 0.5 * np.einsum('pij,qij->pq', phi, br)
    return P, phi, A


def rho(n, M, phi=None):
    """Representation of M in so(n) on Lambda^2, in the phi basis."""
    if phi is None:
        _, phi = phi_basis(n)
    br = M @ phi - phi @ M                        # (N,n,n)
    return 0.5 * np.einsum('pij,qij->pq', phi, br)


# ---------------------------------------------------- operator <-> 4-tensor
def op_to_tensor(n, W, P=None):
    if P is None:
        P = pairs(n)
    R = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            v = W[a, b]
            R[i, j, k, l] = v
            R[j, i, k, l] = -v
            R[i, j, l, k] = -v
            R[j, i, l, k] = v
    return R


def tensor_to_op(n, R, P=None):
    if P is None:
        P = pairs(n)
    N = len(P)
    W = np.zeros((N, N), dtype=R.dtype)
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            W[a, b] = R[i, j, k, l]
    return W


# --------------------------------------------------------------- Weyl space
def weyl_basis(n):
    """Orthonormal basis (in the ambient S^2(Lambda^2) Frobenius sense) of
    { W symmetric : first Bianchi, Ricci-flat }, returned as (D, N, N)."""
    P = pairs(n)
    N = len(P)
    idx = {p: a for a, p in enumerate(P)}
    # parametrise symmetric matrices
    sym = [(a, b) for a in range(N) for b in range(a, N)]
    ns = len(sym)
    col = {s: c for c, s in enumerate(sym)}

    def entry(i, j, k, l, coeffs, w):
        """add w * R_{ijkl} into the linear form 'coeffs' over sym params."""
        if i == j or k == l:
            return
        s1 = 1.0
        if i > j:
            i, j = j, i
            s1 = -s1
        s2 = 1.0
        if k > l:
            k, l = l, k
            s2 = -s2
        a, b = idx[(i, j)], idx[(k, l)]
        if a > b:
            a, b = b, a
        coeffs[col[(a, b)]] += w * s1 * s2

    rows = []
    # first Bianchi
    for i, j, k, l in itertools.combinations(range(n), 4):
        for (p, q, r, s) in [(i, j, k, l), (i, j, l, k), (i, k, j, l),
                             (i, k, l, j), (i, l, j, k), (i, l, k, j)]:
            pass
    seen = set()
    for i in range(n):
        for j, k, l in itertools.combinations(range(n), 3):
            if len({i, j, k, l}) < 4:
                continue
            key = (i,) + tuple(sorted((j, k, l)))
            if key in seen:
                continue
            seen.add(key)
            c = np.zeros(ns)
            entry(i, j, k, l, c, 1.0)
            entry(i, k, l, j, c, 1.0)
            entry(i, l, j, k, c, 1.0)
            rows.append(c)
    # Ricci flatness
    for j in range(n):
        for l in range(j, n):
            c = np.zeros(ns)
            for i in range(n):
                entry(i, j, i, l, c, 1.0)
            rows.append(c)
    Mrows = np.array(rows)
    # nullspace
    u, s, vt = np.linalg.svd(Mrows)
    tol = max(Mrows.shape) * np.finfo(float).eps * (s[0] if len(s) else 1.0)
    rank = int((s > tol).sum())
    null = vt[rank:]                              # (D, ns)
    D = null.shape[0]
    B = np.zeros((D, N, N))
    for d in range(D):
        for (a, b), c in col.items():
            B[d, a, b] = null[d, c]
            B[d, b, a] = null[d, c]
    # orthonormalise in the Frobenius inner product tr(X^T Y)
    B2 = B.reshape(B.shape[0], -1)
    G = B2 @ B2.T
    w, V = np.linalg.eigh(G)
    T = V @ np.diag(1.0 / np.sqrt(w)) @ V.T
    B = (T @ B2).reshape(B.shape)
    return B


# ------------------------------------------------------------------ algebra
def sharp(A, W):
    """W^#_{ab} = -1/2 tr(A_a W A_b W)."""
    M = A @ W                                     # (N,N,N),  M_a = A_a W
    N = W.shape[0]
    U = M.reshape(N, N * N)
    V = np.transpose(M, (0, 2, 1)).reshape(N, N * N)
    return -0.5 * (U @ V.T)


def sharp_bilin(A, X, Y):
    """-1/4 (T_ab + T_ba), T_ab = tr(A_a X A_b Y)."""
    N = X.shape[0]
    MX = (A @ X).reshape(N, N * N)
    MY = (A @ Y).reshape(N, N * N)
    MYt = np.transpose((A @ Y), (0, 2, 1)).reshape(N, N * N)
    MXt = np.transpose((A @ X), (0, 2, 1)).reshape(N, N * N)
    T = MX @ MYt.T                                # T_ab = tr(A_a X A_b Y)
    return -0.25 * (T + T.T)


def Qop(A, W):
    return W @ W + sharp(A, W)


def circ(A, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(A, X, Y)


# --------------------------------------------------------------- projections
def proj_weyl(B, X):
    """Orthogonal projection of X onto span(B) (B orthonormal, Frobenius)."""
    c = np.einsum('dij,ij->d', B, X)
    return np.einsum('d,dij->ij', c, B), c
