"""Reviewer 112 -- independent implementation from the brief's definitions.

Conventions (brief):
  Lambda^2 basis: phi_{ij} = E_ij - E_ji, i<j, UNNORMALISED, declared orthonormal
  via <X,Y> = 1/2 tr(X^T Y).   [checked: this is the convention that makes the
  row marginal rho_alpha = 2(n-2)]
  M_{(ij),(kl)} = W_{ijkl};  ||M||_F = 1.
  c_{abg} = <[phi_a,phi_b],phi_g>;  T_{g,a,b} = c_{gab}^2 (fully symmetric).
"""
import itertools
import numpy as np


def pairs(n):
    return list(itertools.combinations(range(n), 2))


def phis(n):
    P = pairs(n)
    out = np.zeros((len(P), n, n))
    for a, (i, j) in enumerate(P):
        out[a, i, j] = 1.0
        out[a, j, i] = -1.0
    return out


def ip(X, Y):
    return 0.5 * np.einsum('...ij,...ij->...', X, Y)


_C = {}
def struct(n):
    """c[a,b,g] = <[phi_a,phi_b], phi_g>, totally antisymmetric."""
    if n in _C:
        return _C[n]
    Ph = phis(n)
    Br = np.einsum('aik,bkj->abij', Ph, Ph) - np.einsum('bik,akj->abij', Ph, Ph)
    c = 0.5 * np.einsum('abij,gij->abg', Br, Ph)
    _C[n] = c
    return c


_B = {}
def weyl_basis(n):
    """Orthonormal basis of Weyl_n inside Sym^2(Lambda^2), as (D, N, N)."""
    if n in _B:
        return _B[n]
    P = pairs(n)
    N = len(P)
    idx = {p: a for a, p in enumerate(P)}

    def ent(Mt, i, j, k, l):
        if i == j or k == l:
            return 0.0
        si = 1.0
        if i > j:
            i, j, si = j, i, -si
        if k > l:
            k, l, si = l, k, -si
        return si * Mt[idx[(i, j)], idx[(k, l)]]

    # basis of Sym^2(Lambda^2)
    B0 = []
    for a in range(N):
        for b in range(a, N):
            Mt = np.zeros((N, N))
            Mt[a, b] = Mt[b, a] = 1.0
            B0.append(Mt / np.linalg.norm(Mt))
    B0 = np.array(B0)

    # constraints: first Bianchi (-> Lambda^4) and trace (-> Sym^2 R^n)
    rows = []
    quad = list(itertools.combinations(range(n), 4))
    for Mt in B0:
        r = []
        for (i, j, k, l) in quad:
            r.append(ent(Mt, i, j, k, l) + ent(Mt, i, k, l, j) + ent(Mt, i, l, j, k))
        for i in range(n):
            for j in range(i, n):
                r.append(sum(ent(Mt, i, p, j, p) for p in range(n)))
        rows.append(r)
    A = np.array(rows).T                      # (constraints, dim Sym^2)
    _, s, Vt = np.linalg.svd(A, full_matrices=True)
    tol = max(A.shape) * np.finfo(float).eps * (s[0] if s.size else 1.0)
    rk = int((s > tol).sum())
    ns = Vt[rk:]                              # (D, dim Sym^2)
    Bs = np.einsum('dk,kij->dij', ns, B0)
    # re-orthonormalise in matrix Frobenius inner product
    D = Bs.shape[0]
    F = Bs.reshape(D, -1)
    Ql, _ = np.linalg.qr(F.T)
    Bs = Ql.T.reshape(-1, N, N)
    _B[n] = Bs
    return Bs


def proj_weyl(n, M):
    Bs = weyl_basis(n)
    co = np.einsum('dij,ij->d', Bs, M)
    return np.einsum('d,dij->ij', co, Bs)


def sharp(n, M):
    """W^# from the Lie-algebra square:  (W^#)_ab = 1/2 c_acd c_bef W_ce W_df."""
    c = struct(n)
    Tmp = np.einsum('acd,ce->aed', c, M)
    Tmp = np.einsum('aed,df->aef', Tmp, M)
    return 0.5 * np.einsum('aef,bef->ab', Tmp, c)


def Qop(n, M):
    return M @ M + sharp(n, M)


def theta(n, M):
    return float(np.sum(Qop(n, M) * M))


def crit_residual(n, M):
    th = theta(n, M)
    return np.linalg.norm(proj_weyl(n, Qop(n, M)) - th * M)


# ---------- test points ----------
def riem_to_op(n, R):
    P = pairs(n)
    N = len(P)
    M = np.zeros((N, N))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            M[a, b] = R[i, j, k, l]
    return M


def sphere_product(n, k):
    l = n - k
    R = np.zeros((n, n, n, n))
    for blk in (range(k), range(k, n)):
        blk = list(blk)
        for i in blk:
            for j in blk:
                for p in blk:
                    for q in blk:
                        R[i, j, p, q] += (i == p) * (j == q) - (i == q) * (j == p)
    M = proj_weyl(n, riem_to_op(n, R))
    return M / np.linalg.norm(M)


def pad(n0, n, M0):
    """Zero-pad an operator on Lambda^2(R^n0) into Lambda^2(R^n)."""
    P0, P = pairs(n0), pairs(n)
    idx = {q: b for b, q in enumerate(P)}
    M = np.zeros((len(P), len(P)))
    for a, q in enumerate(P0):
        for b, r in enumerate(P0):
            M[idx[q], idx[r]] = M0[a, b]
    return M


def cp2(n):
    """Fubini-Study Weyl tensor of CP^2 (n0=4), zero-padded into R^n."""
    n0 = 4
    J = np.zeros((n0, n0))
    J[0, 1] = 1; J[1, 0] = -1; J[2, 3] = 1; J[3, 2] = -1
    g = np.eye(n0)
    R = (np.einsum('ik,jl->ijkl', g, g) - np.einsum('il,jk->ijkl', g, g)
         + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
         + 2 * np.einsum('ij,kl->ijkl', J, J))
    M0 = proj_weyl(n0, riem_to_op(n0, R))
    M0 = M0 / np.linalg.norm(M0)
    return M0 if n == n0 else pad(n0, n, M0)


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


# ---------- slack ----------
def neg_space(n, M, tol=1e-9):
    ev, V = np.linalg.eigh(M)
    return V[:, ev < -tol], ev


def slack_mmm(n, M, tol=1e-9):
    """S = sum_{a<b in m} ||Pi_m [X_a,X_b]||^2  (the r52 convention)."""
    Vn, _ = neg_space(n, M, tol)
    k = Vn.shape[1]
    if k < 2:
        return 0.0
    c = struct(n)
    cm = np.einsum('abg,ax,by,gz->xyz', c, Vn, Vn, Vn, optimize=True)
    return 0.5 * float(np.sum(cm * cm))


def slack_hhm(n, M, tol=1e-9):
    Vn, _ = neg_space(n, M, tol)
    Pm = Vn @ Vn.T
    Ph = np.eye(M.shape[0]) - Pm
    c = struct(n)
    t = np.einsum('abg,ax,by,gz->xyz', c, Ph, Ph, Pm, optimize=True)
    return float(np.sum(t * t))


# ---------- second-order machinery ----------
def sh(n, A, B):
    """Polarised Lie-algebra square: sh(W,W) = W^#, <sh(A,B),C> totally symmetric."""
    c = struct(n)
    t1 = np.einsum('acd,ce,df->aef', c, A, B, optimize=True)
    t2 = np.einsum('acd,ce,df->aef', c, B, A, optimize=True)
    return 0.25 * np.einsum('aef,bef->ab', t1 + t2, c, optimize=True)


def Lop(n, M):
    """Matrix of v -> Pi_Weyl[ 1/2 (Mv+vM) + sh(M,v) ] in the Weyl basis."""
    Bs = weyl_basis(n)
    D = Bs.shape[0]
    out = np.zeros((D, D))
    for d in range(D):
        v = Bs[d]
        Lv = 0.5 * (M @ v + v @ M) + sh(n, M, v)
        out[:, d] = np.einsum('eij,ij->e', Bs, Lv)
    return 0.5 * (out + out.T)


def lam2(g):
    """Lambda^2 of an n x n matrix, in the phi basis."""
    n = g.shape[0]
    P = pairs(n)
    N = len(P)
    out = np.zeros((N, N))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            out[a, b] = g[i, k] * g[j, l] - g[i, l] * g[j, k]
    return out


def orbit_tangent(n, M):
    """Basis (as Weyl-coordinate vectors) of the O(n)-orbit tangent at M."""
    Bs = weyl_basis(n)
    c = struct(n)
    P = pairs(n)
    cols = []
    for a in range(len(P)):
        Aa = c[a]                       # ad(phi_a) on Lambda^2: (Aa)_{b,g}?  fix sign below
        Aa = -c[a].T                    # <[phi_a, phi_b], phi_g> -> matrix acting b->g
        v = Aa @ M + M @ Aa.T
        cols.append(np.einsum('eij,ij->e', Bs, v))
    return np.array(cols).T


def coords(n, M):
    return np.einsum('dij,ij->d', weyl_basis(n), M)


def from_coords(n, x):
    return np.einsum('d,dij->ij', x, weyl_basis(n))
