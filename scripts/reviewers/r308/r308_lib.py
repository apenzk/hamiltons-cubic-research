"""Reviewer 308 -- independent implementation, written from the definitions.

Conventions fixed here and anchored on two facts external to this repo's code:
  * basis of so(n) = Lambda^2 R^n: phi_{ij} = E_ij - E_ji (i<j), orthonormal for
    <A,B> = 1/2 tr(A^T B).  Structure constants c[a,b,g] = <[phi_a,phi_b],phi_g>
    computed from the matrix commutator, entries in {0,+-1}.
  * sharp: (R#S)_{ab} = -1/4 ( tr(C_a R C_b S) + tr(C_a S C_b R) ), C_a = ad(phi_a).
    The overall constant is PINNED below by the published diagonal formula
    (R#S)_{ij,ij} = 1/2 sum_k (r_ik s_jk + r_jk s_ik)   [Jaeger 2016 / Poljsak 2022].
"""
import numpy as np
from itertools import combinations


def basis(n):
    idx = list(combinations(range(n), 2))
    pos = {p: k for k, p in enumerate(idx)}
    return idx, pos, len(idx)


def struct(n):
    idx, pos, N = basis(n)
    c = np.zeros((N, N, N))
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            terms = []
            if j == k: terms.append((1.0, (i, l)))
            if i == k: terms.append((-1.0, (j, l)))
            if j == l: terms.append((-1.0, (i, k)))
            if i == l: terms.append((1.0, (j, k)))
            for co, (u, v) in terms:
                if u == v:
                    continue
                s = 1.0
                if u > v:
                    u, v, s = v, u, -1.0
                c[a, b, pos[(u, v)]] += co * s
    return idx, pos, N, c


def ad(c):
    """ad[a][g,b] = c[a,b,g] so that ad(phi_a) acts as a matrix on coefficient vectors."""
    return np.transpose(c, (0, 2, 1))


def sharp_bilin(A, R, S):
    """A = ad tensor. Symmetric bilinear sharp."""
    T1 = np.einsum('agb,bd->agd', A, R, optimize=True)   # ad_a @ R
    T2 = np.einsum('agb,bd->agd', A, S, optimize=True)   # ad_a @ S
    M = -0.25 * (np.einsum('agd,bdg->ab', T1, T2, optimize=True)
                 + np.einsum('agd,bdg->ab', T2, T1, optimize=True))
    return M


def sharp(A, R):
    T = np.einsum('agb,bd->agd', A, R, optimize=True)
    return -0.5 * np.einsum('agd,bdg->ab', T, T, optimize=True)


def Qop(A, R):
    return R @ R + sharp(A, R)


# ---------- curvature-tensor side: Bianchi and Ricci, from the operator ----------

def tensor_from_op(M, idx, pos, n):
    """T_ijkl with T = 0 on repeated indices, antisymmetric in (ij),(kl)."""
    T = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            v = M[a, b]
            T[i, j, k, l] = v;  T[j, i, k, l] = -v
            T[i, j, l, k] = -v; T[j, i, l, k] = v
    return T


def weyl_constraints(n, sym_basis, idx, pos):
    """Rows of the linear map (Bianchi, Ricci) applied to each element of sym_basis."""
    rows = []
    for M in sym_basis:
        T = tensor_from_op(M, idx, pos, n)
        B = T + np.transpose(T, (0, 2, 3, 1)) + np.transpose(T, (0, 3, 1, 2))
        ric = np.einsum('ijil->jl', T)
        rows.append(np.concatenate([B.ravel(), ric.ravel()]))
    return np.array(rows)


def nullspace_basis(vecs, rows, tol=1e-9):
    """vecs: (m, N, N) candidate directions; rows: (m, K) constraint values.
    Returns an orthonormal (in Frobenius) basis of the subspace of span(vecs) with rows=0."""
    U, s, Vt = np.linalg.svd(rows, full_matrices=True)
    r = int((s > tol * max(1.0, s[0])).sum())
    coeff = U[:, r:].T if U.shape[0] > r else np.zeros((0, len(vecs)))
    out = np.einsum('km,mij->kij', coeff, vecs)
    # orthonormalise in Frobenius
    flat = out.reshape(len(out), -1)
    Qm, _ = np.linalg.qr(flat.T)
    return Qm.T.reshape(-1, vecs.shape[1], vecs.shape[2])


def sym_basis_full(N):
    out = []
    for a in range(N):
        for b in range(a, N):
            M = np.zeros((N, N))
            if a == b:
                M[a, a] = 1.0
            else:
                M[a, b] = M[b, a] = 1.0 / np.sqrt(2.0)
            out.append(M)
    return np.array(out)


def sym_basis_blocks(N, kidx, midx):
    out = []
    for grp in (kidx, midx):
        for ii, a in enumerate(grp):
            for b in grp[ii:]:
                M = np.zeros((N, N))
                if a == b:
                    M[a, a] = 1.0
                else:
                    M[a, b] = M[b, a] = 1.0 / np.sqrt(2.0)
                out.append(M)
    return np.array(out)


def split_indices(n, p, idx):
    """k = so(p)+so(q) planes (both endpoints on same side); m = mixed planes."""
    kidx = [a for a, (i, j) in enumerate(idx) if (i < p) == (j < p)]
    midx = [a for a, (i, j) in enumerate(idx) if (i < p) != (j < p)]
    return kidx, midx


def sphere_product_W(n, p, idx):
    q = n - p
    lam = np.zeros(len(idx))
    for a, (i, j) in enumerate(idx):
        if i < p and j < p:
            lam[a] = 1.0 / (p * (p - 1)) if p > 1 else 0.0
        elif i >= p and j >= p:
            lam[a] = 1.0 / (q * (q - 1)) if q > 1 else 0.0
        else:
            lam[a] = -1.0 / (p * q)
    W = np.diag(lam)
    return W / np.linalg.norm(W)
