"""Reviewer 303: independent build of Lambda^2, the sharp product, Weyl_n,
and the second-order operator L_W.  Nothing under review is imported.

Conventions, fixed by the definitions and checked in phase 0:
  * Lambda^2(R^n) ~ so(n) via  e_a ^ e_b  |->  A_ab = E_ab - E_ba,
    inner product  <X,Y> = (1/2) tr(X^T Y),  so the A_ab (a<b) are orthonormal.
  * c[al,be,ga] = <[phi_al, phi_be], phi_ga>, totally antisymmetric, entries 0,+-1.
  * (R # S)_{al,be} = (1/2) sum c[al,ga,ep] c[be,de,ze] R[ga,de] S[ep,ze].
  * Q(W) = W^2 + W#W,   P(W) = <W,Q(W)>_F  with <A,B>_F = tr(A^T B).
  * L_W H = (WH+HW)/2 + W#H = D Q(W)[H] / 2.
"""
import itertools
import numpy as np


def pairs(n):
    return list(itertools.combinations(range(n), 2))


def so_basis(n):
    P = pairs(n)
    B = np.zeros((len(P), n, n))
    for k, (a, b) in enumerate(P):
        B[k, a, b] = 1.0
        B[k, b, a] = -1.0
    return B


def struct(n):
    B = so_basis(n)
    m = len(B)
    c = np.zeros((m, m, m))
    for i in range(m):
        for j in range(m):
            br = B[i] @ B[j] - B[j] @ B[i]
            c[i, j] = 0.5 * np.einsum('ab,kab->k', br, B)
    return c


class Alg:
    def __init__(self, n):
        self.n = n
        self.P = pairs(n)
        self.m = len(self.P)
        self.idx = {}
        for k, (a, b) in enumerate(self.P):
            self.idx[(a, b)] = (k, 1.0)
            self.idx[(b, a)] = (k, -1.0)
        self.c = struct(n)

    def sharp(self, R, S):
        return 0.5 * np.einsum('age,bdz,gd,ez->ab', self.c, self.c, R, S,
                               optimize=True)

    def Q(self, W):
        return W @ W + self.sharp(W, W)

    def L(self, W, H):
        return 0.5 * (W @ H + H @ W) + self.sharp(W, H)

    def theta(self, W):
        return float(np.sum(W * self.Q(W)))

    def T(self, R, i, j, k, l):
        """R_{ijkl} = <R (e_i ^ e_j), e_k ^ e_l>."""
        if i == j or k == l:
            return 0.0
        a, sa = self.idx[(i, j)]
        b, sb = self.idx[(k, l)]
        return sa * sb * R[a, b]

    def weyl_basis(self):
        """Orthonormal Frobenius basis of {R sym on Lambda^2 : b(R)=0, Ric(R)=0}."""
        m = self.m
        basis = []
        for al in range(m):
            for be in range(al, m):
                E = np.zeros((m, m))
                E[al, be] = 1.0
                E[be, al] = 1.0
                basis.append(E)
        basis = np.array(basis)
        rows = []
        for (i, j, k, l) in itertools.combinations(range(self.n), 4):
            rows.append([self.T(E, i, j, k, l) + self.T(E, i, k, l, j)
                         + self.T(E, i, l, j, k) for E in basis])
        for i in range(self.n):
            for k in range(i, self.n):
                rows.append([sum(self.T(E, i, j, k, j) for j in range(self.n))
                             for E in basis])
        A = np.array(rows, dtype=float)
        _, s, vt = np.linalg.svd(A)
        ns = vt[int(np.sum(s > 1e-9)):]
        out = np.einsum('kb,bij->kij', ns, basis)
        flat = out.reshape(len(out), -1)
        qq, _ = np.linalg.qr(flat.T)
        return qq.T.reshape(-1, m, m)


def diag_op(alg, M):
    W = np.zeros((alg.m, alg.m))
    for k, (a, b) in enumerate(alg.P):
        W[k, k] = M[a, b]
    return W


def op_diag(alg, W):
    M = np.zeros((alg.n, alg.n))
    for k, (a, b) in enumerate(alg.P):
        M[a, b] = M[b, a] = W[k, k]
    return M


def offdiag_mass(W):
    return float(np.linalg.norm(W - np.diag(np.diag(W))))


def sphere_product_M(p, q):
    """Weyl matrix of S^p x S^q as an n x n vertex matrix, normalised tr M^2 = 2."""
    n = p + q
    M = np.zeros((n, n))
    M[:p, :p] = 1.0 / (p * (p - 1)) if p > 1 else 0.0
    M[p:, p:] = 1.0 / (q * (q - 1)) if q > 1 else 0.0
    M[:p, p:] = -1.0 / (p * q)
    M[p:, :p] = -1.0 / (p * q)
    np.fill_diagonal(M, 0.0)
    M *= np.sqrt(2.0 / np.sum(M * M))
    return M
