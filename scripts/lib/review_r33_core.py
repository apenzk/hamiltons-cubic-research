"""Reviewer 33 -- independent implementation of Weyl_n, Q, the polarization and L_e.

Built from the definitions only.  No project module is imported.
"""
import itertools, numpy as np
from fractions import Fraction

# ---------- so(n) in the basis phi_ij = E_ij - E_ji, <X,Y> = 1/2 tr(X^T Y) ----------

def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]

def pair_index(n):
    return {pq: a for a, pq in enumerate(pairs(n))}

def phi_matrices(n):
    P = pairs(n)
    out = []
    for (i, j) in P:
        M = np.zeros((n, n))
        M[i, j] = 1.0
        M[j, i] = -1.0
        out.append(M)
    return out

def structure_constants(n):
    """c[a,b,c] = <[phi_a, phi_b], phi_c>, orthonormal basis."""
    ph = np.array(phi_matrices(n))         # (D, n, n)
    br = np.einsum('aij,bjk->abik', ph, ph)
    br = br - br.transpose(1, 0, 2, 3)      # [phi_a, phi_b]
    return 0.5 * np.einsum('abik,cik->abc', br, ph)

def A_tensor(n):
    """A[a][m,n] = c_{a m n}."""
    return structure_constants(n)          # A[a] is exactly C[a,:,:]

# ---------- sharp and the polarization ----------

def sharp_bilin(A, X, Y):
    """sharp(X,Y)_ab = -1/4 (T_ab + T_ba),  T_ab = tr(A_a X A_b Y)."""
    D = A.shape[0]
    P = np.einsum('amn,np->amp', A, X)     # P[a] = A_a X
    Q = np.einsum('bmn,np->bmp', A, Y)     # Q[b] = A_b Y
    T = np.einsum('amn,bnm->ab', P, Q)     # tr(P_a Q_b)
    return -0.25 * (T + T.T)

def circ(A, X, Y):
    """X o Y = 1/2 (XY + YX) + sharp_bilin(X,Y)."""
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(A, X, Y)

def sharp(A, X):
    return sharp_bilin(A, X, X)

def Q_of(A, X):
    return X @ X + sharp(A, X)

# ---------- curvature-tensor view ----------

def Rget(W, idx, i, j, k, l):
    if i == j or k == l:
        return 0.0
    s = 1.0
    if i > j:
        i, j = j, i; s = -s
    if k > l:
        k, l = l, k; s = -s
    return s * W[idx[(i, j)], idx[(k, l)]]

def weyl_constraints(n):
    """Rows of a matrix acting on the vectorised upper triangle of Sym^2(Lambda^2)."""
    P = pairs(n); idx = pair_index(n); D = len(P)
    # coordinates: symmetric matrix entries (a<=b)
    coords = [(a, b) for a in range(D) for b in range(a, D)]
    cidx = {ab: t for t, ab in enumerate(coords)}
    def add(row, i, j, k, l, val):
        if i == j or k == l:
            return
        s = val
        if i > j:
            i, j = j, i; s = -s
        if k > l:
            k, l = l, k; s = -s
        a, b = idx[(i, j)], idx[(k, l)]
        if a > b:
            a, b = b, a
        row[cidx[(a, b)]] += s
    rows = []
    # Bianchi (Lambda^4 component)
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        row = np.zeros(len(coords))
        add(row, i, j, k, l, 1.0)
        add(row, i, k, l, j, 1.0)
        add(row, i, l, j, k, 1.0)
        rows.append(row)
    # Ricci
    for i in range(n):
        for k in range(i, n):
            row = np.zeros(len(coords))
            for j in range(n):
                add(row, i, j, k, j, 1.0)
            rows.append(row)
    return np.array(rows), coords

def sym_from_vec(v, coords, D):
    M = np.zeros((D, D))
    for t, (a, b) in enumerate(coords):
        M[a, b] = v[t]
        M[b, a] = v[t]
    return M

def vec_from_sym(M, coords):
    return np.array([M[a, b] for (a, b) in coords])

def weyl_basis(n):
    """Orthonormal (Frobenius) basis of Weyl_n as a (dim, D, D) array."""
    Cst, coords = weyl_constraints(n)
    D = n * (n - 1) // 2
    # nullspace
    u, s, vt = np.linalg.svd(Cst)
    tol = max(Cst.shape) * np.finfo(float).eps * (s[0] if s.size else 1.0)
    rank = int((s > tol).sum())
    N = vt[rank:]                      # (dim, ncoords)
    mats = [sym_from_vec(N[k], coords, D) for k in range(N.shape[0])]
    # Gram-Schmidt in Frobenius inner product
    B = []
    for M in mats:
        for Bk in B:
            M = M - np.sum(M * Bk) * Bk
        nrm = np.sqrt(np.sum(M * M))
        if nrm > 1e-9:
            B.append(M / nrm)
    return np.array(B)

def weyl_projector(n):
    B = weyl_basis(n)
    D = n * (n - 1) // 2
    F = B.reshape(B.shape[0], -1)
    return F.T @ F, B

# ---------- the sphere product ----------

def W_pq(p, q):
    n = p + q
    P = pairs(n); idx = pair_index(n); D = len(P)
    W = np.zeros((D, D))
    for (i, j) in P:
        if i < p and j < p:
            v = 1.0 / (p * (p - 1))
        elif i >= p and j >= p:
            v = 1.0 / (q * (q - 1))
        else:
            v = -1.0 / (p * q)
        W[idx[(i, j)], idx[(i, j)]] = v
    return W

def dim_weyl_formula(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


# ---------- L_e as a matrix on Weyl_n ----------

def L_matrix(A, e, B, chunk=64):
    """Matrix of Y |-> e o Y in the orthonormal Weyl basis B."""
    dim = B.shape[0]
    D = e.shape[0]
    Pa = np.einsum('amn,np->amp', A, e)             # P[a] = A_a e
    Pflat = Pa.reshape(D, D * D)
    L = np.zeros((dim, dim))
    Bf = B.reshape(dim, -1)
    for s in range(0, dim, chunk):
        Yb = B[s:s + chunk]                          # (c, D, D)
        Qb = np.einsum('bmn,cnp->cbmp', A, Yb)       # (c, D, D, D)
        T = np.einsum('amn,cbnm->cab', Pa, Qb)
        sh = -0.25 * (T + T.transpose(0, 2, 1))
        out = 0.5 * (np.einsum('ij,cjk->cik', e, Yb) + np.einsum('cij,jk->cik', Yb, e)) + sh
        L[:, s:s + chunk] = Bf @ out.reshape(out.shape[0], -1).T
    return L
