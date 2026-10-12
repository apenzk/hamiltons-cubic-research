"""Reviewer 27: independent constructions of the critical points under audit."""
import numpy as np
from itertools import combinations
import review_r27_core as C


# ---------------------------------------------------------------- subalgebras
def proj_from_gens(n, gens):
    """Orthogonal projector (in the phi basis) onto span{gens}, gens = n x n antisymmetric."""
    pr, idx, c = C.struct(n)
    N = len(pr)
    V = np.zeros((len(gens), N))
    for g, X in enumerate(gens):
        for a, (i, j) in enumerate(pr):
            V[g, a] = X[i, j]
    Qm, R = np.linalg.qr(V.T)
    r = int((np.abs(np.diag(R)) > 1e-9).sum())
    Qm = Qm[:, :r]
    return Qm @ Qm.T, r


def W_subalgebra(n, gens):
    Pi, r = proj_from_gens(n, gens)
    N = Pi.shape[0]
    W = Pi - (r / N) * np.eye(N)
    W = W / np.sqrt(np.trace(W @ W))
    return W, r, Pi


def gens_so_direct_sum(n, blocks):
    """so(b1) + so(b2) + ... embedded blockwise in so(n)."""
    gens = []
    off = 0
    for b in blocks:
        for (i, j) in combinations(range(b), 2):
            X = np.zeros((n, n))
            X[off + i, off + j] = 1.0
            X[off + j, off + i] = -1.0
            gens.append(X)
        off += b
    return gens


def su3_f():
    """Gell-Mann structure constants f_abc, built from lambda matrices."""
    l = np.zeros((8, 3, 3), dtype=complex)
    l[0] = [[0, 1, 0], [1, 0, 0], [0, 0, 0]]
    l[1] = [[0, -1j, 0], [1j, 0, 0], [0, 0, 0]]
    l[2] = [[1, 0, 0], [0, -1, 0], [0, 0, 0]]
    l[3] = [[0, 0, 1], [0, 0, 0], [1, 0, 0]]
    l[4] = [[0, 0, -1j], [0, 0, 0], [1j, 0, 0]]
    l[5] = [[0, 0, 0], [0, 0, 1], [0, 1, 0]]
    l[6] = [[0, 0, 0], [0, 0, -1j], [0, 1j, 0]]
    l[7] = np.array([[1, 0, 0], [0, 1, 0], [0, 0, -2]]) / np.sqrt(3)
    T = l / 2.0
    f = np.zeros((8, 8, 8))
    d = np.zeros((8, 8, 8))
    for a in range(8):
        for b in range(8):
            comm = T[a] @ T[b] - T[b] @ T[a]
            anti = T[a] @ T[b] + T[b] @ T[a]
            for cc in range(8):
                f[a, b, cc] = np.real(-2j * np.trace(comm @ T[cc]))
                d[a, b, cc] = np.real(2 * np.trace(anti @ T[cc]))
    return f, d, T


def gens_su3_adjoint():
    """su(3) acting on its own 8-dim real adjoint space -> 8 antisymmetric 8x8 matrices."""
    f, d, T = su3_f()
    gens = [f[a] for a in range(8)]     # (M_a)_{bc} = f_abc, antisymmetric in b,c
    return gens, f, d


def gens_so_adjoint(m):
    """so(m) acting on Lambda^2 R^m (dim N=m(m-1)/2) -> N x N antisymmetric matrices."""
    A = C.Aops(m)
    return [A[a] for a in range(A.shape[0])]


def gens_so3_in_so5():
    """so(3) on traceless symmetric 3x3 (dim 5)."""
    basis = []
    b = np.zeros((3, 3)); b[0, 1] = b[1, 0] = 1 / np.sqrt(2); basis.append(b)
    b = np.zeros((3, 3)); b[0, 2] = b[2, 0] = 1 / np.sqrt(2); basis.append(b)
    b = np.zeros((3, 3)); b[1, 2] = b[2, 1] = 1 / np.sqrt(2); basis.append(b)
    b = np.diag([1, -1, 0]) / np.sqrt(2); basis.append(b)
    b = np.diag([1, 1, -2]) / np.sqrt(6); basis.append(b)
    basis = np.array(basis)
    gens = []
    for (i, j) in combinations(range(3), 2):
        X = np.zeros((3, 3)); X[i, j] = 1; X[j, i] = -1
        M = np.zeros((5, 5))
        for p in range(5):
            im = X @ basis[p] - basis[p] @ X
            for q in range(5):
                M[q, p] = np.trace(im @ basis[q])
        gens.append(M)
    return gens


# ---------------------------------------------------------------- diagonal / sphere products
def diag_operator(n, w):
    """w: hollow symmetric n x n; returns the Lambda^2 operator diagonal in coordinate 2-planes."""
    pr, idx, c = C.struct(n)
    N = len(pr)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(pr):
        W[a, a] = w[i, j]
    return W


def weyl_part_diag(n, w):
    """Orthogonal projection of a hollow symmetric w onto the zero-row-sum subspace."""
    s = w.sum(axis=1)
    U = s.sum() / (2 * n - 2)
    u = (s - U) / (n - 2)
    out = w.copy()
    for i in range(n):
        for j in range(n):
            if i != j:
                out[i, j] -= (u[i] + u[j])
    np.fill_diagonal(out, 0.0)
    return out


def multiblock(n, blocks, vals=None):
    """Product of round spheres with block sizes `blocks`; vals = per-block curvature.
    Returns the normalized Weyl operator."""
    assert sum(blocks) == n
    k = len(blocks)
    if vals is None:
        vals = np.ones(k)
    lab = np.concatenate([[b] * blocks[b] for b in range(k)]).astype(int)
    w = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            if i != j and lab[i] == lab[j]:
                w[i, j] = vals[lab[i]]
    w = weyl_part_diag(n, w)
    W = diag_operator(n, w)
    return W / np.sqrt(np.trace(W @ W)), lab


def solve_multiblock(n, blocks):
    """Find per-block values making the multi-block Weyl operator exactly critical."""
    from scipy.optimize import least_squares
    k = len(blocks)

    def resid(v):
        vv = np.concatenate([[1.0], v])
        W, lab = multiblock(n, blocks, vv)
        QW = C.Q(n, W)
        th = np.trace(W @ QW)
        return (QW - th * W)[np.triu_indices(W.shape[0])]

    if k == 1:
        v0 = np.array([])
    else:
        v0 = np.ones(k - 1)
    sol = least_squares(resid, v0, xtol=1e-15, ftol=1e-15, gtol=1e-15)
    vv = np.concatenate([[1.0], sol.x])
    W, lab = multiblock(n, blocks, vv)
    return W, lab, np.linalg.norm(sol.fun)
