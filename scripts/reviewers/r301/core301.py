"""Reviewer 301: independent rebuild of Weyl_n, Q, o, L_e, isotropy, Sym_0 deformations.

Built from the definitions in the brief only.  Nothing imported from scripts/lib or
from any other reviewer's directory.

Conventions
  Lambda^2 R^n ~= so(n),  orthonormal basis  phi_ij = E_ij - E_ji (i<j)  under
      <X,Y> = 1/2 tr(X^T Y).
  A curvature operator is a symmetric N x N matrix in that basis, N = n(n-1)/2.
  ad_a = ad(phi_a) acting on so(n), written in the phi basis.
  (X # Y)_ab = -1/4 ( tr(ad_a X ad_b Y) + tr(ad_b X ad_a Y) ),  X^# = X # X
  Q(X) = X^2 + X^#,   X o Y = 1/2(XY+YX) + X # Y,   Q(X) = X o X.
  Weyl_n = { S sym on Lambda^2 : first Bianchi  and  Ric(S) = 0 }.
  W critical: Q(W) = theta W with |W| = 1;  L_e = (1/theta) L_W.
"""
import numpy as np
from functools import lru_cache

# ---------------------------------------------------------------- so(n) basis
@lru_cache(maxsize=None)
def pairs(n):
    P = [(i, j) for i in range(n) for j in range(i + 1, n)]
    return tuple(P), {p: a for a, p in enumerate(P)}

def phi(n, i, j):
    M = np.zeros((n, n)); M[i, j] = 1.0; M[j, i] = -1.0
    return M

@lru_cache(maxsize=None)
def adj(n):
    """ad[a] = matrix of ad(phi_a) on so(n) in the orthonormal phi basis."""
    P, idx = pairs(n); N = len(P)
    B = [phi(n, i, j) for (i, j) in P]
    A = np.zeros((N, N, N))
    for a in range(N):
        for m in range(N):
            C = B[a] @ B[m] - B[m] @ B[a]
            for b, (k, l) in enumerate(P):
                if C[k, l] != 0.0:
                    A[a, b, m] = C[k, l]
    return A

def ip(X, Y):
    """Frobenius inner product on operators (basis phi is orthonormal)."""
    return float(np.tensordot(X, Y, axes=([0, 1], [0, 1])))

def nrm(X):
    return float(np.sqrt(ip(X, X)))

# ---------------------------------------------------------------- sharp / Q / o
def sharp_bilin(n, X, Y):
    A = adj(n); N = A.shape[0]
    AX = A @ X
    AY = A @ Y
    T = AX.reshape(N, -1) @ np.transpose(AY, (0, 2, 1)).reshape(N, -1).T
    return -0.25 * (T + T.T)

def Q(n, X):
    return X @ X + sharp_bilin(n, X, X)

def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(n, X, Y)

# ---------------------------------------------------------------- Weyl_n
@lru_cache(maxsize=None)
def sym_coords(n):
    """Index map for Sym(N) coordinates; returns (V, list of (a,b,scale))."""
    P, idx = pairs(n); N = len(P)
    coords = []
    for a in range(N):
        coords.append((a, a))
    for a in range(N):
        for b in range(a + 1, N):
            coords.append((a, b))
    return N, coords

def sym_to_vec(n, S):
    N, coords = sym_coords(n)
    r2 = np.sqrt(2.0)
    v = np.empty(len(coords))
    for c, (a, b) in enumerate(coords):
        v[c] = S[a, a] if a == b else r2 * S[a, b]
    return v

def vec_to_sym(n, v):
    N, coords = sym_coords(n)
    r2 = np.sqrt(2.0)
    S = np.zeros((N, N))
    for c, (a, b) in enumerate(coords):
        if a == b:
            S[a, a] = v[c]
        else:
            S[a, b] = S[b, a] = v[c] / r2
    return S

def riem(n, S):
    """R_{ijkl} from the operator matrix, antisymmetrised in ij and kl."""
    P, idx = pairs(n); N = len(P)
    R = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            v = S[a, b]
            R[i, j, k, l] = v;  R[j, i, k, l] = -v
            R[i, j, l, k] = -v; R[j, i, l, k] = v
    return R

@lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal basis (list of N x N symmetric matrices) of Weyl_n."""
    N, coords = sym_coords(n)
    D = len(coords)
    rows = []
    # first Bianchi: R_{ijkl}+R_{iklj}+R_{iljk} = 0 for i<j<k<l
    quad = [(i, j, k, l) for i in range(n) for j in range(i + 1, n)
            for k in range(j + 1, n) for l in range(k + 1, n)]
    P, idx = pairs(n)
    def entry(S, i, j, k, l):
        if i == j or k == l:
            return 0.0
        si = 1.0
        if i > j: i, j, si = j, i, -si
        if k > l: k, l, si = l, k, -si
        return si * S[idx[(i, j)], idx[(k, l)]]
    basisD = [vec_to_sym(n, e) for e in np.eye(D)]
    for (i, j, k, l) in quad:
        row = np.zeros(D)
        for c in range(D):
            S = basisD[c]
            row[c] = entry(S, i, j, k, l) + entry(S, i, k, l, j) + entry(S, i, l, j, k)
        rows.append(row)
    # Ricci: sum_j R_{ijkj} = 0 for i <= k
    for i in range(n):
        for k in range(i, n):
            row = np.zeros(D)
            for c in range(D):
                S = basisD[c]
                row[c] = sum(entry(S, i, j, k, j) for j in range(n))
            rows.append(row)
    C = np.array(rows)
    u, s, vt = np.linalg.svd(C)
    tol = max(C.shape) * s.max() * 1e-12 if len(s) else 0.0
    rank = int((s > tol).sum())
    ns = vt[rank:]                      # rows span the nullspace, orthonormal
    return tuple(vec_to_sym(n, r) for r in ns)

@lru_cache(maxsize=None)
def weyl_mat(n):
    B = weyl_basis(n)
    return np.array([sym_to_vec(n, b) for b in B])   # (dimW, D), orthonormal rows

def proj_weyl(n, S):
    M = weyl_mat(n)
    v = sym_to_vec(n, 0.5 * (S + S.T))
    return vec_to_sym(n, M.T @ (M @ v))

# ---------------------------------------------------------------- deformations
def D_A(n, A):
    """Derivation action of A in gl(n) on Lambda^2, as an N x N matrix in phi basis."""
    P, idx = pairs(n); N = len(P)
    M = np.zeros((N, N))
    for b, (i, j) in enumerate(P):
        # D_A(e_i ^ e_j) = A e_i ^ e_j + e_i ^ A e_j
        for k in range(n):
            if A[k, i] != 0.0 and k != j:
                a2, s = (idx[(k, j)], 1.0) if k < j else (idx[(j, k)], -1.0)
                M[a2, b] += s * A[k, i]
            if A[k, j] != 0.0 and k != i:
                a2, s = (idx[(i, k)], 1.0) if i < k else (idx[(k, i)], -1.0)
                M[a2, b] += s * A[k, j]
    return M

@lru_cache(maxsize=None)
def sym0_basis(n):
    """Orthonormal basis of Sym_0(R^n) under tr(A^T B)."""
    out = []
    for i in range(n):
        for j in range(i + 1, n):
            M = np.zeros((n, n)); M[i, j] = M[j, i] = 1 / np.sqrt(2.0)
            out.append(M)
    for k in range(1, n):
        d = np.zeros(n); d[:k] = 1.0; d[k] = -k
        d /= np.linalg.norm(d)
        out.append(np.diag(d))
    # Gram-Schmidt on the diagonal part (already orthogonal by construction? make sure)
    B = []
    for M in out:
        for X in B:
            M = M - np.tensordot(M, X, axes=([0,1],[0,1])) * X
        nn = np.linalg.norm(M)
        if nn > 1e-9:
            B.append(M / nn)
    return tuple(B)

# ---------------------------------------------------------------- isotropy
def isotropy(n, W, tol=1e-8):
    """Basis of k(W) = {x in so(n) : [ad(x), W] = 0}, in the phi basis of so(n)."""
    A = adj(n); N = A.shape[0]
    rows = []
    for a in range(N):
        C = A[a] @ W - W @ A[a]
        rows.append(C.reshape(-1))
    Mx = np.array(rows).T                    # (N*N, N):  columns = images
    u, s, vt = np.linalg.svd(Mx, full_matrices=False)
    keep = s <= max(s.max(), 1.0) * tol
    return vt[keep]                          # rows = coefficient vectors in phi basis

def so_from_coeffs(n, c):
    P, idx = pairs(n)
    M = np.zeros((n, n))
    for a, (i, j) in enumerate(P):
        M[i, j] += c[a]; M[j, i] -= c[a]
    return M
