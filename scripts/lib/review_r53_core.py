"""Reviewer 53: independent machinery, written from the definitions in findings/INDEX.md.

Conventions (all rebuilt here, nothing imported from the repository):
  Lambda^2 R^n has orthonormal basis phi_{ij} = E_ij - E_ji (i<j),
  <X,Y> = 1/2 tr(X^T Y).  For antisymmetric Z the coordinate on phi_{ij} is Z[i,j].
  c[a,b,g] = <[phi_a,phi_b],phi_g>,  (A_a)[m,n] = c[a,m,n]  (so A_a = ad(phi_a)).
  (W^#)[a,b] = -1/2 tr(A_a W A_b W),  Q(W) = W W + W^#,  P(W) = <W,Q(W)>.
  X o Y = 1/2 (Q(X+Y) - Q(X) - Q(Y)).
  Weyl_n = {W symmetric on Lambda^2 : Ric(W) = 0, Alt(W) = 0}.
  Critical point: Q(W) = theta W with |W| = 1.  L_e X = e o X, e = W/theta.
  theta_0(n) = sqrt(2(n-1)(n-2))/n.
"""
import functools
import itertools

import numpy as np


# ---------------------------------------------------------------- basis / algebra

@functools.lru_cache(maxsize=None)
def pairs_of(n):
    prs = tuple((i, j) for i in range(n) for j in range(i + 1, n))
    idx = {p: a for a, p in enumerate(prs)}
    return prs, idx


def Npairs(n):
    return n * (n - 1) // 2


@functools.lru_cache(maxsize=None)
def phis(n):
    prs, _ = pairs_of(n)
    Ph = np.zeros((len(prs), n, n))
    for a, (i, j) in enumerate(prs):
        Ph[a, i, j] = 1.0
        Ph[a, j, i] = -1.0
    return Ph


@functools.lru_cache(maxsize=None)
def cstruct(n):
    """c[a,b,g] = <[phi_a,phi_b],phi_g>, built by brute force from the matrices."""
    Ph = phis(n)
    comm = np.einsum('aik,bkj->abij', Ph, Ph) - np.einsum('bik,akj->abij', Ph, Ph)
    prs, _ = pairs_of(n)
    ii = np.array([p[0] for p in prs])
    jj = np.array([p[1] for p in prs])
    return comm[:, :, ii, jj]


def ad(n):
    return cstruct(n)


def sharp(n, W):
    A = ad(n)
    M = np.einsum('aik,kj->aij', A, W)
    return -0.5 * np.einsum('aij,bji->ab', M, M)


def sharp_bi(n, X, Y):
    """polarisation of #: 1/2[(X+Y)^# - X^# - Y^#]."""
    A = ad(n)
    AX = np.einsum('aik,kj->aij', A, X)
    AY = np.einsum('aik,kj->aij', A, Y)
    T = np.einsum('aij,bji->ab', AX, AY)          # tr(A_a X A_b Y)
    return -0.25 * (T + T.T)


def Qop(n, W):
    return W @ W + sharp(n, W)


def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_bi(n, X, Y)


def Pval(n, W):
    return float(np.sum(W * Qop(n, W)))


# ---------------------------------------------------------------- curvature reads

@functools.lru_cache(maxsize=None)
def ricci_index(n):
    """R,C,S with Ric[i,k] = sum_j S[i,k,j] * W[R[i,k,j], C[i,k,j]]."""
    prs, idx = pairs_of(n)
    R = np.zeros((n, n, n), dtype=int)
    C = np.zeros((n, n, n), dtype=int)
    S = np.zeros((n, n, n))
    for i in range(n):
        for k in range(n):
            for j in range(n):
                if i == j or k == j:
                    continue
                sa = 1.0 if i < j else -1.0
                sb = 1.0 if k < j else -1.0
                R[i, k, j] = idx[(min(i, j), max(i, j))]
                C[i, k, j] = idx[(min(k, j), max(k, j))]
                S[i, k, j] = sa * sb
    return R, C, S


def ricci(n, W):
    R, C, S = ricci_index(n)
    return np.einsum('ikj,ikj->ik', S, W[R, C])


@functools.lru_cache(maxsize=None)
def alt_index(n):
    """Alt(W)[a,b] = (R(ijkl)+R(iklj)+R(iljk))/3 for a=(i,j), b=(k,l)."""
    prs, idx = pairs_of(n)
    N = len(prs)
    Rs = np.zeros((3, N, N), dtype=int)
    Cs = np.zeros((3, N, N), dtype=int)
    Ss = np.zeros((3, N, N))
    for a, (i, j) in enumerate(prs):
        for b, (k, l) in enumerate(prs):
            for t, quad in enumerate([(i, j, k, l), (i, k, l, j), (i, l, j, k)]):
                p, q, r, s = quad
                if p == q or r == s:
                    continue
                sg = 1.0
                if p > q:
                    p, q, sg = q, p, -sg
                if r > s:
                    r, s, sg = s, r, -sg
                Rs[t, a, b] = idx[(p, q)]
                Cs[t, a, b] = idx[(r, s)]
                Ss[t, a, b] = sg
    return Rs, Cs, Ss


def alt(n, W):
    Rs, Cs, Ss = alt_index(n)
    return (Ss * W[Rs, Cs]).sum(axis=0) / 3.0


# ---------------------------------------------------------------- Weyl_n

@functools.lru_cache(maxsize=None)
def sym_coords(N):
    """rows/cols/scale for the orthonormal Sym^2 basis: E_aa, then (E_ab+E_ba)/sqrt2."""
    rows = list(range(N))
    cols = list(range(N))
    scale = [1.0] * N
    for a in range(N):
        for b in range(a + 1, N):
            rows.append(a); cols.append(b); scale.append(1.0 / np.sqrt(2.0))
    return np.array(rows), np.array(cols), np.array(scale)


def sym_to_mat(N, v):
    r, c, s = sym_coords(N)
    M = np.zeros((N, N))
    M[r, c] = v * s
    M[c, r] = v * s
    return M


def mat_to_sym(N, M):
    r, c, s = sym_coords(N)
    out = M[r, c].copy()
    out[N:] *= np.sqrt(2.0)
    return out


@functools.lru_cache(maxsize=None)
def constraint_rows(n):
    """Bianchi + Ricci constraints as rows in orthonormal Sym^2 coordinates."""
    prs, idx = pairs_of(n)
    N = len(prs)
    D = N * (N + 1) // 2
    rows = []

    def pack(M):
        M = 0.5 * (M + M.T)
        return mat_to_sym(N, M)

    for (i, j, k, l) in itertools.combinations(range(n), 4):
        M = np.zeros((N, N))
        for (a, b, cc, d) in ((i, j, k, l), (i, k, l, j), (i, l, j, k)):
            sg = 1.0
            p, q = (a, b) if a < b else (b, a)
            if a > b:
                sg = -sg
            u, v = (cc, d) if cc < d else (d, cc)
            if cc > d:
                sg = -sg
            M[idx[(p, q)], idx[(u, v)]] += sg
        rows.append(pack(M))
    Ri, Ci, Si = ricci_index(n)
    for i in range(n):
        for k in range(i, n):
            M = np.zeros((N, N))
            for j in range(n):
                if j == i or j == k:
                    continue
                M[Ri[i, k, j], Ci[i, k, j]] += Si[i, k, j]
            rows.append(pack(M))
    return np.array(rows)


@functools.lru_cache(maxsize=None)
def weyl_nullspace(n):
    """Orthonormal nullspace rows (d, D) in Sym^2 coordinates -- no dense N^2 basis."""
    A = constraint_rows(n)
    u, sv, vt = np.linalg.svd(A, full_matrices=True)
    tol = max(A.shape) * (sv[0] if sv.size else 1.0) * 1e-12
    rank = int((sv > tol).sum())
    return vt[rank:]


def dim_weyl(n):
    return weyl_nullspace(n).shape[0]


def dim_weyl_formula(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    N = Npairs(n)
    return np.array([sym_to_mat(N, v) for v in weyl_nullspace(n)])


def project_weyl(n, W):
    N = Npairs(n)
    ns = weyl_nullspace(n)
    v = mat_to_sym(N, 0.5 * (W + W.T))
    return sym_to_mat(N, ns.T @ (ns @ v))


# ---------------------------------------------------------------- L_e

def Le_matrix(n, e, B=None):
    """Matrix of X -> e o X restricted to Weyl_n, in the orthonormal basis B."""
    if B is None:
        B = weyl_basis(n)
    A = ad(n)
    N = A.shape[0]
    Ae = np.einsum('aik,kj->aij', A, e)
    AeT = np.transpose(Ae, (0, 2, 1)).reshape(N, N * N)
    d = B.shape[0]
    cols = np.empty((d, N, N))
    for j in range(d):
        X = B[j]
        AX = np.einsum('aik,kj->aij', A, X).reshape(N, N * N)
        T = AX @ AeT.T
        cols[j] = 0.5 * (e @ X + X @ e) - 0.25 * (T + T.T)
    Bf = B.reshape(d, -1)
    M = Bf @ cols.reshape(d, -1).T
    return 0.5 * (M + M.T)


# ---------------------------------------------------------------- orbit tangent

def orbit_tangent(n, W):
    A = ad(n)
    return A @ W - W @ A


def onb_rows(V, tol=1e-9):
    F = V.reshape(V.shape[0], -1)
    u, s, vt = np.linalg.svd(F, full_matrices=False)
    if s.size == 0:
        return vt[:0]
    r = int((s > tol * max(1.0, s[0])).sum())
    return vt[:r]


# ---------------------------------------------------------------- slacks

def slack_struct(n, W, tol=1e-9, scaled=False):
    """Structural bracket leakage S = sum_{i<j} ||Pi_m [m_i,m_j]||^2.

    m = negative eigenspace of W inside Lambda^2 = so(n), h = its complement.
    scaled=True multiplies by (n-2)^2, reproducing the ad-trace normalisation
    that scripts/b_padded_s3s3.py's slack() uses.
    """
    prs, _ = pairs_of(n)
    Ph = phis(n)
    w, V = np.linalg.eigh(W)
    neg = V[:, w < -tol]
    k = neg.shape[1]
    if k < 2:
        return 0.0
    Ms = np.einsum('ci,ckl->ikl', neg, Ph)          # m_i as n x n antisymmetric
    Pm = neg @ neg.T
    ii = np.array([p[0] for p in prs])
    jj = np.array([p[1] for p in prs])
    tot = 0.0
    for i in range(k):
        if i + 1 >= k:
            break
        Cm = Ms[i] @ Ms[i + 1:] - Ms[i + 1:] @ Ms[i]
        v = Cm[:, ii, jj]
        tot += float(np.einsum('ra,ab,rb->', v, Pm, v))
    return tot * ((n - 2) ** 2 if scaled else 1.0)


def leaks(n, W, tol=1e-9):
    """(||Pi_m[m,m]||^2, ||Pi_h[h,m]||^2, ||Pi_m[h,h]||^2) with unscaled coordinates."""
    prs, _ = pairs_of(n)
    Ph = phis(n)
    w, V = np.linalg.eigh(W)
    neg = V[:, w < -tol]
    pos = V[:, w >= -tol]
    Pm = neg @ neg.T
    Phh = pos @ pos.T
    ii = np.array([p[0] for p in prs])
    jj = np.array([p[1] for p in prs])
    M = np.einsum('ci,ckl->ikl', neg, Ph)
    H = np.einsum('ci,ckl->ikl', pos, Ph)

    def leak(Aset, Bset, Proj, strict):
        tot = 0.0
        for i in range(Aset.shape[0]):
            other = Bset[i + 1:] if strict else Bset
            if other.shape[0] == 0:
                continue
            Cm = Aset[i] @ other - other @ Aset[i]
            v = Cm[:, ii, jj]
            tot += float(np.einsum('ra,ab,rb->', v, Proj, v))
        return tot

    return (leak(M, M, Pm, True), leak(H, M, Phh, False), leak(H, H, Pm, True))


def slack_theta(n, W, theta):
    """||Ric(W_-)||^2 + 6 delta^2 - theta tr(W_-) - tr(W_-^2), W_- = (-W)_+ ."""
    w, V = np.linalg.eigh(W)
    g = np.where(w < 0, -w, 0.0)
    Wm = (V * g) @ V.T
    ric = ricci(n, Wm)
    d2 = float(np.sum(alt(n, Wm) ** 2))
    return (float(np.sum(ric * ric)) + 6.0 * d2
            - theta * float(np.trace(Wm)) - float(np.trace(Wm @ Wm)))


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n
