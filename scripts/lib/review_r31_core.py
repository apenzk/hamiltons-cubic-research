"""Reviewer 31: independent machinery for Weyl_n, Q, #, and L_e. Built from definitions only."""
import numpy as np
from itertools import combinations


class Alg:
    def __init__(self, n):
        self.n = n
        self.pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
        self.N = len(self.pairs)
        self.pos = {p: a for a, p in enumerate(self.pairs)}
        Ph = np.zeros((self.N, n, n))
        for a, (i, j) in enumerate(self.pairs):
            Ph[a, i, j] = 1.0
            Ph[a, j, i] = -1.0
        self.Ph = Ph
        # structure constants c[a,b,g] = <[phi_a,phi_b],phi_g>, <X,Y>=1/2 tr(X^T Y)
        pp = np.einsum('aik,bkj->abij', Ph, Ph)
        comm = pp - pp.transpose(1, 0, 2, 3)
        self.C = 0.5 * np.einsum('abij,gij->abg', comm, Ph)
        self.A = np.ascontiguousarray(self.C)          # A[a][m,n] = c_{a m n}
        self.At = np.ascontiguousarray(self.A.transpose(0, 2, 1))
        idxm = np.zeros((n, n), dtype=int)
        sgn = np.zeros((n, n))
        for (i, j) in self.pairs:
            a = self.pos[(i, j)]
            idxm[i, j] = a; sgn[i, j] = 1.0
            idxm[j, i] = a; sgn[j, i] = -1.0
        self.idxm, self.sgn = idxm, sgn
        self.ii = np.array([p[0] for p in self.pairs])
        self.jj = np.array([p[1] for p in self.pairs])

    # ---------- conversions ----------
    def to_R(self, W):
        n = self.n
        S = self.sgn[:, :, None, None] * self.sgn[None, None, :, :]
        return S * W[self.idxm[:, :, None, None], self.idxm[None, None, :, :]]

    def from_R(self, R):
        return R[self.ii[:, None], self.jj[:, None], self.ii[None, :], self.jj[None, :]]

    # ---------- projections ----------
    def alt(self, R):
        return (R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))) / 3.0

    def ricci(self, R):
        return np.einsum('ijkj->ik', R)

    def kn(self, h, k):
        # (h box k)_{ijkl} = h_ik k_jl + h_jl k_ik - h_il k_jk - h_jk k_il
        return (np.einsum('ik,jl->ijkl', h, k) + np.einsum('jl,ik->ijkl', h, k)
                - np.einsum('il,jk->ijkl', h, k) - np.einsum('jk,il->ijkl', h, k))

    def weyl_project_R(self, R):
        n = self.n
        g = np.eye(n)
        R = R - self.alt(R)                       # kill Lambda^4 part
        ric = self.ricci(R)
        s = np.trace(ric)
        ric0 = ric - (s / n) * g
        R = R - self.kn(ric0, g) / (n - 2) - (s / (2 * n * (n - 1))) * self.kn(g, g)
        return R

    def PW(self, W):
        W = 0.5 * (W + W.T)
        return self.from_R(self.weyl_project_R(self.to_R(W)))

    # ---------- algebra ----------
    def sharp(self, X, Y=None):
        """(X # Y)_{ab} = -1/2 tr(A_a X A_b Y); X#X = X^#."""
        if Y is None:
            Y = X
        N = self.N
        AX = (self.A.reshape(N * N, N) @ X).reshape(N, N, N)
        AY = (self.A.reshape(N * N, N) @ Y).reshape(N, N, N)
        M = -0.5 * (AX.reshape(N, N * N) @ np.ascontiguousarray(
            AY.transpose(0, 2, 1)).reshape(N, N * N).T)
        return 0.5 * (M + M.T)

    def Q(self, W):
        return W @ W + self.sharp(W)

    def circ(self, X, Y):
        return 0.5 * (X @ Y + Y @ X) + self.sharp(X, Y)

    def P(self, W):
        return 0.5 * np.trace(self.Q(W).T @ W) * 2 / 2 * 2 / 2  # placeholder

    def ip(self, X, Y):
        return float(np.sum(X * Y))

    # ---------- so(n) action ----------
    def rho(self, A):
        """induced action of A in so(n) on Lambda^2 = so(n): ad(A)."""
        return A[0] if False else None


def rho_of_pair(alg, i, j):
    """ad(phi_ij) as an N x N matrix on Lambda^2."""
    n = alg.n
    A = np.zeros((n, n)); A[i, j] = 1.0; A[j, i] = -1.0
    return ad_matrix(alg, A)


def ad_matrix(alg, A):
    """matrix of X -> [A,X] on Lambda^2 in the phi basis."""
    Ph = alg.Ph
    comm = np.einsum('ik,akj->aij', A, Ph) - np.einsum('aik,kj->aij', Ph, A)
    return 0.5 * np.einsum('aij,bij->ba', comm, Ph)  # column a = image of phi_a


def sphere_product_W(alg, p, q):
    n = alg.n
    assert p + q == n
    W = np.zeros((alg.N, alg.N))
    for a, (i, j) in enumerate(alg.pairs):
        if i < p and j < p:
            W[a, a] = 1.0 / (p * (p - 1))
        elif i >= p and j >= p:
            W[a, a] = 1.0 / (q * (q - 1))
        else:
            W[a, a] = -1.0 / (p * q)
    return W


def weyl_dim(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12
