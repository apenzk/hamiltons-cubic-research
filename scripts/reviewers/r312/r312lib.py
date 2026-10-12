"""r312: independent re-implementation of the Weyl/Q/L_e machinery.
Nothing here imports from the repository. Conventions fixed by self-tests.
Lambda^2(R^n) has orthonormal basis b_{ij}=e_i^e_j, i<j.
so(n) identified with Lambda^2 via A_{ij}=(E_ij-E_ji)/sqrt(2)  (orthonormal in Frobenius).
"""
import numpy as np
from itertools import combinations

class Amb:
    def __init__(self, n):
        self.n = n
        self.pairs = list(combinations(range(n), 2))
        self.N = len(self.pairs)
        self.idx = {}
        for a,(i,j) in enumerate(self.pairs):
            self.idx[(i,j)] = a
        # structure constants c[a,b,g] = <[A_a,A_b],A_g>
        A = np.zeros((self.N, n, n))
        for a,(i,j) in enumerate(self.pairs):
            A[a,i,j] = 1/np.sqrt(2); A[a,j,i] = -1/np.sqrt(2)
        self.A = A
        # [A_a,A_b] = A_a A_b - A_b A_a ; <X,Y>=tr(X^T Y)
        AB = np.einsum('aik,bkj->abij', A, A)
        C = AB - np.transpose(AB, (1,0,2,3))
        self.c = np.einsum('abij,gij->abg', C, A)

    # ---- index helpers -------------------------------------------------
    def pos(self, i, j):
        if i == j: return None, 0.0
        return (self.idx[(i,j)], 1.0) if i < j else (self.idx[(j,i)], -1.0)

    def tensor(self, M):
        """4-index R_{ijkl} from the Lambda^2 matrix M."""
        n = self.n
        S = np.zeros((n,n,self.N))
        for a,(i,j) in enumerate(self.pairs):
            S[i,j,a] = 1.0; S[j,i,a] = -1.0
        return np.einsum('ija,klb,ab->ijkl', S, S, M)

    def ricci(self, M):
        R = self.tensor(M)
        return np.einsum('ibkb->ik', R)

    def bianchi(self, M):
        R = self.tensor(M)
        return R + np.transpose(R,(0,2,3,1)) + np.transpose(R,(0,3,1,2))

    # ---- sharp ---------------------------------------------------------
    def sharp_bilin(self, R, S):
        """(R#S)_{ab} = sum c[a,g,d] c[b,e,z] R[g,e] S[d,z]; calibrated so I#I=(n-2)I."""
        T = np.einsum('agd,ge->ade', self.c, R)
        V = np.einsum('bez,dz->bed', self.c, S)
        out = np.einsum('ade,bed->ab', T, V)
        return 0.5*(out+out.T)

    def sharp(self, R):
        return self.sharp_bilin(R, R)

    def Q(self, R):
        return R@R + self.sharp(R)

    def LW(self, W, H):
        return 0.5*(W@H + H@W) + self.sharp_bilin(W, H)

    # ---- Weyl space ----------------------------------------------------
    def weyl_basis(self):
        if hasattr(self, '_wb'): return self._wb
        n, N = self.n, self.N
        # coordinates on Sym(N): orthonormal basis
        sym = []
        for a in range(N): sym.append((a,a,1.0))
        for a in range(N):
            for b in range(a+1,N): sym.append((a,b,1/np.sqrt(2)))
        D = len(sym)
        col = {}
        for k,(a,b,s) in enumerate(sym): col[(a,b)] = (k,s)
        def put(rows, r, a, b, v):
            if a>b: a,b = b,a
            k,s = col[(a,b)]
            rows[r,k] += v*(1.0/s if a!=b else 1.0)*(s if False else 1.0)/ (1.0)
        # careful: M[a,b] = x_k * s  where s=1 (diag) or 1/sqrt2 (offdiag)
        cons = []
        # Bianchi: M[(ij),(kl)] - M[(ik),(jl)] + M[(il),(jk)] = 0
        for (i,j,k,l) in combinations(range(n),4):
            row = np.zeros(D)
            for (p,q,r,s,sg) in [((i,j),(k,l),None,None,1.0),((i,k),(j,l),None,None,-1.0),((i,l),(j,k),None,None,1.0)]:
                a = self.idx[p]; b = self.idx[q]
                aa,bb = (a,b) if a<=b else (b,a)
                kk,ss = col[(aa,bb)]
                row[kk] += sg*ss
            cons.append(row)
        # Ricci
        for i in range(n):
            for kk2 in range(i, n):
                row = np.zeros(D)
                for b in range(n):
                    a1,s1 = self.pos(i,b)
                    a2,s2 = self.pos(kk2,b)
                    if a1 is None or a2 is None: continue
                    aa,bb = (a1,a2) if a1<=a2 else (a2,a1)
                    kx,sx = col[(aa,bb)]
                    row[kx] += s1*s2*sx
                cons.append(row)
        C = np.array(cons)
        # nullspace via complete QR of C^T
        Qm, Rm = np.linalg.qr(C.T, mode='complete')
        r = np.linalg.matrix_rank(C, tol=1e-9)
        NS = Qm[:, r:]
        # convert nullspace vectors to matrices
        B = np.zeros((NS.shape[1], N, N))
        for k,(a,b,s) in enumerate(sym):
            B[:, a, b] += NS[k]*s
            if a != b: B[:, b, a] += NS[k]*s
        self._wb = B
        return B

    def weyl_proj(self, M):
        B = self.weyl_basis()
        co = np.einsum('kab,ab->k', B, M)
        return np.einsum('k,kab->ab', co, B)

    def in_weyl(self, M):
        P = self.weyl_proj(M)
        return np.linalg.norm(M-P)/max(np.linalg.norm(M),1e-30)

    # ---- derivations ---------------------------------------------------
    def deriv(self, A):
        """D_A on Lambda^2 for any n x n matrix A: D_A(x^y)=Ax^y + x^Ay."""
        n, N = self.n, self.N
        D = np.zeros((N,N))
        for b,(i,j) in enumerate(self.pairs):
            # A e_i ^ e_j + e_i ^ A e_j ; A e_i = sum_k A[k,i] e_k
            for k in range(n):
                a,s = self.pos(k, j)
                if a is not None: D[a,b] += s*A[k,i]
                a,s = self.pos(i, k)
                if a is not None: D[a,b] += s*A[k,j]
        return D

    def adso(self, v):
        """ad(v) on Lambda^2 for v in Lambda^2 (=so(n)). Equals deriv of the so(n) matrix."""
        X = np.einsum('a,aij->ij', v, self.A)
        return self.deriv(X)*np.sqrt(2)/np.sqrt(2)  # deriv already correct for antisym A? see test

def eig_sym(M):
    w,v = np.linalg.eigh(0.5*(M+M.T)); return w,v
