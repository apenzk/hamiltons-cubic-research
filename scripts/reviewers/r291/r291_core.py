"""Reviewer 291: independent machinery, built from the definitions only.

phi_{ij} = E_ij - E_ji for i<j, <X,Y> = 1/2 tr(X^T Y), so {phi_a} is orthonormal.
c_{abg} = <[phi_a,phi_b],phi_g>.
g_d = sum_{a,b} c_{dab}^2 (lam_a-lam_b)^2 in an eigenbasis of W.
Delta = sum over the STRICTLY positive eigenspace of g;  S_mmm = sum_{a,b,c in m} c_abc^2.
"""
import itertools
import numpy as np


def pairs_of(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def phi_mats(n):
    P = np.zeros((len(pairs_of(n)), n, n))
    for a, (i, j) in enumerate(pairs_of(n)):
        P[a, i, j] = 1.0
        P[a, j, i] = -1.0
    return P


def cconst(n):
    """c[a,b,g] from the definition, no imports from the file under review."""
    P = phi_mats(n)
    N = P.shape[0]
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            comm = P[a] @ P[b] - P[b] @ P[a]
            for g in range(N):
                c[a, b, g] = 0.5 * np.trace(comm.T @ P[g])
    return c


def defect_mine(n, W, tol=1e-9):
    """(Delta, total, S_mmm) from the definition, via an explicit eigenbasis."""
    W = W / np.sqrt(np.sum(W * W))
    lam, V = np.linalg.eigh(W)
    c = cconst(n)
    # rotate the structure tensor into the eigenbasis: cE[a,b,g] = sum c[p,q,r] V[p,a]V[q,b]V[r,g]
    cE = np.einsum('pqr,pa,qb,rg->abg', c, V, V, V)
    T = cE ** 2
    g = np.einsum('dab,ab->d', T, (lam[:, None] - lam[None, :]) ** 2)
    m, p = lam < -tol, lam > tol
    return float(g[p].sum()), float(g.sum()), float(T[np.ix_(m, m, m)].sum()), g, lam


def M_to_W(M):
    n = M.shape[0]
    return np.diag(np.array([M[i, j] for (i, j) in pairs_of(n)]))


def locus_basis(n):
    """orthonormal basis of {M symmetric, zero diag, zero row sums} in pair coords."""
    prs = pairs_of(n)
    N = len(prs)
    A = np.zeros((n, N))
    for a, (i, j) in enumerate(prs):
        A[i, a] = 1.0
        A[j, a] = 1.0
    u, s, vt = np.linalg.svd(A)
    r = int((s > 1e-10).sum())
    return vt[r:]                        # (N-r, N) rows span the null space


def rand_M(n, rng, basis=None):
    prs = pairs_of(n)
    B = locus_basis(n) if basis is None else basis
    v = rng.normal(size=B.shape[0]) @ B
    v = v / np.linalg.norm(v)
    M = np.zeros((n, n))
    for a, (i, j) in enumerate(prs):
        M[i, j] = M[j, i] = v[a]
    return M


def vec_to_M(n, v):
    M = np.zeros((n, n))
    for a, (i, j) in enumerate(pairs_of(n)):
        M[i, j] = M[j, i] = v[a]
    return M


def g_formula(M):
    """C1: g_ab = 2 sum_{d != a,b} (M[a,d]-M[b,d])^2, returned in pair order."""
    n = M.shape[0]
    out = []
    for (a, b) in pairs_of(n):
        out.append(2.0 * sum((M[a, d] - M[b, d]) ** 2
                             for d in range(n) if d != a and d != b))
    return np.array(out)


def tri_count(G):
    """number of triangles of a boolean adjacency matrix."""
    n = G.shape[0]
    return sum(1 for (i, j, k) in itertools.combinations(range(n), 3)
               if G[i, j] and G[j, k] and G[i, k])


import functools

@functools.lru_cache(maxsize=None)
def _c_cached(n):
    return cconst(n)


def defect_diag(n, M, tol=1e-9):
    """Delta, total, S_mmm for a COORDINATE-DIAGONAL W = diag(M), from the definition.

    The coordinate bivectors ARE an eigenbasis of such a W, so g_d = sum_ab c_dab^2
    (lam_a-lam_b)^2 evaluated in that basis is the definition, with no rotation needed.
    """
    prs = pairs_of(n)
    lam = np.array([M[i, j] for (i, j) in prs])
    nrm = np.sqrt((lam ** 2).sum())
    lam = lam / nrm
    c = _c_cached(n)
    T = c ** 2
    g = np.einsum('dab,ab->d', T, (lam[:, None] - lam[None, :]) ** 2)
    m, p = lam < -tol, lam > tol
    return float(g[p].sum()), float(g.sum()), float(T[np.ix_(m, m, m)].sum()), g, lam


def theta_diag(M):
    """theta = P(W)/||W||^3 for W = diag(M), from P = <W, W^2 + W^#>."""
    n = M.shape[0]
    nrm = np.sqrt(0.5 * np.sum(M * M))
    Mn = M / nrm
    return float(0.5 * (np.sum(Mn ** 3) + np.trace(Mn @ Mn @ Mn)))
