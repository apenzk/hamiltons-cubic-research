"""Reviewer 300: independent machinery, built from the definitions in the brief.

Lambda^2 R^n with phi_{ij} = E_ij - E_ji (i<j), <X,Y> = 1/2 tr(X^T Y)  -> orthonormal.
c[a,b,g] = <[phi_a,phi_b],phi_g>;  (A_a)_{mn} = c[a,m,n]
sharp_bilin(X,Y)_{ab} = -1/4 ( tr(A_a X A_b Y) + tr(A_b X A_a Y) )
Q(W) = W@W + sharp(W,W);  P(W) = <W,Q(W)>_F ;  X o Y = 1/2(Q(X+Y)-Q(X)-Q(Y))
Weyl_n = {W sym on Lambda^2 : first Bianchi (Alt = 0), Ric(W) = 0}
L_e X = 1/2(eX + Xe) + sharp_bilin(e,X), e = W/theta.
"""
import itertools, functools
import numpy as np


@functools.lru_cache(maxsize=None)
def pairs_of(n):
    prs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    return tuple(prs), {p: a for a, p in enumerate(prs)}


@functools.lru_cache(maxsize=None)
def cstruct(n):
    prs, idx = pairs_of(n)
    N = len(prs)
    phi = np.zeros((N, n, n))
    for a, (i, j) in enumerate(prs):
        phi[a, i, j] = 1.0
        phi[a, j, i] = -1.0
    c = np.zeros((N, N, N))
    for a in range(N):
        comm = phi[a] @ phi - phi @ phi[a]
        c[a] = 0.5 * np.einsum('bij,gij->bg', comm, phi)
    return c


def sharp_bilin(n, X, Y):
    A = cstruct(n)
    N = A.shape[0]
    AX = np.einsum('amn,np->amp', A, X)
    AY = np.einsum('bmn,np->bmp', A, Y)
    T = np.einsum('amp,bpm->ab', AX, AY)          # tr(A_a X A_b Y)
    return -0.25 * (T + T.T)


def Q(n, W):
    return W @ W + sharp_bilin(n, W, W)


def P(n, W):
    return float(np.tensordot(W, Q(n, W)))


def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(n, X, Y)


# ---------- curvature-tensor accessors ----------

def Rget(n, W, i, j, k, l):
    prs, idx = pairs_of(n)
    if i == j or k == l:
        return 0.0
    s = 1.0
    if i > j:
        i, j, s = j, i, -s
    if k > l:
        k, l, s = l, k, -s
    return s * W[idx[(i, j)], idx[(k, l)]]


def ricci(n, W):
    R = np.zeros((n, n))
    for i in range(n):
        for k in range(n):
            R[i, k] = sum(Rget(n, W, i, j, k, j) for j in range(n))
    return R


def alt_defect(n, W):
    """first Bianchi: R_{ijkl} + R_{iklj} + R_{iljk} on 4 distinct indices."""
    out = []
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        out.append(Rget(n, W, i, j, k, l) + Rget(n, W, i, k, l, j) + Rget(n, W, i, l, j, k))
    return np.array(out) if out else np.zeros(0)


# ---------- Weyl basis (independent construction) ----------

@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal (Frobenius) basis of Weyl_n, as (d, N, N)."""
    prs, idx = pairs_of(n)
    N = len(prs)
    # orthonormal basis of Sym^2(R^N)
    S = []
    for a in range(N):
        E = np.zeros((N, N)); E[a, a] = 1.0; S.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N)); E[a, b] = E[b, a] = 1.0 / np.sqrt(2.0); S.append(E)
    S = np.array(S)
    rows = []
    for E in S:
        rows.append(np.concatenate([ricci(n, E).ravel(), alt_defect(n, E)]))
    M = np.array(rows).T                      # (constraints, D)
    u, s, vt = np.linalg.svd(M, full_matrices=True)
    rank = int((s > 1e-9 * s[0]).sum()) if s.size else 0
    ker = vt[rank:]
    B = np.einsum('kd,dij->kij', ker, S)
    gram = np.einsum('kij,lij->kl', B, B)
    assert np.allclose(gram, np.eye(len(B)), atol=1e-9)
    return B


def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


def proj_weyl(n, H):
    B = weyl_basis(n)
    co = np.einsum('kij,ij->k', B, H)
    return np.einsum('k,kij->ij', co, B)


def to_coords(n, H):
    return np.einsum('kij,ij->k', weyl_basis(n), H)


# ---------- L_e as a matrix in the Weyl basis ----------

def Le_matrix(n, e):
    B = weyl_basis(n)
    A = cstruct(n)
    N = A.shape[0]
    Ae = np.einsum('amn,np->amp', A, e)                       # A_a e
    D = len(B)
    M = np.empty((D, D))
    for k in range(D):
        X = B[k]
        AX = np.einsum('bmn,np->bmp', A, X)
        T = np.einsum('amp,bpm->ab', Ae, AX)                  # tr(A_a e A_b X)
        prod = 0.5 * (e @ X + X @ e) - 0.25 * (T + T.T)
        M[:, k] = np.einsum('kij,ij->k', B, prod)
    asym = np.abs(M - M.T).max()
    return 0.5 * (M + M.T), asym


def lambda_max_perp(n, W):
    """theta, criticality residual, lambda_max(L_e|W^perp), full spectrum."""
    W = W / np.linalg.norm(W)
    QW = Q(n, W)
    th = float(np.tensordot(W, QW))
    res = float(np.linalg.norm(QW - th * W))
    M, asym = Le_matrix(n, W / th)
    w = to_coords(n, W); w /= np.linalg.norm(w)
    Pp = np.eye(len(M)) - np.outer(w, w)
    Mp = Pp @ M @ Pp
    ev = np.linalg.eigvalsh(Mp)
    # the projected operator has a spurious 0 for the W direction; take the true perp spectrum
    return th, res, M, Mp, ev, w, asym


# ---------- test points ----------

def sphere_pair(p, q):
    """Weyl operator of S^p x S^q, built from Ric = 0 on the diagonal ansatz."""
    n = p + q
    prs, idx = pairs_of(n)
    N = len(prs)
    lab = [0] * p + [1] * q
    x, y, z = q / (p - 1.0), p / (q - 1.0), -1.0
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(prs):
        if lab[i] == lab[j]:
            W[a, a] = x if lab[i] == 0 else y
        else:
            W[a, a] = z
    return W / np.linalg.norm(W), n


def cpm(m):
    """Weyl part of the Fubini-Study curvature operator on R^{2m}."""
    n = 2 * m
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = -1.0
        J[2 * k + 1, 2 * k] = 1.0
    prs, idx = pairs_of(n)
    N = len(prs)
    I = np.eye(n)

    def R(i, j, k, l):
        return (I[i, k] * I[j, l] - I[i, l] * I[j, k]
                + J[i, k] * J[j, l] - J[i, l] * J[j, k]
                + 2.0 * J[i, j] * J[k, l])
    M = np.zeros((N, N))
    for a, (i, j) in enumerate(prs):
        for b, (k, l) in enumerate(prs):
            M[a, b] = R(i, j, k, l)
    M = 0.5 * (M + M.T)
    W = proj_weyl(n, M)
    return W / np.linalg.norm(W), n


def c5_blowup(sizes=(2, 2, 2, 2, 2), diag=4.0, adjv=-2.0, nonadj=1.0):
    k = len(sizes); n = sum(sizes)
    G = [[0] * k for _ in range(k)]
    for a in range(k):
        G[a][(a + 1) % k] = G[(a + 1) % k][a] = 1
    prs, idx = pairs_of(n)
    N = len(prs)
    lab = []
    for bi, b in enumerate(sizes):
        lab += [bi] * b
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(prs):
        A_, B_ = lab[i], lab[j]
        W[a, a] = diag if A_ == B_ else (adjv if G[A_][B_] else nonadj)
    return W / np.linalg.norm(W), n


# ---------- symmetric deformations ----------

def sym0_basis(n):
    """orthonormal basis of traceless symmetric n x n."""
    out = []
    for i in range(n):
        for j in range(i + 1, n):
            E = np.zeros((n, n)); E[i, j] = E[j, i] = 1 / np.sqrt(2.0); out.append(E)
    for k in range(1, n):
        d = np.zeros(n); d[:k] = 1.0; d[k] = -float(k)
        E = np.diag(d / np.linalg.norm(d)); out.append(E)
    return np.array(out)


def D_A(n, A):
    """derivation action of symmetric A on Lambda^2, as an N x N matrix:
    D_A(x ^ y) = (Ax) ^ y + x ^ (Ay), i.e. X -> A X + X A on so(n)."""
    prs, idx = pairs_of(n)
    N = len(prs)
    phi = np.zeros((N, n, n))
    for a, (i, j) in enumerate(prs):
        phi[a, i, j] = 1.0; phi[a, j, i] = -1.0
    img = A @ phi + phi @ A
    return 0.5 * np.einsum('aij,bij->ba', img, phi)   # column b = image of phi_b


def orth_rows(F, tol=1e-9):
    u, s, vt = np.linalg.svd(F, full_matrices=False)
    r = int((s > tol * max(1.0, s[0])).sum())
    return vt[:r], s


def orbit_tangent(n, W):
    A = cstruct(n)
    return np.array([A[a] @ W - W @ A[a] for a in range(A.shape[0])])


def delta_defect(n, W):
    """Delta(W) = sum over positive eigenvectors v of W of || [ad(v), W] ||^2."""
    A = cstruct(n)
    ev, U = np.linalg.eigh(W)
    tot = 0.0; pos = 0.0
    for k in range(len(ev)):
        v = U[:, k]
        adv = np.einsum('a,amn->mn', v, A)
        g = float(np.linalg.norm(adv @ W - W @ adv) ** 2)
        tot += g
        if ev[k] > 1e-9:
            pos += g
    return pos, tot
