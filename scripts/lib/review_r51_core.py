"""Reviewer 51: independent machinery, written from the definitions only.

Lambda^2 R^n with orthonormal basis phi_ij = E_ij - E_ji (i<j), <X,Y> = 1/2 tr(X^T Y).
c[a,b,g] = <[phi_a,phi_b],phi_g>;  (A_a)_{mn} = c[a,m,n]
(W^#)_{ab} = -1/2 tr(A_a W A_b W);  Q(W) = W^2 + W^#;  P(W) = <W,Q(W)>
X o Y = 1/2(XY+YX) + sharp_bilin(X,Y)
Weyl_n = {Alt = 0, Ricci = 0}.
"""
import numpy as np, functools


@functools.lru_cache(maxsize=None)
def pairs_of(n):
    P = np.array([(i, j) for i in range(n) for j in range(i + 1, n)], dtype=int)
    idx = -np.ones((n, n), dtype=int)
    sgn = np.zeros((n, n))
    for a, (i, j) in enumerate(P):
        idx[i, j] = idx[j, i] = a
        sgn[i, j] = 1.0
        sgn[j, i] = -1.0
    return P, idx, sgn


@functools.lru_cache(maxsize=None)
def struct(n):
    """c[a,b,g], totally antisymmetric."""
    P, idx, sgn = pairs_of(n)
    N = len(P)
    phi = np.zeros((N, n, n))
    for a, (i, j) in enumerate(P):
        phi[a, i, j] = 1.0
        phi[a, j, i] = -1.0
    c = np.zeros((N, N, N))
    for a in range(N):
        comm = phi[a] @ phi - phi @ phi[a]
        c[a] = 0.5 * np.einsum('bij,gij->bg', comm, phi)
    return c


def adjA(n):
    return struct(n)


def sharp(n, W):
    A = adjA(n); N = A.shape[0]
    M = (A.reshape(N * N, N) @ W).reshape(N, N, N)      # M[a] = A_a W
    return -0.5 * (M.reshape(N, N * N) @ M.transpose(0, 2, 1).reshape(N, N * N).T)


def sharp_bilin(n, X, Y):
    A = adjA(n); N = A.shape[0]
    AX = (A.reshape(N * N, N) @ X).reshape(N, N, N)
    AY = (A.reshape(N * N, N) @ Y).reshape(N, N, N)
    T = AX.reshape(N, N * N) @ AY.transpose(0, 2, 1).reshape(N, N * N).T
    return -0.25 * (T + T.T)


def Qop(n, W):
    return W @ W + sharp(n, W)


def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(n, X, Y)


def Pval(n, W):
    return float(np.tensordot(W, Qop(n, W)))


# ---------- tensor <-> matrix ----------

def to_tensor(n, M):
    P, idx, sgn = pairs_of(n)
    S = sgn[:, :, None, None] * sgn[None, None, :, :]
    I = np.clip(idx, 0, None)
    T = M[I[:, :, None, None], I[None, None, :, :]] * S
    return T


def from_tensor(n, T):
    P, idx, sgn = pairs_of(n)
    I, J = P[:, 0], P[:, 1]
    return T[I[:, None], J[:, None], I[None, :], J[None, :]]


def alt_part(n, M):
    """Orthogonal projection onto the Lambda^4 (Bianchi) component."""
    T = to_tensor(n, M)
    B = (T + T.transpose(0, 2, 3, 1) + T.transpose(0, 3, 1, 2)) / 3.0
    return from_tensor(n, B)


def ricci_of(n, M):
    T = to_tensor(n, M)
    R = np.einsum('ikjk->ij', T)
    return 0.5 * (R + R.T)


def KN(n, h):
    """KN(h)[(i,j),(k,l)] = 1/2 ( h_ik d_jl - h_il d_jk - h_jk d_il + h_jl d_ik )."""
    P, idx, sgn = pairs_of(n)
    I, J = P[:, 0], P[:, 1]
    dII = (I[:, None] == I[None, :]).astype(float)
    dJJ = (J[:, None] == J[None, :]).astype(float)
    dIJ = (I[:, None] == J[None, :]).astype(float)
    dJI = (J[:, None] == I[None, :]).astype(float)
    return 0.5 * (h[np.ix_(I, I)] * dJJ - h[np.ix_(I, J)] * dJI
                  - h[np.ix_(J, I)] * dIJ + h[np.ix_(J, J)] * dII)


def weyl_project(n, X, alpha=None, beta=None):
    """Basis-free orthogonal projection onto Weyl_n (my own vectorised build)."""
    if alpha is None: alpha = 2.0 / (n - 2)
    if beta is None: beta = 1.0 / (n * (n - 1))
    Y = X - alt_part(n, X)
    R = ricci_of(n, Y)
    s = float(np.trace(R))
    rho0 = R - (s / n) * np.eye(n)
    return Y - alpha * KN(n, rho0) - beta * s * KN(n, np.eye(n))


# ---------- basis route ----------

def weyl_constraint_matrix(n):
    """Rows spanning Weyl_n^perp inside Sym^2(Lambda^2), as flattened N*N vectors."""
    P, idx, sgn = pairs_of(n)
    N = len(P)
    rows = []
    # Lambda^4 generators: Alt of elementary symmetric matrices
    import itertools
    for quad in itertools.combinations(range(n), 4):
        i, j, k, l = quad
        M = np.zeros((N, N))
        for (a, b) in (((i, j), (k, l)), ((i, k), (l, j)), ((i, l), (j, k))):
            ra, rb = idx[a[0], a[1]], idx[b[0], b[1]]
            sa, sb = sgn[a[0], a[1]], sgn[b[0], b[1]]
            M[ra, rb] += sa * sb
            M[rb, ra] += sa * sb
        rows.append(M.ravel())
    # Ricci generators: gradient of Ric_{pq}
    for p in range(n):
        for q in range(p, n):
            M = np.zeros((N, N))
            for k in range(n):
                if k == p or k == q:
                    continue
                a, b = idx[p, k], idx[q, k]
                s = sgn[p, k] * sgn[q, k]
                M[a, b] += s
                M[b, a] += s
            rows.append(M.ravel())
    return np.array(rows)


@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal basis of Weyl_n as (d, N, N).  Sym^2 coordinates handled by
    scatter/gather so the (D, N*N) matrix is never materialised."""
    P, idx, sgn = pairs_of(n)
    N = len(P)
    di, dj = np.triu_indices(N, 1)
    D = N + len(di)
    C = weyl_constraint_matrix(n).reshape(-1, N, N)     # (r, N, N), symmetric
    Mat = np.empty((C.shape[0], D))
    Mat[:, :N] = C[:, np.arange(N), np.arange(N)]
    Mat[:, N:] = np.sqrt(2.0) * C[:, di, dj]
    u, sv, vt = np.linalg.svd(Mat, full_matrices=True)
    tol = max(Mat.shape) * (sv[0] if sv.size else 1.0) * 1e-12
    rank = int((sv > tol).sum())
    ns = vt[rank:]                                       # (d, D)
    d = ns.shape[0]
    B = np.zeros((d, N, N))
    B[:, np.arange(N), np.arange(N)] = ns[:, :N]
    off = ns[:, N:] / np.sqrt(2.0)
    B[:, di, dj] = off
    B[:, dj, di] = off
    return B


def basis_project(n, X):
    B = weyl_basis(n)
    co = np.tensordot(B, X, axes=([1, 2], [0, 1]))
    return np.tensordot(co, B, axes=(0, 0))


def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


# ---------- points ----------

def sphere_product_W(blocks, n=None):
    m = sum(blocks)
    if n is None: n = m
    P, idx, sgn = pairs_of(n)
    lab = []
    for bi, b in enumerate(blocks):
        lab += [bi] * b
    lab += [-1] * (n - m)
    N = len(P)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(P):
        if lab[i] < 0 or lab[j] < 0:
            continue
        if lab[i] == lab[j]:
            p = blocks[lab[i]]
            W[a, a] = 1.0 / (p * (p - 1))
        else:
            p, q = blocks[lab[i]], blocks[lab[j]]
            W[a, a] = -1.0 / (p * q)
    return W


def normalize(W):
    return W / np.sqrt(float(np.tensordot(W, W)))


def orbit_tangent(n, W):
    A = adjA(n)
    return A @ W - W @ A


def onb_rows(V, tol=1e-9):
    F = V.reshape(V.shape[0], -1)
    u, s, vt = np.linalg.svd(F, full_matrices=False)
    r = int((s > tol * max(1.0, s[0])).sum())
    return vt[:r]


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n
