"""Reviewer 63 -- independent re-implementation of the so(m) / Weyl / theta machinery.

Written from the conventions in the audit brief only; imports nothing from the repo.
Conventions: Lambda^2 R^m = so(m), phi_{ij} = E_ij - E_ji (i<j), <X,Y> = (1/2) tr(X^T Y).
"""
import itertools
import numpy as np


def basis(m):
    """Orthonormal basis phi_{ij} of so(m) under <X,Y> = 1/2 tr(X^T Y)."""
    pairs = list(itertools.combinations(range(m), 2))
    B = np.zeros((len(pairs), m, m))
    for a, (i, j) in enumerate(pairs):
        B[a, i, j] = 1.0
        B[a, j, i] = -1.0
    return pairs, B


def ip(X, Y):
    return 0.5 * np.tensordot(X, Y, axes=([-2, -1], [-2, -1]))


def structure_constants(m):
    """c[A,B,C] = <[phi_A, phi_B], phi_C>."""
    pairs, B = basis(m)
    N = len(pairs)
    comm = np.einsum('aij,bjk->abik', B, B) - np.einsum('bij,ajk->abik', B, B)
    c = 0.5 * np.einsum('abij,cij->abc', comm, B)
    return c, pairs, B


def sharp(W, c):
    """Hamilton's #: (R^#)_{AB} = 1/2 c_{ACE} c_{BDF} R_{CD} R_{EF}."""
    M = np.einsum('ace,cd->ade', c, W)          # ade
    return 0.5 * np.einsum('ade,bde->ab', M, np.einsum('bdf,ef->bde', c, W))


def theta(W, c):
    return ip_mat(W, W @ W + sharp(W, c))


def ip_mat(A, B):
    """Frobenius inner product on operators on Lambda^2 (basis is orthonormal)."""
    return float(np.sum(A * B))


# ---------------------------------------------------------------- Weyl space
def weyl_basis(m):
    """Orthonormal basis of Weyl_m = {W sym on Lambda^2 : Bianchi, Ricci-flat}."""
    pairs, B = basis(m)
    N = len(pairs)
    idx = {p: a for a, p in enumerate(pairs)}

    def R(W, i, j, k, l):
        if i == j or k == l:
            return 0.0
        si = 1.0 if i < j else -1.0
        sk = 1.0 if k < l else -1.0
        a = idx[(min(i, j), max(i, j))]
        b = idx[(min(k, l), max(k, l))]
        return si * sk * W[a, b]

    # symmetric-matrix coordinates
    sym = [(a, b) for a in range(N) for b in range(a, N)]
    D = len(sym)
    rows = []

    def wmat(t):
        W = np.zeros((N, N))
        a, b = sym[t]
        W[a, b] = 1.0
        W[b, a] = 1.0
        return W

    Ws = [wmat(t) for t in range(D)]
    # Bianchi: R_{ijkl} + R_{iklj} + R_{iljk} = 0 for i<j<k<l
    for (i, j, k, l) in itertools.combinations(range(m), 4):
        rows.append([R(W, i, j, k, l) + R(W, i, k, l, j) + R(W, i, l, j, k) for W in Ws])
    # Ricci: sum_j R_{ijkj} = 0
    for i in range(m):
        for k in range(i, m):
            rows.append([sum(R(W, i, j, k, j) for j in range(m)) for W in Ws])
    A = np.array(rows) if rows else np.zeros((0, D))
    # nullspace
    _, s, Vt = np.linalg.svd(A)
    tol = 1e-10 * max(A.shape)
    ns = Vt[np.sum(s > tol):] if A.shape[0] else np.eye(D)
    out = []
    for v in ns:
        W = np.zeros((N, N))
        for t, coef in enumerate(v):
            a, b = sym[t]
            W[a, b] += coef
            W[b, a] += coef if a != b else 0.0
        out.append(W)
    # orthonormalize in Frobenius
    V = np.array([W.ravel() for W in out])
    Qm, _ = np.linalg.qr(V.T)
    return [Qm[:, i].reshape(N, N) for i in range(Qm.shape[1])]


def random_weyl(m, rng, wb=None):
    wb = wb if wb is not None else weyl_basis(m)
    x = rng.normal(size=len(wb))
    W = sum(xi * Wi for xi, Wi in zip(x, wb))
    return W / np.sqrt(ip_mat(W, W))


def eigen_T(W, c):
    """Eigenvalues lam and T_{abg} = <[v_a,v_b],v_g>^2 in the eigenframe."""
    lam, V = np.linalg.eigh(W)
    cp = np.einsum('abc,ai,bj,ck->ijk', c, V, V, V)
    return lam, cp ** 2, cp
