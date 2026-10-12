"""Reviewer 42: independent machinery for Weyl_n, Q, L_e, U(m) projectors.

Nothing is imported from b_*.py or review_r*.py.  Conventions taken from the
brief:  phi_ij = E_ij - E_ji (i<j) orthonormal for <X,Y> = 1/2 tr(X^T Y) on
Lambda^2;  (A_a)_{mn} = c_{amn};  sb(X,Y)_{ab} = -1/4 (T_ab + T_ba) with
T_ab = tr(A_a X A_b Y);  X o Y = 1/2(XY+YX) + sb(X,Y);  Q(X) = X o X.
"""
import numpy as np
from functools import lru_cache

# ---------------------------------------------------------------- basis -----
def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]

def pair_index(n):
    return {p: k for k, p in enumerate(pairs(n))}

def phi(n, i, j):
    M = np.zeros((n, n))
    M[i, j] = 1.0
    M[j, i] = -1.0
    return M

_cache = {}

def struct(n):
    """c[a,b,c] with [phi_a,phi_b] = sum_c c[a,b,c] phi_c."""
    key = ('c', n)
    if key in _cache:
        return _cache[key]
    P = pairs(n); N = len(P)
    ph = np.array([phi(n, *p) for p in P])
    c = np.zeros((N, N, N))
    for a in range(N):
        Ma = ph[a]
        for b in range(N):
            C = Ma @ ph[b] - ph[b] @ Ma
            for k, (i, j) in enumerate(P):
                c[a, b, k] = C[i, j]
    _cache[key] = c
    return c

def Amats(n):
    """A_a with (A_a)_{mn} = c_{a m n}."""
    key = ('A', n)
    if key in _cache:
        return _cache[key]
    A = struct(n).copy()          # index [a, m, n] already
    _cache[key] = A
    return A

# ------------------------------------------------------------ the algebra ---
def sb(n, X, Y):
    """sharp_bilin(X,Y)_{ab} = -1/4 (tr(A_a X A_b Y) + tr(A_b X A_a Y))."""
    A = Amats(n); N = A.shape[0]
    AX = A.reshape(N * N, N) @ X          # (a,m,:) rows -> A_a X
    AX = AX.reshape(N, N, N)
    AY = A.reshape(N * N, N) @ Y
    AY = AY.reshape(N, N, N)
    # T_ab = tr( (A_a X) (A_b Y) ) = sum_{m,p} (A_aX)_{mp} (A_bY)_{pm}
    T = AX.reshape(N, N * N) @ np.transpose(AY, (0, 2, 1)).reshape(N, N * N).T
    return -0.25 * (T + T.T)

def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sb(n, X, Y)

def Qop(n, X):
    return circ(n, X, X)

# ------------------------------------------------------- tensor dictionary --
def lift(n, X):
    """pair matrix -> 4-tensor R[i,j,k,l], antisymmetric in ij and in kl."""
    idx = pair_index(n)
    R = np.zeros((n, n, n, n), dtype=X.dtype)
    for (i, j), a in idx.items():
        for (k, l), b in idx.items():
            v = X[a, b]
            R[i, j, k, l] = v; R[j, i, k, l] = -v
            R[i, j, l, k] = -v; R[j, i, l, k] = v
    return R

def drop(n, R):
    idx = pair_index(n); N = len(idx)
    X = np.zeros((N, N), dtype=R.dtype)
    for (i, j), a in idx.items():
        for (k, l), b in idx.items():
            X[a, b] = R[i, j, k, l]
    return X

def alt(n, X):
    """orthogonal projection of a symmetric pair matrix onto Lambda^4."""
    R = lift(n, X)
    T = (R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))) / 3.0
    return drop(n, T)

def ricci(n, X):
    R = lift(n, X)
    return np.einsum('ijkj->ik', R)

def kn(n, h):
    """Kulkarni-Nomizu h ? g as a pair matrix."""
    d = np.eye(n)
    T = (np.einsum('ik,jl->ijkl', h, d) + np.einsum('jl,ik->ijkl', h, d)
         - np.einsum('il,jk->ijkl', h, d) - np.einsum('jk,il->ijkl', h, d))
    return drop(n, T)

def kn_basis(n):
    """orthonormal (Frobenius on pair matrices) basis of {KN(h)}."""
    key = ('kn', n)
    if key in _cache:
        return _cache[key]
    vecs = []
    for i in range(n):
        for j in range(i, n):
            h = np.zeros((n, n)); h[i, j] = 1.0; h[j, i] = 1.0
            vecs.append(kn(n, h).ravel())
    M = np.array(vecs).T
    Qm, Rm = np.linalg.qr(M)
    keep = np.abs(np.diag(Rm)) > 1e-9
    B = Qm[:, keep]
    _cache[key] = B
    return B

def proj_weyl(n, X):
    """TRUE orthogonal projection of a symmetric pair matrix onto Weyl_n."""
    Y = 0.5 * (X + X.T)
    Y = Y - alt(n, Y)
    B = kn_basis(n)
    v = Y.ravel()
    v = v - B @ (B.T @ v)
    return v.reshape(X.shape)

def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12

# --------------------------------------------------------- U(m) projectors --
def Jmat(n):
    m = n // 2
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = 1.0
        J[2 * k + 1, 2 * k] = -1.0
    return J

def omega_vec(n):
    idx = pair_index(n); N = len(idx)
    w = np.zeros(N)
    J = Jmat(n)
    for (i, j), a in idx.items():
        w[a] = J[i, j]
    return w

def P_omega(n):
    w = omega_vec(n)
    return np.outer(w, w) / (w @ w)

def P_u(n):
    """projection of Lambda^2 = so(2m) onto u(m), via E -> 1/2 (E - J E J)."""
    P = pairs(n); N = len(P); J = Jmat(n)
    cols = []
    for (i, j) in P:
        E = phi(n, i, j)
        F = 0.5 * (E - J @ E @ J)
        cols.append(np.array([F[k, l] for (k, l) in P]))
    return np.array(cols).T

def P_su(n):
    return P_u(n) - P_omega(n)

def P_mm(n):
    N = len(pairs(n))
    return np.eye(N) - P_u(n)
