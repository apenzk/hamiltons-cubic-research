"""Reviewer 34: independent implementation of Weyl_n, Q, and L_e from the definitions.

Nothing is imported from scripts/b_*.py or scripts/review_r3*.py.

Conventions (verbatim from the brief):
  phi_ij = E_ij - E_ji  (i<j), an orthonormal basis of so(n) for <X,Y> = 1/2 tr(X^T Y).
  c_abc  = <[phi_a, phi_b], phi_c>;   (A_a)_{mn} = c_{amn}.
  W acts on Lambda^2(R^n) = so(n); Weyl_n = symmetric W, first Bianchi, Ricci-flat.
  (W^#)_{ab} = -1/2 tr(A_a W A_b W),  Q(W) = W^2 + W^#.
  X o Y = 1/2(XY+YX) + sharp_bilin(X,Y),  sharp_bilin_{ab} = -1/4 (T_ab + T_ba),
  T_ab = tr(A_a X A_b Y).
"""
import numpy as np
from itertools import combinations
from functools import lru_cache


# ---------------------------------------------------------------- so(n) basis
@lru_cache(maxsize=None)
def pairs_of(n):
    return tuple(combinations(range(n), 2))


@lru_cache(maxsize=None)
def struct(n):
    """Return (pairs, index, C) with C[a,b,c] = <[phi_a,phi_b],phi_c>, and A[a] = C[a]."""
    prs = pairs_of(n)
    idx = {p: i for i, p in enumerate(prs)}
    N = len(prs)
    # explicit matrices
    phi = np.zeros((N, n, n))
    for a, (i, j) in enumerate(prs):
        phi[a, i, j] = 1.0
        phi[a, j, i] = -1.0
    C = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            br = phi[a] @ phi[b] - phi[b] @ phi[a]
            if not br.any():
                continue
            # expand in phi basis: coefficient = <br, phi_c> = 1/2 tr(br^T phi_c) = br[i,j]
            for c, (i, j) in enumerate(prs):
                v = br[i, j]
                if v:
                    C[a, b, c] = v
    return prs, idx, C


def ip(X, Y):
    """Inner product on operators (Frobenius on the N x N matrix)."""
    return float(np.sum(X * Y))


# ------------------------------------------------------- curvature-tensor maps
def tensor_of(M, n):
    """R_{ijkl} from the matrix M in the phi basis (antisymmetric extension)."""
    prs, idx, _ = struct(n)
    T = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(prs):
        for b, (k, l) in enumerate(prs):
            v = M[a, b]
            for (si, p, q) in ((1, i, j), (-1, j, i)):
                for (sk, r, s) in ((1, k, l), (-1, l, k)):
                    T[p, q, r, s] = si * sk * v
    return T


def bianchi_and_ricci_constraints(n):
    """Rows of the linear system on symmetric N x N matrices."""
    prs, idx, _ = struct(n)
    N = len(prs)
    # orthonormal basis of Sym(N): E_aa and (E_ab+E_ba)/sqrt2
    sym = []
    for a in range(N):
        M = np.zeros((N, N)); M[a, a] = 1.0
        sym.append(M)
    for a in range(N):
        for b in range(a + 1, N):
            M = np.zeros((N, N)); M[a, b] = M[b, a] = 1 / np.sqrt(2)
            sym.append(M)
    rows = []
    quads = list(combinations(range(n), 4))
    for M in sym:
        T = tensor_of(M, n)
        r = []
        for (i, j, k, l) in quads:
            r.append(T[i, j, k, l] + T[i, k, l, j] + T[i, l, j, k])
        Ric = np.einsum('ijkj->ik', T)
        for i in range(n):
            for k in range(i, n):
                r.append(Ric[i, k])
        rows.append(r)
    return np.array(rows).T, sym          # A (constraints x dim Sym), sym basis


@lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal (Frobenius) basis of Weyl_n, as an array (D, N, N)."""
    A, sym = bianchi_and_ricci_constraints(n)
    # nullspace of A
    u, s, vt = np.linalg.svd(A)
    rank = int((s > 1e-9 * max(1.0, s[0])).sum())
    ns = vt[rank:]                                # (D, dim Sym)
    N = sym[0].shape[0]
    symarr = np.array(sym)                        # (dimSym, N, N), orthonormal
    B = np.einsum('dk,kij->dij', ns, symarr)
    return B


def weyl_dim_formula(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


# ------------------------------------------------------------- the # operation
def sharp_bilin(X, Y, n):
    """sharp_bilin(X,Y)_{ab} = -1/4 ( tr(A_a X A_b Y) + tr(A_b X A_a Y) )."""
    _, _, C = struct(n)
    N = C.shape[0]
    # U[a] = A_a X ; V[b] = A_b Y
    U = (C.reshape(N * N, N) @ X).reshape(N, N, N)
    V = (C.reshape(N * N, N) @ Y).reshape(N, N, N)
    # T[a,b] = tr(U_a V_b) = sum_{m,p} U[a,m,p] V[b,p,m]
    T = U.reshape(N, N * N) @ np.transpose(V, (0, 2, 1)).reshape(N, N * N).T
    return -0.25 * (T + T.T)


def sharp(X, n):
    return sharp_bilin(X, X, n)


def Q(X, n):
    return X @ X + sharp(X, n)


def circ(X, Y, n):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(X, Y, n)


# ------------------------------------------------- the sphere-product operator
def W_pq(p, q):
    """Weyl operator of S^p x S^q as a diagonal matrix in the phi basis (unnormalised)."""
    n = p + q
    prs, idx, _ = struct(n)
    N = len(prs)
    d = np.zeros(N)
    for a, (i, j) in enumerate(prs):
        if j < p:
            d[a] = 1.0 / (p * (p - 1))
        elif i >= p:
            d[a] = 1.0 / (q * (q - 1))
        else:
            d[a] = -1.0 / (p * q)
    return np.diag(d)


def idempotent(p, q):
    """e = W/theta with Q(e) = e, plus theta for the UNIT-NORM operator."""
    n = p + q
    W = W_pq(p, q)
    QW = Q(W, n)
    lam = ip(QW, W) / ip(W, W)
    assert np.linalg.norm(QW - lam * W) < 1e-9 * np.linalg.norm(W), "not critical"
    e = W / lam
    Wu = W / np.sqrt(ip(W, W))
    theta = ip(Q(Wu, n), Wu)
    return e, theta, Wu


# ------------------------------------------------------------------ L_e matrix
def Le_matrix(e, n, B=None):
    """Matrix of X -> e o X on the orthonormal Weyl basis B."""
    if B is None:
        B = weyl_basis(n)
    D = B.shape[0]
    N = B.shape[1]
    Bf = B.reshape(D, N * N)
    _, _, C = struct(n)
    Ue = (C.reshape(N * N, N) @ e).reshape(N, N, N)        # A_a e
    Uef = Ue.reshape(N, N * N)
    M = np.empty((D, D))
    for c in range(D):
        X = B[c]
        V = (C.reshape(N * N, N) @ X).reshape(N, N, N)     # A_b X
        T = Uef @ np.transpose(V, (0, 2, 1)).reshape(N, N * N).T
        out = 0.5 * (e @ X + X @ e) - 0.25 * (T + T.T)
        M[:, c] = Bf @ out.ravel()
    return M
