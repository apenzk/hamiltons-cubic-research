"""r275 independent Weyl/curvature machinery.  No imports from scripts/ anywhere.

Conventions, fixed here and self-tested at the bottom:
  * Lambda^2(R^n) has orthonormal basis phi_ab = e_a ^ e_b (a<b), realised as the
    skew matrix (phi_ab)_{ab}=+1, (phi_ab)_{ba}=-1, with <X,Y> = 1/2 tr(X^T Y).
  * A curvature operator is a symmetric N x N matrix M on that basis, N=n(n-1)/2.
  * structure constants  c[a,b,g] = < [phi_a, phi_b], phi_g >   (totally antisym).
  * sharp:  (M#)[a,b] = 1/2 * sum c[a,p,q] c[b,r,s] M[p,r] M[q,s].
  * Q(M) = M@M + M#,  theta(M) = <M, Q(M)> = tr(M^3) + <M#,M>.
  * F(M) = tr(M^3) + ||M#||_F   -- route M's quantity.
"""
import itertools
import numpy as np


class Geo:
    def __init__(self, n):
        self.n = n
        self.pairs = list(itertools.combinations(range(n), 2))
        self.N = len(self.pairs)
        self.pos = {p: k for k, p in enumerate(self.pairs)}
        # basis as skew matrices
        B = np.zeros((self.N, n, n))
        for a, (i, j) in enumerate(self.pairs):
            B[a, i, j] = 1.0
            B[a, j, i] = -1.0
        self.B = B
        # c[a,b,g] = <[B_a,B_b], B_g> = 1/2 tr( [Ba,Bb]^T Bg )
        comm = np.einsum('aik,bkj->abij', B, B) - np.einsum('bik,akj->abij', B, B)
        self.c = 0.5 * np.einsum('abij,gij->abg', comm, B)
        self._sg = None

    # ---------- sharp ----------
    def sharp_slow(self, M):
        # 1/2 c[a,p,q] c[b,r,s] M[p,r] M[q,s]
        T = np.einsum('apq,pr->aqr', self.c, M, optimize=True)   # aqr = sum_p c[a,p,q]M[p,r]
        return 0.5 * np.einsum('aqr,brq->ab', T, np.einsum('brs,qs->brq', self.c, M, optimize=True), optimize=True)

    def bil(self, A, B):
        """polarisation of #, as a 4-tensor contraction: S(A,B) with S(A,A)=A#.
        (A#B)_{ijkl} = 1/2 sum_{p,q} [ A_{ipkq}B_{jplq} + B_{ipkq}A_{jplq}
                                     - A_{iplq}B_{jpkq} - B_{iplq}A_{jpkq} ] / 2
        The overall constant is fixed once, in the self-test, against sharp_slow."""
        RA = self.to_tensor(A); RB = self.to_tensor(B)
        T = (np.einsum('ipkq,jplq->ijkl', RA, RB, optimize=True)
             + np.einsum('ipkq,jplq->ijkl', RB, RA, optimize=True))
        T = 0.5 * (T - np.transpose(T, (0, 1, 3, 2)))
        return self.to_matrix(T)

    def sharp(self, M):
        return self.bil(M, M)

    def theta(self, M):
        return float(np.trace(M @ M @ M) + np.sum(self.sharp(M) * M))

    def F(self, M):
        return float(np.trace(M @ M @ M) + np.linalg.norm(self.sharp(M)))

    def Q(self, M):
        return M @ M + self.sharp(M)

    def grad_sharp_norm2(self, M):
        """gradient of ||M#||_F^2 in the ambient symmetric matrices.
        # is quadratic with polarisation S(A,B)_ab = 1/2 c_apq c_brs A_pr B_qs,
        so d||M#||^2[H] = 4 <M#, S(M,H)> and the gradient is 4*sym(T),
        T_qs = 1/2 sum G_ab c_apq M_pr c_brs,  G = M#."""
        # <A, S(B,C)> is fully symmetric (self-tested), so
        # d||M#||^2[H] = 4 <M#, S(M,H)> = 4 <S(M#, M), H>.
        return 4.0 * self.bil(self.sharp(M), M)

    def grad_F(self, M):
        """ambient gradient of F(M) = tr(M^3) + ||M#||_F."""
        nS = np.linalg.norm(self.sharp(M))
        return 3.0 * (M @ M) + self.grad_sharp_norm2(M) / (2.0 * nS)

    # ---------- 4-tensor <-> operator ----------
    def _tables(self):
        if getattr(self, '_sg', None) is None:
            n = self.n
            sg = np.zeros((n, n)); pk = np.zeros((n, n), dtype=int)
            for i in range(n):
                for j in range(n):
                    if i == j:
                        continue
                    key = (i, j) if i < j else (j, i)
                    sg[i, j] = 1.0 if i < j else -1.0
                    pk[i, j] = self.pos[key]
            self._sg, self._pk = sg, pk
        return self._sg, self._pk

    def to_tensor(self, M):
        sg, pk = self._tables()
        return sg[:, :, None, None] * sg[None, None, :, :] * M[pk][:, :, pk]

    def to_matrix(self, R):
        I = np.array([p[0] for p in self.pairs]); J = np.array([p[1] for p in self.pairs])
        M = R[I[:, None], J[:, None], I[None, :], J[None, :]]
        return 0.5 * (M + M.T)

    # ---------- Weyl projection ----------
    def proj_weyl(self, M):
        n = self.n
        R = self.to_tensor(M)
        # first Bianchi
        R = R - (R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))) / 3.0
        Ric = np.einsum('ijkj->ik', R)
        s = np.trace(Ric)
        Ric0 = Ric - (s / n) * np.eye(n)
        I = np.eye(n)
        KN = (np.einsum('ik,jl->ijkl', Ric0, I) + np.einsum('jl,ik->ijkl', Ric0, I)
              - np.einsum('il,jk->ijkl', Ric0, I) - np.einsum('jk,il->ijkl', Ric0, I))
        G = np.einsum('ik,jl->ijkl', I, I) - np.einsum('il,jk->ijkl', I, I)
        return self.to_matrix(R - KN / (n - 2) - (s / (n * (n - 1))) * G)

    def rand_weyl(self, rng):
        A = rng.standard_normal((self.N, self.N))
        W = self.proj_weyl(0.5 * (A + A.T))
        return W / np.linalg.norm(W)


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def sphere_product(g, p, q):
    """W of S^p x S^q, p+q=n, as a diagonal operator; unit-normalised."""
    n = g.n
    assert p + q == n
    blk = np.zeros(g.N)
    for a, (i, j) in enumerate(g.pairs):
        if i < p and j < p:
            blk[a] = 1.0 / (p * (p - 1)) if p > 1 else 0.0
        elif i >= p and j >= p:
            blk[a] = 1.0 / (q * (q - 1)) if q > 1 else 0.0
        else:
            blk[a] = -1.0 / (p * q)
    M = np.diag(blk)
    M = g.proj_weyl(M)
    return M / np.linalg.norm(M)


def cp_m(g, m):
    """W of CP^m in n=2m, from the Kaehler form: W = c1*(P_u - stuff); built by
    projecting the rank-one operator J (x) J onto Weyl and normalising."""
    n = g.n
    assert n == 2 * m
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = 1.0
        J[2 * k + 1, 2 * k] = -1.0
    # omega in Lambda^2 coordinates
    om = np.array([J[i, j] for (i, j) in g.pairs])
    M = np.outer(om, om)
    W = g.proj_weyl(M)
    return W / np.linalg.norm(W)


def pad(g_small, W_small, g_big):
    """embed a Weyl operator of Weyl_{n0} into Weyl_n (n>n0) by zero padding."""
    M = np.zeros((g_big.N, g_big.N))
    for a, pa in enumerate(g_small.pairs):
        for b, pb in enumerate(g_small.pairs):
            M[g_big.pos[pa], g_big.pos[pb]] = W_small[a, b]
    return M


def L_e_spectrum(g, W, theta):
    """L_e = e o (.) restricted to Weyl_n, e = W/theta;  x o y = 1/2(Q(x+y)-Q(x)-Q(y))."""
    e = W / theta
    # basis of Weyl_n
    tri = [(a, b) for a in range(g.N) for b in range(a, g.N)]
    cols = []
    for (a, b) in tri:
        X = np.zeros((g.N, g.N)); X[a, b] = 1.0; X[b, a] = 1.0
        cols.append(g.proj_weyl(X).ravel())
    A = np.array(cols).T
    U, s, _ = np.linalg.svd(A, full_matrices=False)
    d = int(np.sum(s > 1e-8 * s[0]))
    U = U[:, :d]                      # orthonormal basis of Weyl_n as flattened matrices
    # circ product
    def circ(X, Y):
        return 0.5 * (g.Q(X + Y) - g.Q(X) - g.Q(Y))
    L = np.zeros((d, d))
    for k in range(d):
        V = U[:, k].reshape(g.N, g.N)
        L[:, k] = U.T @ circ(e, V).ravel()
    return np.linalg.eigvalsh(0.5 * (L + L.T)), d
