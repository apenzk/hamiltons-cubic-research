"""Reviewer 302: independent implementation of Weyl_n, Q, L_e, D_A, H_A.

Conventions derived from the definitions, not imported from the code under review.
  Lambda^2 basis: omega_{ij} = e_i ^ e_j, i<j, orthonormal.
  Curvature operator R: symmetric matrix on Lambda^2, R_{ijkl} = <R omega_ij, omega_kl>.
  Bianchi:  R_{ijkl} + R_{iklj} + R_{iljk} = 0  <=>  M[ij,kl] - M[ik,jl] + M[il,jk] = 0.
  Ric_{ab} = sum_j R_{ajbj};  Weyl_n = {Bianchi, Ric = 0}.
  Sharp:  <R# eta, eta> = -1/2 tr(ad_eta R ad_eta R)   (equivalent to the quadform in the record,
          since sum_i <[eta, R[eta, R w_i]], w_i> = tr(ad_eta R ad_eta R)).
  Polarised:  (X#Y)_{ab} = -1/4 [ tr(A_a X A_b Y) + tr(A_b X A_a Y) ],  A_a = ad(omega_a).
  Q(R) = R^2 + R#R ;  X o Y = (XY+YX)/2 + X#Y ;  P(W) = <Q(W),W> ; L_e = W o (.) / theta.
  D_A on Lambda^2 for A in Sym(R^n):  D_A(e_i ^ e_j) = (Ae_i)^e_j + e_i^(Ae_j).
  H_A = D_A W + W D_A.
"""
import itertools
import numpy as np


class Geom:
    def __init__(self, n):
        self.n = n
        self.pairs = list(itertools.combinations(range(n), 2))
        self.idx = {p: k for k, p in enumerate(self.pairs)}
        self.N = len(self.pairs)
        self._ad = None

    def wedge(self, i, j):
        """vector of e_i ^ e_j in the omega basis"""
        v = np.zeros(self.N)
        if i == j:
            return v
        if i < j:
            v[self.idx[(i, j)]] = 1.0
        else:
            v[self.idx[(j, i)]] = -1.0
        return v

    def sgn_idx(self, i, j):
        if i < j:
            return 1.0, self.idx[(i, j)]
        return -1.0, self.idx[(j, i)]

    # ---- so(n) = Lambda^2 as a Lie algebra ----
    def to_mat(self, v):
        """omega_ij  ->  the skew matrix E_ij with E[i,j]=1, E[j,i]=-1 (any fixed iso works)"""
        A = np.zeros((self.n, self.n))
        for a, (i, j) in enumerate(self.pairs):
            if v[a] != 0.0:
                A[i, j] += v[a]
                A[j, i] -= v[a]
        return A

    def from_mat(self, A):
        v = np.zeros(self.N)
        for a, (i, j) in enumerate(self.pairs):
            v[a] = A[i, j]
        return v

    @property
    def ad(self):
        """ad[a] = matrix of ad(omega_a) on Lambda^2, in the omega basis."""
        if self._ad is None:
            n, N = self.n, self.N
            mats = [self.to_mat(np.eye(N)[a]) for a in range(N)]
            out = np.zeros((N, N, N))
            for a in range(N):
                A = mats[a]
                for b in range(N):
                    B = mats[b]
                    out[a][:, b] = self.from_mat(A @ B - B @ A)
            self._ad = out
        return self._ad

    # ---- sharp ----
    def sharp(self, X, Y):
        ad = self.ad                     # (N,N,N): ad[a] is a matrix
        BX = ad @ X                      # BX[a] = A_a X
        CY = ad @ Y                      # CY[a] = A_a Y
        T = np.einsum('aij,bji->ab', BX, CY, optimize=True)
        return -0.25 * (T + T.T)

    def circ(self, X, Y):
        return 0.5 * (X @ Y + Y @ X) + self.sharp(X, Y)

    def Q(self, X):
        return X @ X + self.sharp(X, X)

    def P(self, X):
        return float(np.sum(self.Q(X) * X))

    # ---- D_A ----
    def D(self, A):
        """A symmetric n x n -> D_A on Lambda^2"""
        N = self.N
        out = np.zeros((N, N))
        for b, (i, j) in enumerate(self.pairs):
            col = np.zeros(N)
            for k in range(self.n):
                if A[k, i] != 0.0:
                    col += A[k, i] * self.wedge(k, j)
                if A[k, j] != 0.0:
                    col += A[k, j] * self.wedge(i, k)
            out[:, b] = col
        return out

    def H(self, W, A):
        DA = self.D(A)
        return DA @ W + W @ DA

    # ---- Ricci / Bianchi / Weyl ----
    def ric(self, M):
        n = self.n
        R = np.zeros((n, n))
        for a in range(n):
            for b in range(a, n):
                s = 0.0
                for j in range(n):
                    if j == a or j == b:
                        continue
                    sa, ia = self.sgn_idx(a, j)
                    sb, ib = self.sgn_idx(b, j)
                    s += sa * sb * M[ia, ib]
                R[a, b] = R[b, a] = s
        return R

    def bianchi_vec(self, M):
        out = []
        for i, j, k, l in itertools.combinations(range(self.n), 4):
            out.append(M[self.idx[(i, j)], self.idx[(k, l)]]
                       - M[self.idx[(i, k)], self.idx[(j, l)]]
                       + M[self.idx[(i, l)], self.idx[(j, k)]])
        return np.array(out)


# ---- isometric vectorisation of symmetric N x N matrices ----
def sym_basis(N):
    idxs = [(i, j) for i in range(N) for j in range(i, N)]
    return idxs


def mat_to_vec(M, idxs):
    r2 = np.sqrt(2.0)
    return np.array([M[i, j] if i == j else r2 * M[i, j] for (i, j) in idxs])


def vec_to_mat(v, idxs, N):
    M = np.zeros((N, N))
    r2 = np.sqrt(2.0)
    for c, (i, j) in enumerate(idxs):
        if i == j:
            M[i, j] = v[c]
        else:
            M[i, j] = M[j, i] = v[c] / r2
    return M


def weyl_basis(g, tol=1e-9):
    """Orthonormal basis of Weyl_n, as columns in the isometric sym-vectorisation."""
    N = g.N
    idxs = sym_basis(N)
    D = len(idxs)
    rows = []
    for c, (i, j) in enumerate(idxs):
        M = np.zeros((N, N))
        if i == j:
            M[i, j] = 1.0
        else:
            M[i, j] = M[j, i] = 1.0 / np.sqrt(2.0)
        rows.append(np.concatenate([g.bianchi_vec(M), g.ric(M)[np.triu_indices(g.n)]]))
    C = np.array(rows).T                       # constraints x D
    u, s, vt = np.linalg.svd(C)
    rank = int((s > tol * max(s[0], 1.0)).sum()) if s.size else 0
    B = vt[rank:].T
    return B, idxs


def op_matrix(g, B, idxs, f):
    """matrix of a linear map f on Weyl (columns = images of basis vectors)"""
    N, d = g.N, B.shape[1]
    out = np.zeros((d, d))
    for k in range(d):
        Mk = vec_to_mat(B[:, k], idxs, N)
        out[:, k] = B.T @ mat_to_vec(f(Mk), idxs)
    return out
