"""Reviewer 40 -- independent machinery for Weyl_n, Q, the o-product and L_e.

Written from the definitions in findings/INDEX.md / the review brief.  Nothing is
imported from scripts/b_*.py or scripts/review_r*.py.

Conventions (brief SETUP):
    phi_ij = E_ij - E_ji  (i<j), <X,Y> = 1/2 tr(X^T Y)  -> {phi_ij} orthonormal
    (A_a)_{mn} = c_amn, structure constants of so(n) in that basis
    (W^#)_ab   = -1/2 tr(A_a W A_b W)
    Q(W)       = W^2 + W^#
    X o Y      = 1/2 (XY + YX) + sharp_bilin(X,Y)
    sharp_bilin_ab = -1/4 (T_ab + T_ba),  T_ab = tr(A_a X A_b Y)
    Weyl_n     = {W in Sym(Lambda^2) : first Bianchi, Ric = 0}
"""
import numpy as np
from itertools import combinations

# ---------------------------------------------------------------- so(n) basis


def pairs_of(n):
    prs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    idx = {p: a for a, p in enumerate(prs)}
    return prs, idx


def so_basis(n):
    prs, idx = pairs_of(n)
    N = len(prs)
    B = np.zeros((N, n, n))
    for a, (i, j) in enumerate(prs):
        B[a, i, j] = 1.0
        B[a, j, i] = -1.0
    return B, prs, idx


def struct_const(n):
    """A[a] = matrix of ad(phi_a): ad(phi_a) phi_b = sum_c A[a][c,b] phi_c."""
    B, prs, idx = so_basis(n)
    N = len(prs)
    A = np.zeros((N, N, N))
    for a in range(N):
        Ba = B[a]
        for b in range(N):
            C = Ba @ B[b] - B[b] @ Ba
            for c, (i, j) in enumerate(prs):
                v = C[i, j]
                if v != 0.0:
                    A[a][c, b] = v
    return A


# ------------------------------------------------------------------ sharp / Q


def _G(A, X):
    """G[a,m,p] = sum_n (A_a)_{mn} X_{np}."""
    return np.einsum('amn,np->amp', A, X, optimize=True)


def sharp(A, W):
    G = _G(A, W)
    return -0.5 * np.einsum('amp,bpm->ab', G, G, optimize=True)


def sharp_bilin(A, X, Y, GX=None):
    GX = _G(A, X) if GX is None else GX
    GY = _G(A, Y)
    T = np.einsum('amp,bpm->ab', GX, GY, optimize=True)
    return -0.25 * (T + T.T)


def Qop(A, W):
    return W @ W + sharp(A, W)


def circ(A, X, Y, GX=None):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(A, X, Y, GX=GX)


def ip(X, Y):
    """Operator inner product on Sym(Lambda^2): tr(X^T Y) in the phi pair basis.

    NB the 1/2 tr(X^T Y) of the brief is the inner product on so(n) ~ Lambda^2 that
    makes {phi_ij} orthonormal; at the *operator* level the induced product is the
    plain Frobenius one on the N x N pair matrix.  Anchored in review_r40_anchor.py:
    only this choice reproduces theta_0(n) = sqrt(2(n-1)(n-2))/n and Nienhaus 2.25.
    """
    return float(np.sum(X * Y))


# --------------------------------------------------------------- 4-tensor map


def to_tensor(n, W, prs):
    """R_{ijkl} from the pair matrix, antisymmetrised in ij and kl."""
    R = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(prs):
        for b, (k, l) in enumerate(prs):
            v = W[a, b]
            for (si, ii, jj) in ((1, i, j), (-1, j, i)):
                for (sk, kk, ll) in ((1, k, l), (-1, l, k)):
                    R[ii, jj, kk, ll] = si * sk * v
    return R


# ------------------------------------------------------------- Weyl_n basis


def weyl_basis(n, verbose=False):
    """Orthonormal basis of Weyl_n inside Sym(Lambda^2 R^n), as (D,N,N) array."""
    prs, idx = pairs_of(n)
    N = len(prs)
    # coordinates: symmetric N x N -> upper triangle including diagonal
    coord = []
    cidx = {}
    for a in range(N):
        for b in range(a, N):
            cidx[(a, b)] = len(coord)
            coord.append((a, b))
    M = len(coord)

    def sym_put(row, a, b, v):
        if a > b:
            a, b = b, a
        row[cidx[(a, b)]] += v

    def Rcoef(row, i, j, k, l, v):
        """add v * R_{ijkl} to a linear form 'row'."""
        if i == j or k == l:
            return
        s = 1.0
        if i > j:
            i, j = j, i
            s = -s
        if k > l:
            k, l = l, k
            s = -s
        sym_put(row, idx[(i, j)], idx[(k, l)], s * v)

    rows = []
    # first Bianchi: R_ijkl + R_iklj + R_iljk = 0, for i<j<k<l
    for (i, j, k, l) in combinations(range(n), 4):
        row = np.zeros(M)
        Rcoef(row, i, j, k, l, 1.0)
        Rcoef(row, i, k, l, j, 1.0)
        Rcoef(row, i, l, j, k, 1.0)
        rows.append(row)
    # Ricci: sum_i R_{ijil} = 0
    for j in range(n):
        for l in range(j, n):
            row = np.zeros(M)
            for i in range(n):
                Rcoef(row, i, j, i, l, 1.0)
            rows.append(row)
    Cm = np.array(rows)
    # isometric coordinates: W_ab = W_ba = y/sqrt(2) off-diagonal, W_aa = y
    scale = np.array([1.0 if a == b else 1.0 / np.sqrt(2.0) for (a, b) in coord])
    Cm = Cm * scale[None, :]
    U, s_, Vt = np.linalg.svd(Cm)
    tol = max(Cm.shape) * (s_[0] if len(s_) else 1.0) * 1e-12
    rank = int(np.sum(s_ > tol))
    ns = Vt[rank:]                       # (D, M), rows orthonormal
    D = ns.shape[0]
    Bs = np.zeros((D, N, N))
    ns_s = ns * scale[None, :]
    for c, (a, b) in enumerate(coord):
        Bs[:, a, b] += ns_s[:, c]
        if a != b:
            Bs[:, b, a] += ns_s[:, c]
    if verbose:
        print(f"  weyl_basis n={n}: constraints {Cm.shape}, rank {rank}, dim {D}")
    return Bs, prs, idx


def weyl_dim_formula(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


# ------------------------------------------------------- projection utilities


def coords(Bs, X):
    return np.einsum('dij,ij->d', Bs, X)


def from_coords(Bs, c):
    return np.einsum('d,dij->ij', c, Bs)


def project(Bs, X):
    return from_coords(Bs, coords(Bs, X))


# ------------------------------------------------------------- rho on Lambda^2


def rho_alg(n, E, prs):
    """so(n) element E -> its action on Lambda^2 in the phi basis (antisym N x N)."""
    B, _, idx = so_basis(n)
    N = len(prs)
    out = np.zeros((N, N))
    for b, (i, j) in enumerate(prs):
        C = E @ B[b] - B[b] @ E
        for c, (k, l) in enumerate(prs):
            v = C[k, l]
            if v != 0.0:
                out[c, b] = v
    return out


def rho_grp(n, g, prs):
    """g in O(n) -> Lambda^2 g in the phi basis."""
    N = len(prs)
    out = np.zeros((N, N))
    B, _, _ = so_basis(n)
    for b, (i, j) in enumerate(prs):
        C = g @ B[b] @ g.T
        for c, (k, l) in enumerate(prs):
            out[c, b] = C[k, l]
    return out


# ------------------------------------------------------------------ L_e matrix


def L_matrix(A, Bs, e, chunk=40, progress=None):
    """Matrix of X -> e o X in the orthonormal Weyl basis Bs, plus out-of-Weyl residual."""
    D = Bs.shape[0]
    Ge = _G(A, e)
    L = np.zeros((D, D))
    resid = 0.0
    for s in range(0, D, chunk):
        blk = Bs[s:s + chunk]
        GY = np.einsum('amn,cnp->camp', A, blk, optimize=True)
        T = np.einsum('amp,cbpm->cab', Ge, GY, optimize=True)
        sb = -0.25 * (T + np.transpose(T, (0, 2, 1)))
        anti = 0.5 * (np.einsum('ij,cjk->cik', e, blk) + np.einsum('cij,jk->cik', blk, e))
        img = anti + sb
        L[:, s:s + chunk] = Bs.reshape(D, -1) @ img.reshape(len(blk), -1).T
        back = np.einsum('dc,dij->cij', L[:, s:s + chunk], Bs)
        resid = max(resid, float(np.max(np.abs(img - back))))
        if progress is not None:
            progress(s + len(blk), D, resid)
    return L, resid
