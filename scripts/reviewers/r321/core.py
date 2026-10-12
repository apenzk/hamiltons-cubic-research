"""Reviewer 321's independent implementation. Nothing is imported from the repo."""
import numpy as np
import itertools


def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def so_basis(n):
    """E_ij = e_i e_j^T - e_j e_i^T, orthonormal for <A,B> = -(1/2) tr(AB)."""
    P = pairs(n)
    B = np.zeros((len(P), n, n))
    for a, (i, j) in enumerate(P):
        B[a, i, j] = 1.0
        B[a, j, i] = -1.0
    return B, P


def struct(n):
    """C[a,b,c] = <[phi_a, phi_b], phi_c>; totally antisymmetric."""
    B, P = so_basis(n)
    N = len(P)
    C = np.zeros((N, N, N))
    for a in range(N):
        # [B_a, B_b] for all b, vectorised
        comm = B[a] @ B - B @ B[a]          # (N,n,n)
        for c, (i, j) in enumerate(P):
            C[a, :, c] = comm[:, i, j]      # coefficient of E_ij in an antisym X is X[i,j]
    return C, P


def ad_mats(C):
    """ad_a as an N x N matrix: (ad_a)[c,b] = C[a,b,c]."""
    return np.transpose(C, (0, 2, 1))


def sharp(W, AD):
    """(W#)_{ab} = -(1/2) tr(ad_a W ad_b W)."""
    M = AD @ W                                # (N,N,N): M[a] = ad_a W
    return -0.5 * np.einsum('aij,bji->ab', M, M, optimize=True)


def Q(W, AD):
    return W @ W + sharp(W, AD)


def P_func(W, AD):
    return float(np.sum(W * Q(W, AD)))


# ---------------------------------------------------------------- Weyl space

def sym_basis(N):
    """Orthonormal (Frobenius) basis of symmetric N x N matrices."""
    out = []
    for a in range(N):
        E = np.zeros((N, N)); E[a, a] = 1.0
        out.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N)); E[a, b] = E[b, a] = 1.0 / np.sqrt(2.0)
            out.append(E)
    return np.array(out)


def _tensor(M, IDX, SGN, n):
    F = IDX.reshape(-1)
    T = M[np.ix_(F, F)].reshape(n, n, n, n)
    return T * SGN[:, :, None, None] * SGN[None, None, :, :]


def weyl_basis(n):
    """Orthonormal basis of {symmetric on Lambda^2, first Bianchi, Ricci-flat}."""
    P = pairs(n)
    N = len(P)
    IDX = np.zeros((n, n), dtype=int)
    SGN = np.zeros((n, n))
    for a, (i, j) in enumerate(P):
        IDX[i, j] = IDX[j, i] = a
        SGN[i, j] = 1.0; SGN[j, i] = -1.0
    SB = sym_basis(N)
    quads = list(itertools.combinations(range(n), 4))
    rows = []
    for M in SB:
        T = _tensor(M, IDX, SGN, n)
        r = []
        for (i, j, k, l) in quads:
            r.append(T[i, j, k, l] + T[i, k, l, j] + T[i, l, j, k])
        Ric = np.einsum('ijkj->ik', T)
        for i in range(n):
            for k in range(i, n):
                r.append(Ric[i, k])
        rows.append(r)
    A = np.array(rows).T                     # (constraints, dim sym)
    U, s, Vt = np.linalg.svd(A, full_matrices=True)
    tol = max(A.shape) * (s[0] if s.size else 1.0) * 1e-12
    rank = int((s > tol).sum())
    ns = Vt[rank:]                           # (dimWeyl, dim sym)
    return np.einsum('kd,dij->kij', ns, SB), N


def project_weyl(R, WB):
    c = np.einsum('kij,ij->k', WB, R)
    return np.einsum('k,kij->ij', c, WB)


# ---------------------------------------------------------------- test points

def sphere_product(n, p, WB):
    """Weyl part of the curvature operator of S^p(1) x S^q(1), p+q=n."""
    P = pairs(n)
    R = np.zeros((len(P), len(P)))
    for a, (i, j) in enumerate(P):
        if (i < p and j < p) or (i >= p and j >= p):
            R[a, a] = 1.0
    W = project_weyl(R, WB)
    return W / np.linalg.norm(W)


def diag_weyl(Mmat, n):
    """Diagonal operator W(e_i ^ e_j) = M_ij e_i ^ e_j; Weyl iff M hollow symmetric, row sums 0."""
    P = pairs(n)
    return np.diag(np.array([Mmat[i, j] for (i, j) in P]))


def cpm_weyl(m, WB):
    """Weyl part of the Fubini-Study curvature operator on CP^m (real dim n=2m)."""
    n = 2 * m
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = 1.0
        J[2 * k + 1, 2 * k] = -1.0
    P = pairs(n)
    N = len(P)
    # R_{ijkl} = g_ik g_jl - g_il g_jk + J_ik J_jl - J_il J_jk + 2 J_ij J_kl   (FS, holo sec curv 4)
    R = np.zeros((N, N))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            v = ((i == k) * (j == l) - (i == l) * (j == k)
                 + J[i, k] * J[j, l] - J[i, l] * J[j, k] + 2 * J[i, j] * J[k, l])
            R[a, b] = v
    W = project_weyl(R, WB)
    return W / np.linalg.norm(W)
