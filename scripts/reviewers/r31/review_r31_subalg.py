"""Reviewer 31: invariant Weyl spaces of subalgebras h < so(n) -- N5 audit."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r31_core import *
from review_r31_spec import sym_basis, build_L, orbit_tangent, all_gens


def sym_ops(alg):
    N = alg.N
    B = sym_basis(N)
    Bf = np.array([b.ravel() for b in B])
    return B, Bf


def invariant_weyl(alg, gens, ret_basis=True):
    """dim and orthonormal basis of {W in Weyl_n : [ad A, W]=0 for A in gens}."""
    B, Bf = sym_ops(alg)
    D = len(B)
    S = np.zeros((D, D))
    Ms = [ad_matrix(alg, A) for A in gens]
    # (I - PW) block
    Pw = np.zeros((D, D))
    for t, X in enumerate(B):
        Pw[:, t] = Bf @ alg.PW(X).ravel()
    R = np.eye(D) - Pw
    S += R.T @ R
    for Mx in Ms:
        Ck = np.zeros((D, D))
        for t, X in enumerate(B):
            Ck[:, t] = Bf @ (Mx @ X - X @ Mx).ravel()
        S += Ck.T @ Ck
    w, V = np.linalg.eigh(S)
    k = int((w < 1e-8 * max(1.0, w.max())).sum())
    basis = [(Bf.T @ V[:, i]).reshape(alg.N, alg.N) for i in range(k)]
    return k, basis


def lam4_invariants(alg, gens):
    """dim of (Lambda^4 R^n)^h."""
    n = alg.n
    from itertools import combinations
    quads = list(combinations(range(n), 4))
    D = len(quads)
    pos = {q: i for i, q in enumerate(quads)}
    rows = []
    for A in gens:
        M = np.zeros((D, D))
        for c, quad in enumerate(quads):
            for slot in range(4):
                i = quad[slot]
                for j in range(n):
                    if A[j, i] == 0 or j in quad:
                        continue
                    new = list(quad); new[slot] = j
                    sgn = 1.0
                    arr = new[:]
                    # bubble sort sign
                    for x in range(4):
                        for y in range(3 - x):
                            if arr[y] > arr[y + 1]:
                                arr[y], arr[y + 1] = arr[y + 1], arr[y]
                                sgn = -sgn
                    M[pos[tuple(arr)], c] += sgn * A[j, i]
        rows.append(M)
    S = sum(M.T @ M for M in rows)
    w = np.linalg.eigvalsh(S)
    return int((w < 1e-8 * max(1.0, w.max())).sum())


# ---------- subalgebra constructions ----------
def gens_so_pq(n, p):
    G = []
    for i in range(p):
        for j in range(i + 1, p):
            A = np.zeros((n, n)); A[i, j] = 1; A[j, i] = -1; G.append(A)
    for i in range(p, n):
        for j in range(i + 1, n):
            A = np.zeros((n, n)); A[i, j] = 1; A[j, i] = -1; G.append(A)
    return G


def gens_u(m):
    n = 2 * m
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = -1; J[2 * k + 1, 2 * k] = 1
    G = []
    for i in range(n):
        for j in range(i + 1, n):
            A = np.zeros((n, n)); A[i, j] = 1; A[j, i] = -1
            G.append(A)
    # project onto commutant of J inside so(n)
    basis = []
    for A in G:
        basis.append((A + J @ A @ J.T) / 2)
    # orthonormalise
    M = np.array([b.ravel() for b in basis])
    U, s, Vt = np.linalg.svd(M, full_matrices=False)
    r = int((s > 1e-9 * s[0]).sum())
    return [Vt[i].reshape(n, n) for i in range(r)], J


OCT = None
def octonion_table():
    """multiplication table of the octonions, basis 1,e1..e7 (Cayley-Dickson from H)."""
    global OCT
    if OCT is not None:
        return OCT
    # quaternion table
    def qmul(a, b):
        a0, a1, a2, a3 = a; b0, b1, b2, b3 = b
        return np.array([a0*b0-a1*b1-a2*b2-a3*b3,
                         a0*b1+a1*b0+a2*b3-a3*b2,
                         a0*b2-a1*b3+a2*b0+a3*b1,
                         a0*b3+a1*b2-a2*b1+a3*b0])
    def qconj(a):
        return np.array([a[0], -a[1], -a[2], -a[3]])
    T = np.zeros((8, 8, 8))
    for i in range(8):
        for j in range(8):
            a = np.zeros(8); a[i] = 1
            b = np.zeros(8); b[j] = 1
            a1, a2 = a[:4], a[4:]
            b1, b2 = b[:4], b[4:]
            c1 = qmul(a1, b1) - qmul(qconj(b2), a2)
            c2 = qmul(b2, a1) + qmul(a2, qconj(b1))
            T[i, j] = np.concatenate([c1, c2])
    OCT = T
    return T


def gens_spin7():
    """spin(7) < so(8) acting irreducibly, via left octonion multiplication."""
    T = octonion_table()
    L = [T[i].T for i in range(1, 8)]   # L_i[x] = e_i * x ; column x -> T[i,x]
    L = [np.array(T[i]).T for i in range(1, 8)]
    G = []
    for a in range(7):
        for b in range(a + 1, 7):
            G.append(0.5 * (L[a] @ L[b]))
    return G, L


def gens_sp1_sp2():
    """sp(1)+sp(2) < so(8) on H^2."""
    def qmul(a, b):
        a0, a1, a2, a3 = a; b0, b1, b2, b3 = b
        return np.array([a0*b0-a1*b1-a2*b2-a3*b3,
                         a0*b1+a1*b0+a2*b3-a3*b2,
                         a0*b2-a1*b3+a2*b0+a3*b1,
                         a0*b3+a1*b2-a2*b1+a3*b0])
    def Lq(q):
        M = np.zeros((4, 4))
        for k in range(4):
            b = np.zeros(4); b[k] = 1
            M[:, k] = qmul(q, b)
        return M
    def Rq(q):
        M = np.zeros((4, 4))
        for k in range(4):
            b = np.zeros(4); b[k] = 1
            M[:, k] = qmul(b, q)
        return M
    im = [np.array([0., 1, 0, 0]), np.array([0., 0, 1, 0]), np.array([0., 0, 0, 1])]
    G = []
    # sp(1): right multiplication by imaginary q on both H factors
    for q in im:
        A = np.zeros((8, 8))
        A[:4, :4] = Rq(q); A[4:, 4:] = Rq(q)
        G.append(A)
    # sp(2): 2x2 quaternionic anti-hermitian, acting by LEFT mult (commutes with right mult)
    for q in im:
        A = np.zeros((8, 8)); A[:4, :4] = Lq(q); G.append(A)
        A = np.zeros((8, 8)); A[4:, 4:] = Lq(q); G.append(A)
    for q in [np.array([1., 0, 0, 0])] + im:
        A = np.zeros((8, 8))
        A[:4, 4:] = Lq(q)
        A[4:, :4] = -Lq(np.array([q[0], -q[1], -q[2], -q[3]]))
        G.append(A)
    M = np.array([g.ravel() for g in G])
    U, s, Vt = np.linalg.svd(M, full_matrices=False)
    r = int((s > 1e-9 * s[0]).sum())
    return [Vt[i].reshape(8, 8) for i in range(r)]


def analyse(alg, name, gens):
    n = alg.n
    G = [0.5 * (A - A.T) for A in gens]
    # confirm they lie in so(n) and are closed under bracket
    M = np.array([g.ravel() for g in G])
    U, s, Vt = np.linalg.svd(M, full_matrices=False)
    r = int((s > 1e-9 * s[0]).sum())
    Gb = [Vt[i].reshape(n, n) for i in range(r)]
    Pg = Vt[:r]
    closed = 0.0
    for a in range(r):
        for b in range(a + 1, r):
            c = (Gb[a] @ Gb[b] - Gb[b] @ Gb[a]).ravel()
            closed = max(closed, np.linalg.norm(c - Pg.T @ (Pg @ c)))
    k, basis = invariant_weyl(alg, Gb)
    l4 = lam4_invariants(alg, Gb)
    out = dict(name=name, dim_h=r, closed=closed, dim_inv=k, lam4=l4, crit=[])
    for W in basis[:4]:
        nrm = np.sqrt(np.sum(W * W))
        if nrm < 1e-9:
            continue
        Wn = W / nrm
        th = float(np.sum(alg.Q(Wn) * Wn))
        res = float(np.abs(alg.Q(Wn) - th * Wn).max())
        out['crit'].append((th, res, np.round(np.linalg.eigvalsh(Wn), 6)))
    return out
