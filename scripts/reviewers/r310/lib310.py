"""Reviewer 310: independent re-implementation from the definitions.

Conventions fixed from scratch:
  * Lambda^2(R^n) ~ so(n) with basis phi_ab = E_ab := e_a e_b^T - e_b e_a^T, a<b.
    Inner product <A,B> = (1/2) tr(A^T B) makes {phi_ab} orthonormal, and
    [phi_ab, phi_bd] = phi_ad for distinct a,b,d.
  * structure constants c[al,be,ga] = <[b_al, b_be], b_ga>  (values in {0,+-1}).
  * Hamilton sharp normalised so that I # I = (n-2) I  (Boehm-Wilking Lemma 2.1
    with W#I = -W is the cross-check):
        (R # S)_{al be} = (1/2) sum c[al,g,m] c[be,d,n] R[g,d] S[m,n].
  * Q(W) = W@W + sharp(W,W);  P(W) = <W, Q(W)>_op with <A,B>_op = tr(A B).
  * L_W H = (W H + H W)/2 + sharp(W,H);  L_e = L_W/theta.
"""
import numpy as np
import itertools


def pairs(n):
    return [(a, b) for a in range(n) for b in range(a + 1, n)]


def pair_index(n):
    return {p: i for i, p in enumerate(pairs(n))}


_SC = {}


def struct(n):
    """c[al,be,ga] = <[b_al,b_be], b_ga> for the E_ab basis."""
    if n in _SC:
        return _SC[n]
    P = pairs(n)
    idx = pair_index(n)
    D = len(P)
    c = np.zeros((D, D, D))
    # [E_ij,E_kl] = d_jk E_il - d_ik E_jl - d_jl E_ik + d_il E_jk
    def add(c, al, i, j, coef, idx):
        if i == j:
            return
        if i < j:
            c[al[0], al[1], idx[(i, j)]] += coef
        else:
            c[al[0], al[1], idx[(j, i)]] -= coef
    for ai, (i, j) in enumerate(P):
        for bi, (k, l) in enumerate(P):
            al = (ai, bi)
            if j == k:
                add(c, al, i, l, 1.0, idx)
            if i == k:
                add(c, al, j, l, -1.0, idx)
            if j == l:
                add(c, al, i, k, -1.0, idx)
            if i == l:
                add(c, al, j, k, 1.0, idx)
    _SC[n] = c
    return c


def dim_of(W):
    D = W.shape[0]
    n = int(round((1 + np.sqrt(1 + 8 * D)) / 2))
    assert n * (n - 1) // 2 == D, (D, n)
    return n


def sharp(R, S, n=None):
    if n is None:
        n = dim_of(R)
    c = struct(n)
    # (1/2) sum_{g,d,m,nu} c[al,g,m] c[be,d,nu] R[g,d] S[m,nu]
    T = np.einsum('agm,gd->adm', c, R)
    U = np.einsum('bdn,mn->bdm', c, S)
    return 0.5 * np.einsum('adm,bdm->ab', T, U)


def Q(W, n=None):
    return W @ W + sharp(W, W, n)


def ip(A, B):
    return float(np.tensordot(A, B, axes=([0, 1], [0, 1])))


def P(W, n=None):
    return ip(W, Q(W, n))


def L_W(W, H, n=None):
    return 0.5 * (W @ H + H @ W) + sharp(W, H, n)


# ---------------- diagonal locus ----------------

def W_from_M(M):
    """M hollow symmetric n x n -> diagonal Weyl operator on Lambda^2."""
    n = M.shape[0]
    P_ = pairs(n)
    return np.diag(np.array([M[a, b] for (a, b) in P_]))


def M_from_W(W):
    n = dim_of(W)
    M = np.zeros((n, n))
    for i, (a, b) in enumerate(pairs(n)):
        M[a, b] = M[b, a] = W[i, i]
    return M


# ---------------- Weyl subspace ----------------

_WB = {}


def weyl_basis(n):
    """Orthonormal basis (list of DxD symmetric matrices) of Weyl_n."""
    if n in _WB:
        return _WB[n]
    P_ = pairs(n)
    idx = pair_index(n)
    D = len(P_)

    def sidx(i, j):
        if i < j:
            return idx[(i, j)], 1.0
        return idx[(j, i)], -1.0

    # parametrise symmetric DxD matrices
    coords = [(a, b) for a in range(D) for b in range(a, D)]
    cidx = {p: k for k, p in enumerate(coords)}
    NP = len(coords)

    def ent(row, i, j, k, l, coef):
        """add coef * R_{ijkl} into linear form `row`."""
        if i == j or k == l:
            return
        p, s1 = sidx(i, j)
        q, s2 = sidx(k, l)
        key = (p, q) if p <= q else (q, p)
        row[cidx[key]] += coef * s1 * s2

    rows = []
    # first Bianchi
    for i, j, k, l in itertools.combinations(range(n), 4):
        r = np.zeros(NP)
        ent(r, i, j, k, l, 1.0)
        ent(r, i, k, l, j, 1.0)
        ent(r, i, l, j, k, 1.0)
        rows.append(r)
    # Ricci-flat: Ric_ik = sum_j R_{ijkj}
    for i in range(n):
        for k in range(i, n):
            r = np.zeros(NP)
            for j in range(n):
                ent(r, i, j, k, j, 1.0)
            rows.append(r)
    A = np.array(rows)
    # nullspace
    u, s, vt = np.linalg.svd(A)
    tol = max(A.shape) * np.finfo(float).eps * (s[0] if len(s) else 1.0)
    ns = vt[np.sum(s > tol):]
    basis = []
    for v in ns:
        Mx = np.zeros((D, D))
        for k, (a, b) in enumerate(coords):
            Mx[a, b] = v[k]
            Mx[b, a] = v[k]
        basis.append(Mx)
    # orthonormalise w.r.t. <A,B> = tr(AB)
    G = np.array([[ip(X, Y) for Y in basis] for X in basis])
    w, V = np.linalg.eigh(G)
    keep = w > 1e-10
    T = V[:, keep] / np.sqrt(w[keep])
    B = np.tensordot(T.T, np.array(basis), axes=([1], [0]))
    _WB[n] = B
    return B


def weyl_dim(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


def L_matrix(W, n=None, basis=None):
    """Matrix of L_W in an orthonormal basis of Weyl_n."""
    if n is None:
        n = dim_of(W)
    if basis is None:
        basis = weyl_basis(n)
    imgs = np.array([L_W(W, Bk, n) for Bk in basis])
    Lm = np.einsum('kab,lab->kl', imgs, basis)
    resid = np.linalg.norm(imgs - np.tensordot(Lm.T, basis, axes=([0], [0])))
    return Lm, resid


def lam_max_perp(W, n=None, basis=None):
    """lambda_max of L_W restricted to W-perp inside Weyl_n."""
    if n is None:
        n = dim_of(W)
    if basis is None:
        basis = weyl_basis(n)
    Lm, resid = L_matrix(W, n, basis)
    wv = np.array([ip(W, Bk) for Bk in basis])
    wv = wv / np.linalg.norm(wv)
    # orthonormal complement of wv
    Ucomp = np.linalg.svd(wv[:, None])[0][:, 1:]
    Lr = Ucomp.T @ ((Lm + Lm.T) / 2) @ Ucomp
    ev = np.linalg.eigvalsh(Lr)
    return ev[-1], resid, ev


# ---------------- diagonal-locus second-order operator ----------------

def diag_L_eigs(M):
    """Spectrum of L_W restricted to the diagonal-locus part of W-perp.

    The locus is {N hollow symmetric, zero row sums}; L_W acts as
    N -> hollow( M o N + (MN+NM)/2 ) in pair coordinates.  Inner product used
    is the Lambda^2 one, <N,N'> = sum_{a<b} N_ab N'_ab.
    """
    n = M.shape[0]
    P_ = pairs(n)
    D = len(P_)
    # basis of hollow symmetric zero-row-sum, orthonormal in Lambda^2 ip
    rows = []
    for a in range(n):
        r = np.zeros(D)
        for k, (i, j) in enumerate(P_):
            if i == a or j == a:
                r[k] = 1.0
        rows.append(r)
    A = np.array(rows)
    u, s, vt = np.linalg.svd(A)
    tol = max(A.shape) * np.finfo(float).eps * s[0]
    NS = vt[np.sum(s > tol):]          # orthonormal rows, dim D - n
    # operator in pair coords
    Op = np.zeros((D, D))
    for k, (a, b) in enumerate(P_):
        Op[k, k] += M[a, b]
        for e in range(n):
            if e == a or e == b:
                continue
            ka = P_.index((min(a, e), max(a, e)))
            kb = P_.index((min(b, e), max(b, e)))
            Op[k, kb] += 0.5 * M[a, e]
            Op[k, ka] += 0.5 * M[b, e]
    Lr = NS @ Op @ NS.T
    Lr = (Lr + Lr.T) / 2
    # remove the radial direction W
    mvec = np.array([M[a, b] for (a, b) in P_])
    proj = NS @ mvec
    if np.linalg.norm(proj) > 1e-12:
        proj = proj / np.linalg.norm(proj)
        U = np.linalg.svd(proj[:, None])[0][:, 1:]
        Lr = U.T @ Lr @ U
    return np.linalg.eigvalsh(Lr), NS


# ---------------- symmetry defect ----------------

def ad_op(v, n):
    """matrix of ad(v) acting on Lambda^2 ~ so(n), v a vector in pair coords."""
    c = struct(n)
    # (ad(v) x)_ga = sum_{al,be} v_al x_be c[al,be,ga]
    return np.einsum('a,abg->gb', v, c)


def defect(W, tol=1e-9, n=None):
    if n is None:
        n = dim_of(W)
    ev, V = np.linalg.eigh((W + W.T) / 2)
    tot = 0.0
    for k in range(len(ev)):
        if ev[k] > tol:
            A = ad_op(V[:, k], n)
            Cm = A @ W - W @ A
            tot += float(np.sum(Cm * Cm))
    return tot


def defect_diag(M, tol=1e-12):
    """closed form on the diagonal locus: g_ab = 2||M_a-M_b||^2 - 4 M_ab^2."""
    n = M.shape[0]
    tot = 0.0
    for a in range(n):
        for b in range(a + 1, n):
            if M[a, b] > tol:
                tot += 2 * np.sum((M[a] - M[b]) ** 2) - 4 * M[a, b] ** 2
    return tot
