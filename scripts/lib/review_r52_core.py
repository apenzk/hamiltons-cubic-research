"""Reviewer 52: independent from-definitions machinery for the multi-block audit.

Basis phi_{ij} = E_ij - E_ji (i<j), <X,Y> = 1/2 tr(X^T Y) so |phi_a| = 1.
c[a,b,g] = <[phi_a,phi_b],phi_g>   (built by literal n x n commutators)
(W^#)_{ab} = 1/2 c[a,p,q] c[b,r,s] W[p,r] W[q,s]      (polarizable form)
Q(W) = W W + W^#,  P(W)=<W,Q(W)>=tr(W Q(W)),  X o Y = 1/2(Q(X+Y)-Q(X)-Q(Y))
Weyl_n = {Alt(W)=0} cap {Ric(W)=0}.
Nothing here imports any repo module.
"""
import functools
import itertools

import numpy as np


@functools.lru_cache(maxsize=None)
def pairs_of(n):
    prs = tuple((i, j) for i in range(n) for j in range(i + 1, n))
    idx = {p: a for a, p in enumerate(prs)}
    return prs, idx


@functools.lru_cache(maxsize=None)
def phis(n):
    prs, _ = pairs_of(n)
    P = np.zeros((len(prs), n, n))
    for a, (i, j) in enumerate(prs):
        P[a, i, j] = 1.0
        P[a, j, i] = -1.0
    return P


@functools.lru_cache(maxsize=None)
def cstruct(n):
    """c[a,b,g] = <[phi_a,phi_b],phi_g>, by literal commutators."""
    P = phis(n)
    N = P.shape[0]
    comm = np.einsum('aij,bjk->abik', P, P) - np.einsum('bij,ajk->abik', P, P)
    return 0.5 * np.einsum('abik,gik->abg', comm, P)


def so_coeffs(n, X):
    """coefficients of an so(n) matrix X in the phi basis."""
    P = phis(n)
    return 0.5 * np.einsum('aij,ij->a', P, X)


def sharp(n, W):
    c = cstruct(n)
    N = c.shape[0]
    G = np.einsum('apq,pr->aqr', c, W)
    H = np.einsum('brs,qs->brq', c, W)
    return 0.5 * (G.reshape(N, N * N) @ H.transpose(0, 2, 1).reshape(N, N * N).T)


def sharp_bilin(n, X, Y):
    c = cstruct(n)
    N = c.shape[0]
    GX = np.einsum('apq,pr->aqr', c, X)
    HY = np.einsum('brs,qs->brq', c, Y)
    GY = np.einsum('apq,pr->aqr', c, Y)
    HX = np.einsum('brs,qs->brq', c, X)
    t1 = GX.reshape(N, N * N) @ HY.transpose(0, 2, 1).reshape(N, N * N).T
    t2 = GY.reshape(N, N * N) @ HX.transpose(0, 2, 1).reshape(N, N * N).T
    return 0.25 * (t1 + t2)


def Q(n, W):
    return W @ W + sharp(n, W)


def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(n, X, Y)


def P_val(n, W):
    return float(np.tensordot(W, Q(n, W)))


# ---------- Weyl space ----------

def get_entry(n, W, i, j, k, l):
    if i == j or k == l:
        return 0.0
    _, idx = pairs_of(n)
    s = 1.0
    if i > j:
        i, j, s = j, i, -s
    if k > l:
        k, l, s = l, k, -s
    return s * W[idx[(i, j)], idx[(k, l)]]


def ricci(n, W):
    prs, idx = pairs_of(n)
    R = np.zeros((n, n))
    for i in range(n):
        for k in range(n):
            R[i, k] = sum(get_entry(n, W, i, j, k, j) for j in range(n))
    return R


def alt(n, W):
    """Alt(W)[a,b] = (1/3)(R(i,j,k,l)+R(i,k,l,j)+R(i,l,j,k)): projection onto Lambda^4."""
    prs, idx = pairs_of(n)
    A = np.zeros_like(W)
    for a, (i, j) in enumerate(prs):
        for b, (k, l) in enumerate(prs):
            A[a, b] = (get_entry(n, W, i, j, k, l) + get_entry(n, W, i, k, l, j)
                       + get_entry(n, W, i, l, j, k)) / 3.0
    return A


@functools.lru_cache(maxsize=None)
def sym_coords(N):
    """index maps for symmetric N x N matrices as a flat vector of length N(N+1)/2,
    orthonormal: diagonal entries weight 1, off-diagonal weight sqrt(2)."""
    ent = [(a, a) for a in range(N)] + [(a, b) for a in range(N) for b in range(a + 1, N)]
    return tuple(ent)


def sym_to_mat(N, v):
    ent = sym_coords(N)
    M = np.zeros((N, N))
    for t, (a, b) in enumerate(ent):
        if a == b:
            M[a, a] = v[t]
        else:
            M[a, b] = M[b, a] = v[t] / np.sqrt(2.0)
    return M


def mat_to_sym(N, M):
    ent = sym_coords(N)
    v = np.zeros(len(ent))
    for t, (a, b) in enumerate(ent):
        v[t] = M[a, a] if a == b else np.sqrt(2.0) * M[a, b]
    return v


@functools.lru_cache(maxsize=None)
def weyl_basis(n, ret_sym=False):
    """orthonormal basis of Weyl_n, returned as (d, N, N).  Constraints assembled
    directly in symmetric coordinates (no dense Sym^2 basis materialised)."""
    prs, idx = pairs_of(n)
    N = len(prs)
    ent = sym_coords(N)
    pos = {e: t for t, e in enumerate(ent)}
    D = len(ent)

    def addsym(row, a, b, val):
        if a == b:
            row[pos[(a, a)]] += val
        else:
            key = (a, b) if a < b else (b, a)
            row[pos[key]] += val / np.sqrt(2.0)

    rows = []
    # Bianchi: for each 4-subset the cyclic sum
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        row = np.zeros(D)
        for (p, q) in (((i, j), (k, l)), ((i, k), (l, j)), ((i, l), (j, k))):
            sg = 1.0
            a, b = p
            if a > b:
                a, b, sg = b, a, -sg
            cq, d = q
            if cq > d:
                cq, d, sg = d, cq, -sg
            u, v = idx[(a, b)], idx[(cq, d)]
            addsym(row, u, v, sg)
        rows.append(row)
    # Ricci
    for i in range(n):
        for k in range(i, n):
            row = np.zeros(D)
            for j in range(n):
                if j == i or j == k:
                    continue
                sa = 1.0 if i < j else -1.0
                sb = 1.0 if k < j else -1.0
                u = idx[(min(i, j), max(i, j))]
                v = idx[(min(k, j), max(k, j))]
                addsym(row, u, v, sa * sb)
            rows.append(row)
    M = np.array(rows)
    u_, s_, vt = np.linalg.svd(M, full_matrices=True)
    tol = max(M.shape) * (s_[0] if s_.size else 1.0) * 1e-12
    rank = int((s_ > tol).sum())
    ns = vt[rank:]
    if ret_sym:
        return ns
    B = np.array([sym_to_mat(N, v) for v in ns])
    return B


def dim_weyl_formula(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


def project_weyl(n, X):
    B = weyl_basis(n)
    return np.einsum('k,kij->ij', np.einsum('kij,ij->k', B, X), B)


# ---------- L_e ----------

def Le_matrix(n, e):
    """matrix of X -> e o X restricted to Weyl_n, in the orthonormal Weyl basis."""
    B = weyl_basis(n)
    d, N, _ = B.shape
    c = cstruct(n)
    Ge = np.einsum('apq,pr->aqr', c, e).reshape(N, N * N)
    He = np.einsum('brs,qs->brq', c, e).transpose(0, 2, 1).reshape(N, N * N)
    cols = np.empty((d, N, N))
    for j in range(d):
        X = B[j]
        GX = np.einsum('apq,pr->aqr', c, X).reshape(N, N * N)
        HX = np.einsum('brs,qs->brq', c, X).transpose(0, 2, 1).reshape(N, N * N)
        sb = 0.25 * (Ge @ HX.T + GX @ He.T)
        cols[j] = 0.5 * (e @ X + X @ e) + sb
    return np.einsum('kij,lij->kl', B, cols)


def orbit_tangent(n, W):
    """span of [phi_a-action, W] where phi_a acts on Lambda^2 by A_a = ad."""
    c = cstruct(n)
    N = c.shape[0]
    A = c            # (A_a)_{mn} = c[a,m,n]
    out = A @ W - W @ A[:]   # broadcasting: (N,N,N)
    out = np.einsum('amn,nb->amb', A, W) - np.einsum('mn,anb->amb', W, A)
    return out


def orth_rank(V, tol=1e-9):
    F = V.reshape(V.shape[0], -1)
    s = np.linalg.svd(F, compute_uv=False)
    return int((s > tol * max(1.0, s[0])).sum())


def orth_rows(V, tol=1e-9):
    F = V.reshape(V.shape[0], -1)
    u, s, vt = np.linalg.svd(F, full_matrices=False)
    r = int((s > tol * max(1.0, s[0])).sum())
    return vt[:r]


# ---------- slack ----------

def neg_space(n, W, tol=1e-9):
    w, V = np.linalg.eigh(W)
    sel = w < -tol
    return V[:, sel], w[sel]


def slack_structural(n, W, tol=1e-9):
    """S = sum_{i<j} ||Pi_m [X_i,X_j]||^2 over an orthonormal basis of m,
    brackets taken in so(n) as n x n matrices, <X,Y> = 1/2 tr(X^T Y)."""
    Vn, _ = neg_space(n, W, tol)
    k = Vn.shape[1]
    if k < 2:
        return 0.0
    Ph = phis(n)
    Xs = np.einsum('ca,cij->aij', Vn, Ph)            # (k, n, n)
    Pm = Vn @ Vn.T
    tot = 0.0
    for i in range(k):
        Ci = Xs[i] @ Xs[i + 1:] - Xs[i + 1:] @ Xs[i]  # (k-i-1, n, n)
        if Ci.shape[0] == 0:
            continue
        v = 0.5 * np.einsum('tij,aij->ta', Ci, Ph)    # coefficients in phi basis
        tot += float(np.einsum('ta,ab,tb->', v, Pm, v))
    return tot


def slack_repo_adjoint(n, W, tol=1e-9):
    """the b_padded_s3s3.py variant: brackets taken in the ADJOINT rep (N x N),
    coefficients read off by trace against A_c with a 1/2 factor."""
    c = cstruct(n)
    N = c.shape[0]
    Vn, _ = neg_space(n, W, tol)
    k = Vn.shape[1]
    if k < 2:
        return 0.0
    Xs = np.einsum('ca,cmn->amn', Vn, c)
    Pm = Vn @ Vn.T
    tot = 0.0
    for i in range(k):
        Ci = Xs[i] @ Xs[i + 1:] - Xs[i + 1:] @ Xs[i]
        if Ci.shape[0] == 0:
            continue
        v = 0.5 * np.einsum('tmn,cmn->tc', Ci, c)
        tot += float(np.einsum('tc,cd,td->', v, Pm, v))
    return tot


def slack_theta_formula(n, W, theta, tol=1e-12):
    """||Ric(W_-)||^2 + 6 delta^2 - theta tr(W_-) - tr(W_-^2),  W_- = -W|_{neg} >= 0."""
    w, V = np.linalg.eigh(W)
    sel = w < 0
    Wm = (V[:, sel] * (-w[sel])) @ V[:, sel].T
    d2 = float(np.tensordot(alt(n, Wm), alt(n, Wm)))
    R = ricci(n, Wm)
    return (float(np.sum(R * R)) + 6 * d2 - theta * float(np.trace(Wm))
            - float(np.trace(Wm @ Wm)))


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n
