"""Reviewer 36: independent implementation of the Weyl algebra machinery.

Built from the definitions in the brief alone.  Nothing here imports b_*.py or
review_r3*.py.
"""
import numpy as np
from itertools import combinations


def pairs_of(n):
    prs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    idx = {p: a for a, p in enumerate(prs)}
    return prs, idx


def phi_matrices(n):
    """phi_ij = E_ij - E_ji, i<j, in the order given by pairs_of."""
    prs, _ = pairs_of(n)
    P = np.zeros((len(prs), n, n))
    for a, (i, j) in enumerate(prs):
        P[a, i, j] = 1.0
        P[a, j, i] = -1.0
    return P


def inner(X, Y):
    return 0.5 * np.trace(X.T @ Y)


def struct(n):
    """A[a][m][n] = c_amn with [phi_a, phi_b] = sum_c c_abc phi_c."""
    P = phi_matrices(n)
    N = P.shape[0]
    A = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = P[a] @ P[b] - P[b] @ P[a]
            for c in range(N):
                A[a, b, c] = 0.5 * np.trace(P[c].T @ C)
    return A


def gram_check(n):
    P = phi_matrices(n)
    N = P.shape[0]
    G = np.array([[inner(P[a], P[b]) for b in range(N)] for a in range(N)])
    return np.abs(G - np.eye(N)).max()


# ---------- algebraic curvature operators ----------

def Rval_map(n):
    """Return f(M,i,j,k,l) -> R_ijkl for a matrix M in the plane basis."""
    _, idx = pairs_of(n)

    def sgn_idx(i, j):
        if i == j:
            return 0, None
        if i < j:
            return 1, idx[(i, j)]
        return -1, idx[(j, i)]

    def f(M, i, j, k, l):
        s1, a = sgn_idx(i, j)
        s2, b = sgn_idx(k, l)
        if s1 == 0 or s2 == 0:
            return 0.0
        return s1 * s2 * M[a, b]
    return f


def weyl_basis(n, ric_free=True):
    """Orthonormal (Frobenius) basis of symmetric operators on Lambda^2 with
    first Bianchi, and Ricci = 0 when ric_free."""
    prs, idx = pairs_of(n)
    N = len(prs)
    # coordinates: symmetric matrices, param by (a<=b)
    coords = [(a, b) for a in range(N) for b in range(a, N)]
    cidx = {c: t for t, c in enumerate(coords)}
    D0 = len(coords)

    def add(row, a, b, v):
        key = (a, b) if a <= b else (b, a)
        row[cidx[key]] += v

    def Rrow(i, j, k, l, coef, row):
        if i == j or k == l:
            return
        s = 1.0
        if i > j:
            i, j, s = j, i, -s
        if k > l:
            k, l, s = l, k, -s
        add(row, idx[(i, j)], idx[(k, l)], coef * s)

    rows = []
    for (i, j, k, l) in combinations(range(n), 4):
        row = np.zeros(D0)
        Rrow(i, j, k, l, 1.0, row)
        Rrow(i, k, l, j, 1.0, row)
        Rrow(i, l, j, k, 1.0, row)
        rows.append(row)
    if ric_free:
        for i in range(n):
            for k in range(i, n):
                row = np.zeros(D0)
                for j in range(n):
                    Rrow(i, j, k, j, 1.0, row)
                rows.append(row)
    C = np.array(rows)
    # nullspace
    u, s, vt = np.linalg.svd(C)
    rank = int((s > 1e-9 * s[0]).sum())
    ns = vt[rank:]
    # turn coordinate vectors into matrices, orthonormalise in Frobenius
    B = []
    for v in ns:
        M = np.zeros((N, N))
        for t, (a, b) in enumerate(coords):
            M[a, b] += v[t]
            if a != b:
                M[b, a] += v[t]
        B.append(M)
    B = np.array(B)
    D = len(B)
    F = B.reshape(D, N * N)
    # Gram-Schmidt via symmetric orthogonalisation
    G = F @ F.T
    w, U = np.linalg.eigh(G)
    T = U @ np.diag(1.0 / np.sqrt(w)) @ U.T
    F = T @ F
    return F.reshape(D, N, N)


# ---------- the algebra ----------

def sharp_bilin(A, X, Y):
    """-1/4 (T + T^T),  T_ab = tr(A_a X A_b Y)."""
    N = A.shape[0]
    P = np.einsum('amn,nr->amr', A, X)
    Qm = np.einsum('brs,sm->brm', A, Y)
    T = P.reshape(N, N * N) @ Qm.transpose(0, 2, 1).reshape(N, N * N).T
    return -0.25 * (T + T.T)


def circ(A, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(A, X, Y)


def sharp(A, X):
    return sharp_bilin(A, X, X)


def Qop(A, X):
    return X @ X + sharp(A, X)


def W_pq(p, q):
    n = p + q
    prs, _ = pairs_of(n)
    N = len(prs)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(prs):
        if j < p:
            W[a, a] = 1.0 / (p * (p - 1))
        elif i >= p:
            W[a, a] = 1.0 / (q * (q - 1))
        else:
            W[a, a] = -1.0 / (p * q)
    return W


def I_block(n, lo, hi):
    """projection onto Lambda^2 of coordinates [lo,hi)."""
    prs, _ = pairs_of(n)
    N = len(prs)
    M = np.zeros((N, N))
    for a, (i, j) in enumerate(prs):
        if lo <= i and j < hi:
            M[a, a] = 1.0
    return M


def block_of(i, p):
    return 0 if i < p else 1


def plane_type(pr, p):
    i, j = pr
    return (block_of(i, p), block_of(j, p))  # (0,0) pp, (0,1) mix, (1,1) qq


def rho(n, g):
    """Lambda^2 representation of g in O(n) in the phi basis."""
    P = phi_matrices(n)
    N = P.shape[0]
    gP = np.einsum('mi,aij,nj->amn', g, P, g)
    return 0.5 * np.einsum('amn,bmn->ba', gP, P)  # <g phi_b g^T, phi_a>? see below


def rho2(n, g):
    P = phi_matrices(n)
    N = P.shape[0]
    gP = np.einsum('mi,bij,nj->bmn', g, P, g)   # (g phi_b g^T)
    R = np.zeros((N, N))
    for b in range(N):
        for a in range(N):
            R[a, b] = 0.5 * np.trace(P[a].T @ gP[b])
    return R


def L_matrix(A, B, e):
    """Matrix of X -> e o X in the orthonormal basis B."""
    D = B.shape[0]
    N = A.shape[0]
    out = np.zeros((D, D))
    Bf = B.reshape(D, N * N)
    for j in range(D):
        Y = circ(A, e, B[j])
        out[:, j] = Bf @ Y.reshape(N * N)
    return out


def op_matrix(A, B, X0):
    """Matrix of V -> sharp_bilin(X0, V) restricted to span(B), in basis B."""
    D = B.shape[0]
    N = A.shape[0]
    out = np.zeros((D, D))
    Bf = B.reshape(D, N * N)
    for j in range(D):
        Y = sharp_bilin(A, X0, B[j])
        out[:, j] = Bf @ Y.reshape(N * N)
    return out


def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12
