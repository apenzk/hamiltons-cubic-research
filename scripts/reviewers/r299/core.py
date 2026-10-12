"""Reviewer 299: independent machinery, built from the definitions in brief5.md.

Lambda^2 R^n with basis phi_{ij} = E_ij - E_ji (i<j), <X,Y> = 1/2 tr(X^T Y).
c[a,b,g] = <[phi_a,phi_b], phi_g>;  (A_a)_{mn} = c[a,m,n]
(W^#)_{ab} = -1/2 tr(A_a W A_b W);  Q(W) = W^2 + W^#;  P(W) = <W,Q(W)>
X o Y = 1/2(Q(X+Y)-Q(X)-Q(Y)) = (XY+YX)/2 + sharp_bilin(X,Y)
Weyl_n = {W in Sym^2(Lambda^2) : Bianchi = 0, Ricci = 0}
"""
import numpy as np, itertools, functools


@functools.lru_cache(maxsize=None)
def pairs_of(n):
    P = tuple((i, j) for i in range(n) for j in range(i + 1, n))
    return P, {p: a for a, p in enumerate(P)}


@functools.lru_cache(maxsize=None)
def phis(n):
    P, _ = pairs_of(n)
    ph = np.zeros((len(P), n, n))
    for a, (i, j) in enumerate(P):
        ph[a, i, j] = 1.0
        ph[a, j, i] = -1.0
    return ph


@functools.lru_cache(maxsize=None)
def cstruct(n):
    """c[a,b,g] = <[phi_a,phi_b],phi_g> with <X,Y>=1/2 tr(X^T Y)."""
    ph = phis(n)
    N = ph.shape[0]
    c = np.zeros((N, N, N))
    for a in range(N):
        comm = ph[a] @ ph - ph @ ph[a]          # (N,n,n)
        c[a] = 0.5 * np.einsum('bij,gij->bg', comm, ph)
    return c


@functools.lru_cache(maxsize=None)
def ad(n):
    """A_a = ad(phi_a) acting on Lambda^2 in the phi basis."""
    return cstruct(n)


def deriv(n, M):
    """Derivation d(M) on Lambda^2 induced by an n x n matrix M:
       d(M)(e_i ^ e_j) = (M e_i)^e_j + e_i^(M e_j).  For skew M this equals ad(M)."""
    P, idx = pairs_of(n)
    N = len(P)
    D = np.zeros((N, N))
    for b, (i, j) in enumerate(P):
        # image of e_i ^ e_j
        for k in range(n):
            if k != j:
                a = idx[(min(k, j), max(k, j))]
                s = 1.0 if k < j else -1.0
                D[a, b] += s * M[k, i]
            if k != i:
                a = idx[(min(i, k), max(i, k))]
                s = 1.0 if i < k else -1.0
                D[a, b] += s * M[k, j]
    return D


def sharp(n, W):
    A = ad(n)
    N = A.shape[0]
    AW = np.einsum('amn,np->amp', A, W)
    return -0.5 * np.einsum('amp,bpm->ab', AW, AW)


def sharp_bilin(n, X, Y):
    A = ad(n)
    AX = np.einsum('amn,np->amp', A, X)
    AY = np.einsum('amn,np->amp', A, Y)
    T = np.einsum('amp,bpm->ab', AX, AY)
    return -0.25 * (T + T.T)


def Q(n, W):
    return W @ W + sharp(n, W)


def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(n, X, Y)


def P(n, W):
    return float(np.sum(W * Q(n, W)))


# ---------------- Weyl space ----------------

def _bianchi_ricci_rows(n):
    P_, idx = pairs_of(n)
    N = len(P_)

    def put(row, i, j, k, l, s):
        if i == j or k == l:
            return
        if i > j:
            i, j, s = j, i, -s
        if k > l:
            k, l, s = l, k, -s
        row[idx[(i, j)], idx[(k, l)]] += s

    rows = []
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        r = np.zeros((N, N))
        put(r, i, j, k, l, 1.0)
        put(r, i, k, l, j, 1.0)
        put(r, i, l, j, k, 1.0)
        rows.append(0.5 * (r + r.T))
    for i in range(n):
        for k in range(i, n):
            r = np.zeros((N, N))
            for j in range(n):
                if j == i or j == k:
                    continue
                put(r, i, j, k, j, 1.0)
            rows.append(0.5 * (r + r.T))
    return np.array(rows)


@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Frobenius-orthonormal basis of Weyl_n, shape (d, N, N)."""
    C = _bianchi_ricci_rows(n)
    N = C.shape[1]
    # symmetric-matrix coordinates: orthonormal basis of Sym^2(R^N)
    S = []
    for a in range(N):
        E = np.zeros((N, N)); E[a, a] = 1.0; S.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N)); E[a, b] = E[b, a] = 1 / np.sqrt(2.0); S.append(E)
    S = np.array(S)
    M = np.einsum('rij,dij->rd', C, S)
    u, s, vt = np.linalg.svd(M)
    tol = max(M.shape) * (s[0] if s.size else 1.0) * 1e-12
    rank = int((s > tol).sum())
    return np.einsum('kd,dij->kij', vt[rank:], S)


def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


@functools.lru_cache(maxsize=None)
def weyl_flat(n):
    B = weyl_basis(n)
    return B.reshape(B.shape[0], -1)          # (d, N*N), orthonormal rows


def proj_weyl(n, H):
    F = weyl_flat(n)
    h = H.reshape(-1)
    return (F.T @ (F @ h)).reshape(H.shape)


def L_operator(n, W, theta=None):
    """Matrix of L_e = e o (.) restricted to Weyl_n, in the weyl_basis coordinates.
       e = W/theta with W unit norm; here we return L in the basis, using
       L_e H = [ (WH+HW)/2 + sharp_bilin(n,W,H) ] / theta."""
    B = weyl_basis(n)
    d = B.shape[0]
    if theta is None:
        theta = P(n, W)
    Lm = np.zeros((d, d))
    for k in range(d):
        img = circ(n, W, B[k]) / theta
        Lm[:, k] = np.einsum('ij,kij->k', img, B)
    return 0.5 * (Lm + Lm.T)


def sym0_basis(n):
    """orthonormal basis of trace-free symmetric n x n (Frobenius)."""
    out = []
    for i in range(n):
        for j in range(i + 1, n):
            E = np.zeros((n, n)); E[i, j] = E[j, i] = 1 / np.sqrt(2.0); out.append(E)
    for k in range(1, n):
        E = np.zeros((n, n))
        for i in range(k):
            E[i, i] = 1.0
        E[k, k] = -float(k)
        out.append(E / np.linalg.norm(E))
    return np.array(out)
