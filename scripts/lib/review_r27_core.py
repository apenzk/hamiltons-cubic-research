"""Reviewer 27: independent implementation, built only from the definitions.

Basis of Lambda^2 R^n: phi_{ij} = E_ij - E_ji for i<j, inner product <X,Y> = (1/2) tr(X^T Y).
That makes {phi_{ij}} orthonormal.  N = n(n-1)/2.
c_{abg} = <[phi_a,phi_b],phi_g>;  (A_a)_{mn} = c_{amn}.
(W#)_{ab} = -(1/2) tr(A_a W A_b W);  Q(W) = W^2 + W#;  P(W) = <W,Q(W)> = tr(W Q(W)).
"""
import numpy as np
from itertools import combinations

_cache = {}


def pairs(n):
    return list(combinations(range(n), 2))


def struct(n):
    """Return (pairs, index map, c tensor) for so(n)."""
    if ('c', n) in _cache:
        return _cache[('c', n)]
    pr = pairs(n)
    N = len(pr)
    idx = {p: k for k, p in enumerate(pr)}
    # phi_a as n x n matrices
    phi = np.zeros((N, n, n))
    for a, (i, j) in enumerate(pr):
        phi[a, i, j] = 1.0
        phi[a, j, i] = -1.0
    # c[a,b,g] = <[phi_a,phi_b],phi_g> = (1/2) tr( [pa,pb]^T pg )
    comm = np.einsum('aij,bjk->abik', phi, phi) - np.einsum('bij,ajk->abik', phi, phi)
    c = 0.5 * np.einsum('abij,gij->abg', comm, phi)
    _cache[('c', n)] = (pr, idx, c)
    return pr, idx, c


def Aops(n):
    """A_a with (A_a)_{mn} = c_{a m n}."""
    if ('A', n) in _cache:
        return _cache[('A', n)]
    pr, idx, c = struct(n)
    A = np.ascontiguousarray(c)          # A[a][m][n] = c[a,m,n]
    _cache[('A', n)] = A
    return A


def sharp_bilinear(n, X, Y):
    """Polarized #: returns S with S(X,X) = X#.  S(X,Y)_{ab} = -(1/2) tr(A_a X A_b Y), symmetrized."""
    A = Aops(n)
    N = A.shape[0]
    U = A.reshape(N * N, N) @ X          # U[a,i,j] = (A_a X)_{ij}
    U = U.reshape(N, N, N)
    V = A.reshape(N * N, N) @ Y
    V = V.reshape(N, N, N)
    # tr(U_a V_b) = sum_{ij} U[a,i,j] V[b,j,i]
    M = U.reshape(N, N * N) @ np.transpose(V, (0, 2, 1)).reshape(N, N * N).T
    M = -0.5 * M
    return 0.5 * (M + M.T)


def sharp(n, W):
    return sharp_bilinear(n, W, W)


def Q(n, W):
    return W @ W + sharp(n, W)


def circ(n, X, Y):
    """X o Y = (1/2)(Q(X+Y)-Q(X)-Q(Y)) = (1/2)(XY+YX) + sharp_bilinear(X,Y)."""
    return 0.5 * (X @ Y + Y @ X) + sharp_bilinear(n, X, Y)


def P(n, W):
    return float(np.trace(W @ Q(n, W)))


# ---------------------------------------------------------------- Weyl space
def R_of(W, idx, i, j, k, l):
    if i == j or k == l:
        return 0.0
    si = 1.0
    if i > j:
        i, j, si = j, i, -si
    sk = 1.0
    if k > l:
        k, l, sk = l, k, -sk
    return si * sk * W[idx[(i, j)], idx[(k, l)]]


def weyl_constraints(n):
    """Rows of a linear system on scaled-sym-vec(W) enforcing Bianchi and Ric = 0.

    Vectorization: v[t] for t indexing (a<=b);  v[(a,a)] = W[a,a], v[(a,b)] = sqrt(2) W[a,b].
    Then the euclidean inner product on v equals the Frobenius product tr(X Y).
    """
    if ('con', n) in _cache:
        return _cache[('con', n)]
    pr, idx, c = struct(n)
    N = len(pr)
    tidx = {}
    t = 0
    for a in range(N):
        for b in range(a, N):
            tidx[(a, b)] = t
            t += 1
    T = t
    rows = []

    def put(row, a, b, val):
        if a > b:
            a, b = b, a
        row[tidx[(a, b)]] += val * (1.0 if a == b else 1.0 / np.sqrt(2.0))

    def addR(row, i, j, k, l, coef):
        if i == j or k == l:
            return
        s = 1.0
        if i > j:
            i, j, s = j, i, -s
        if k > l:
            k, l, s = l, k, -s
        put(row, idx[(i, j)], idx[(k, l)], coef * s)

    # first Bianchi:  R_ijkl + R_iklj + R_iljk = 0 for i<j<k<l
    for (i, j, k, l) in combinations(range(n), 4):
        row = np.zeros(T)
        addR(row, i, j, k, l, 1.0)
        addR(row, i, k, l, j, 1.0)
        addR(row, i, l, j, k, 1.0)
        rows.append(row)
    # Ricci: Ric_ik = sum_j R_ijkj = 0
    for i in range(n):
        for k in range(i, n):
            row = np.zeros(T)
            for jj in range(n):
                addR(row, i, jj, k, jj, 1.0)
            rows.append(row)
    Cm = np.array(rows)
    _cache[('con', n)] = (Cm, tidx, T)
    return Cm, tidx, T


def vec_scaled(W, tidx, T):
    v = np.zeros(T)
    r2 = np.sqrt(2.0)
    for (a, b), t in tidx.items():
        v[t] = W[a, b] if a == b else r2 * W[a, b]
    return v


def unvec_scaled(v, tidx, N):
    W = np.zeros((N, N))
    r2 = np.sqrt(2.0)
    for (a, b), t in tidx.items():
        if a == b:
            W[a, a] = v[t]
        else:
            W[a, b] = W[b, a] = v[t] / r2
    return W


def weyl_basis(n):
    """Orthonormal (w.r.t. tr(XY)) basis of the Weyl space, as an array (dimW, N, N)."""
    if ('wb', n) in _cache:
        return _cache[('wb', n)]
    Cm, tidx, T = weyl_constraints(n)
    N = len(pairs(n))
    # null space of Cm
    u, s, vt = np.linalg.svd(Cm, full_matrices=True)
    rank = int((s > 1e-9 * s.max()).sum())
    Ns = vt[rank:]                       # (T-rank, T) orthonormal rows
    B = np.array([unvec_scaled(row, tidx, N) for row in Ns])
    _cache[('wb', n)] = B
    return B


def weyl_dim(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


def proj_weyl(n, W):
    B = weyl_basis(n)
    co = np.einsum('kab,ab->k', B, W)
    return np.einsum('k,kab->ab', co, B)


def ricci(W, n, idx):
    Ric = np.zeros((n, n))
    for i in range(n):
        for k in range(n):
            Ric[i, k] = sum(R_of(W, idx, i, j, k, j) for j in range(n))
    return Ric


def alt_norm(W, n, idx):
    tot = 0.0
    for (i, j, k, l) in combinations(range(n), 4):
        b = R_of(W, idx, i, j, k, l) + R_of(W, idx, i, k, l, j) + R_of(W, idx, i, l, j, k)
        tot += b * b
    return np.sqrt(tot)


# ---------------------------------------------------------------- diagnostics
def crit_residual(n, W):
    QW = Q(n, W)
    th = float(np.trace(W @ QW)) / float(np.trace(W @ W))
    return np.linalg.norm(QW - th * W), th


def slack(n, W, theta):
    """S = ||Ric(W_-)||^2 + 6 delta^2 - theta tr(W_-) - tr(W_-^2), W_- the negative part."""
    pr, idx, c = struct(n)
    ev, U = np.linalg.eigh(W)
    neg = np.where(ev < -1e-10)[0]
    Wm = (U[:, neg] * ev[neg]) @ U[:, neg].T
    Ric = ricci(Wm, n, idx)
    d2 = alt_norm(Wm, n, idx) ** 2 / 12.0      # placeholder; see slack_def below
    return Ric, Wm, d2
