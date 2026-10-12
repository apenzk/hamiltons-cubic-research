"""Reviewer 294: independent machinery, built from the definitions in the brief.

Basis of so(n) ~ Lambda^2 R^n: phi_{ij} = E_ij - E_ji, i<j, with <X,Y> = 1/2 tr(X^T Y),
so <phi_a,phi_b> = delta_ab.
c_{abg} = <[phi_a,phi_b],phi_g>;  (A_a)_{mn} = c_{amn};  (W^#)_{ab} = -1/2 tr(A_a W A_b W).
Q(W) = W^2 + W^#;  theta(W) = <W,Q(W)> = tr(W Q(W)) at ||W|| = 1.
"""
import numpy as np, itertools, functools


def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


@functools.lru_cache(None)
def phi(n):
    P = pairs(n)
    M = np.zeros((len(P), n, n))
    for a, (i, j) in enumerate(P):
        M[a, i, j] = 1.0
        M[a, j, i] = -1.0
    return M


@functools.lru_cache(None)
def cconst(n):
    M = phi(n)
    br = np.einsum('aik,bkj->abij', M, M) - np.einsum('bik,akj->abij', M, M)
    return 0.5 * np.einsum('abij,gij->abg', br, M)     # <[phi_a,phi_b],phi_g>


def sharp(n, W):
    A = cconst(n)
    AW = np.einsum('amk,kn->amn', A, W)
    return -0.5 * np.einsum('amn,bnm->ab', AW, AW)


def Qop(n, W):
    return W @ W + sharp(n, W)


def theta(n, W):
    return float(np.sum(W * Qop(n, W)))


# ---- eigen-frame quantities, straight from the brief ----
def frame(n, W):
    """(lam, V, cprime) with cprime[a,b,g] = <[v_a,v_b],v_g>."""
    lam, V = np.linalg.eigh(W)
    c = cconst(n)
    cp = np.einsum('ijk,ia,jb,kg->abg', c, V, V, V)
    return lam, V, cp


def Tten(n, W, half=False):
    """T from the record's code:  T_abg = c'_abg ** 2  (half=True gives (c'/2)**2)."""
    lam, V, cp = frame(n, W)
    T = (0.5 * cp) ** 2 if half else cp ** 2
    return lam, V, T


def RQg(lam, T):
    R = T.sum(axis=2)                                   # R_{g a} = sum_b T_{gab}
    Qg = np.einsum('gab,a,b->g', T, lam, lam)
    g = np.einsum('gab,ab->g', T, (lam[:, None] - lam[None, :]) ** 2)
    X = np.einsum('ga,a->g', R, lam ** 2)               # sum_a lam_a^2 R_{ga}
    return R, Qg, g, X


# ---- Weyl space ----
def Rget(W, idx, i, j, k, l):
    if i == j or k == l:
        return 0.0
    s = 1.0
    if i > j:
        i, j, s = j, i, -s
    if k > l:
        k, l, s = l, k, -s
    return s * W[idx[(i, j)], idx[(k, l)]]


def ricci(n, W):
    P = pairs(n); idx = {p: a for a, p in enumerate(P)}
    Ric = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            Ric[i, j] = sum(Rget(W, idx, i, k, j, k) for k in range(n))
    return Ric


def bianchi(n, W):
    P = pairs(n); idx = {p: a for a, p in enumerate(P)}
    m = 0.0
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        m = max(m, abs(Rget(W, idx, i, j, k, l) + Rget(W, idx, i, k, l, j)
                       + Rget(W, idx, i, l, j, k)))
    return m


def is_weyl(n, W, tol=1e-9):
    return (abs(np.trace(W)) < tol and np.abs(ricci(n, W)).max() < tol
            and bianchi(n, W) < tol)


@functools.lru_cache(None)
def weyl_basis294(n):
    """Orthonormal basis of {sym W : trace-free block-sym, Ricci = 0, Bianchi = 0}."""
    P = pairs(n); N = len(P); idx = {p: a for a, p in enumerate(P)}
    rows = []
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        M = np.zeros((N, N))
        for (a, b, c_, d) in ((i, j, k, l), (i, k, l, j), (i, l, j, k)):
            sa = 1.0 if a < b else -1.0
            sb = 1.0 if c_ < d else -1.0
            M[idx[(min(a, b), max(a, b))], idx[(min(c_, d), max(c_, d))]] += sa * sb
        rows.append(0.5 * (M + M.T))
    for i in range(n):
        for k in range(i, n):
            M = np.zeros((N, N))
            for j in range(n):
                if j == i or j == k:
                    continue
                sa = 1.0 if i < j else -1.0
                sb = 1.0 if k < j else -1.0
                M[idx[(min(i, j), max(i, j))], idx[(min(k, j), max(k, j))]] += sa * sb
            rows.append(0.5 * (M + M.T))
    C = np.array(rows).reshape(len(rows), N * N)
    # symmetric matrices as a linear space, then intersect with ker C
    S = []
    for a in range(N):
        E = np.zeros((N, N)); E[a, a] = 1.0; S.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N)); E[a, b] = E[b, a] = 1 / np.sqrt(2); S.append(E)
    S = np.array(S)
    Mat = C @ S.reshape(len(S), -1).T
    u, s, vt = np.linalg.svd(Mat)
    rank = int((s > max(Mat.shape) * s[0] * 1e-12).sum())
    return np.einsum('kd,dij->kij', vt[rank:], S)


def sphere_product(blocks):
    n = sum(blocks); P = pairs(n)
    lab = sum(([b] * d for b, d in enumerate(blocks)), [])
    W = np.zeros((len(P), len(P)))
    for a, (i, j) in enumerate(P):
        if lab[i] == lab[j]:
            p = blocks[lab[i]]; W[a, a] = 1.0 / (p * (p - 1))
        else:
            W[a, a] = -1.0 / (blocks[lab[i]] * blocks[lab[j]])
    return n, W / np.linalg.norm(W)


def cpm(m):
    n = 2 * m
    J = np.zeros((n, n))
    for t in range(m):
        J[2 * t, 2 * t + 1] = 1.0; J[2 * t + 1, 2 * t] = -1.0
    d = np.eye(n)
    Tn = (np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)
          + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
          + 2.0 * np.einsum('ij,kl->ijkl', J, J))
    P = pairs(n)
    R = np.array([[Tn[i, j, k, l] for (k, l) in P] for (i, j) in P])
    scal = sum(Tn[i, k, i, k] for i in range(n) for k in range(n))
    W = R - (scal / (n * (n - 1))) * np.eye(len(P))
    return n, W / np.linalg.norm(W)
