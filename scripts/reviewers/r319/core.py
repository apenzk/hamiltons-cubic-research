"""Reviewer 319: independent implementation from the definitions. No repo imports."""
import numpy as np
from itertools import combinations

def pairs(n):
    return list(combinations(range(n), 2))

def so_basis(n):
    """Orthonormal basis of so(n) = Lambda^2 R^n under <A,B> = (1/2) tr(A^T B)."""
    P = pairs(n); N = len(P)
    B = np.zeros((N, n, n))
    for a, (i, j) in enumerate(P):
        B[a, i, j] = 1.0; B[a, j, i] = -1.0
    return P, B

def struct_consts(n):
    """c[a,b,c] = <[phi_a,phi_b], phi_c>, phi orthonormal in <A,B>=(1/2)tr(A^T B)."""
    P, B = so_basis(n); N = len(P)
    # [A,B] = AB - BA ; <X,Y> = (1/2) tr(X^T Y) = -(1/2) tr(XY) for antisym
    c = np.zeros((N, N, N))
    for a in range(N):
        Ba = B[a]
        comm = Ba @ B - np.einsum('kij,jl->kil', B, Ba)  # [Ba, Bb] for all b
        # <comm_b, phi_c> = (1/2) tr(comm_b^T B_c)
        c[a] = 0.5 * np.einsum('bij,cij->bc', comm, B)
    return c

def sharp_op(c):
    """Return function W -> W^#, using (W^#)_{ab} = -1/2 tr(C_a W C_b W), C_a = c[a]."""
    N = c.shape[0]
    def sharp(W):
        V = np.einsum('aij,jk->aik', c, W)          # V_a = C_a W
        A = V.reshape(N, N * N)
        Bt = np.transpose(V, (0, 2, 1)).reshape(N, N * N)
        return -0.5 * (A @ Bt.T)
    return sharp

def bianchi_ricci_constraints(n):
    """Linear constraints on symmetric N x N matrices W (as operator on Lambda^2,
    orthonormal basis e_i^e_j, i<j) for first Bianchi and Ricci-flatness."""
    P = pairs(n); N = len(P)
    idx = {p: a for a, p in enumerate(P)}
    def R(i, j, k, l, W):
        if i == j or k == l: return 0.0
        si = 1.0
        if i > j: i, j = j, i; si = -si
        if k > l: k, l = l, k; si = -si
        return si * W[idx[(i, j)], idx[(k, l)]]
    # symmetric-matrix coordinates
    sym = [(a, b) for a in range(N) for b in range(a, N)]
    sidx = {s: t for t, s in enumerate(sym)}
    D = len(sym)
    def coordvec(i, j, k, l):
        v = np.zeros(D)
        if i == j or k == l: return v
        s = 1.0
        if i > j: i, j = j, i; s = -s
        if k > l: k, l = l, k; s = -s
        a, b = idx[(i, j)], idx[(k, l)]
        if a > b: a, b = b, a
        v[sidx[(a, b)]] += s
        return v
    rows = []
    for i, j, k, l in combinations(range(n), 4):
        for (p, q, r, s) in [(i, j, k, l), (i, j, l, k), (i, k, j, l)]:
            pass
    # Bianchi: R_{ijkl}+R_{iklj}+R_{iljk}=0 over 4-subsets, all index roles
    for quad in combinations(range(n), 4):
        i, j, k, l = quad
        rows.append(coordvec(i, j, k, l) + coordvec(i, k, l, j) + coordvec(i, l, j, k))
    # Ricci-flat: sum_j R_{ijkj} = 0
    for i in range(n):
        for k in range(i, n):
            v = np.zeros(D)
            for j in range(n):
                v += coordvec(i, j, k, j)
            rows.append(v)
    return np.array(rows), sym, D

def weyl_basis(n):
    """Orthonormal basis of Weyl_n inside symmetric operators on Lambda^2 (Frobenius)."""
    P = pairs(n); N = len(P)
    A, sym, D = bianchi_ricci_constraints(n)
    # weight columns so that Frobenius inner product is the Euclidean one on coords
    w = np.array([1.0 if a == b else np.sqrt(2.0) for (a, b) in sym])
    Aw = A / w[None, :]
    _, s, Vt = np.linalg.svd(Aw)
    tol = max(Aw.shape) * (s[0] if len(s) else 1.0) * 1e-12
    rank = int((s > tol).sum())
    null = Vt[rank:]            # (d, D) orthonormal in weighted coords
    d = null.shape[0]
    basis = np.zeros((d, N, N))
    for t, (a, b) in enumerate(sym):
        basis[:, a, b] += null[:, t] / w[t]
        if a != b:
            basis[:, b, a] += null[:, t] / w[t]
    return basis

def to_matrix(n, coords, basis):
    return np.einsum('d,dij->ij', coords, basis)

def frob(A, B):
    return float(np.sum(A * B))
