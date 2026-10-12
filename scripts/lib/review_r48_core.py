"""Reviewer 48: independent machinery, written from the definitions only.

Lambda^2(R^n) with orthonormal basis phi_ij = E_ij - E_ji (i<j) under
<X,Y> = 1/2 tr(X^T Y).  c[a,b,g] = <[phi_a,phi_b], phi_g>, (A_a)_{mn} = c[a,m,n].
(W^#)_{ab} = -1/2 tr(A_a W A_b W),  Q(W) = W@W + W^#,  P(W) = <W, Q(W)>_Frob.
Weyl_n = {W symmetric on Lambda^2 : first Bianchi = 0, Ricci = 0}.
"""
import numpy as np, itertools, functools


def pairs_of(n):
    P = [(i, j) for i in range(n) for j in range(i + 1, n)]
    return P, {p: a for a, p in enumerate(P)}


@functools.lru_cache(maxsize=None)
def cconst(n):
    P, idx = pairs_of(n)
    N = len(P)
    phi = np.zeros((N, n, n))
    for a, (i, j) in enumerate(P):
        phi[a, i, j], phi[a, j, i] = 1.0, -1.0
    # [phi_a, phi_b]_{ij}; inner product 1/2 tr(X^T Y)
    comm = np.einsum('aik,bkj->abij', phi, phi) - np.einsum('bik,akj->abij', phi, phi)
    return 0.5 * np.einsum('abij,gij->abg', comm, phi)


def sharp(n, W):
    c = cconst(n)
    # (W^#)_{ab} = -1/2 sum c[a,m,n] W[n,p] c[b,p,q] W[q,m]
    AW = np.einsum('amn,np->amp', c, W)          # A_a W
    return -0.5 * np.einsum('amp,bpm->ab', AW, AW)


def sharp_pol(n, X, Y):
    """1/2[(X+Y)^# - X^# - Y^#]."""
    c = cconst(n)
    AX = np.einsum('amn,np->amp', c, X)
    AY = np.einsum('amn,np->amp', c, Y)
    T = np.einsum('amp,bpm->ab', AX, AY)
    return -0.25 * (T + T.T)


def Q(n, W):
    return W @ W + sharp(n, W)


def P(n, W):
    return float(np.sum(W * Q(n, W)))


def nrm(W):
    return float(np.sqrt(np.sum(W * W)))


# ---- tensor view -----------------------------------------------------------

def tensor(n, W):
    """R[i,j,k,l] from the matrix in the phi basis (antisymmetric extension)."""
    P, idx = pairs_of(n)
    R = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            v = W[a, b]
            for (ii, jj, s1) in ((i, j, 1), (j, i, -1)):
                for (kk, ll, s2) in ((k, l, 1), (l, k, -1)):
                    R[ii, jj, kk, ll] = s1 * s2 * v
    return R


def ricci(n, W):
    R = tensor(n, W)
    return np.einsum('ijil->jl', R)


def bianchi(n, W):
    R = tensor(n, W)
    return R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))


def is_weyl(n, W, tol=1e-10):
    return (abs(W - W.T).max() < tol and abs(ricci(n, W)).max() < tol
            and abs(bianchi(n, W)).max() < tol)


# ---- Weyl space dimension --------------------------------------------------

def weyl_dim(n):
    """rank-count of the linear constraints on Sym^2(Lambda^2)."""
    P, idx = pairs_of(n)
    N = len(P)
    D = N * (N + 1) // 2
    coord = np.zeros((N, N), dtype=int) - 1
    k = 0
    for a in range(N):
        for b in range(a, N):
            coord[a, b] = coord[b, a] = k
            k += 1
    rows = []

    def add(row2):
        v = np.zeros(D)
        for a in range(N):
            for b in range(N):
                if row2[a, b]:
                    v[coord[a, b]] += row2[a, b]
        rows.append(v)

    def E(i, j):
        s = 1.0
        if i > j:
            i, j, s = j, i, -1.0
        return idx[(i, j)], s

    for (i, j, k2, l) in itertools.combinations(range(n), 4):
        M = np.zeros((N, N))
        for (a, b, cc, d) in ((i, j, k2, l), (i, k2, l, j), (i, l, j, k2)):
            p, s1 = E(a, b); q, s2 = E(cc, d)
            M[p, q] += s1 * s2
        add(M + M.T)
    for i in range(n):
        for k2 in range(i, n):
            M = np.zeros((N, N))
            for j in range(n):
                if j == i or j == k2:
                    continue
                p, s1 = E(i, j); q, s2 = E(k2, j)
                M[p, q] += s1 * s2
            add(M + M.T)
    A = np.array(rows)
    s = np.linalg.svd(A, compute_uv=False)
    r = int((s > max(A.shape) * s[0] * 1e-12).sum())
    return D - r


# ---- named critical points -------------------------------------------------

def sphere_product(blocks):
    """Weyl operator of prod of round spheres; coordinate-diagonal.
    lambda_{ij} = 1/(p(p-1)) inside block p, -1/(pq) across."""
    n = sum(blocks)
    P, idx = pairs_of(n)
    lab = []
    for bi, b in enumerate(blocks):
        lab += [bi] * b
    W = np.zeros((len(P), len(P)))
    for a, (i, j) in enumerate(P):
        if lab[i] == lab[j]:
            p = blocks[lab[i]]
            W[a, a] = 1.0 / (p * (p - 1))
        else:
            W[a, a] = -1.0 / (blocks[lab[i]] * blocks[lab[j]])
    return W / nrm(W)


def fox_point(n):
    """W_{CP^2} in dim 4 (diag(0,0,0,-1,-1,2)/sqrt6 on Lambda^- + Lambda^+),
    zero-padded into Lambda^2(R^n)."""
    P4, idx4 = pairs_of(4)
    s = 1 / np.sqrt(2)
    def bv(pairsigns):
        v = np.zeros(6)
        for (p, sg) in pairsigns:
            v[idx4[p]] = sg * s
        return v
    plus = [bv([((0, 1), 1), ((2, 3), 1)]), bv([((0, 2), 1), ((1, 3), -1)]),
            bv([((0, 3), 1), ((1, 2), 1)])]
    minus = [bv([((0, 1), 1), ((2, 3), -1)]), bv([((0, 2), 1), ((1, 3), 1)]),
             bv([((0, 3), 1), ((1, 2), -1)])]
    W4 = np.zeros((6, 6))
    for v, e in zip(plus, (-1.0, -1.0, 2.0)):
        W4 += e * np.outer(v, v)
    W4 /= np.sqrt(6)
    return pad(4, W4, n)


def pad(n0, W0, n, off=0):
    P0, _ = pairs_of(n0)
    P, idx = pairs_of(n)
    M = np.zeros((len(P), len(P)))
    for a, (i, j) in enumerate(P0):
        for b, (k, l) in enumerate(P0):
            M[idx[(i + off, j + off)], idx[(k + off, l + off)]] = W0[a, b]
    return M


def rand_weyl(n, rng):
    """random element of Weyl_n by projecting a random symmetric matrix."""
    B = weyl_basis(n)
    N = B.shape[1]
    X = rng.standard_normal((N, N)); X = X + X.T
    co = np.einsum('kij,ij->k', B, X)
    return np.einsum('k,kij->ij', co, B)


@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    P, idx = pairs_of(n)
    N = len(P)
    S = []
    for a in range(N):
        E = np.zeros((N, N)); E[a, a] = 1.0; S.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N)); E[a, b] = E[b, a] = 1 / np.sqrt(2); S.append(E)
    S = np.array(S)
    rows = []
    def Eidx(i, j):
        s = 1.0
        if i > j: i, j, s = j, i, -1.0
        return idx[(i, j)], s
    for (i, j, k2, l) in itertools.combinations(range(n), 4):
        M = np.zeros((N, N))
        for (a, b, cc, d) in ((i, j, k2, l), (i, k2, l, j), (i, l, j, k2)):
            p, s1 = Eidx(a, b); q, s2 = Eidx(cc, d)
            M[p, q] += s1 * s2
        rows.append(M + M.T)
    for i in range(n):
        for k2 in range(i, n):
            M = np.zeros((N, N))
            for j in range(n):
                if j == i or j == k2: continue
                p, s1 = Eidx(i, j); q, s2 = Eidx(k2, j)
                M[p, q] += s1 * s2
            rows.append(M + M.T)
    C = np.array(rows)
    Mat = np.einsum('rij,dij->rd', C, S)
    u, s, vt = np.linalg.svd(Mat, full_matrices=True)
    tol = max(Mat.shape) * s[0] * 1e-12
    r = int((s > tol).sum())
    return np.einsum('kd,dij->kij', vt[r:], S)


def theta0(n):
    return np.sqrt(2 * (n - 1) * (n - 2)) / n
