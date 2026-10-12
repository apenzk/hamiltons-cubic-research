"""Reviewer 328 -- independent implementation of so(n), Weyl_n, Q, #, criticality, D.

Conventions fixed from the definitions alone:
  Lambda^2 R^n has orthonormal basis w_{ij} = e_i ^ e_j (i<j).
  Bracket: [w_ij, w_kl] = d_jk w_il - d_ik w_jl - d_jl w_ik + d_il w_jk.
  c_abc = <[w_a,w_b], w_c>  (totally antisymmetric).
  W is a symmetric N x N matrix, M_ab = R_ijkl for a=(i<j), b=(k<l).
  Weyl_n = {W sym : first Bianchi = 0, Ric = 0}.
  <v,W#v> = -1/2 tr(ad(v) W ad(v) W);  W#_pq = -1/2 tr(ad(w_p) W ad(w_q) W).
  Q(W) = W^2 + W#.  Critical: Q(W) = theta W with ||W||_F = 1, theta = <W,Q(W)>.
"""
import numpy as np, itertools, functools

def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]

@functools.lru_cache(maxsize=None)
def struct(n):
    P = pairs(n); N = len(P); idx = {p: a for a, p in enumerate(P)}
    def w(i, j):
        # returns (index, sign) for e_i ^ e_j
        if i == j: return None
        return (idx[(i, j)], 1.0) if i < j else (idx[(j, i)], -1.0)
    c = np.zeros((N, N, N))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            terms = []
            if j == k: terms.append((w(i, l), 1.0))
            if i == k: terms.append((w(j, l), -1.0))
            if j == l: terms.append((w(i, k), -1.0))
            if i == l: terms.append((w(j, k), 1.0))
            for t, s in terms:
                if t is None: continue
                c[a, b, t[0]] += s * t[1]
    return np.asarray(P), c

def ad(n, v):
    """ad(v) as N x N matrix in the w basis: (ad v)_{cb} = c_{v b c}."""
    _, c = struct(n)
    A = np.einsum('p,pbc->cb', v, c)
    return A

def ad_basis(n):
    _, c = struct(n)
    return np.transpose(c, (0, 2, 1))   # A[p][c,b] = c[p,b,c]

# ---------- Weyl space ----------
@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal basis (as flattened NxN symmetric matrices) of Weyl_n."""
    P, _ = struct(n); N = len(P); idx = {tuple(p): a for a, p in enumerate(P)}
    def R(M, i, j, k, l):
        if i == j or k == l: return 0.0
        si = 1.0; sj = 1.0
        if i > j: i, j, si = j, i, -1.0
        if k > l: k, l, sj = l, k, -1.0
        return si * sj * M[idx[(i, j)], idx[(k, l)]]
    # symmetric matrix coordinates
    coords = [(a, b) for a in range(N) for b in range(a, N)]
    D = len(coords)
    rows = []
    def basis_mat(t):
        a, b = coords[t]; M = np.zeros((N, N)); M[a, b] = 1.0; M[b, a] = 1.0
        if a == b: M[a, b] = 1.0
        return M
    mats = [basis_mat(t) for t in range(D)]
    # Bianchi constraints
    cons = []
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        cons.append([R(M, i, j, k, l) + R(M, i, k, l, j) + R(M, i, l, j, k) for M in mats])
    # Ricci constraints
    for i in range(n):
        for j in range(i, n):
            cons.append([sum(R(M, i, k, j, k) for k in range(n)) for M in mats])
    C = np.array(cons)
    u, s, vt = np.linalg.svd(C)
    ns = vt[(s.shape[0] and np.sum(s > 1e-9) or 0):] if C.size else np.eye(D)
    B = []
    for row in ns:
        M = np.zeros((N, N))
        for t, val in enumerate(row):
            a, b = coords[t]; M[a, b] += val; M[b, a] += val if a != b else 0.0
        B.append(M / np.linalg.norm(M))
    # re-orthonormalise
    F = np.array([M.ravel() for M in B])
    q, _ = np.linalg.qr(F.T)
    return np.ascontiguousarray(q.T)     # rows: orthonormal flattened basis

def weyl_proj(n, W):
    B = weyl_basis(n); v = W.ravel()
    return (B.T @ (B @ v)).reshape(W.shape)

def weyl_dist(n, W):
    return np.linalg.norm(W - weyl_proj(n, W))

# ---------- Q ----------
def sharp(n, W):
    A = ad_basis(n)                      # (N, N, N)
    AW = np.einsum('pab,bc->pac', A, W)  # ad(w_p) W
    return -0.5 * np.einsum('pac,qca->pq', AW, AW)

def Q(n, W):
    return W @ W + sharp(n, W)

def theta_of(n, W):
    return float(np.sum(W * Q(n, W)))

def crit_res(n, W):
    th = theta_of(n, W)
    return float(np.linalg.norm(Q(n, W) - th * W)), th

def sharp_bil(n, W, V):
    A = ad_basis(n)
    AW = np.einsum('pab,bc->pac', A, W); AV = np.einsum('pab,bc->pac', A, V)
    return -0.25 * (np.einsum('pac,qca->pq', AW, AV) + np.einsum('pac,qca->pq', AV, AW))

def DQ(n, W, V):
    return W @ V + V @ W + 2.0 * sharp_bil(n, W, V)
