"""Reviewer 47 core: independent implementation of the Weyl/Q machinery.

Nothing is imported from scripts/b_*.py or scripts/review_r*.py.
Conventions fixed here and validated in review_r47_validate.py:

  Lambda^2(R^n) has the orthonormal basis phi_{ij} = e_i ^ e_j, i<j, identified
  with so(n) via A_{ij} = E_ij - E_ji and <X,Y> = (1/2) tr(X^T Y).
  A curvature operator is a symmetric matrix M on that basis, equivalently a
  4-tensor R_{ijkl} = SGN(i,j) SGN(k,l) M[p(i,j), p(k,l)].
  R# via  (R#S)_{ijkl} = 1/2 sum_pq (R_ipkq S_jplq + S_ipkq R_jplq
                                     - R_iplq S_jpkq - S_iplq R_jpkq),
  matrix square via ordinary matrix product, Q(M) = M@M + sharp(M,M).
"""
import numpy as np
import itertools


class Geom:
    def __init__(self, n):
        self.n = n
        self.prs = [(i, j) for i in range(n) for j in range(i + 1, n)]
        self.N = len(self.prs)
        self.pidx = -np.ones((n, n), dtype=int)
        self.sgn = np.zeros((n, n))
        for a, (i, j) in enumerate(self.prs):
            self.pidx[i, j] = a
            self.pidx[j, i] = a
            self.sgn[i, j] = 1.0
            self.sgn[j, i] = -1.0
        self._P = np.where(self.pidx >= 0, self.pidx, 0)

    # ---- representation changes -------------------------------------------
    def mat_to_tensor(self, M):
        n = self.n
        P, S = self._P, self.sgn
        R = M[np.ix_(P.ravel(), P.ravel())].reshape(n, n, n, n)
        R = R * S[:, :, None, None] * S[None, None, :, :]
        return R

    def tensor_to_mat(self, R):
        idx = np.array(self.prs)
        return R[idx[:, 0][:, None], idx[:, 1][:, None],
                 idx[None, :, 0], idx[None, :, 1]]

    # ---- algebra -----------------------------------------------------------
    def sharp_t(self, R, S):
        """bilinear #, symmetric in (R,S); sharp_t(R,R) = R^#"""
        t = np.einsum('ipkq,jplq->ijkl', R, S, optimize=True)
        t = t + np.einsum('ipkq,jplq->ijkl', S, R, optimize=True)
        u = np.einsum('iplq,jpkq->ijkl', R, S, optimize=True)
        u = u + np.einsum('iplq,jpkq->ijkl', S, R, optimize=True)
        return 0.5 * (t - u)

    def sharp(self, M1, M2=None):
        R1 = self.mat_to_tensor(M1)
        R2 = R1 if M2 is None else self.mat_to_tensor(M2)
        return self.tensor_to_mat(self.sharp_t(R1, R2))

    def Q(self, M):
        return M @ M + self.sharp(M)

    def B(self, X, Y):
        """polarization: B(X,X) = Q(X)"""
        return 0.5 * (X @ Y + Y @ X) + self.sharp(X, Y)

    # ---- curvature projections --------------------------------------------
    def ricci(self, M):
        R = self.mat_to_tensor(M)
        return np.einsum('ijkj->ik', R)

    def bianchi(self, M):
        """the C(n,4) independent first-Bianchi components"""
        out = []
        for (i, j, k, l) in itertools.combinations(range(self.n), 4):
            out.append(M[self.pidx[i, j], self.pidx[k, l]]
                       - M[self.pidx[i, k], self.pidx[j, l]]
                       + M[self.pidx[i, l], self.pidx[j, k]])
        return np.array(out)

    # ---- so(n) structure ---------------------------------------------------
    def so_basis(self):
        n = self.n
        A = np.zeros((self.N, n, n))
        for a, (i, j) in enumerate(self.prs):
            A[a, i, j] = 1.0
            A[a, j, i] = -1.0
        return A

    def ad(self, X):
        """ad_X on Lambda^2 in the phi basis, X an n x n antisymmetric matrix"""
        A = self.so_basis()
        C = X @ A - A @ X          # [X, A_a]
        return np.einsum('acd,bcd->ba', C, A) * 0.5

    # ---- Weyl space --------------------------------------------------------
    def weyl_basis(self, tol=1e-9):
        """orthonormal basis of Weyl_n inside Sym^2(Lambda^2), Frobenius-isometric.

        returns Bas with shape (dimW, N, N)."""
        N = self.N
        coords = [(a, b) for a in range(N) for b in range(a, N)]
        ncoord = len(coords)
        rows = []
        # Bianchi rows
        for (i, j, k, l) in itertools.combinations(range(self.n), 4):
            r = np.zeros(ncoord)
            for (p, q, s) in ((self.pidx[i, j], self.pidx[k, l], 1.0),
                              (self.pidx[i, k], self.pidx[j, l], -1.0),
                              (self.pidx[i, l], self.pidx[j, k], 1.0)):
                a, b = min(p, q), max(p, q)
                w = 1.0 if a == b else 1.0 / np.sqrt(2.0)
                r[self._ci(a, b)] += s * w
            rows.append(r)
        # Ricci rows
        for i in range(self.n):
            for k in range(i, self.n):
                r = np.zeros(ncoord)
                for j in range(self.n):
                    if j == i or j == k:
                        continue
                    p, q = self.pidx[i, j], self.pidx[k, j]
                    s = self.sgn[i, j] * self.sgn[k, j]
                    a, b = min(p, q), max(p, q)
                    w = 1.0 if a == b else 1.0 / np.sqrt(2.0)
                    r[self._ci(a, b)] += s * w
                rows.append(r)
        Amat = np.array(rows)
        # nullspace
        _, sv, Vt = np.linalg.svd(Amat, full_matrices=True)
        rank = int((sv > tol * max(Amat.shape) * sv[0]).sum())
        ns = Vt[rank:]
        Bas = np.zeros((ns.shape[0], N, N))
        for t, v in enumerate(ns):
            M = np.zeros((N, N))
            for (idx, (a, b)) in enumerate(coords):
                if a == b:
                    M[a, a] = v[idx]
                else:
                    M[a, b] = M[b, a] = v[idx] / np.sqrt(2.0)
            Bas[t] = M
        return Bas

    def _ci(self, a, b):
        # index of (a,b), a<=b, in the row-major upper triangle
        N = self.N
        return a * N - a * (a - 1) // 2 + (b - a)


# ---------------------------------------------------------------------------
# slack and gradedness
# ---------------------------------------------------------------------------
def struct_sums(g, M, tol=None):
    """split sum_{a,b,c} <[X_a,X_b],X_c>^2 over ONB of Lambda^2 adapted to
    m = negative eigenspace of M, h = orthogonal complement.

    returns dict with T0..T3 (k = number of m-indices in the ordered triple),
    dim m, dim [m,m], and the total."""
    N = g.N
    w, U = np.linalg.eigh(M)
    if tol is None:
        tol = 1e-9 * max(1.0, np.abs(w).max())
    neg = w < -tol
    dm = int(neg.sum())
    # adapted orthonormal basis: m first
    Um = U[:, neg]
    Uh = U[:, ~neg]
    Uad = np.concatenate([Um, Uh], axis=1)
    A = g.so_basis()                        # (N, n, n)
    X = np.einsum('an,aij->nij', Uad, A)    # rotated basis, m-block first
    # c_{abc} = <[X_a,X_b],X_c>, <Y,Z> = (1/2) tr(Y^T Z)
    br = np.einsum('aik,bkj->abij', X, X) - np.einsum('bik,akj->abij', X, X)
    C = 0.5 * np.einsum('abij,cij->abc', br, X)
    mask = np.zeros(N)
    mask[:dm] = 1.0
    k = (mask[:, None, None] + mask[None, :, None] + mask[None, None, :])
    C2 = C ** 2
    T = [float(C2[k == kk].sum()) for kk in range(4)]
    # dim [m,m]
    if dm >= 2:
        brm = br[:dm, :dm].reshape(dm * dm, -1)
        s = np.linalg.svd(brm, compute_uv=False)
        dmm = int((s > 1e-8 * max(1.0, s[0])).sum()) if s.size else 0
    else:
        dmm = 0
    return dict(T0=T[0], T1=T[1], T2=T[2], T3=T[3], S=T[3], leak=T[1],
                dim_m=dm, dim_h=N - dm, dim_mm=dmm, total=sum(T),
                spec=w)


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def crit_residual(g, M):
    """||Q(M) - theta M|| with theta = <Q(M),M>/<M,M>, at ||M||=1"""
    QM = g.Q(M)
    th = float((QM * M).sum() / (M * M).sum())
    return th, float(np.linalg.norm(QM - th * M))


def casimir_W(g, h_proj):
    """unit-norm Casimir operator c (Pi_h - (r/N) Id) for a projector Pi_h"""
    N = g.N
    r = float(np.trace(h_proj))
    M = h_proj - (r / N) * np.eye(N)
    return M / np.linalg.norm(M)


def sphere_product(g, p, q):
    """Weyl operator of S^p x S^q as the Casimir of so(p)+so(q)"""
    n = g.n
    assert p + q == n
    Pi = np.zeros((g.N, g.N))
    for a, (i, j) in enumerate(g.prs):
        if (i < p and j < p) or (i >= p and j >= p):
            Pi[a, a] = 1.0
    return casimir_W(g, Pi)


def pad(g_small, g_big, M):
    """zero-pad a Lambda^2(R^k) operator into Lambda^2(R^n)"""
    out = np.zeros((g_big.N, g_big.N))
    for a, (i, j) in enumerate(g_small.prs):
        for b, (k, l) in enumerate(g_small.prs):
            out[g_big.pidx[i, j], g_big.pidx[k, l]] = M[a, b]
    return out


def Le_matrix(g, e, Bas, chunk=64, verbose=False):
    """matrix of V |-> B(e,V) = (eV+Ve)/2 + e#V on the given orthonormal basis"""
    import sys
    dW = Bas.shape[0]
    Re = g.mat_to_tensor(e)
    out = np.zeros((dW, dW))
    idx = np.array(g.prs)
    for s in range(0, dW, chunk):
        V = Bas[s:s+chunk]
        Rv = np.stack([g.mat_to_tensor(v) for v in V])
        t = np.einsum('ipkq,ajplq->aijkl', Re, Rv, optimize=True)
        t += np.einsum('aipkq,jplq->aijkl', Rv, Re, optimize=True)
        u = np.einsum('iplq,ajpkq->aijkl', Re, Rv, optimize=True)
        u += np.einsum('aiplq,jpkq->aijkl', Rv, Re, optimize=True)
        sh = 0.5*(t-u)
        shm = sh[:, idx[:,0][:,None], idx[:,1][:,None], idx[None,:,0], idx[None,:,1]]
        LV = 0.5*(e @ V + V @ e) + shm
        out[:, s:s+chunk] = np.einsum('bij,aij->ba', Bas, LV)
        if verbose:
            print(f"    Le col {s+len(V)}/{dW}", flush=True)
    return out


def orbit_dim(g, W, tol=1e-9):
    rows = []
    for X in g.so_basis():
        adX = g.ad(X)
        rows.append((adX @ W - W @ adX).ravel())
    s = np.linalg.svd(np.array(rows), compute_uv=False)
    return int((s > tol * max(1.0, s[0])).sum())
