"""Why theta large => ||K||_F large is FALSE: ||K||_F is frame-dependent, theta is not.
Rotate CP^2 and watch ||K||_F collapse while theta is fixed."""
import numpy as np, itertools
from scipy.linalg import expm
rng=np.random.default_rng(91)
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
def theta_K(M,n,c):
    sh=0.5*np.einsum('agd,bez,ge,dz->ab',c,c,M,M,optimize=True)
    th=np.trace(M@M@M)+np.sum(sh*M)
    pr=pairs(n); K=np.zeros((n,n))
    for a,(i,j) in enumerate(pr): K[i,j]=K[j,i]=M[a,a]
    return th, np.linalg.norm(K)
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
def rotate(W,Q):
    return np.einsum('ai,bj,ck,dl,ijkl->abcd',Q,Q,Q,Q,W,optimize=True)
for n in [6,8]:
    c=csts(n); W0=cp2(n); M0=toM(W0,n); M0/=np.linalg.norm(M0); W0=W0/np.linalg.norm(toM(W0,n))
    th0,K0=theta_K(M0,n,c)
    # minimise ||K||_F over frames by gradient-free random search + local polish
    bestQ=np.eye(n); bestK=K0
    for t in range(4000):
        A=rng.standard_normal((n,n))*0.7; A=A-A.T; Q=expm(A)
        M=toM(rotate(W0,Q),n); th,K=theta_K(M,n,c)
        if K<bestK: bestK, bestQ = K, Q
    Mb=toM(rotate(W0,bestQ),n); thb,Kb=theta_K(Mb,n,c)
    # and maximise, for the frame-optimised quantity
    maxK=K0
    for t in range(4000):
        A=rng.standard_normal((n,n))*0.7; A=A-A.T; Q=expm(A)
        M=toM(rotate(W0,Q),n); th,K=theta_K(M,n,c)
        if K>maxK: maxK=K
    print(f"CP^2 padded to n={n}:  theta is frame-INVARIANT: {th0:.6f} -> {thb:.6f}  (drift {abs(th0-thb):.1e})")
    print(f"    ||K||_F over frames: standard {K0:.5f}   min found {Kb:.5f}   max found {maxK:.5f}")
    print(f"    so theta/||K||_F ranges over [{abs(thb)/maxK:.3f}, {abs(thb)/Kb:.3f}] on ONE tensor -- unbounded as ||K||->0")
    print()
