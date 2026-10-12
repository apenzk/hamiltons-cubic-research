"""Reviewer 37: independent implementation of the Weyl algebra, built only from
the definitions in the brief.  Imports nothing from the code under review."""
import numpy as np
from itertools import combinations


def pairs_of(n):
    return list(combinations(range(n), 2))


def pair_index(n):
    P = pairs_of(n)
    return P, {p: a for a, p in enumerate(P)}


# ---------------------------------------------------------------- so(n) basis
def phi_matrices(n):
    """phi_ij = E_ij - E_ji, i<j, in the order of pairs_of(n)."""
    P = pairs_of(n)
    out = np.zeros((len(P), n, n))
    for a, (i, j) in enumerate(P):
        out[a, i, j] = 1.0
        out[a, j, i] = -1.0
    return out


def struct_A(n):
    """A_a with (A_a)_{mn} = c_{amn}, c_{abc} = <[phi_a,phi_b], phi_c>,
    <X,Y> = 1/2 tr(X^T Y).  Built by literal commutators."""
    ph = phi_matrices(n)
    N = ph.shape[0]
    A = np.zeros((N, N, N))
    for a in range(N):
        for m in range(N):
            C = ph[a] @ ph[m] - ph[m] @ ph[a]
            # <C, phi_k> = 1/2 tr(C^T phi_k); for antisymmetric C this is C_{ij}
            for k, (i, j) in enumerate(pairs_of(n)):
                A[a, m, k] = C[i, j]
    return A


# ------------------------------------------------------------- algebra pieces
def sharp_bilin(X, Y, A):
    """sharp_bilin(X,Y)_ab = -1/4 (T_ab + T_ba),  T_ab = tr(A_a X A_b Y)."""
    N = A.shape[0]
    A2 = A.reshape(N * N, N)
    AX = (A2 @ X).reshape(N, N, N)          # AX[a] = A_a X
    AY = (A2 @ Y).reshape(N, N, N)          # AY[b] = A_b Y
    T = np.einsum('aij,bji->ab', AX, AY)
    return -0.25 * (T + T.T)


def sharp(X, A):
    return sharp_bilin(X, X, A)


def circ(X, Y, A):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(X, Y, A)


def Qop(X, A):
    return X @ X + sharp(X, A)


def ip(X, Y):
    return float(np.tensordot(X, Y))


# ------------------------------------------------------------- Weyl_n as a nullspace
def sym_basis(N):
    """Orthonormal basis of symmetric NxN matrices, as a (D,N,N) array."""
    out = []
    for a in range(N):
        E = np.zeros((N, N)); E[a, a] = 1.0
        out.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N)); E[a, b] = E[b, a] = 1 / np.sqrt(2.0)
            out.append(E)
    return np.array(out)


def tensor_entry(M, idx, i, j, k, l):
    """R_{ijkl} from the matrix M in the phi basis, antisymmetric extension."""
    if i == j or k == l:
        return 0.0
    si = 1.0
    if i > j:
        i, j = j, i; si = -si
    if k > l:
        k, l = l, k; si = -si
    return si * M[idx[(i, j)], idx[(k, l)]]


def weyl_basis(n, tol=1e-9):
    """Symmetric operators on Lambda^2 obeying first Bianchi and Ric = 0."""
    P, idx = pair_index(n)
    N = len(P)
    S = sym_basis(N)
    D = S.shape[0]
    rows = []
    # first Bianchi: R_{ij,kl} - R_{ik,jl} + R_{il,jk} = 0 for i<j<k<l
    for (i, j, k, l) in combinations(range(n), 4):
        r = np.array([tensor_entry(M, idx, i, j, k, l)
                      - tensor_entry(M, idx, i, k, j, l)
                      + tensor_entry(M, idx, i, l, j, k) for M in S])
        rows.append(r)
    # Ricci: Ric_ik = sum_j R_{ijkj} = 0
    for i in range(n):
        for k in range(i, n):
            r = np.array([sum(tensor_entry(M, idx, i, j, k, j) for j in range(n))
                          for M in S])
            rows.append(r)
    C = np.array(rows)
    u, s, vt = np.linalg.svd(C)
    rank = int((s > tol * max(1.0, s[0])).sum())
    ns = vt[rank:]                       # (D - rank, D) orthonormal
    return np.einsum('kd,dij->kij', ns, S)


# ------------------------------------------------------------- sphere product
def kinds(p, q):
    """0 = pp plane, 1 = mixed plane, 2 = qq plane."""
    n = p + q
    return np.array([0 if (i < p and j < p) else (2 if (i >= p and j >= p) else 1)
                     for (i, j) in pairs_of(n)])


def W_pq(p, q):
    k = kinds(p, q)
    v = np.where(k == 0, 1.0 / (p * (p - 1)) if p > 1 else 0.0,
                 np.where(k == 2, 1.0 / (q * (q - 1)) if q > 1 else 0.0,
                          -1.0 / (p * q)))
    return np.diag(v)


def I_block(p, q, which):
    k = kinds(p, q)
    d = np.zeros(len(k))
    if which == 'p':
        d[k == 0] = 1.0
    elif which == 'q':
        d[k == 2] = 1.0
    else:
        d[:] = 1.0
    return np.diag(d)


# ------------------------------------------------------------- O(n) action
def lambda2(g):
    """Matrix of Lambda^2(g) in the phi basis: rho[(ij),(kl)] = g_ik g_jl - g_il g_jk."""
    n = g.shape[0]
    P = pairs_of(n)
    N = len(P)
    rho = np.zeros((N, N))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            rho[a, b] = g[i, k] * g[j, l] - g[i, l] * g[j, k]
    return rho


def rand_O(m, rng, det=None):
    g, r = np.linalg.qr(rng.normal(size=(m, m)))
    g = g * np.sign(np.diag(r))
    if det is not None and np.linalg.det(g) * det < 0:
        g[:, 0] *= -1
    return g


# ------------------------------------------------------------- helpers
def coords(B, X):
    return np.einsum('kij,ij->k', B, X)


def expand(B, c):
    return np.einsum('k,kij->ij', c, B)


def operator_matrix(B, f):
    """Matrix of a linear map f on the span of the orthonormal basis B, followed
    by orthogonal projection onto that span."""
    D = B.shape[0]
    M = np.zeros((D, D))
    for j in range(D):
        M[:, j] = coords(B, f(B[j]))
    return M
