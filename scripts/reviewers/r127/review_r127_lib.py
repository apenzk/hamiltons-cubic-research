"""Reviewer 127: independent machinery.  Written from scratch.

Conventions
  Lambda^2 basis  b_{ij} = e_i ^ e_j, i<j, orthonormal.
  so(n) model     A_{ij} has entry +1 at (j,i) and -1 at (i,j).
  M_{(ij)(kl)}    = R_{ijkl}
  R#_{ab}         = (1/2) c_{a g d} c_{b m n} R_{g m} R_{d n}
  Q(M)            = M M + M#
"""
import itertools
import numpy as np


def pairs_of(n):
    return list(itertools.combinations(range(n), 2))


def struct(n):
    """c[a,b,g] = <[A_a, A_b], A_g>, totally antisymmetric, entries in {0,+-1}."""
    prs = pairs_of(n)
    N = len(prs)
    A = np.zeros((N, n, n))
    for a, (i, j) in enumerate(prs):
        A[a, j, i] = 1.0
        A[a, i, j] = -1.0
    C = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            br = A[a] @ A[b] - A[b] @ A[a]
            C[a, b] = np.array([br[j, i] for (i, j) in prs])
    return C, prs


_CACHE = {}


def get_struct(n):
    if n not in _CACHE:
        _CACHE[n] = struct(n)
    return _CACHE[n]


def sharp(M, n):
    C, _ = get_struct(n)
    return 0.5 * np.einsum('agd,bmn,gm,dn->ab', C, C, M, M, optimize=True)


def Q(M, n):
    return M @ M + sharp(M, n)


def mop_from_tensor(R, n):
    prs = pairs_of(n)
    N = len(prs)
    M = np.zeros((N, N))
    for a, (i, j) in enumerate(prs):
        for b, (k, l) in enumerate(prs):
            M[a, b] = R[i, j, k, l]
    return M


def tensor_from_mop(M, n):
    prs = pairs_of(n)
    R = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(prs):
        for b, (k, l) in enumerate(prs):
            v = M[a, b]
            for (p, q, s) in [((i, j), (k, l), 1), ((j, i), (k, l), -1),
                              ((i, j), (l, k), -1), ((j, i), (l, k), 1)]:
                R[p[0], p[1], q[0], q[1]] = s * v
    return R


def kn(A, B):
    """Kulkarni-Nomizu product."""
    return (np.einsum('ac,bd->abcd', A, B) + np.einsum('bd,ac->abcd', A, B)
            - np.einsum('ad,bc->abcd', A, B) - np.einsum('bc,ad->abcd', A, B))


def weyl_part(R, n):
    g = np.eye(n)
    Ric = np.einsum('abad->bd', R)
    S = np.trace(Ric)
    E = Ric - (S / n) * g
    return R - (1.0 / (n - 2)) * kn(E, g) - (S / (2.0 * n * (n - 1))) * kn(g, g)


def traces(R, n):
    Ric = np.einsum('abad->bd', R)
    return np.abs(Ric).max()


def vertex(M, n):
    prs = pairs_of(n)
    K = np.zeros((n, n))
    for a, (i, j) in enumerate(prs):
        K[i, j] = K[j, i] = M[a, a]
    return K


def normalise(M):
    return M / np.linalg.norm(M, 'fro')
