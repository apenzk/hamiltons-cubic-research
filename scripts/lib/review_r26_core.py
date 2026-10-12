"""Reviewer 26: independent implementation from definitions only.

Lambda^2 R^n has orthonormal basis phi_{ij} = E_ij - E_ji (i<j) under <X,Y> = 1/2 tr(X^T Y).
c_{abg} = <[phi_a,phi_b],phi_g>.  (A_a)_{mn} = c_{amn}.
(W^#)_{ab} = -1/2 tr(A_a W A_b W).  Q(W) = W^2 + W^#.  P(W) = <W,Q(W)> = tr(W Q(W)).
"""
import numpy as np
import itertools


def basis_pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def phi_mats(n):
    prs = basis_pairs(n)
    mats = []
    for (i, j) in prs:
        M = np.zeros((n, n))
        M[i, j] = 1.0
        M[j, i] = -1.0
        mats.append(M)
    return prs, np.array(mats)


def ip(X, Y):
    """<X,Y> = 1/2 tr(X^T Y)"""
    return 0.5 * np.trace(X.T @ Y)


def coeffs_of_skew(M, prs):
    """<M, phi_ij> = M_ij for skew M (derived, checked in tests)."""
    return np.array([M[i, j] for (i, j) in prs])


def struct_const(n):
    """Dense C[a,b,g] = <[phi_a,phi_b],phi_g>, built by literal matrix commutators."""
    prs, mats = phi_mats(n)
    N = len(prs)
    C = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            br = mats[a] @ mats[b] - mats[b] @ mats[a]
            C[a, b, :] = coeffs_of_skew(br, prs)
    return C


def sharp(W, C):
    """(W^#)_ab = -1/2 tr(A_a W A_b W), A_a = C[a,:,:]."""
    N = W.shape[0]
    out = np.empty((N, N))
    for a in range(N):
        AaW = C[a] @ W
        for b in range(a, N):
            out[a, b] = -0.5 * np.trace(AaW @ C[b] @ W)
            out[b, a] = out[a, b]
    return out


def sharp_fast(W, C):
    """Same via einsum:  W^#_ab = 1/2 sum c_acd c_bef W_ce W_df."""
    M1 = np.einsum('acd,ce->ade', C, W, optimize=True)
    M2 = np.einsum('ade,df->aef', M1, W, optimize=True)
    return 0.5 * np.einsum('aef,bef->ab', M2, C, optimize=True)


def sharp_bilin(X, Y, C):
    """Polarization: (X#Y) with X#X = X^#.  (X#Y)_ab = 1/2 sum c_acd c_bef X_ce Y_df."""
    M1 = np.einsum('acd,ce->ade', C, X, optimize=True)
    M2 = np.einsum('ade,df->aef', M1, Y, optimize=True)
    return 0.5 * np.einsum('aef,bef->ab', M2, C, optimize=True)


def Q(W, C):
    return W @ W + sharp_fast(W, C)


def P(W, C):
    return np.trace(W @ Q(W, C))


def circ(X, Y, C):
    """X o Y = 1/2 (Q(X+Y)-Q(X)-Q(Y)) = 1/2(XY+YX) + X#Y."""
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(X, Y, C)


# ---------- curvature-operator structure: Bianchi and Ricci ----------

def pair_index(n):
    prs = basis_pairs(n)
    idx = {}
    for k, (i, j) in enumerate(prs):
        idx[(i, j)] = (k, 1.0)
        idx[(j, i)] = (k, -1.0)
    return prs, idx


def R_from_W(W, n):
    """R_{ijkl} = <W phi_ij, phi_kl>, antisymmetrized index conventions."""
    prs, idx = pair_index(n)
    R = np.zeros((n, n, n, n))
    for (i, j) in prs:
        a, sa = idx[(i, j)]
        for (k, l) in prs:
            b, sb = idx[(k, l)]
            v = W[a, b]
            R[i, j, k, l] = v
            R[j, i, k, l] = -v
            R[i, j, l, k] = -v
            R[j, i, l, k] = v
    return R


def weyl_constraints(n):
    """Rows of a linear system on vec(sym W) enforcing first Bianchi and Ric=0."""
    prs, idx = pair_index(n)
    N = len(prs)
    # parameterize symmetric W by its upper-triangular entries
    sym_idx = [(a, b) for a in range(N) for b in range(a, N)]
    D = len(sym_idx)
    pos = {(a, b): m for m, (a, b) in enumerate(sym_idx)}
    pos.update({(b, a): m for m, (a, b) in enumerate(sym_idx)})

    rows = []

    def addterm(row, i, j, k, l, coef):
        if i == j or k == l:
            return
        a, sa = idx[(i, j)]
        b, sb = idx[(k, l)]
        row[pos[(a, b)]] += coef * sa * sb

    # Bianchi: R_ijkl + R_iklj + R_iljk = 0 for i<j<k<l
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        row = np.zeros(D)
        addterm(row, i, j, k, l, 1.0)
        addterm(row, i, k, l, j, 1.0)
        addterm(row, i, l, j, k, 1.0)
        rows.append(row)
    # Ricci: Ric_ik = sum_j R_ijkj = 0
    for i in range(n):
        for k in range(i, n):
            row = np.zeros(D)
            for j in range(n):
                addterm(row, i, j, k, j, 1.0)
            rows.append(row)
    return np.array(rows), sym_idx, D


def weyl_basis(n, tol=1e-9):
    """Orthonormal (in Frobenius <A,B>=tr(AB)) basis of the Weyl space, as N x N matrices."""
    A, sym_idx, D = weyl_constraints(n)
    N = len(basis_pairs(n))
    # metric on the parameterization: tr(W^2) = sum_ab W_ab^2 = sum_diag x^2 + 2 sum_offdiag x^2
    w = np.array([1.0 if a == b else 2.0 for (a, b) in sym_idx])
    S = np.sqrt(w)
    # work in orthonormal coordinates y = S x
    Ay = A / S[None, :]
    _, sv, Vt = np.linalg.svd(Ay)
    rank = int((sv > tol * max(sv[0], 1.0)).sum())
    Ny = Vt[rank:]          # rows: orthonormal basis of nullspace in y-coords
    mats = []
    for y in Ny:
        x = y / S
        M = np.zeros((N, N))
        for m, (a, b) in enumerate(sym_idx):
            M[a, b] = x[m]
            M[b, a] = x[m]
        mats.append(M)
    return np.array(mats)


def weyl_dim_formula(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


def sphere_product_weyl(n, p, C=None):
    """Weyl part of the curvature operator of S^p x S^q (product of round unit spheres),
    built from scratch: R(X,Y)Z = <Y,Z>X - <X,Z>Y within each factor."""
    q = n - p
    prs, idx = pair_index(n)
    N = len(prs)
    A = set(range(p))
    B = set(range(p, n))
    # curvature operator of the product: acts diagonally, eigenvalue 1 on Lambda^2 of each
    # factor, 0 on mixed bivectors
    Rop = np.zeros((N, N))
    for k, (i, j) in enumerate(prs):
        if (i in A and j in A) or (i in B and j in B):
            Rop[k, k] = 1.0
    # subtract Ricci and scalar parts to land in the Weyl space
    return weyl_project(Rop, n)


def weyl_project(W, n, basis=None):
    if basis is None:
        basis = weyl_basis(n)
    coef = np.einsum('kab,ab->k', basis, W)
    return np.einsum('k,kab->ab', coef, basis)
