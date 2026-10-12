"""Reviewer 313: independent implementation of Hamilton's cubic on algebraic Weyl operators.

Built from definitions only.  No repository script is imported.

Conventions
-----------
Lambda^2(R^n) has orthonormal basis phi_a = A_{ij} = E_ij - E_ji for a = (i<j),
under <X,Y> = (1/2) tr(X^T Y).  A symmetric operator R on Lambda^2 has matrix
R[a,b]; the tensor is R_{ijkl} = <R(e_i^e_j), e_k^e_l> with the antisymmetric
extension.  Round sphere: R = Id gives Ric = (n-1) g.

Sharp:  R^#_{ab} = (1/2) sum_{cdef} c_{acd} c_{bef} R_{ce} R_{df},
        c_{abc} = <[phi_b, phi_c], phi_a>.
Bilinear: (W # H)_{ab} = (1/2) sum c_{acd} c_{bef} W_{ce} H_{df}   (symmetric in W,H).
Q(R) = R^2 + R^#.  P(W) = <W, Q(W)>.  L_W(H) = (WH+HW)/2 + W#H.
"""
import numpy as np
from functools import lru_cache


# ---------------------------------------------------------------- basis / structure
@lru_cache(maxsize=None)
def pairs(n):
    return tuple((i, j) for i in range(n) for j in range(i + 1, n))


@lru_cache(maxsize=None)
def pidx(n):
    P = pairs(n)
    d = {}
    for a, (i, j) in enumerate(P):
        d[(i, j)] = (a, 1.0)
        d[(j, i)] = (a, -1.0)
    return d


@lru_cache(maxsize=None)
def basis_mats(n):
    P = pairs(n)
    B = np.zeros((len(P), n, n))
    for a, (i, j) in enumerate(P):
        B[a, i, j] = 1.0
        B[a, j, i] = -1.0
    return B


@lru_cache(maxsize=None)
def struct(n):
    """c[a,b,c] = <[phi_b, phi_c], phi_a>, dense (N,N,N)."""
    B = basis_mats(n)
    P = pairs(n)
    N = len(P)
    c = np.zeros((N, N, N))
    for b in range(N):
        # commutators [phi_b, phi_d] for all d at once
        Cm = B[b] @ B - np.einsum('dij,jk->dik', B, B[b])  # (N,n,n)
        for a, (i, j) in enumerate(P):
            c[a, b, :] = Cm[:, i, j]
    return c


def vec_of(n, X):
    """coordinates of an antisymmetric matrix X in the phi basis."""
    P = pairs(n)
    return np.array([X[i, j] for (i, j) in P])


def mat_of(n, v):
    B = basis_mats(n)
    return np.tensordot(v, B, axes=(0, 0))


# ---------------------------------------------------------------- sharp / Q
def sharp_bilin(n, W, H):
    c = struct(n)
    N = c.shape[0]
    # U[a,e,d] = sum_c c[a,c,d] W[c,e]
    U = np.einsum('acd,ce->aed', c, W, optimize=True)
    V = np.einsum('aed,df->aef', U, H, optimize=True)
    out = 0.5 * np.einsum('aef,bef->ab', V, c, optimize=True)
    return 0.5 * (out + out.T)


def sharp(n, W):
    return sharp_bilin(n, W, W)


def Qmap(n, W):
    return W @ W + sharp(n, W)


def L_op(n, W, H):
    return 0.5 * (W @ H + H @ W) + sharp_bilin(n, W, H)


# ---------------------------------------------------------------- Weyl space
def _sym_param_maps(N):
    """index bookkeeping for the isometric parametrisation of Sym(R^N)."""
    idx = []
    for a in range(N):
        for b in range(a, N):
            idx.append((a, b))
    return idx


@lru_cache(maxsize=None)
def weyl_basis(n):
    """orthonormal basis of Weyl_n as a (dim, N, N) array of symmetric matrices."""
    P = pairs(n)
    N = len(P)
    D = pidx(n)
    idx = _sym_param_maps(N)
    npar = len(idx)
    pos = {ab: k for k, ab in enumerate(idx)}

    def add(row, a, b, val):
        if a > b:
            a, b = b, a
        row[pos[(a, b)]] += val * (1.0 if a == b else 1.0 / np.sqrt(2.0))

    rows = []
    # first Bianchi over i<j<k<l
    for i in range(n):
        for j in range(i + 1, n):
            for k in range(j + 1, n):
                for l in range(k + 1, n):
                    row = np.zeros(npar)
                    for (p, q, r, s) in ((i, j, k, l), (i, k, l, j), (i, l, j, k)):
                        a, sa = D[(p, q)]
                        b, sb = D[(r, s)]
                        add(row, a, b, sa * sb)
                    rows.append(row)
    # Ricci
    for i in range(n):
        for k in range(i, n):
            row = np.zeros(npar)
            for j in range(n):
                if j == i or j == k:
                    continue
                a, sa = D[(i, j)]
                b, sb = D[(k, j)]
                add(row, a, b, sa * sb)
            rows.append(row)
    C = np.array(rows)
    # nullspace
    _, s, Vt = np.linalg.svd(C, full_matrices=True)
    tol = max(C.shape) * np.finfo(float).eps * (s[0] if len(s) else 1.0)
    rank = int((s > tol).sum())
    ns = Vt[rank:]           # (dim, npar), orthonormal rows in the isometric params
    dim = ns.shape[0]
    B = np.zeros((dim, N, N))
    for t in range(dim):
        v = ns[t]
        M = np.zeros((N, N))
        for k, (a, b) in enumerate(idx):
            if a == b:
                M[a, a] = v[k]
            else:
                M[a, b] = M[b, a] = v[k] / np.sqrt(2.0)
        B[t] = M
    return B


def weyl_dim_formula(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


def coords(n, X):
    B = weyl_basis(n)
    return np.einsum('tab,ab->t', B, X)


def from_coords(n, v):
    B = weyl_basis(n)
    return np.tensordot(v, B, axes=(0, 0))


def proj_weyl(n, X):
    X = 0.5 * (X + X.T)
    return from_coords(n, coords(n, X))


# ---------------------------------------------------------------- diagnostics
def theta_of(n, W):
    return float(np.tensordot(W, Qmap(n, W), axes=2) / np.tensordot(W, W, axes=2))


def crit_residual(n, W):
    th = theta_of(n, W)
    return float(np.linalg.norm(Qmap(n, W) - th * W)), th


def Le_matrix(n, W, theta, chunk=64):
    """matrix of L_W/theta on the Weyl basis."""
    B = weyl_basis(n)
    dim = B.shape[0]
    c = struct(n)
    U = np.einsum('acd,ce->aed', c, W, optimize=True)
    out = np.zeros((dim, dim))
    for st in range(0, dim, chunk):
        Hs = B[st:st + chunk]
        V = np.einsum('aed,bdf->baef', U, Hs, optimize=True)
        sh = 0.5 * np.einsum('baef,cef->bac', V, c, optimize=True)
        sh = 0.5 * (sh + np.transpose(sh, (0, 2, 1)))
        img = 0.5 * (W @ Hs + Hs @ W) + sh
        out[st:st + chunk] = np.einsum('bab,...->', np.zeros(0), 0) if False else np.einsum('kab,tab->kt', img, B)
    return out / theta


def lam_max_perp(n, W, theta=None):
    """largest eigenvalue of L_e restricted to W-perp inside Weyl_n; returns (lam, evec)."""
    if theta is None:
        theta = theta_of(n, W)
    Bw = weyl_basis(n)
    Lm = Le_matrix(n, W, theta)
    Lm = 0.5 * (Lm + Lm.T)
    w = coords(n, W)
    w = w / np.linalg.norm(w)
    dim = len(w)
    # orthonormal complement of w
    Qf, _ = np.linalg.qr(np.column_stack([w, np.eye(dim)]))
    Cperp = Qf[:, 1:dim]
    Lp = Cperp.T @ Lm @ Cperp
    ev, evec = np.linalg.eigh(Lp)
    return float(ev[-1]), Cperp @ evec[:, -1], ev, Cperp, Lm
