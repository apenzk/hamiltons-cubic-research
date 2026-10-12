"""Reviewer 32: independent implementation of the Weyl algebra and L_e.

Built from the definitions in findings/INDEX.md only.  Nothing is imported from
b_twoblock_symbolic.py, review_r30_*.py or review_r31_*.py.

Conventions used here (stated so they can be checked):
  * Lambda^2(R^n) has the orthonormal basis phi_ij = E_ij - E_ji (i<j) with
    <X,Y> = 1/2 tr(X^T Y);  <phi_ij,phi_ij> = 1.
  * A curvature operator is a symmetric N x N matrix R, N = n(n-1)/2, with
    R_{ij,kl} = <phi_ij, R phi_kl>.  The tensor R_{ijkl} extends it by
    antisymmetry in each pair.
  * (A_a)_{mn} = c_{amn} with [phi_a, phi_m] = sum_n c_{amn} phi_n.
  * (W^#)_{ab} = -1/2 tr(A_a W A_b W),  Q(W) = W^2 + W^#.
  * sharp_bilin(X,Y)_{ab} = -1/4 (T_ab + T_ba), T_ab = tr(A_a X A_b Y).
  * X o Y = 1/2 (XY + YX) + sharp_bilin(X,Y).
  * Operator inner product is Frobenius: <X,Y> = tr(XY) = sum_ab X_ab Y_ab.
"""
import itertools
import numpy as np
import scipy.sparse as sps


# ---------------------------------------------------------------- basis / so(n)

def planes(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def plane_index(n):
    return {pl: k for k, pl in enumerate(planes(n))}


def phi_matrices(n):
    """phi_ij = E_ij - E_ji as n x n matrices, in plane order."""
    out = []
    for (i, j) in planes(n):
        M = np.zeros((n, n))
        M[i, j] = 1.0
        M[j, i] = -1.0
        out.append(M)
    return np.array(out)


def struct_constants_dense(n):
    """c[a,m,r] = <[phi_a, phi_m], phi_r> with <X,Y> = 1/2 tr(X^T Y).

    Computed by brute force from the matrices, no formula assumed.
    """
    P = phi_matrices(n)
    N = P.shape[0]
    c = np.zeros((N, N, N))
    for a in range(N):
        for m in range(N):
            C = P[a] @ P[m] - P[m] @ P[a]
            for r in range(N):
                c[a, m, r] = 0.5 * np.trace(P[r].T @ C)
    return c


def struct_sparse_lists(n):
    """For each plane a, the nonzeros of A_a: arrays m[a,k], r[a,k], v[a,k].

    Each row of A_a has at most one nonzero, and exactly 2(n-2) rows are
    nonzero, so the lists have uniform length K = 2(n-2).
    """
    pls = planes(n)
    pi = plane_index(n)
    N = len(pls)
    K = 2 * (n - 2)
    m_arr = np.zeros((N, K), dtype=np.int64)
    r_arr = np.zeros((N, K), dtype=np.int64)
    v_arr = np.zeros((N, K))
    P = phi_matrices(n)
    for a, pa in enumerate(pls):
        k = 0
        for m, pm in enumerate(pls):
            C = P[a] @ P[m] - P[m] @ P[a]
            if not np.any(np.abs(C) > 1e-12):
                continue
            # find the single r
            hits = []
            for r in range(N):
                val = 0.5 * np.trace(P[r].T @ C)
                if abs(val) > 1e-12:
                    hits.append((r, val))
            assert len(hits) == 1, (pa, pm, hits)
            r, val = hits[0]
            m_arr[a, k] = m
            r_arr[a, k] = r
            v_arr[a, k] = val
            k += 1
        assert k == K, (a, k, K)
    return m_arr, r_arr, v_arr


# ------------------------------------------------------------ tensor utilities

def to_tensor(n, R):
    """Symmetric N x N matrix -> 4-index tensor T[i,j,k,l] with antisymmetry."""
    pi = plane_index(n)
    T = np.zeros((n, n, n, n))
    for (i, j), a in pi.items():
        for (k, l), b in pi.items():
            v = R[a, b]
            for si, (ii, jj) in ((1, (i, j)), (-1, (j, i))):
                for sk, (kk, ll) in ((1, (k, l)), (-1, (l, k))):
                    T[ii, jj, kk, ll] = si * sk * v
    return T


def bianchi_defect(n, R):
    T = to_tensor(n, R)
    return T + np.transpose(T, (0, 2, 3, 1)) + np.transpose(T, (0, 3, 1, 2))


def ricci(n, R):
    T = to_tensor(n, R)
    return np.einsum('ijil->jl', T)


# ------------------------------------------------------------------ Weyl space

def sym_basis(n):
    """Orthonormal basis of symmetric N x N matrices, as columns of an
    (N*N, D) matrix (row-major vec)."""
    N = n * (n - 1) // 2
    cols = []
    for a in range(N):
        M = np.zeros((N, N))
        M[a, a] = 1.0
        cols.append(M.ravel())
    for a in range(N):
        for b in range(a + 1, N):
            M = np.zeros((N, N))
            M[a, b] = M[b, a] = 1.0 / np.sqrt(2.0)
            cols.append(M.ravel())
    return np.array(cols).T


def weyl_basis(n, tol=1e-9):
    """Orthonormal basis of Weyl_n as columns of an (N*N, dim) array."""
    N = n * (n - 1) // 2
    S = sym_basis(n)
    D = S.shape[1]
    rows = []
    pls = planes(n)
    pi = plane_index(n)
    # Bianchi constraints, one per 4-subset: R_{ij,kl} - R_{ik,jl} + R_{il,jk}=0
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        v = np.zeros((N, N))

        def add(p1, p2, s):
            a, b = pi[p1], pi[p2]
            v[a, b] += s
            v[b, a] += s
        add((i, j), (k, l), 1.0)
        add((i, k), (j, l), -1.0)
        add((i, l), (j, k), 1.0)
        rows.append(0.5 * v.ravel())   # 0.5 undoes the double-add on off-diag
    # Ricci constraints
    for j in range(n):
        for l in range(j, n):
            v = np.zeros((N, N))
            for i in range(n):
                if i == j or i == l:
                    continue
                a = pi[tuple(sorted((i, j)))]
                b = pi[tuple(sorted((i, l)))]
                si = 1.0 if i < j else -1.0
                sl = 1.0 if i < l else -1.0
                v[a, b] += si * sl
                v[b, a] += si * sl
            rows.append(0.5 * v.ravel())
    Cst = np.array(rows) @ S            # constraints in the symmetric coords
    u, s, vt = np.linalg.svd(Cst)
    rank = int((s > tol * max(1.0, s[0])).sum())
    ker = vt[rank:].T                   # (D, dim)
    return S @ ker


# ---------------------------------------------------------------- the products

def W_pq(n, p, q, normalise=False):
    """Unnormalised Weyl operator of S^p x S^q: 1/(p(p-1)) inside P,
    1/(q(q-1)) inside Q, -1/(pq) across."""
    assert p + q == n and p >= 2 and q >= 2
    pi = plane_index(n)
    N = len(pi)
    W = np.zeros((N, N))
    for (i, j), a in pi.items():
        if i < p and j < p:
            w = 1.0 / (p * (p - 1))
        elif i >= p and j >= p:
            w = 1.0 / (q * (q - 1))
        else:
            w = -1.0 / (p * q)
        W[a, a] = w
    if normalise:
        W = W / np.sqrt(np.sum(W * W))
    return W


# --------------------------------------------------------- the algebra product

def sharp_bilin_ref(n, X, Y, c=None):
    """Reference (slow, straight from the definition)."""
    if c is None:
        c = struct_constants_dense(n)
    N = X.shape[0]
    A = c                                # A[a] has entries A[a][m,r]
    T = np.zeros((N, N))
    for a in range(N):
        Ma = A[a] @ X
        for b in range(N):
            T[a, b] = np.trace(Ma @ A[b] @ Y)
    return -0.25 * (T + T.T)


def circ_ref(n, X, Y, c=None):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin_ref(n, X, Y, c)


def Q_ref(n, X, c=None):
    return X @ X + sharp_bilin_ref(n, X, X, c)


# ------------------------------------------------- fast L_e as a sparse matrix

def L_operator_sparse(n, e, lists=None):
    """The matrix of X -> e o X on vec(X) (row-major), as a sparse (N^2,N^2).

    T_ab = sum_{m,r,s,t} (A_a)_{mr} e_{rs} (A_b)_{st} X_{tm}
    with the nonzero lists of A_a and A_b.
    """
    if lists is None:
        lists = struct_sparse_lists(n)
    m_arr, r_arr, v_arr = lists
    N, K = m_arr.shape
    a = np.arange(N)[:, None, None, None]
    i = np.arange(K)[None, :, None, None]
    b = np.arange(N)[None, None, :, None]
    j = np.arange(K)[None, None, None, :]
    ma = m_arr[a, i]          # (N,K,1,1)
    ra = r_arr[a, i]
    va = v_arr[a, i]
    mb = m_arr[b, j]          # s index of A_b's nonzero
    rb = r_arr[b, j]          # t index
    vb = v_arr[b, j]
    data = (va * vb * e[ra, mb]).ravel()
    rows = np.broadcast_to(a * N + b, (N, K, N, K)).ravel()
    cols = np.broadcast_to(rb * N + ma, (N, K, N, K)).ravel()
    Tmat = sps.coo_matrix((data, (rows, cols)), shape=(N * N, N * N)).tocsr()
    # transpose in (a,b):  row a*N+b  <-  row b*N+a
    perm = (np.arange(N * N).reshape(N, N).T).ravel()
    Tmat_T = Tmat[perm, :]
    sharp = -0.25 * (Tmat + Tmat_T)
    I = sps.identity(N, format='csr')
    symp = 0.5 * (sps.kron(sps.csr_matrix(e), I) + sps.kron(I, sps.csr_matrix(e)))
    return (symp + sharp).tocsr()


def L_on_weyl(n, e, B, lists=None):
    """Matrix of L_e restricted to Weyl_n in the orthonormal basis B."""
    Lop = L_operator_sparse(n, e, lists)
    return B.T @ (Lop @ B)
