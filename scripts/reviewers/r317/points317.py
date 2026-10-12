"""Reviewer 317: independent constructions of the named curvature operators."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib317 as L


def op_from_tensor(R, n):
    pairs, idx, sgn = L.pair_index(n)
    N = len(pairs)
    M = np.zeros((N, N))
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            M[a, b] = R[i, j, k, l]
    return M


def weyl_from_curv(M):
    N = M.shape[0]
    return M - (np.trace(M) / N) * np.eye(N)


def sphere_product(k, l):
    """S^k x S^l, Einstein constant 1/2 on each factor."""
    n = k + l
    R = np.zeros((n, n, n, n))
    def add(block, kap):
        for i in block:
            for j in block:
                for p in block:
                    for q in block:
                        R[i, j, p, q] += kap * (
                            (i == p) * (j == q) - (i == q) * (j == p))
    if k >= 2:
        add(range(k), 1.0 / (2 * (k - 1)))
    if l >= 2:
        add(range(k, n), 1.0 / (2 * (l - 1)))
    return weyl_from_curv(op_from_tensor(R, n)), n


def cpm(m):
    """Fubini-Study curvature operator on CP^m, real dim n=2m."""
    n = 2 * m
    J = np.zeros((n, n))
    for a in range(m):
        J[2 * a, 2 * a + 1] = 1.0
        J[2 * a + 1, 2 * a] = -1.0
    g = np.eye(n)
    R = np.zeros((n, n, n, n))
    for i in range(n):
        for j in range(n):
            for p in range(n):
                for q in range(n):
                    R[i, j, p, q] = (
                        g[i, p] * g[j, q] - g[i, q] * g[j, p]
                        + np.dot(J[i], g[:, p]) * np.dot(J[j], g[:, q])
                        - np.dot(J[i], g[:, q]) * np.dot(J[j], g[:, p])
                        + 2 * np.dot(g[i], J[:, j]) * np.dot(J[p], g[:, q]))
    return weyl_from_curv(op_from_tensor(R, n)), n


def pad(M, n_small, n_big):
    """Embed an operator on Lambda^2(R^{n_small}) into Lambda^2(R^{n_big})."""
    ps, idxs, _ = L.pair_index(n_small)
    pb, idxb, _ = L.pair_index(n_big)
    Nb = len(pb)
    out = np.zeros((Nb, Nb))
    for a, (i, j) in enumerate(ps):
        for b, (k, l) in enumerate(ps):
            out[idxb[i, j], idxb[k, l]] = M[a, b]
    return out
