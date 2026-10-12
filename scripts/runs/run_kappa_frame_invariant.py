"""kappa(W) = max over orthonormal frames of ||K(F)||_F,  K_ab = W_abab.
O(n)-invariant; kappa^2 <= 2||W||^2 with equality iff W is coordinate-diagonal in some frame.
Maximised by gradient ascent on so(n), multistart.  Sequential contraction keeps it cheap.
"""
import numpy as np, itertools
from scipy.linalg import expm
rng=np.random.default_rng(97)
def rot(W,Q):
    X=np.einsum('ai,ijkl->ajkl',Q,W,optimize=True)
    X=np.einsum('bj,ajkl->abkl',Q,X,optimize=True)
    X=np.einsum('ck,abkl->abcl',Q,X,optimize=True)
    return np.einsum('dl,abcl->abcd',Q,X,optimize=True)
def Kmat(W):
    n=W.shape[0]; K=np.zeros((n,n))
    for a in range(n):
        for b in range(n):
            if a!=b: K[a,b]=W[a,b,a,b]
    return K
def kappa(W,starts=6,iters=160):
    n=W.shape[0]; best=np.linalg.norm(Kmat(W))
    for s in range(starts):
        Q=np.eye(n) if s==0 else expm((lambda A:(A-A.T))(rng.standard_normal((n,n))*0.6))
        step=0.35
        Wc=rot(W,Q); f=np.linalg.norm(Kmat(Wc))
        for it in range(iters):
            G=np.zeros((n,n))
            for i in range(n):
                for j in range(i+1,n):
                    A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1
                    Wp=rot(Wc,expm(1e-5*A)); G[i,j]=(np.linalg.norm(Kmat(Wp))-f)/1e-5; G[j,i]=-G[i,j]
            ng=np.linalg.norm(G)
            if ng<1e-10: break
            Wn=rot(Wc,expm(step*G/ng)); fn=np.linalg.norm(Kmat(Wn))
            if fn>f: Wc,f=Wn,fn
            else: step*=0.6
            if step<1e-9: break
        best=max(best,f)
    return best
def pairs(n): return list(itertools.combinations(range(n),2))
def toM(W,n):
    pr=pairs(n); return np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr])
def csts(n):
    pr=pairs(n); N=len(pr)
    def E(i,j):
        A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; return A
    B=[E(i,j) for (i,j) in pr]; c=np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            C=B[a]@B[b]-B[b]@B[a]
            for g,(k,l) in enumerate(pr): c[a,b,g]=C[k,l]
    return c
def theta(M,n,c):
    sh=0.5*np.einsum('agd,bez,ge,dz->ab',c,c,M,M,optimize=True)
    return np.trace(M@M@M)+np.sum(sh*M)
def unit(W,n): return W/np.linalg.norm(toM(W,n))
def diag_weyl(Lam):
    n=Lam.shape[0]; I=np.eye(n)
    return np.einsum('ij,ik,jl->ijkl',Lam,I,I)-np.einsum('ij,il,jk->ijkl',Lam,I,I)
def sphere_product(p,q,n):
    Lam=np.zeros((n,n)); b=1.0; a1=-q*b/(p-1); a2=-p*b/(q-1)
    for i in range(n):
        for j in range(n):
            if i!=j: Lam[i,j]=a1 if (i<p and j<p) else a2 if (i>=p and j>=p) else b
    return -diag_weyl(Lam)
def cp2(n):
    d=4; J=np.zeros((d,d)); J[0,1]=1;J[1,0]=-1;J[2,3]=1;J[3,2]=-1; g=np.eye(d)
    R=(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g)
       +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)+2*np.einsum('ij,kl->ijkl',J,J))
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/d*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)-np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    W=R-KN(E,g)/(d-2)-s/(2*d*(d-1))*KN(g,g)
    if n>d:
        Wp=np.zeros((n,n,n,n)); Wp[:d,:d,:d,:d]=W; W=Wp
    return W
def cpm(m,n=None):
    d=2*m; J=np.zeros((d,d))
    for k in range(m): J[2*k,2*k+1]=1; J[2*k+1,2*k]=-1
    g=np.eye(d)
    R=(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g)
       +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)+2*np.einsum('ij,kl->ijkl',J,J))
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/d*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)-np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    W=R-KN(E,g)/(d-2)-s/(2*d*(d-1))*KN(g,g)
    if n and n>d:
        Wp=np.zeros((n,n,n,n)); Wp[:d,:d,:d,:d]=W; W=Wp
    return W
C=np.sqrt(1.5)
print(f"{'point':22s} {'theta':>9} {'kappa':>8} {'C*kappa':>9} {'slack':>10}  {'ratio th/kap':>12}")
rng2=np.random.default_rng(101)
for (m,n) in [(2,4),(3,6),(4,8),(5,10)]:
    c=csts(n); W=unit(cpm(m,n),n); th=theta(toM(W,n),n,c); k=kappa(W,starts=8,iters=200)
    print(f"{'CP^%d n=%d'%(m,n):22s} {th:9.5f} {k:8.5f} {C*k:9.5f} {C*k-abs(th):10.5f}  {abs(th)/k:12.5f}")
for n in [6,8]:
    c=csts(n)
    for t in range(3):
        A=rng2.standard_normal((n,n,n,n))
        R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
        R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
        g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
        KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)-np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
        W=unit(R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g),n)
        th=theta(toM(W,n),n,c); k=kappa(W,starts=4,iters=120)
        print(f"{'random n=%d #%d'%(n,t):22s} {th:9.5f} {k:8.5f} {C*k:9.5f} {C*k-abs(th):10.5f}  {abs(th)/k:12.5f}")
print()
print("the candidate is theta <= sqrt(3/2) kappa, i.e. ratio <= 1.224745")
