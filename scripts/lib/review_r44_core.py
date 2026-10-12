"""Reviewer 44 -- independent implementation from the definitions in findings/INDEX.md.

Nothing is imported from scripts/b_*.py or scripts/review_r*.py.

Conventions (from the brief):
  Lambda^2(R^n) has orthonormal basis phi_ij = E_ij - E_ji (i<j),
      <X,Y>_{Lambda^2} = 1/2 tr(X^T Y).
  c_amn = <[phi_a, phi_b=phi_m], phi_n>  -- structure constants; (A_a)_mn = c_amn.
  W is a symmetric N x N matrix, N = n(n-1)/2.
  (W^#)_ab = -1/2 tr(A_a W A_b W),  Q(W) = W^2 + W^#.
  <X,Y> on operators = plain Frobenius = tr(X Y) for symmetric X,Y.
  X o Y = 1/2(XY + YX) + sharp_bilin(X,Y),  sharp_bilin(X,X) = X^#.
  Weyl_n = {W symmetric on Lambda^2 : first Bianchi = 0, Ric(W) = 0}.
"""
import numpy as np
from itertools import combinations

# ---------------------------------------------------------------- basic index
_cache = {}

def pairs_of(n):
    if ('pairs', n) not in _cache:
        p = list(combinations(range(n), 2))
        idx = {q: a for a, q in enumerate(p)}
        _cache[('pairs', n)] = (p, idx)
    return _cache[('pairs', n)]

def phi_matrices(n):
    """phi_ij = E_ij - E_ji as n x n matrices, in pair order."""
    p, _ = pairs_of(n)
    out = np.zeros((len(p), n, n))
    for a, (i, j) in enumerate(p):
        out[a, i, j] = 1.0
        out[a, j, i] = -1.0
    return out

def struct_consts(n):
    """c[a,m,nn] = <[phi_a, phi_m], phi_nn>, computed by brute force from matrices."""
    key = ('c', n)
    if key in _cache:
        return _cache[key]
    P = phi_matrices(n); N = P.shape[0]
    c = np.zeros((N, N, N))
    for a in range(N):
        Ca = P[a] @ P - P @ P[a]                       # (N,n,n) = [phi_a, phi_m]
        # <C, phi_nn> = 1/2 tr(C^T phi_nn)
        c[a] = 0.5 * np.einsum('mij,nij->mn', Ca, P)
    _cache[key] = c
    return c

def adjoint_A(n):
    """A_a with (A_a)_{m,nn} = c_{a,m,nn}."""
    return struct_consts(n)

# ------------------------------------------------------- tensor <-> matrix map
def liftL(n):
    """L[(i,j), a] = <e_i ^ e_j, phi_a> (i.e. +1/-1/0)."""
    key = ('L', n)
    if key in _cache:
        return _cache[key]
    p, idx = pairs_of(n); N = len(p)
    L = np.zeros((n * n, N))
    for a, (i, j) in enumerate(p):
        L[i * n + j, a] = 1.0
        L[j * n + i, a] = -1.0
    _cache[key] = L
    return L

def to_tensor(W, n):
    """T[i,j,k,l] = W_{(ij),(kl)} extended antisymmetrically, as (n^2, n^2)."""
    L = liftL(n)
    return (L @ W) @ L.T

def from_tensor(T, n):
    """Inverse of to_tensor for tensors already in the right symmetry class."""
    L = liftL(n)
    return 0.25 * (L.T @ T) @ L

# ------------------------------------------------------------------ # and o
def _M(Tflat, n):
    """M[(i,k),(p,q)] = T[i,p,k,q]."""
    return Tflat.reshape(n, n, n, n).transpose(0, 2, 1, 3).reshape(n * n, n * n)

def sharp_bilin(X, Y, n, TX=None, TY=None):
    """Polarization of #, so sharp_bilin(X,X) = X^#.  Returns N x N matrix."""
    TX = to_tensor(X, n) if TX is None else TX
    TY = to_tensor(Y, n) if TY is None else TY
    MX = _M(TX, n); MY = _M(TY, n)
    G = MX @ MY.T
    G = G + G.T                                       # M_X M_Y^T + M_Y M_X^T
    G4 = G.reshape(n, n, n, n)                        # G[i,k,j,l]
    S4 = 0.5 * (G4.transpose(0, 2, 1, 3) - G4.transpose(0, 2, 3, 1))
    return from_tensor(S4.reshape(n * n, n * n), n)

def sharp_structconst(W, n):
    """(W^#)_ab = -1/2 tr(A_a W A_b W), literal definition.  O(N^4) -- small n only."""
    A = adjoint_A(n); N = A.shape[0]
    P = np.einsum('amn,np->amp', A, W)                # A_a W
    return -0.5 * np.einsum('amp,bpm->ab', P, P)

def circ(X, Y, n, TX=None, TY=None):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(X, Y, n, TX, TY)

def Qop(W, n):
    return W @ W + sharp_bilin(W, W, n)

# ------------------------------------------------------- Ricci / Bianchi / Weyl
def ricci(W, n):
    T = to_tensor(W, n).reshape(n, n, n, n)
    return np.einsum('ijkj->ik', T)

def bianchi(W, n):
    """Alt part: b[i,j,k,l] for i<j<k<l."""
    T = to_tensor(W, n).reshape(n, n, n, n)
    out = []
    for i, j, k, l in combinations(range(n), 4):
        out.append(T[i, j, k, l] - T[i, k, j, l] + T[i, l, j, k])
    return np.array(out)

def _param_maps(n):
    """Weighted upper-triangular parametrization of symmetric N x N matrices,
       chosen so that |p|_2 = |X|_Frobenius."""
    key = ('pm', n)
    if key in _cache:
        return _cache[key]
    p, _ = pairs_of(n); N = len(p)
    ii, jj = np.triu_indices(N)
    w = np.where(ii == jj, 1.0, np.sqrt(2.0))
    _cache[key] = (ii, jj, w, N)
    return _cache[key]

def p_to_X(pv, n):
    ii, jj, w, N = _param_maps(n)
    X = np.zeros((N, N))
    X[ii, jj] = pv / w
    X = X + X.T
    X[np.arange(N), np.arange(N)] *= 0.5
    return X

def X_to_p(X, n):
    ii, jj, w, N = _param_maps(n)
    return X[ii, jj] * w

def constraint_matrix(n):
    """Rows: first Bianchi (C(n,4)) then Ricci (n(n+1)/2), acting on p-space."""
    key = ('C', n)
    if key in _cache:
        return _cache[key]
    p, idx = pairs_of(n); N = len(p)
    ii, jj, w, _ = _param_maps(n)
    pos = {}
    for t, (a, b) in enumerate(zip(ii, jj)):
        pos[(a, b)] = t; pos[(b, a)] = t
    D = len(ii)
    rows = []
    def add(row, a, b, val):
        t = pos[(a, b)]
        row[t] += val / w[t]
    for i, j, k, l in combinations(range(n), 4):
        r = np.zeros(D)
        add(r, idx[(i, j)], idx[(k, l)], 1.0)
        add(r, idx[(i, k)], idx[(j, l)], -1.0)
        add(r, idx[(i, l)], idx[(j, k)], 1.0)
        rows.append(r)
    def ent(a, b, s):
        return (a, b, s)
    for i in range(n):
        for k in range(i, n):
            r = np.zeros(D)
            for j in range(n):
                if j == i or j == k:
                    continue
                s1 = 1.0 if i < j else -1.0
                a = idx[(min(i, j), max(i, j))]
                s2 = 1.0 if k < j else -1.0
                b = idx[(min(k, j), max(k, j))]
                add(r, a, b, s1 * s2)
            rows.append(r)
    C = np.array(rows)
    _cache[key] = C
    return C

def weyl_basis(n, seed=0):
    """Orthonormal basis of Weyl_n in p-space, columns of a (D x dimWeyl) array."""
    key = ('B', n)
    if key in _cache:
        return _cache[key]
    C = constraint_matrix(n)
    Qr, _ = np.linalg.qr(C.T)                          # orthonormal row space
    D = C.shape[1]
    dim = n * (n + 1) * (n + 2) * (n - 3) // 12
    rng = np.random.default_rng(seed)
    G = rng.standard_normal((D, dim))
    Y = G - Qr @ (Qr.T @ G)
    B, _ = np.linalg.qr(Y)
    _cache[key] = B
    return B

def weyl_proj_p(pv, n):
    B = weyl_basis(n)
    return B @ (B.T @ pv)

def project_weyl(X, n):
    return p_to_X(weyl_proj_p(X_to_p(X, n), n), n)

# ------------------------------------------------------------- sphere products
def embed(Wsmall, n0, n):
    """Zero-pad an operator on Lambda^2(R^{n0}) into Lambda^2(R^n)."""
    p0, _ = pairs_of(n0); p1, idx1 = pairs_of(n); N = len(p1)
    W = np.zeros((N, N))
    ii = np.array([idx1[q] for q in p0])
    W[np.ix_(ii, ii)] = Wsmall
    return W

def sphere_product_W(blocks, n=None):
    """Weyl operator of the Einstein product of round spheres S^{k_1} x ... .
       blocks = tuple of dimensions k_i >= 2 (each S^{k_i} of its own radius).
       Returns the unit-norm Weyl part."""
    ks = list(blocks)
    m = sum(ks)
    n = m
    assert len(ks) >= 2
    # radii: Einstein  (k_i - 1)/a_i^2 = lam  ->  curvature kappa_i = lam/(k_i-1)
    lam = 1.0
    kap = [lam / (k - 1) for k in ks]
    p, idx = pairs_of(n); N = len(p)
    start = np.cumsum([0] + ks)
    blk = np.full(n, -1)
    for b, k in enumerate(ks):
        blk[start[b]:start[b + 1]] = b
    R = np.zeros((N, N))
    for a, (i, j) in enumerate(p):
        if i < m and j < m and blk[i] == blk[j]:
            R[a, a] = kap[blk[i]]
    # Ricci of R, then subtract the constant-curvature piece to make it Ricci-flat.
    # Only valid as "the Einstein product" when the padding is absent (n == m).
    Ric = ricci(R, n)
    scal = np.trace(Ric)
    c = scal / (n * (n - 1))
    W = R - c * np.eye(N)
    return W / np.linalg.norm(W)

# ------------------------------------------------------------------- utilities
def orbit_tangent_dim(W, n, tol=1e-9):
    A = adjoint_A(n); N = A.shape[0]
    ad = A.transpose(0, 2, 1)                         # ad(phi_a) = A_a^T
    Dm = ad @ W - W @ ad
    M = Dm.reshape(N, -1)
    s = np.linalg.svd(M, compute_uv=False)
    return int((s > tol * max(1.0, s[0])).sum()), s

def orbit_tangent_basis(W, n, tol=1e-9):
    A = adjoint_A(n); N = A.shape[0]
    ad = A.transpose(0, 2, 1)
    Dm = ad @ W - W @ ad
    M = np.array([X_to_p(0.5 * (d + d.T), n) for d in Dm])
    U, s, Vt = np.linalg.svd(M, full_matrices=False)
    r = int((s > tol * max(1.0, s[0])).sum())
    return Vt[:r].T, s

def slack_S(W, n, tol=1e-9):
    """S_mmm = sum over an orthonormal basis of m of ||Pi_m [X_a, X_b]||^2,
       m = negative eigenspace of W inside Lambda^2 = so(n)."""
    A = adjoint_A(n); N = A.shape[0]
    P = phi_matrices(n)
    w, V = np.linalg.eigh(W)
    neg = V[:, w < -tol]
    k = neg.shape[1]
    if k == 0:
        return 0.0, 0
    Xs = np.einsum('ck,cij->kij', neg, P)             # basis of m as n x n matrices
    Pm = neg @ neg.T
    tot = 0.0
    for a in range(k):
        Cm = Xs[a] @ Xs - Xs @ Xs[a]                  # [X_a, X_b] for all b
        v = 0.5 * np.einsum('bij,cij->bc', Cm, P)     # coords in Lambda^2
        tot += float(np.einsum('bc,cd,bd->', v, Pm, v))
    return tot, k
