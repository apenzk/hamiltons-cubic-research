"""r273: independent implementation of so(n) structure constants, Hamilton's #,
the Weyl subspace, and the balanced sphere-product Weyl tensor.

Nothing is imported from scripts/.  Every object is built from its definition.

Conventions (stated, then checked):
  * so(n) basis  phi_{ij} = E_ij - E_ji, i<j, inner product <A,B> = 1/2 tr(A^T B).
    Then {phi_ij}_{i<j} is orthonormal.
  * structure constants c[a,b,g] = <[phi_a,phi_b], phi_g>.
  * Hamilton's sharp:  (R#)_{ab} = 1/2 sum_{c,d,e,f} c[c,d,a] c[e,f,b] R_{ce} R_{df}.
  * bilinear form A#B with (A+B)# = A# + 2 A#B + B#.
  * ad-form cross check: <R# x, y> = -1/2 tr(ad_x R ad_y R) with R viewed as an
    endomorphism of so(n) and ad_x the adjoint action.
"""
import numpy as np
from itertools import combinations


def so_basis(n):
    idx = list(combinations(range(n), 2))
    B = np.zeros((len(idx), n, n))
    for a, (i, j) in enumerate(idx):
        B[a, i, j] = 1.0
        B[a, j, i] = -1.0
    return idx, B


def struct(n):
    """c[a,b,g] built by literally taking matrix commutators and projecting."""
    idx, B = so_basis(n)
    N = len(idx)
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            comm = B[a] @ B[b] - B[b] @ B[a]
            # <comm, phi_g> = 1/2 tr(comm^T B_g)
            c[a, b, :] = 0.5 * np.einsum('ij,gij->g', comm, B)
    return idx, N, c


def sharp(R, c):
    """(R#)_{ab} = 1/2 sum c[c,d,a] c[e,f,b] R_ce R_df."""
    # T[d,f,a] = sum_{c,e} c[c,d,a] R[c,e] c[e,f,b] ... do it in two steps
    X = np.einsum('cda,ce->dae', c, R, optimize=True)      # sum_c c[c,d,a] R[c,e]
    Y = np.einsum('dae,efb->dafb', X, c, optimize=True)    # sum_e ... c[e,f,b]
    return 0.5 * np.einsum('dafb,df->ab', Y, R, optimize=True)


def sharp_bilinear(A, Bm, c):
    """A#B with (A+B)# = A# + 2 A#B + B#."""
    return 0.5 * (sharp(A + Bm, c) - sharp(A, c) - sharp(Bm, c))


def sharp_adform(R, c):
    """(R#)_{ab} = -1/2 tr(ad_a R ad_b R) with (ad_a)_{mn} = c[a,m,n]... check sign."""
    N = R.shape[0]
    A = np.transpose(c, (0, 2, 1))   # A[a][g,b] = c[a,b,g]:  ad_a as a matrix acting on so(n)
    S = np.einsum('amn,np->amp', A, R, optimize=True)
    return -0.5 * np.einsum('amp,bpm->ab', S, S, optimize=True)


def bianchi_and_weyl(n, idx, N):
    """Return an orthonormal basis (as N x N symmetric matrices, flattened on the
    upper triangle) of the Weyl subspace of Sym^2(Lambda^2)."""
    pos = {p: k for k, p in enumerate(idx)}
    triu = [(a, b) for a in range(N) for b in range(a, N)]
    tp = {p: k for k, p in enumerate(triu)}
    M = len(triu)

    def add(rows, p1, p2, s):
        s1, s2 = 1.0, 1.0
        q1 = p1
        if p1[0] > p1[1]:
            q1 = (p1[1], p1[0]); s1 = -1.0
        q2 = p2
        if p2[0] > p2[1]:
            q2 = (p2[1], p2[0]); s2 = -1.0
        a, b = pos[q1], pos[q2]
        if a > b:
            a, b = b, a
        rows[tp[(a, b)]] = rows.get(tp[(a, b)], 0.0) + s * s1 * s2

    rows_list = []
    for (i, j, k, l) in combinations(range(n), 4):
        rows = {}
        add(rows, (i, j), (k, l), 1.0)
        add(rows, (i, k), (l, j), 1.0)
        add(rows, (i, l), (j, k), 1.0)
        rows_list.append(rows)
    Bm = np.zeros((len(rows_list), M))
    for r, rows in enumerate(rows_list):
        for ci, v in rows.items():
            Bm[r, ci] += v
    return Bm, triu, tp, pos


def vec2mat(v, triu, N):
    R = np.zeros((N, N))
    for k, (a, b) in enumerate(triu):
        R[a, b] = v[k]; R[b, a] = v[k]
    return R


def mat2vec(R, triu):
    return np.array([R[a, b] for (a, b) in triu])


def Rval(R, pos, i, j, k, l):
    if i == j or k == l:
        return 0.0
    s = 1.0
    a, b = (i, j) if i < j else (j, i)
    if i > j: s = -s
    p, q = (k, l) if k < l else (l, k)
    if k > l: s = -s
    return s * R[pos[(a, b)], pos[(p, q)]]


def sphere_product_M(m):
    """Weyl tensor of the balanced product S^m x S^m as an operator on Lambda^2,
    built from the Riemann tensor and the Weyl decomposition, NOT from a stored
    lambda vector.  Returns (idx, N, c, M) with ||M||_F = 1."""
    n = 2 * m
    idx, N, c = struct(n)
    # Riemann of a product of two unit round S^m: R_{ijkl} = g_ik g_jl - g_il g_jk
    # inside each factor, 0 across.  Einstein with scal = 2m(m-1).
    scal = 2.0 * m * (m - 1)
    c0 = scal / (2.0 * n * (n - 1)) * 2.0     # coefficient of (g_ik g_jl - g_il g_jk)
    lam = np.zeros(N)
    for a, (i, j) in enumerate(idx):
        same = (i < m and j < m) or (i >= m and j >= m)
        lam[a] = (1.0 if same else 0.0) - c0
    M = np.diag(lam)
    M = M / np.sqrt(np.sum(lam ** 2))
    return idx, N, c, M


def weyl_basis(n, cache=None):
    """Frobenius-orthonormal basis of Weyl_n inside Sym^2(Lambda^2).

    Coordinates are the SCALED upper triangle  v_k = s_k R_{a_k b_k},
    s_k = sqrt(2) off the diagonal, 1 on it, so that <v,v> = ||R||_F^2.
    Constraints: first Bianchi over every 4-subset, and Ric = 0.
    """
    import os
    if cache and os.path.exists(cache):
        d = np.load(cache)
        return d['B'], [tuple(t) for t in d['triu']]
    idx, N, c = struct(n)
    Bm, triu, tp, pos = bianchi_and_weyl(n, idx, N)
    s = np.array([np.sqrt(2.0) if a != b else 1.0 for (a, b) in triu])
    rows = [Bm]
    # Ricci rows: Ric_{ik} = sum_j R_{ijkj}, as a linear functional of the triu coords
    ric = np.zeros((n * (n + 1) // 2, len(triu)))
    r = 0
    for i in range(n):
        for k in range(i, n):
            for j in range(n):
                if j == i or j == k:
                    continue
                # R_{ijkj} = sgn * R[pos(i,j), pos(k,j)]
                sg = 1.0
                a, b = (i, j) if i < j else (j, i)
                if i > j: sg = -sg
                p, q = (k, j) if k < j else (j, k)
                if k > j: sg = -sg
                A, B2 = pos[(a, b)], pos[(p, q)]
                if A > B2: A, B2 = B2, A
                ric[r, tp[(A, B2)]] += sg
            r += 1
    rows.append(ric)
    C = np.vstack(rows) / s[None, :]
    U, S, Vt = np.linalg.svd(C, full_matrices=True)
    tol = 1e-9 * S[0]
    rk = int(np.sum(S > tol))
    B = Vt[rk:, :].T                      # (M, dimWeyl), orthonormal columns
    if cache:
        np.savez(cache, B=B, triu=np.array(triu))
    return B, triu


def to_vec(R, triu):
    s = np.array([np.sqrt(2.0) if a != b else 1.0 for (a, b) in triu])
    return np.array([R[a, b] for (a, b) in triu]) * s


def from_vec(v, triu, N):
    s = np.array([np.sqrt(2.0) if a != b else 1.0 for (a, b) in triu])
    w = v / s
    R = np.zeros((N, N))
    for k, (a, b) in enumerate(triu):
        R[a, b] = w[k]; R[b, a] = w[k]
    return R
