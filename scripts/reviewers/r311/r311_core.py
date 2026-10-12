"""Reviewer 311: independent implementation of the algebraic Weyl-curvature setup.

Built from the mathematical definitions only.  Nothing is imported from the
repository's own libraries.

Conventions fixed here and calibrated by self-tests in r311_selftest.py:

*  Lambda^2(R^n) carries the orthonormal basis  E_{ij} = e_i ^ e_j,  i<j.
*  It is identified with so(n) by  E_{ij} <-> L_{ij}, the matrix with +1 in
   entry (i,j) and -1 in (j,i).  The inner product <A,B> = tr(A^T B)/2 makes
   the L_{ij} orthonormal, so the identification is an isometry.
*  A curvature operator is a symmetric matrix on Lambda^2; its (0,4) tensor is
   R[i,j,k,l] = <R(e_i ^ e_j), e_k ^ e_l>.
*  Hamilton's sharp uses the structure constants of so(n) in that orthonormal
   basis:  (W#)_ab = 1/2 sum c_{acd} c_{bef} W_ce W_df.
   Self-test: Id# = (n-2) Id, and for diagonal W with matrix M the sharp is
   diagonal with entries (M^2)_{ij}.
"""

import numpy as np
import itertools


# ----------------------------------------------------------------- basis ----

def pair_list(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def pair_index(n):
    idx = {}
    for a, (i, j) in enumerate(pair_list(n)):
        idx[(i, j)] = a
        idx[(j, i)] = a
    return idx


def so_basis(n):
    """L_{ij} for i<j, as n x n matrices; orthonormal for <A,B> = tr(A^T B)/2."""
    B = []
    for (i, j) in pair_list(n):
        M = np.zeros((n, n))
        M[i, j] = 1.0
        M[j, i] = -1.0
        B.append(M)
    return np.array(B)


_struct_cache = {}


def structure_constants(n):
    """c[a,b,c] = <[L_a, L_b], L_c> with <A,B> = tr(A^T B)/2.  Sparse-ish but
    small enough to hold densely for n <= 12 (N=66 -> 66^3 = 287k floats)."""
    if n in _struct_cache:
        return _struct_cache[n]
    B = so_basis(n)
    N = len(B)
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(a + 1, N):
            C = B[a] @ B[b] - B[b] @ B[a]
            # expand C in the L basis: coefficient on L_{ij} is C[i,j]
            for cc, (i, j) in enumerate(pair_list(n)):
                if C[i, j] != 0.0:
                    c[a, b, cc] = C[i, j]
                    c[b, a, cc] = -C[i, j]
    _struct_cache[n] = c
    return c


_ad_cache = {}


def ad_matrices(n):
    """ad(L_a) as an N x N matrix acting on Lambda^2 = so(n).
    (ad_a)[c,b] = c[a,b,c]."""
    if n in _ad_cache:
        return _ad_cache[n]
    c = structure_constants(n)
    A = np.transpose(c, (0, 2, 1)).copy()      # A[a][c,b] = c[a,b,c]
    _ad_cache[n] = A
    return A


# ----------------------------------------------------------------- sharp ----

_sp_cache = {}


def _sparse_struct(n):
    """For each basis index a, the list of (c,d,val) with c_{a,c,d} = val.
    The bracket [L_a, L_c] is a single basis vector, so the list has exactly
    2(n-2) entries for every a."""
    if n in _sp_cache:
        return _sp_cache[n]
    c = structure_constants(n)
    N = n * (n - 1) // 2
    m = 2 * (n - 2)
    C = np.zeros((N, m), dtype=int)
    D = np.zeros((N, m), dtype=int)
    V = np.zeros((N, m))
    for a in range(N):
        nz = np.argwhere(np.abs(c[a]) > 1e-12)
        assert len(nz) == m, (a, len(nz), m)
        C[a] = nz[:, 0]
        D[a] = nz[:, 1]
        V[a] = c[a][nz[:, 0], nz[:, 1]]
    _sp_cache[n] = (C, D, V)
    return C, D, V


def sharp_bilin(n, W, H):
    """Polarised sharp: sharp_bilin(W,W) = W#, symmetric bilinear in (W,H).

    (W#)_ab = 1/2 sum_{cdef} c_{acd} c_{bef} W_ce W_df   (calibrated by
    Id# = (n-2) Id and by the diagonal-locus identity W#_(ij) = (M^2)_ij).
    """
    C, D, V = _sparse_struct(n)
    N = W.shape[0]
    Cr = C.ravel(); Dr = D.ravel(); Vv = V.ravel()
    G = (Vv[:, None] * Vv[None, :])
    G = G * W[Cr[:, None], Cr[None, :]] * H[Dr[:, None], Dr[None, :]]
    m = C.shape[1]
    out = 0.5 * G.reshape(N, m, N, m).sum(axis=(1, 3))
    return 0.5 * (out + out.T)


def sharp(n, W):
    return sharp_bilin(n, W, W)


def Q(n, W):
    return W @ W + sharp(n, W)


def L_W(n, W, H):
    """L_W H = (WH + HW)/2 + sharp_bilin(W,H);  = DQ_W(H)/2."""
    return 0.5 * (W @ H + H @ W) + sharp_bilin(n, W, H)


# ------------------------------------------------------- tensor <-> matrix --

_idx_cache = {}


def _idx(n):
    if n in _idx_cache:
        return _idx_cache[n]
    P = pair_list(n)
    I = np.array([p[0] for p in P])
    J = np.array([p[1] for p in P])
    _idx_cache[n] = (I, J)
    return I, J


def op_to_tensor(n, W):
    """R[i,j,k,l] from the operator matrix in the E_{ij} basis."""
    I, J = _idx(n)
    R = np.zeros((n, n, n, n))
    ii = I[:, None]; jj = J[:, None]; kk = I[None, :]; ll = J[None, :]
    R[ii, jj, kk, ll] = W
    R[jj, ii, kk, ll] = -W
    R[ii, jj, ll, kk] = -W
    R[jj, ii, ll, kk] = W
    return R


def tensor_to_op(n, R):
    I, J = _idx(n)
    return R[I[:, None], J[:, None], I[None, :], J[None, :]].copy()


# --------------------------------------------------------- Weyl projection --

def bianchi_project(n, R):
    """Orthogonal projection of a (0,4) tensor with pair symmetries onto the
    algebraic curvature tensors (kernel of the first Bianchi map)."""
    A = (R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))) / 3.0
    return R - A


def ricci(n, R):
    return np.einsum('ijkj->ik', R)


def kn(A, B):
    """Kulkarni-Nomizu product."""
    return (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
            - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))


def weyl_project_tensor(n, R):
    R = bianchi_project(n, R)
    g = np.eye(n)
    Ric = ricci(n, R)
    s = np.trace(Ric)
    Ric0 = Ric - (s / n) * g
    W = R - kn(Ric0, g) / (n - 2) - (s / (2.0 * n * (n - 1))) * kn(g, g)
    return W


def weyl_project(n, W):
    """Orthogonal projection of a symmetric operator on Lambda^2 onto Weyl_n."""
    return tensor_to_op(n, weyl_project_tensor(n, op_to_tensor(n, W)))


_wb_cache = {}


def weyl_basis(n):
    """Orthonormal basis of Weyl_n inside Sym^2(Lambda^2)."""
    if n in _wb_cache:
        return _wb_cache[n]
    N = n * (n - 1) // 2
    idx = [(a, b) for a in range(N) for b in range(a, N)]
    D = len(idx)
    Pm = np.zeros((D, D))
    r2 = np.sqrt(2.0)
    for t, (a, b) in enumerate(idx):
        E = np.zeros((N, N))
        if a == b:
            E[a, a] = 1.0
        else:
            E[a, b] = E[b, a] = 1.0 / r2
        Y = weyl_project(n, E)
        col = np.array([Y[c_, d_] * (1.0 if c_ == d_ else r2) for (c_, d_) in idx])
        Pm[:, t] = col
    Pm = 0.5 * (Pm + Pm.T)
    ev, evec = np.linalg.eigh(Pm)
    sel = evec[:, ev > 0.5]
    out = np.zeros((sel.shape[1], N, N))
    for k in range(sel.shape[1]):
        M = np.zeros((N, N))
        for t, (a, b) in enumerate(idx):
            v = sel[t, k] * (1.0 if a == b else 1.0 / r2)
            M[a, b] = v
            M[b, a] = v
        out[k] = M
    _wb_cache[n] = out
    return out


# ------------------------------------------------------------------ L_e ----

def Le_matrix(n, W, theta, basis=None):
    """Matrix of L_e = L_W/theta in an orthonormal basis of Weyl_n."""
    if basis is None:
        basis = weyl_basis(n)
    K = len(basis)
    img = np.array([L_W(n, W, basis[k]) / theta for k in range(K)])
    B = np.array([b.ravel() for b in basis])
    return img.reshape(K, -1) @ B.T          # M[k,l] = <L_e b_k, b_l>


def lambda_max_perp(n, W, theta, basis=None):
    """Largest eigenvalue of L_e on Weyl_n intersect W-perp."""
    if basis is None:
        basis = weyl_basis(n)
    B = np.array([b.ravel() for b in basis])
    w = W.ravel() / np.linalg.norm(W)
    coef = B @ w
    # orthonormal basis of the complement inside span(basis)
    Qm, _ = np.linalg.qr(np.column_stack([coef, np.eye(len(basis))]))
    comp = Qm[:, 1:len(basis)]
    M = Le_matrix(n, W, theta, basis)
    M = 0.5 * (M + M.T)
    Mc = comp.T @ M @ comp
    return np.linalg.eigvalsh(0.5 * (Mc + Mc.T))


# ------------------------------------------------------------- defect ------

def defect(n, W, tol=1e-9):
    """Delta(W) = sum over unit eigenvectors with positive eigenvalue of
    ||[ad(v), W]||^2, Frobenius norm on operators on Lambda^2."""
    ev, evec = np.linalg.eigh(W)
    A = ad_matrices(n)
    tot = 0.0
    pos = 0.0
    for k in range(len(ev)):
        v = evec[:, k]
        adv = np.tensordot(v, A, axes=(0, 0))
        C = adv @ W - W @ adv
        g = float(np.sum(C * C))
        tot += g
        if ev[k] > tol:
            pos += g
    return pos, tot, ev
