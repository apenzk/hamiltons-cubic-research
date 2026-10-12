"""Reviewer 50: independent machinery, written from the definitions only.

Conventions (from the brief):
  Lambda^2 R^n, orthonormal basis phi_ij = E_ij - E_ji (i<j),  <X,Y> = 1/2 tr(X^T Y)
  at the Lambda^2 matrix level; PLAIN Frobenius on the (i<j,k<l) pair matrix.
  c_{abg} = <[phi_a,phi_b],phi_g>,  (A_a)_{mn} = c_{amn}
  (W^#)_{ab} = -1/2 tr(A_a W A_b W),  Q(W) = W^2 + W^#,  P(W) = <W,Q(W)>
  Weyl_n = symmetric, first Bianchi, Ricci-flat.
  X o Y = 1/2(XY+YX) + sharp_bilin(X,Y),  L_e X = e o X with e = W/theta.
"""
import numpy as np, itertools, functools


# ---------------- Lambda^2 bookkeeping ----------------

@functools.lru_cache(maxsize=None)
def pairs_idx(n):
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    return tuple(pairs), {p: a for a, p in enumerate(pairs)}


@functools.lru_cache(maxsize=None)
def phis(n):
    pairs, _ = pairs_idx(n)
    N = len(pairs)
    ph = np.zeros((N, n, n))
    for a, (i, j) in enumerate(pairs):
        ph[a, i, j] = 1.0
        ph[a, j, i] = -1.0
    return ph


@functools.lru_cache(maxsize=None)
def struct(n):
    """c[a,b,g] = <[phi_a,phi_b],phi_g> = 1/2 tr([phi_a,phi_b]^T phi_g)."""
    ph = phis(n)
    N = ph.shape[0]
    c = np.zeros((N, N, N))
    for a in range(N):
        comm = ph[a] @ ph - ph @ ph[a]                      # (N,n,n)
        c[a] = 0.5 * np.einsum('bij,gij->bg', comm, ph)
    return c


@functools.lru_cache(maxsize=None)
def _A2(n):
    A = struct(n)
    N = A.shape[0]
    return A.reshape(N * N, N)


def sharp(n, W):
    A = struct(n); N = A.shape[0]
    M = (_A2(n) @ W).reshape(N, N, N)
    return -0.5 * (M.reshape(N, N * N) @ M.transpose(0, 2, 1).reshape(N, N * N).T)


def sharp_bilin(n, X, Y):
    """1/2[(X+Y)^# - X^# - Y^#] = -1/4 (T + T^T), T_ab = tr(A_a X A_b Y)."""
    N = struct(n).shape[0]
    AX = (_A2(n) @ X).reshape(N, N, N)
    AY = (_A2(n) @ Y).reshape(N, N, N)
    T = AX.reshape(N, N * N) @ AY.transpose(0, 2, 1).reshape(N, N * N).T
    return -0.25 * (T + T.T)


def Q(n, W):
    return W @ W + sharp(n, W)


def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(n, X, Y)


def P(n, W):
    return float(np.tensordot(W, Q(n, W)))


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


# ---------------- tensor form, Bianchi, Ricci ----------------

@functools.lru_cache(maxsize=None)
def _lift(n):
    """E[i,j,a]: R[i,j,k,l] = sum_ab E[i,j,a] E[k,l,b] M[a,b]."""
    pairs, idx = pairs_idx(n)
    N = len(pairs)
    E = np.zeros((n, n, N))
    for a, (i, j) in enumerate(pairs):
        E[i, j, a] = 1.0
        E[j, i, a] = -1.0
    return E


def to_tensor(n, M):
    E = _lift(n)
    return np.einsum('ija,ab,klb->ijkl', E, M, E, optimize=True)


def from_tensor(n, R):
    pairs, _ = pairs_idx(n)
    I = np.array([p[0] for p in pairs]); J = np.array([p[1] for p in pairs])
    return R[np.ix_(I, J, I, J)][np.arange(len(pairs))[:, None], np.arange(len(pairs))[None, :]] \
        if False else R[I[:, None], J[:, None], I[None, :], J[None, :]]


def alt_part(n, M):
    """Lambda^4 (first-Bianchi) component, as a pair matrix."""
    R = to_tensor(n, M)
    A = (R + R.transpose(0, 2, 3, 1) + R.transpose(0, 3, 1, 2)) / 3.0
    return from_tensor(n, A)


def ricci(n, M):
    R = to_tensor(n, M)
    r = np.einsum('ikjk->ij', R)
    return 0.5 * (r + r.T)


def KN(n, h):
    """KN(h)[(i,j),(k,l)] = 1/2 (h_ik d_jl - h_il d_jk - h_jk d_il + h_jl d_ik)."""
    pairs, _ = pairs_idx(n)
    I = np.array([p[0] for p in pairs]); J = np.array([p[1] for p in pairs])
    d = np.eye(n)
    return 0.5 * (h[I[:, None], I[None, :]] * d[J[:, None], J[None, :]]
                  - h[I[:, None], J[None, :]] * d[J[:, None], I[None, :]]
                  - h[J[:, None], I[None, :]] * d[I[:, None], J[None, :]]
                  + h[J[:, None], J[None, :]] * d[I[:, None], I[None, :]])


def weyl_project_free(n, X, alpha=None, beta=None):
    """Basis-free projection, coefficients exposed so each can be attacked alone."""
    if alpha is None:
        alpha = 2.0 / (n - 2)
    if beta is None:
        beta = 1.0 / (n * (n - 1))
    Y = X - alt_part(n, X)
    rho = ricci(n, Y)
    s = float(np.trace(rho))
    rho0 = rho - (s / n) * np.eye(n)
    return Y - alpha * KN(n, rho0) - beta * s * KN(n, np.eye(n))


# ---------------- Weyl_n as a coordinate subspace ----------------

@functools.lru_cache(maxsize=None)
def _sym_coords(N):
    return np.triu_indices(N, 1)


def mat2vec(N, M):
    iu = _sym_coords(N)
    return np.concatenate([np.diag(M), M[iu] * np.sqrt(2.0)])


def vec2mat(N, v):
    iu = _sym_coords(N)
    M = np.zeros((N, N))
    M[iu] = v[N:] / np.sqrt(2.0)
    M = M + M.T
    M[np.arange(N), np.arange(N)] = v[:N]
    return M


def weyl_constraint_rows(n):
    """Rows in the sym-coordinate space: Bianchi (4-subsets) then Ricci."""
    pairs, idx = pairs_idx(n)
    N = len(pairs)
    rows = []

    def put(row, a, b, v):
        i, j = a
        s = 1.0
        if i > j:
            i, j, s = j, i, -s
        k, l = b
        if k > l:
            k, l, s = l, k, -s
        if i == j or k == l:
            return
        row[idx[(i, j)], idx[(k, l)]] += s * v

    for (i, j, k, l) in itertools.combinations(range(n), 4):
        row = np.zeros((N, N))
        for (a, b) in (((i, j), (k, l)), ((i, k), (l, j)), ((i, l), (j, k))):
            put(row, a, b, 1.0)
        row = 0.5 * (row + row.T)
        rows.append(mat2vec(N, row))
    for i in range(n):
        for k in range(i, n):
            row = np.zeros((N, N))
            for j in range(n):
                if j == i or j == k:
                    continue
                put(row, (i, j), (k, j), 1.0)
            row = 0.5 * (row + row.T)
            rows.append(mat2vec(N, row))
    return np.array(rows)


@functools.lru_cache(maxsize=None)
def weyl_basis_vec(n):
    """Orthonormal basis of Weyl_n as rows in sym-coordinate space, shape (d, D)."""
    C = weyl_constraint_rows(n)
    u, s, vt = np.linalg.svd(C, full_matrices=True)
    tol = max(C.shape) * (s[0] if s.size else 1.0) * 1e-12
    rank = int((s > tol).sum())
    return vt[rank:], rank


def dim_weyl_formula(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


# ---------------- sphere products, padding, orbit ----------------

def sphere_product_W(blocks):
    n = sum(blocks)
    pairs, idx = pairs_idx(n)
    N = len(pairs)
    lab = []
    for bi, b in enumerate(blocks):
        lab += [bi] * b
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(pairs):
        if lab[i] == lab[j]:
            p = blocks[lab[i]]
            W[a, a] = 1.0 / (p * (p - 1))
        else:
            p, q = blocks[lab[i]], blocks[lab[j]]
            W[a, a] = -1.0 / (p * q)
    return W


def pad(W0, n0, n):
    p0, _ = pairs_idx(n0)
    pairs, idx = pairs_idx(n)
    N = len(pairs)
    W = np.zeros((N, N))
    ii = np.array([idx[p] for p in p0])
    W[np.ix_(ii, ii)] = W0
    return W


def orbit_tangent(n, W):
    A = struct(n)
    return np.array([A[a] @ W - W @ A[a] for a in range(A.shape[0])])


def orthonormalize_rows(F, tol=1e-9):
    u, s, vt = np.linalg.svd(F, full_matrices=False)
    r = int((s > tol * max(1.0, s[0])).sum())
    return vt[:r]
