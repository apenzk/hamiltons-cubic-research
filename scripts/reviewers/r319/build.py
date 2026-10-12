import numpy as np, sys
from itertools import combinations
sys.path.insert(0, 'scripts/reviewers/r319')
import core

class Arena:
    def __init__(self, n):
        self.n = n
        self.P = core.pairs(n)
        self.N = len(self.P)
        self.c = core.struct_consts(n)
        self.sharp = core.sharp_op(self.c)
    def Q(self, W):
        return W @ W + self.sharp(W)
    def P3(self, W):
        return core.frob(W, self.Q(W))
    def ad(self, x):           # x: coefficient vector in so(n) basis -> matrix on Lambda^2
        return -np.einsum('c,cab->ab', x, self.c)
    def ricci(self, W):
        n, Pl = self.n, self.P
        idx = {p: a for a, p in enumerate(Pl)}
        def R(i, j, k, l):
            if i == j or k == l: return 0.0
            s = 1.0
            if i > j: i, j = j, i; s = -s
            if k > l: k, l = l, k; s = -s
            return s * W[idx[(i, j)], idx[(k, l)]]
        Ric = np.zeros((n, n))
        for i in range(n):
            for k in range(n):
                Ric[i, k] = sum(R(i, j, k, j) for j in range(n))
        return Ric
    def bianchi(self, W):
        n, Pl = self.n, self.P
        idx = {p: a for a, p in enumerate(Pl)}
        def R(i, j, k, l):
            if i == j or k == l: return 0.0
            s = 1.0
            if i > j: i, j = j, i; s = -s
            if k > l: k, l = l, k; s = -s
            return s * W[idx[(i, j)], idx[(k, l)]]
        m = 0.0
        for q in combinations(range(n), 4):
            i, j, k, l = q
            m = max(m, abs(R(i,j,k,l)+R(i,k,l,j)+R(i,l,j,k)))
        return m

def diag_blocks(n, blocks):
    """Weyl operator of a multi-block product; blocks is a list of sizes summing to n.
    Diagonal in coordinate 2-planes; returns UNNORMALISED matrix (w_ab = -1 off-diagonal)."""
    lab = []
    for a, s in enumerate(blocks):
        lab += [a] * s
    k = len(blocks)
    w = -np.ones((k, k))
    for a, s in enumerate(blocks):
        if s == 1:
            w[a, a] = 0.0
        else:
            w[a, a] = (n - s) / (s - 1.0)
    P = core.pairs(n); N = len(P)
    W = np.zeros((N, N))
    for t, (i, j) in enumerate(P):
        W[t, t] = w[lab[i], lab[j]]
    return W

def unit(W):
    return W / np.sqrt(np.sum(W * W))

def cp2(n):
    """Weyl operator of CP^2 (self-dual, spectrum prop to (2,-1,-1) on Lambda^+),
    padded into Lambda^2 R^n by zero."""
    P = core.pairs(n); N = len(P)
    idx = {p: a for a, p in enumerate(P)}
    def e(i, j):
        v = np.zeros(N)
        s = 1.0
        if i > j: i, j = j, i; s = -1.0
        v[idx[(i, j)]] = s
        return v
    r2 = np.sqrt(2.0)
    w1 = (e(0,1) + e(2,3)) / r2
    w2 = (e(0,2) + e(3,1)) / r2
    w3 = (e(0,3) + e(1,2)) / r2
    return 2*np.outer(w1,w1) - np.outer(w2,w2) - np.outer(w3,w3)

def subalg_casimir(n, hbasis):
    """hbasis: (r, N) orthonormal rows spanning h inside Lambda^2. Return Pi_h - (r/N) Id."""
    N = len(core.pairs(n)); r = hbasis.shape[0]
    Pi = hbasis.T @ hbasis
    return Pi - (r / N) * np.eye(N)

def so_pq_basis(n, p):
    """orthonormal basis of so(p)+so(q) inside Lambda^2 R^n, q=n-p."""
    P = core.pairs(n); N = len(P)
    rows = []
    for t, (i, j) in enumerate(P):
        if (i < p) == (j < p):
            v = np.zeros(N); v[t] = 1.0; rows.append(v)
    return np.array(rows)

def torus_basis(n):
    P = core.pairs(n); N = len(P)
    rows = []
    for t, (i, j) in enumerate(P):
        if j == i + 1 and i % 2 == 0:
            v = np.zeros(N); v[t] = 1.0; rows.append(v)
    return np.array(rows)

def um_basis(n):
    """u(m) inside so(2m): x in Lambda^2 with [x, J] = 0."""
    m = n // 2
    P, B = core.so_basis(n)
    J = np.zeros((n, n))
    for k in range(m):
        J[2*k, 2*k+1] = 1.0; J[2*k+1, 2*k] = -1.0
    M = np.array([(B[a] @ J - J @ B[a]).reshape(-1) for a in range(len(P))])  # (N, n*n)
    U, S, Vh = np.linalg.svd(M.T, full_matrices=True)   # M.T is (n*n, N)
    tol = max(M.shape) * (S[0] if len(S) else 1.0) * 1e-12
    rank = int((S > tol).sum())
    return Vh[rank:]

def adjoint_basis(n, gen):
    """gen: list of (d,d) antisymmetric-in-Killing generators of a Lie algebra g of dim n
    realised as ad(g) inside so(n) (n = dim g, orthonormal basis wrt -Killing)."""
    P, B = core.so_basis(n)
    rows = []
    for X in gen:
        v = np.array([0.5*np.sum(X * B[a]) for a in range(len(P))])
        rows.append(v)
    Rw = np.array(rows)
    Uq, _ = np.linalg.qr(Rw.T)
    return Uq.T

def su3_adjoint():
    """ad(su(3)) inside so(8) via the real orthonormal basis of su(3) (Gell-Mann/i, normalised)."""
    import numpy as _np
    l = []
    L = _np.zeros((8,3,3), dtype=complex)
    L[0] = [[0,1,0],[1,0,0],[0,0,0]]
    L[1] = [[0,-1j,0],[1j,0,0],[0,0,0]]
    L[2] = [[1,0,0],[0,-1,0],[0,0,0]]
    L[3] = [[0,0,1],[0,0,0],[1,0,0]]
    L[4] = [[0,0,-1j],[0,0,0],[1j,0,0]]
    L[5] = [[0,0,0],[0,0,1],[0,1,0]]
    L[6] = [[0,0,0],[0,0,-1j],[0,1j,0]]
    L[7] = _np.array([[1,0,0],[0,1,0],[0,0,-2]])/_np.sqrt(3)
    T = 1j*L/2.0          # basis of su(3), <A,B> = -2 tr(AB) -> orthonormal
    ad = []
    for a in range(8):
        M = _np.zeros((8,8))
        for b in range(8):
            C = T[a]@T[b]-T[b]@T[a]
            for cc in range(8):
                M[cc,b] = (-2*_np.trace(C@T[cc])).real
        ad.append(M)
    return ad
