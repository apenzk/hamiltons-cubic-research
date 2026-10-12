"""L_e as a matrix on Weyl_n, plus the Sym_0 compression."""
import sys, os
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from core import Geom, weyl_basis, sym_basis, mat_to_vec, vec_to_mat


class SymVec:
    """fast isometric vectorisation of symmetric N x N matrices"""
    def __init__(self, N):
        self.N = N
        iu = np.triu_indices(N)
        self.I, self.Jx = iu
        self.diag = self.I == self.Jx
        self.w = np.where(self.diag, 1.0, np.sqrt(2.0))

    def vec(self, M):
        return M[self.I, self.Jx] * self.w

    def mat(self, v):
        M = np.zeros((self.N, self.N))
        M[self.I, self.Jx] = v / self.w
        M = M + M.T
        M[np.arange(self.N), np.arange(self.N)] *= 0.5
        return M


def build_weyl(g):
    B, idxs = weyl_basis(g)
    sv = SymVec(g.N)
    # reorder rows of B from `idxs` order to SymVec order (they agree: triu row-major)
    assert idxs == list(zip(*np.triu_indices(g.N)))
    return B, sv


def Le_matrix(g, W, B, sv, theta):
    ad = g.ad
    BX = ad @ W
    d = B.shape[1]
    out = np.zeros((d, d))
    for k in range(d):
        Hk = sv.mat(B[:, k])
        CY = ad @ Hk
        T = np.einsum('aij,bji->ab', BX, CY, optimize=True)
        sh = -0.25 * (T + T.T)
        val = (0.5 * (W @ Hk + Hk @ W) + sh) / theta
        out[:, k] = B.T @ sv.vec(val)
    return out


def sym0_basis(n):
    """orthonormal basis of Sym_0(R^n)"""
    out = []
    for i in range(n):
        for j in range(i + 1, n):
            A = np.zeros((n, n)); A[i, j] = A[j, i] = 1 / np.sqrt(2.0)
            out.append(A)
    for k in range(1, n):
        A = np.zeros((n, n))
        for i in range(k):
            A[i, i] = 1.0
        A[k, k] = -float(k)
        out.append(A / np.linalg.norm(A))
    return out


def HA_span(g, W, B, sv, drop_e=True):
    """Pi_Weyl(H_A) for A in an orthonormal basis of Sym_0, in Weyl coordinates,
    then Pi_{e-perp}.  Returns (coeff matrix d x 35..., list of A)."""
    As = sym0_basis(g.n)
    cols = []
    for A in As:
        Hm = g.H(W, A)
        c = B.T @ sv.vec(0.5 * (Hm + Hm.T))
        cols.append(c)
    C = np.array(cols).T
    if drop_e:
        e = B.T @ sv.vec(W / np.linalg.norm(W))
        C = C - np.outer(e, e @ C)
    return C, As


def compression(Le, C, tol=1e-9, floor=1e-9):
    """orthonormal basis of range(C), and the compression of Le to it.
    ABSOLUTE floor as well as a relative tolerance: when every column of C is numerically
    zero (which happens exactly when Pi_Weyl H_A vanishes identically) a purely relative
    rank test returns full rank on noise."""
    u, s, vt = np.linalg.svd(C, full_matrices=False)
    r = int((s > max(tol * s[0], floor)).sum()) if s.size else 0
    U = u[:, :r]
    return U, U.T @ Le @ U, s
