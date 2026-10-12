"""r274: independent Weyl-tensor machinery. No imports from scripts/.

Conventions (fixed once, checked below):
  Lambda^2 basis  phi_ij = e_i ^ e_j, i<j, orthonormal;  M[a,b] = W_{ijkl} for a=(ij), b=(kl).
  <M,M>_F = sum_{a,b} W_{ijkl}^2 = (1/4) sum_{ijkl} W_{ijkl}^2.
  ad from real matrix commutators of phi_ij = E_ij - E_ji, <A,B> = 1/2 tr(A^T B).
  (M#)_{ab} = -1/2 tr(ad_a M ad_b M)   [Wilking / Boehm-Wilking]
  theta(M) = tr(M^3) + <M#,M>.
"""
import numpy as np, itertools

class Geo:
    def __init__(self, n):
        self.n = n
        self.idx = list(itertools.combinations(range(n), 2))
        self.N = len(self.idx)
        self.pos = {p: k for k, p in enumerate(self.idx)}
        # so(n) basis and ad, from matrix commutators
        B = np.zeros((self.N, n, n))
        for a, (i, j) in enumerate(self.idx):
            B[a, i, j] = 1.0; B[a, j, i] = -1.0
        C = np.einsum('aik,bkj->abij', B, B) - np.einsum('bik,akj->abij', B, B)
        self.ad = 0.5 * np.einsum('abij,gij->agb', C, B)   # (ad_a)_{g,b}
        # signed lookup table sgn[i,j], pos[i,j] for 4-tensor conversion
        self.sg = np.zeros((n, n)); self.pk = np.zeros((n, n), dtype=int)
        for i in range(n):
            for j in range(n):
                if i == j: continue
                a, b = (i, j) if i < j else (j, i)
                self.sg[i, j] = 1.0 if i < j else -1.0
                self.pk[i, j] = self.pos[(a, b)]

    # ---- Lambda^2 matrix  <->  4-tensor ----
    def to_tensor(self, M):
        return self.sg[:, :, None, None] * self.sg[None, None, :, :] * M[self.pk][:, :, self.pk]

    def to_matrix(self, R):
        I = np.array([i for i, j in self.idx]); J = np.array([j for i, j in self.idx])
        M = R[I[:, None], J[:, None], I[None, :], J[None, :]]
        return 0.5 * (M + M.T)

    # ---- projections ----
    def proj_bianchi(self, R):
        A = (R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))) / 3.0
        return R - A

    def proj_weyl_tensor(self, R):
        n = self.n
        R = self.proj_bianchi(R)
        Ric = np.einsum('ijkj->ik', R)
        S = np.trace(Ric)
        Ric0 = Ric - (S / n) * np.eye(n)
        I = np.eye(n)
        KN = (np.einsum('ik,jl->ijkl', Ric0, I) + np.einsum('jl,ik->ijkl', Ric0, I)
              - np.einsum('il,jk->ijkl', Ric0, I) - np.einsum('jk,il->ijkl', Ric0, I))
        G = np.einsum('ik,jl->ijkl', I, I) - np.einsum('il,jk->ijkl', I, I)
        return R - KN / (n - 2) - (S / (n * (n - 1))) * G

    def proj_weyl(self, M):
        return self.to_matrix(self.proj_weyl_tensor(self.to_tensor(M)))

    # ---- invariants ----
    def sharp(self, M):
        S = np.einsum('amn,np->amp', self.ad, M, optimize=True)
        return -0.5 * np.einsum('amp,bpm->ab', S, S, optimize=True)

    def theta(self, M):
        return float(np.trace(M @ M @ M) + np.sum(self.sharp(M) * M))

    def grad_sharpnorm2(self, M):
        """gradient of ||M#||_F^2 w.r.t. M, in the ambient S^2(Lambda^2)."""
        S = self.sharp(M)
        B1 = np.einsum('ab,bqr->aqr', S, self.ad, optimize=True)
        B2 = np.einsum('aqr,rs->aqs', B1, M, optimize=True)
        G = -2.0 * np.einsum('aqs,asp->pq', B2, self.ad, optimize=True)
        return 0.5 * (G + G.T)   # symmetrise (M lives in S^2)

    def grad_theta(self, M):
        S = self.sharp(M)
        B1 = np.einsum('ab,bqr->aqr', S, self.ad, optimize=True)  # here S plays M#'s role
        # d<M#,M> = <3*?,..>: <M#,M> is cubic; its gradient is 3*M#  (trilinear symmetry)
        return 3.0 * (M @ M) + 3.0 * S

if __name__ == "__main__":
    for n in (5, 6, 7):
        g = Geo(n)
        rng = np.random.default_rng(7)
        A = rng.standard_normal((g.N, g.N)); M = 0.5 * (A + A.T)
        R = g.to_tensor(M)
        # tensor<->matrix roundtrip
        print(f"n={n} roundtrip {np.abs(g.to_matrix(R)-M).max():.2e}", end='  ')
        # symmetries of the 4-tensor
        print(f"antisym {np.abs(R+np.transpose(R,(1,0,2,3))).max():.2e}", end='  ')
        W = g.proj_weyl(M)
        Rw = g.to_tensor(W)
        bia = (Rw + np.transpose(Rw,(0,2,3,1)) + np.transpose(Rw,(0,3,1,2)))
        print(f"bianchi {np.abs(bia).max():.2e}  ric {np.abs(np.einsum('ijkj->ik',Rw)).max():.2e}", end='  ')
        # idempotent + self-adjoint => orthogonal projection
        print(f"P^2=P {np.abs(g.proj_weyl(W)-W).max():.2e}", end='  ')
        A2 = rng.standard_normal((g.N,g.N)); M2 = 0.5*(A2+A2.T)
        s1 = np.sum(g.proj_weyl(M)*M2); s2 = np.sum(M*g.proj_weyl(M2))
        print(f"selfadj {abs(s1-s2):.2e}", end='  ')
        # dim Weyl
        E = np.zeros((g.N*(g.N+1)//2, g.N*(g.N+1)//2))
        tri = [(a,b) for a in range(g.N) for b in range(a,g.N)]
        for k,(a,b) in enumerate(tri):
            X = np.zeros((g.N,g.N)); X[a,b]=1.0; X[b,a]=1.0
            Y = g.proj_weyl(X)
            E[:,k] = [Y[p,q] for (p,q) in tri]
        rk = np.linalg.matrix_rank(E, tol=1e-8)
        print(f"dimWeyl={rk} formula={(n+2)*(n+1)*n*(n-3)//12}")
    # gradient check
    g = Geo(6); rng = np.random.default_rng(3)
    A = rng.standard_normal((g.N,g.N)); M = 0.5*(A+A.T)
    H = rng.standard_normal((g.N,g.N)); H = 0.5*(H+H.T)
    eps = 1e-6
    num = (np.linalg.norm(g.sharp(M+eps*H))**2 - np.linalg.norm(g.sharp(M-eps*H))**2)/(2*eps)
    ana = np.sum(g.grad_sharpnorm2(M)*H)/1.0
    print("grad ||M#||^2:  num", num, " ana", ana, " relerr", abs(num-ana)/abs(num))
    num = (g.theta(M+eps*H) - g.theta(M-eps*H))/(2*eps)
    ana = np.sum(g.grad_theta(M)*H)
    print("grad theta   :  num", num, " ana", ana, " relerr", abs(num-ana)/abs(num))
