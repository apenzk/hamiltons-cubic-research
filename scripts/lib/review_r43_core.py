"""Reviewer 43: independent machinery for Weyl_n and the multiplication L_e.

Nothing is imported from b_*.py or review_r*.py.  Conventions taken verbatim
from the brief:

  phi_ij = E_ij - E_ji  (i<j) is an orthonormal basis of Lambda^2(R^n) for
  <X,Y> = 1/2 tr(X^T Y).
  c_abc = <phi_c, [phi_a, phi_b]>,   (A_a)_mn = c_amn.
  sharp(X,Y)_ab = -1/4 ( tr(A_a X A_b Y) + tr(A_a Y A_b X) )
  X o Y = 1/2 (XY + YX) + sharp(X,Y)
  Q(X) = X o X.
Operators on Lambda^2 carry the plain Frobenius product <X,Y> = tr(X^T Y).
"""
import numpy as np


class Ambient:
    def __init__(self, n):
        self.n = n
        pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
        self.pairs = pairs
        self.N = len(pairs)
        idx = -np.ones((n, n), dtype=int)
        sgn = np.zeros((n, n))
        for a, (i, j) in enumerate(pairs):
            idx[i, j] = a
            idx[j, i] = a
            sgn[i, j] = 1.0
            sgn[j, i] = -1.0
        self.idx = idx
        self.sgn = sgn
        self._structure()

    def _structure(self):
        n, N = self.n, self.N
        phi = np.zeros((N, n, n))
        for a, (i, j) in enumerate(self.pairs):
            phi[a, i, j] = 1.0
            phi[a, j, i] = -1.0
        self.phi = phi
        # c[a,b,c] = <phi_c, [phi_a, phi_b]> = ([phi_a,phi_b])_{ij}, c=(i<j)
        c = np.zeros((N, N, N))
        for a in range(N):
            com = phi[a] @ phi - phi @ phi[a]      # (N,n,n): [phi_a, phi_b]
            for cc, (i, j) in enumerate(self.pairs):
                c[a, :, cc] = com[:, i, j]
            # note: c[a,b,cc] built as ([phi_a,phi_b])_{ij}
        self.c = c
        self.A = c            # (A_a)_{mn} = c[a,m,n]

    # ---- operator <-> 4-tensor -------------------------------------------
    def to_tensor(self, W):
        n = self.n
        s = self.sgn
        ii = self.idx.copy()
        ii[ii < 0] = 0
        T = W[np.ix_(ii.ravel(), ii.ravel())].reshape(n, n, n, n)
        T = T * s[:, :, None, None] * s[None, None, :, :]
        return T

    def to_op(self, T):
        N = self.N
        W = np.zeros(T.shape[:0] + (N, N), dtype=T.dtype)
        for a, (i, j) in enumerate(self.pairs):
            for b, (k, l) in enumerate(self.pairs):
                W[a, b] = T[i, j, k, l]
        return W

    # ---- curvature projections -------------------------------------------
    def bianchi_part(self, T):
        """b(T)_{ijkl} = 1/3 (T_ijkl + T_iklj + T_iljk); projection onto Lambda^4."""
        return (T + np.transpose(T, (0, 2, 3, 1)) + np.transpose(T, (0, 3, 1, 2))) / 3.0

    def ricci(self, T):
        return np.einsum('ijil->jl', T)

    def kn(self, h):
        n = self.n
        d = np.eye(n)
        return (np.einsum('ik,jl->ijkl', h, d) + np.einsum('jl,ik->ijkl', h, d)
                - np.einsum('il,jk->ijkl', h, d) - np.einsum('jk,il->ijkl', h, d))

    def weyl_project_tensor(self, T):
        n = self.n
        T = T - self.bianchi_part(T)          # now in Curv (first Bianchi)
        r = self.ricci(T)
        h = (r - (np.trace(r) / (2 * n - 2)) * np.eye(n)) / (n - 2)
        return T - self.kn(h)

    def weyl_project(self, W):
        return self.to_op(self.weyl_project_tensor(self.to_tensor(W)))

    def defect(self, W):
        """(bianchi residual, ricci residual) of an operator."""
        T = self.to_tensor(W)
        return np.abs(self.bianchi_part(T)).max(), np.abs(self.ricci(T)).max()

    # ---- the algebra ------------------------------------------------------
    def sharp(self, X, Y):
        U = np.einsum('amp,pq->amq', self.A, X)   # A_a X
        V = np.einsum('bmp,pq->bmq', self.A, Y)   # A_b Y
        T1 = np.einsum('apq,bqp->ab', U, V)       # tr(A_a X A_b Y)
        return -0.25 * (T1 + T1.T)

    def circ(self, X, Y):
        return 0.5 * (X @ Y + Y @ X) + self.sharp(X, Y)

    def Q(self, X):
        return self.circ(X, X)

    # ---- an honest orthonormal basis of Weyl_n ---------------------------
    def weyl_basis(self):
        N = self.N
        cols = []
        E = []
        for a in range(N):
            for b in range(a, N):
                M = np.zeros((N, N))
                M[a, b] = 1.0
                M[b, a] = 1.0
                if a != b:
                    M /= np.sqrt(2.0)
                E.append(M)
        E = np.array(E)
        P = np.array([self.weyl_project(M).ravel() for M in E])
        # rows of P span Weyl inside Sym; orthonormalise
        U, s, Vt = np.linalg.svd(P, full_matrices=False)
        r = int((s > 1e-8 * s[0]).sum())
        B = Vt[:r].reshape(r, N, N)
        return B


def frob(X, Y):
    return float(np.real(np.sum(np.conj(X) * Y)))


def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12
