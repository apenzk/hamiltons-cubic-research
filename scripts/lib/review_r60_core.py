"""Reviewer 60, independent core: so(m) basis, Weyl_m constraints, ad, N_v.

Written from the stated conventions only; imports nothing from the code under review.
"""
import numpy as np
import itertools


def pairs(m):
    return [(i, j) for i in range(m) for j in range(i + 1, m)]


def phi(m, i, j):
    A = np.zeros((m, m))
    A[i, j] = 1.0
    A[j, i] = -1.0
    return A


def basis(m):
    return [phi(m, i, j) for (i, j) in pairs(m)]


def ip(X, Y):
    return 0.5 * np.trace(X.T @ Y)


def mat_to_vec(m, X):
    """coords of skew X in the orthonormal basis phi_{ij}"""
    return np.array([X[i, j] for (i, j) in pairs(m)])


def vec_to_mat(m, v):
    X = np.zeros((m, m))
    for a, (i, j) in enumerate(pairs(m)):
        X[i, j] = v[a]
        X[j, i] = -v[a]
    return X


def ad_matrices(m):
    """C_g = matrix of ad(phi_g) in the orthonormal basis, (C_g)[h,k] = <[phi_g,phi_k],phi_h>."""
    B = basis(m)
    D = len(B)
    C = np.zeros((D, D, D))
    for g in range(D):
        for k in range(D):
            br = B[g] @ B[k] - B[k] @ B[g]
            C[g][:, k] = mat_to_vec(m, br)
    return C


def ad_of(m, v):
    """ad(V) as a D x D matrix, V a skew matrix."""
    B = basis(m)
    D = len(B)
    A = np.zeros((D, D))
    for k in range(D):
        A[:, k] = mat_to_vec(m, v @ B[k] - B[k] @ v)
    return A


def comp(m, W):
    """W_{ijkl} from the D x D operator matrix"""
    idx = {p: a for a, p in enumerate(pairs(m))}

    def g(i, j, k, l):
        if i == j or k == l:
            return 0.0
        si = 1.0
        if i > j:
            i, j, si = j, i, -si
        if k > l:
            k, l, si = l, k, -si
        return si * W[idx[(i, j)], idx[(k, l)]]
    return g


def weyl_constraints(m):
    """rows of a linear system on vech(W) (symmetric D x D) encoding Ricci-flat + Bianchi."""
    P = pairs(m)
    D = len(P)
    idx = {p: a for a, p in enumerate(P)}
    # parameterize symmetric W by upper triangle including diagonal
    sym = [(a, b) for a in range(D) for b in range(a, D)]
    sidx = {s: t for t, s in enumerate(sym)}
    n = len(sym)

    def add(row, i, j, k, l, c):
        if i == j or k == l:
            return
        s = c
        if i > j:
            i, j, s = j, i, -s
        if k > l:
            k, l, s = l, k, -s
        a, b = idx[(i, j)], idx[(k, l)]
        if a > b:
            a, b = b, a
        row[sidx[(a, b)]] += s

    rows = []
    # Ricci
    for i in range(m):
        for k in range(i, m):
            row = np.zeros(n)
            for j in range(m):
                add(row, i, j, k, j, 1.0)
            if np.any(row):
                rows.append(row)
    # first Bianchi
    for (i, j, k, l) in itertools.combinations(range(m), 4):
        for (a, b, c, d) in [(i, j, k, l), (i, j, l, k), (i, k, j, l), (j, k, l, i),
                             (i, l, j, k), (j, l, k, i), (k, l, i, j), (j, i, k, l)]:
            row = np.zeros(n)
            add(row, a, b, c, d, 1.0)
            add(row, a, c, d, b, 1.0)
            add(row, a, d, b, c, 1.0)
            if np.any(row):
                rows.append(row)
    return np.array(rows), sym


def weyl_basis(m, tol=1e-10):
    """orthonormal basis of Weyl_m as a list of D x D symmetric matrices."""
    A, sym = weyl_constraints(m)
    P = pairs(m)
    D = len(P)
    u, s, vt = np.linalg.svd(A)
    ns = vt[np.sum(s > tol * max(1, s[0]) if len(s) else 0):] if len(s) else np.eye(A.shape[1])
    r = int(np.sum(s > tol * s[0])) if len(s) else 0
    ns = vt[r:]
    out = []
    for row in ns:
        M = np.zeros((D, D))
        for t, (a, b) in enumerate(sym):
            M[a, b] += row[t]
            M[b, a] = M[a, b]
        out.append(M)
    # Gram-Schmidt in the Frobenius inner product
    B = []
    for M in out:
        for X in B:
            M = M - np.sum(M * X) * X
        nrm = np.linalg.norm(M)
        if nrm > 1e-8:
            B.append(M / nrm)
    return B


def is_weyl(m, W, tol=1e-9):
    g = comp(m, W)
    ric = max(abs(sum(g(i, j, k, j) for j in range(m))) for i in range(m) for k in range(m))
    bia = 0.0
    for (i, j, k, l) in itertools.permutations(range(m), 4):
        bia = max(bia, abs(g(i, j, k, l) + g(i, k, l, j) + g(i, l, j, k)))
    symerr = np.abs(W - W.T).max()
    return ric, bia, symerr


def N_of(m, v):
    """N_v = 2 v (x) v - ad(v)^2, v given as a skew matrix (vector form used for the outer product)."""
    vv = mat_to_vec(m, v)
    A = ad_of(m, v)
    return 2 * np.outer(vv, vv) - A @ A
