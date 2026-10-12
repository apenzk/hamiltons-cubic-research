"""Reviewer 305: independent implementation of Weyl_n, Q, L_W, Delta.

Written from the definitions in findings/problem.md, findings/second-order.md and
findings/bounds.md.  Nothing under review is imported.
"""
import numpy as np
from itertools import combinations

# ---------------------------------------------------------------- so(n) basis
def pairs(n):
    return list(combinations(range(n), 2))

def struct(n):
    """c[a,b,g] = <[phi_a, phi_b], phi_g>, phi_ij = E_ij - E_ji, <A,B> = tr(A^T B)/2."""
    idx = pairs(n); pos = {p: k for k, p in enumerate(idx)}; N = len(idx)
    c = np.zeros((N, N, N))
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            terms = []
            if j == k: terms.append((1.0, (i, l)))
            if i == k: terms.append((-1.0, (j, l)))
            if j == l: terms.append((-1.0, (i, k)))
            if i == l: terms.append((1.0, (j, k)))
            for co, (p, q) in terms:
                if p == q: continue
                s = 1.0
                if p > q: p, q = q, p; s = -1.0
                c[a, b, pos[(p, q)]] += co * s
    return idx, pos, N, c

# ------------------------------------------------------------------- the cubic
def sharp_bilin(c, R, S):
    """T(R,S)_{ab} = 1/2 sum c[a,g,d] c[b,e,z] R[g,e] S[d,z].  T(R,R) = R#."""
    # M1[a,d,e] = sum_g c[a,g,d] R[g,e]
    M1 = np.einsum('agd,ge->ade', c, R, optimize=True)
    # out[a,b] = 1/2 sum_{d,e,z} M1[a,d,e] c[b,e,z] S[d,z]
    M2 = np.einsum('bez,dz->bed', c, S, optimize=True)
    return 0.5 * np.einsum('ade,bed->ab', M1, M2, optimize=True)

def Qmap(c, R):
    return R @ R + sharp_bilin(c, R, R)

def circ(c, X, Y):
    """X o Y = (Q(X+Y)-Q(X)-Q(Y))/2."""
    return 0.5 * (X @ Y + Y @ X) + 0.5 * (sharp_bilin(c, X, Y) + sharp_bilin(c, Y, X))

def P(c, R):
    return float(np.sum(R * Qmap(c, R)))     # <A,B> = tr(A^T B) on Sym^2(Lambda^2)

# ------------------------------------------------------------- the Weyl space
def R_val(R, pos, i, j, k, l):
    if i == j or k == l: return 0.0
    si = 1.0; a, b = i, j
    if a > b: a, b = b, a; si = -si
    sk = 1.0; p, q = k, l
    if p > q: p, q = q, p; sk = -sk
    return si * sk * R[pos[(a, b)], pos[(p, q)]]

def weyl_basis(n):
    """Orthonormal basis (as N x N symmetric matrices) of {Bianchi, Ricci-flat}."""
    idx, pos, N, c = struct(n)
    triu = [(a, b) for a in range(N) for b in range(a, N)]
    tp = {t: k for k, t in enumerate(triu)}
    D = len(triu)
    rows = []
    def add(rowdict, alpha, beta, co):
        a, b = (alpha, beta) if alpha <= beta else (beta, alpha)
        rowdict[tp[(a, b)]] = rowdict.get(tp[(a, b)], 0.0) + co
    # Bianchi
    for (i, j, k, l) in combinations(range(n), 4):
        rd = {}
        for (p, q, r, s) in [(i, j, k, l), (i, k, l, j), (i, l, j, k)]:
            a, sa = (pos[(p, q)], 1.0) if p < q else (pos[(q, p)], -1.0)
            b, sb = (pos[(r, s)], 1.0) if r < s else (pos[(s, r)], -1.0)
            add(rd, a, b, sa * sb)
        rows.append(rd)
    # Ricci
    for i in range(n):
        for j in range(i, n):
            rd = {}
            for k in range(n):
                if k == i or k == j: continue
                a, sa = (pos[(i, k)], 1.0) if i < k else (pos[(k, i)], -1.0)
                b, sb = (pos[(j, k)], 1.0) if j < k else (pos[(k, j)], -1.0)
                add(rd, a, b, sa * sb)
            rows.append(rd)
    A = np.zeros((len(rows), D))
    for r, rd in enumerate(rows):
        for k, v in rd.items(): A[r, k] = v
    # weight columns so that the euclidean vector norm on coefficients matches
    # the Frobenius norm on the matrix:  off-diagonal entries appear twice.
    w = np.array([1.0 if a == b else np.sqrt(2.0) for (a, b) in triu])
    Aw = A / w
    _, sv, Vt = np.linalg.svd(Aw, full_matrices=True)
    tol = max(Aw.shape) * np.finfo(float).eps * (sv[0] if sv.size else 1.0)
    r = int((sv > tol).sum())
    ns = Vt[r:]                                # (dim, D) coefficient vectors, orthonormal
    B = []
    for v in ns:
        Mt = np.zeros((N, N))
        vv = v / w
        for k, (a, b) in enumerate(triu):
            Mt[a, b] = vv[k]; Mt[b, a] = vv[k]
        B.append(Mt)
    return idx, pos, N, c, np.array(B)

def inner(A, B):
    return float(np.sum(A * B))

def L_operator(c, B, W):
    """Matrix of H -> W o H in the orthonormal basis B (Frobenius/2 inner product)."""
    d = len(B)
    G = np.array([[inner(B[i], B[j]) for j in range(d)] for i in range(d)])
    assert np.allclose(G, np.eye(d), atol=1e-9), np.abs(G - np.eye(d)).max()
    cols = [circ(c, W, B[i]) for i in range(d)]
    Lm = np.array([[inner(B[j], cols[i]) for i in range(d)] for j in range(d)])
    return Lm

def lam_max_perp(Lm, wvec):
    """Largest eigenvalue of L_e restricted to W-perp, W-coefficients wvec (unit)."""
    d = Lm.shape[0]
    u = wvec / np.linalg.norm(wvec)
    Pperp = np.eye(d) - np.outer(u, u)
    Ls = 0.5 * (Lm + Lm.T)
    Mr = Pperp @ Ls @ Pperp - 1e6 * np.outer(u, u)
    ev = np.linalg.eigvalsh(Mr)
    return ev[-1], ev

# ------------------------------------------------------------------- diagonal
def diag_to_operator(M, pos):
    """Diagonal Weyl operator from vertex matrix M (hollow, symmetric, row sums 0)."""
    n = M.shape[0]; N = len(pos)
    R = np.zeros((N, N))
    for (i, j), k in pos.items():
        R[k, k] = M[i, j]
    return R

def theta_diag(M):
    n = M.shape[0]
    return 0.5 * (np.sum(M ** 3) + np.trace(M @ M @ M))

def crit_res(M):
    """Off-diagonal residual of Phi(M) = theta M + diag(s)."""
    n = M.shape[0]
    Phi = M * M + M @ M
    th = theta_diag(M)
    Rr = Phi - th * M
    Rr = Rr - np.diag(np.diag(Rr))
    return np.abs(Rr).max(), th

def Lcal(M, Nm):
    """L(N) = hollow( M o N + (MN+NM)/2 ) -- the derivative of the criticality map."""
    out = M * Nm + 0.5 * (M @ Nm + Nm @ M)
    return out - np.diag(np.diag(out))

def diag_admissible_basis(n):
    """Orthonormal basis of {hollow symmetric, zero row sums} in R^{n x n}."""
    idxs = pairs(n)
    d = len(idxs)
    A = np.zeros((n, d))
    for k, (i, j) in enumerate(idxs):
        A[i, k] = 1.0; A[j, k] = 1.0
    _, sv, Vt = np.linalg.svd(A)
    r = (sv > 1e-10).sum()
    ns = Vt[r:]
    B = []
    for v in ns:
        Mt = np.zeros((n, n))
        for k, (i, j) in enumerate(idxs):
            Mt[i, j] = v[k] / np.sqrt(2.0); Mt[j, i] = Mt[i, j]
        B.append(Mt)          # Frobenius norm 1
    return np.array(B)

def diag_L_matrix(M):
    n = M.shape[0]
    B = diag_admissible_basis(n)
    d = len(B)
    Lm = np.zeros((d, d))
    cols = [Lcal(M, B[i]) for i in range(d)]
    for i in range(d):
        for j in range(d):
            Lm[j, i] = np.sum(B[j] * cols[i])
    return Lm, B

# ---------------------------------------------------------------------- Delta
def ad_matrix(c, v):
    """ad(v) on Lambda^2: (ad v)_{g b} = <[v, phi_b], phi_g> = sum_a v_a c[a,b,g]."""
    return np.einsum('a,abg->gb', v, c, optimize=True)

def Delta(c, W, tol=1e-9):
    """sum over positive eigenvectors of ||[ad(v),W]||^2, <A,B> = tr(A^T B).
    Calibrated: the sum over a FULL orthonormal basis is 4(n-1) exactly."""
    ev, V = np.linalg.eigh(W)
    tot = 0.0
    for k in range(len(ev)):
        if ev[k] > tol:
            ad = ad_matrix(c, V[:, k])
            Cm = ad @ W - W @ ad
            tot += float(np.sum(Cm * Cm))
    return tot
