import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, core

def diagW(n, M):
    """W diagonal on the bivector basis with entries M[i,j]."""
    N = n*(n-1)//2
    W = np.zeros((N,N))
    for a,(i,j) in enumerate(core.pairs(n)):
        W[a,a] = M[i,j]
    return W

def ricci_free_M(n, M):
    """project a symmetric zero-diagonal M onto zero-row-sum (= Ricci-flat diagonal Weyl)."""
    M = M.copy(); np.fill_diagonal(M,0.0)
    r = M.sum(axis=1)
    sa = r.sum()/(2*n-2)
    a = (r - sa)/(n-2)
    P = M - (a[:,None]+a[None,:])
    np.fill_diagonal(P,0.0)
    return P

def sphere_product(p,q):
    n=p+q
    M=np.zeros((n,n))
    M[:p,:p]=1.0; M[p:,p:]=1.0
    M=ricci_free_M(n,M)
    W=diagW(n,M); W/=np.sqrt(np.sum(W*W))
    return n,W

def solve_diagonal_critical(n, M0, iters=4000, lr=0.4, seed=0):
    """gradient flow of P(W)=<W,Q(W)> on the unit sphere inside the diagonal Weyl locus,
       using only the diagonal formula Q_ij = M_ij^2 + (M^2)_ij projected back."""
    M = ricci_free_M(n, M0); M /= np.sqrt(2*np.sum(M**2)/2)  # normalise |W|=1 => sum_{i<j} M^2 =1
    M /= np.sqrt(np.sum(M**2)/2)
    for _ in range(iters):
        Qm = M*M + M@M
        Qm = ricci_free_M(n, Qm)
        th = np.sum(M*Qm)/np.sum(M*M)
        G = Qm - th*M
        M = M + lr*G
        M = ricci_free_M(n,M)
        M /= np.sqrt(np.sum(M**2)/2)
    Qm = ricci_free_M(n, M*M + M@M)
    th = np.sum(M*Qm)/np.sum(M*M)
    res = np.linalg.norm(Qm-th*M)
    return M, th, res

def c5_blowup(m=2):
    """C_5 blow-up: 5 equal blocks of size m, block-constant diagonal Weyl critical point.
       Solved from the diagonal criticality system, no repo code."""
    from scipy.optimize import fsolve
    n = 5*m
    blk = np.repeat(np.arange(5), m)
    def build(a,b,c):
        M=np.zeros((n,n))
        for i in range(n):
            for j in range(n):
                if i==j: continue
                d=(blk[i]-blk[j])%5
                M[i,j]= a if d==0 else (b if d in (1,4) else c)
        return M
    def F(x):
        a,b,c,th,mu=x
        M=build(a,b,c); Qm=M*M+M@M
        e=[]
        if m>1: e.append(Qm[0,1]-th*M[0,1]-2*mu)
        else:   e.append(a)
        e.append(Qm[0,m]-th*M[0,m]-2*mu)
        e.append(Qm[0,2*m]-th*M[0,2*m]-2*mu)
        e.append((m-1)*a+2*m*b+2*m*c)
        e.append(np.sum(M**2)/2-1.0)
        return e
    sol=fsolve(F,[0.3,-0.5,0.1,0.6,0.0],full_output=True)
    x=sol[0]; a,b,c,th,mu=x
    M=build(a,b,c)
    return n,diagW(n,M),M,th,np.max(np.abs(F(x)))
