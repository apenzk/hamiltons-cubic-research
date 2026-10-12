"""Reviewer 111 -- independent build from the brief's definitions.

Conventions fixed by the brief:
  * Lambda^2 basis: index pairs (i<j); M[(ij),(kl)] = W_ijkl ; ||M||_F = 1.
  * so(n) basis phi_ij = E_ij - E_ji  (UNNORMALISED), inner product = the
    coefficient inner product on that basis, i.e. <X,Y> = (1/2) tr(X^T Y).
  * v_alpha = eigenvectors of M read as elements of so(n) in that basis.
  * T[g,a,b] = <[v_a,v_b], v_g>^2 ,  R[g,a] = sum_b T[g,a,b],
    rho_a = sum_g R[g,a]  (claimed 2(n-2)).
  * g_gamma = || [ad(v_gamma), W] ||^2 on Lambda^2.
  * Q_gamma = sum_ab lam_a lam_b T[g,a,b].
  * theta = tr(M^3) + <M#,M>;  theta0(n) = sqrt(2(n-1)(n-2))/n.
Nothing here is imported from the project's own scripts.
"""
import numpy as np
import itertools


class Core:
    def __init__(self, n):
        self.n = n
        self.pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
        self.D = len(self.pairs)
        self.pidx = {p: a for a, p in enumerate(self.pairs)}
        self._struct = None
        self._wbasis = None

    # ---------- Lambda^2 <-> 4-tensor ----------
    def tens(self, M):
        """4-tensor with Riemann antisymmetries from a D x D symmetric matrix."""
        n = self.n
        R = np.zeros((n, n, n, n))
        for a, (i, j) in enumerate(self.pairs):
            for b, (k, l) in enumerate(self.pairs):
                v = M[a, b]
                R[i, j, k, l] = v
                R[j, i, k, l] = -v
                R[i, j, l, k] = -v
                R[j, i, l, k] = v
        return R

    def mat(self, R):
        M = np.zeros((self.D, self.D))
        for a, (i, j) in enumerate(self.pairs):
            for b, (k, l) in enumerate(self.pairs):
                M[a, b] = R[i, j, k, l]
        return M

    # ---------- Weyl projection ----------
    @staticmethod
    def kn(h, g):
        """Kulkarni-Nomizu product (h owedge g)_ijkl."""
        return (np.einsum('ik,jl->ijkl', h, g) + np.einsum('jl,ik->ijkl', h, g)
                - np.einsum('il,jk->ijkl', h, g) - np.einsum('jk,il->ijkl', h, g))

    def weyl_project_tensor(self, R):
        n = self.n
        # pair symmetries
        R = 0.25 * (R - R.transpose(1, 0, 2, 3) - R.transpose(0, 1, 3, 2)
                    + R.transpose(1, 0, 3, 2))
        R = 0.5 * (R + R.transpose(2, 3, 0, 1))
        # remove the totally antisymmetric (Bianchi) part
        alt = (R + R.transpose(0, 2, 3, 1) + R.transpose(0, 3, 1, 2)) / 3.0
        R = R - alt
        g = np.eye(n)
        ric = np.einsum('ikjk->ij', R)
        s = np.trace(ric)
        h = (ric - s / (2 * (n - 1)) * g) / (n - 2)
        return R - self.kn(h, g)

    def weyl_project(self, M):
        return self.mat(self.weyl_project_tensor(self.tens(M)))

    def weyl_basis(self):
        if self._wbasis is not None:
            return self._wbasis
        D = self.D
        cols = []
        for a in range(D):
            for b in range(a, D):
                E = np.zeros((D, D)); E[a, b] = 1.0; E[b, a] = 1.0
                cols.append(self.weyl_project(E).ravel())
        A = np.array(cols).T
        U, sv, _ = np.linalg.svd(A, full_matrices=False)
        r = int((sv > 1e-9 * sv[0]).sum())
        B = [U[:, k].reshape(D, D) for k in range(r)]
        B = [0.5 * (b + b.T) for b in B]
        # re-orthonormalise
        G = np.array([[np.sum(x * y) for y in B] for x in B])
        w, V = np.linalg.eigh(G)
        keep = w > 1e-10
        Bs = np.array([b.ravel() for b in B])
        C = (V[:, keep] / np.sqrt(w[keep])).T @ Bs
        self._wbasis = [c.reshape(D, D) for c in C]
        return self._wbasis

    # ---------- so(n) structure constants in the phi basis ----------
    def struct(self):
        """c[a,b,c] = <[phi_a, phi_b], phi_c> with <X,Y> = (1/2) tr(X^T Y)."""
        if self._struct is not None:
            return self._struct
        n, D = self.n, self.D
        Phi = np.zeros((D, n, n))
        for a, (i, j) in enumerate(self.pairs):
            Phi[a, i, j] = 1.0
            Phi[a, j, i] = -1.0
        c = np.zeros((D, D, D))
        for a in range(D):
            for b in range(a + 1, D):
                K = Phi[a] @ Phi[b] - Phi[b] @ Phi[a]
                for cc, (i, j) in enumerate(self.pairs):
                    if K[i, j] != 0.0:
                        c[a, b, cc] = K[i, j]
                        c[b, a, cc] = -K[i, j]
        self._struct = c
        return c

    # ---------- the tensors of the brief ----------
    def spectral(self, M):
        lam, V = np.linalg.eigh(M)
        return lam, V

    def Ttensor(self, V):
        """T[g,a,b] in the eigenbasis given by columns of V."""
        c = self.struct()
        A = np.einsum('abc,ai,bj,ck->ijk', c, V, V, V, optimize=True)
        return A ** 2, A

    # ---------- # and Q and theta ----------
    def sharp2(self, A, B):
        """Polarised #: (A#B)_ab = 1/2 sum_xyzw c_axy c_bzw A_xz B_yw, symmetrised."""
        c = self.struct()
        Y = np.einsum('axy,xz->ayz', c, A, optimize=True)
        Z = np.einsum('ayz,yw->azw', Y, B, optimize=True)
        out = 0.5 * np.einsum('azw,bzw->ab', Z, c, optimize=True)
        return 0.5 * (out + out.T)

    def sharp(self, M):
        return self.sharp2(M, M)

    def Qop(self, M):
        return M @ M + self.sharp(M)

    def theta(self, M):
        return float(np.trace(M @ M @ M) + np.sum(self.sharp(M) * M))

    def theta0(self):
        n = self.n
        return np.sqrt(2.0 * (n - 1) * (n - 2)) / n

    # ---------- slack ----------
    def slack_struct(self, M, tol=1e-9):
        lam, V = self.spectral(M)
        T, _ = self.Ttensor(V)
        neg = lam < -tol
        return float(T[np.ix_(neg, neg, neg)].sum())

    # ---------- criticality ----------
    def crit_residual(self, M):
        th = self.theta(M)
        return np.linalg.norm(self.weyl_project(self.Qop(M)) - th * M)

    def hess_euclid(self, M, h):
        """H(h) = 3 * Pi_Weyl( Mh + hM + 2 M#h ), M#h the polarisation of #."""
        c = self.struct()
        cross = 0.5 * (self.sharp2(M, h) + self.sharp2(h, M))
        return 3.0 * self.weyl_project(M @ h + h @ M + 2.0 * cross)

    def orbit_tangent(self, M):
        """span of [xi, M] for xi in so(n) acting on Lambda^2 (the ad action)."""
        c = self.struct()
        cols = []
        for g in range(self.D):
            ad = c[g]                     # ad(phi_g)_{b -> a}: [phi_g, phi_b] = sum_a ...
            A = c[g].T                    # A[a,b] = <[phi_g,phi_b],phi_a>
            cols.append((A @ M - M @ A).ravel())
        return np.array(cols).T

    def slacks(self, M, tol=1e-9):
        """(S_mmm, S_hhm) with h = {lambda >= 0}, m = {lambda < 0}."""
        lam, V = self.spectral(M)
        T, _ = self.Ttensor(V)
        neg = lam < -tol
        pos = ~neg
        S_mmm = float(T[np.ix_(neg, neg, neg)].sum())
        S_hhm = float(T[np.ix_(pos, pos, neg)].sum())
        return S_mmm, S_hhm
