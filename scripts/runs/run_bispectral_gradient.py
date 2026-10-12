"""Item 1(ii): the gradient of the bi-spectral identity.
theta is cubic, so differentiating  theta = 3/2 tr(M^3) - 1/2 tr(Wring^3)  gives
    Q(W) = 3/2 pr(M^2) - 1/2 pr(iota^*(Wring^2)),   hence
    M^#  = 1/2 pr(M^2) - 1/2 pr(iota^*(Wring^2))
-- the sharp map written through a SQUARE in the second-kind representation."""
import numpy as np, itertools
rng=np.random.default_rng(17)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
def to_M(W,n,pr): return np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr])
def from_M(M,n,pr):
    W=np.zeros((n,n,n,n))
    for a,(i,j) in enumerate(pr):
        for b,(k,l) in enumerate(pr):
            v=M[a,b]
            for (p,q,sp) in ((i,j,1),(j,i,-1)):
                for (r,s_,sq) in ((k,l,1),(l,k,-1)): W[p,q,r,s_]=sp*sq*v
    return W
def ring(W,n):
    idx=[(i,j) for i in range(n) for j in range(i,n)]
    def bs(i,j):
        h=np.zeros((n,n))
        if i==j: h[i,i]=1
        else: h[i,j]=h[j,i]=1/np.sqrt(2)
        return h
    B=[bs(i,j) for (i,j) in idx]; m=len(idx); Op=np.zeros((m,m))
    for a,h in enumerate(B):
        Wh=np.einsum('iklj,kl->ij',W,h)
        for b,hb in enumerate(B): Op[a,b]=np.sum(Wh*hb)
    g=np.array([np.trace(bs(i,j)) for (i,j) in idx]); g/=np.linalg.norm(g)
    P=np.eye(m)-np.outer(g,g); return P@Op@P
def sharp(M,pr,n):
    N=len(pr)
    def E(i,j):
        A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; return A
    B=[E(i,j) for (i,j) in pr]; c=np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            C=B[a]@B[b]-B[b]@B[a]
            for g,(k,l) in enumerate(pr): c[a,b,g]=C[k,l]
    return 0.5*np.einsum('agd,bez,ge,dz->ab',c,c,M,M,optimize=True)
for n in [5,6,7]:
    pr=list(itertools.combinations(range(n),2))
    # orthonormal basis of Weyl_n in the M picture
    dim=n*(n+1)*(n+2)*(n-3)//12
    V=[]
    for _ in range(4*dim+40):
        M=to_M(proj_weyl(rng.standard_normal((n,n,n,n)),n),n,pr); V.append(M.ravel())
    Vm=np.array(V); U,sv,_=np.linalg.svd(Vm.T,full_matrices=False)
    B=[U[:,k].reshape(len(pr),len(pr)) for k in range(dim)]
    Bt=[from_M(b,n,pr) for b in B]
    ringB=[ring(t,n) for t in Bt]
    def pr_weyl(X): return sum(np.sum(X*b)*b for b in B)
    def iota_star(X): return sum(np.sum(ringB[k]*X)*B[k] for k in range(dim))
    W4=proj_weyl(rng.standard_normal((n,n,n,n)),n); M=to_M(W4,n,pr); M/=np.linalg.norm(M); W4=from_M(M,n,pr)
    Q=M@M+sharp(M,pr,n); Rw=ring(W4,n)
    rhs=1.5*pr_weyl(M@M)-0.5*iota_star(Rw@Rw)
    shp=sharp(M,pr,n); rhs_sharp=0.5*pr_weyl(M@M)-0.5*iota_star(Rw@Rw)
    print(f"n={n} dim Weyl={dim:3d} sv gap {sv[dim-1]:.2e}/{sv[dim] if len(sv)>dim else 0:.1e} | "
          f"||pr(Q) - [3/2 pr(M^2) - 1/2 iota*(ring^2)]|| = {np.linalg.norm(pr_weyl(Q)-rhs):.2e} | "
          f"||pr(M^#) - [1/2 pr(M^2) - 1/2 iota*(ring^2)]|| = {np.linalg.norm(pr_weyl(shp)-rhs_sharp):.2e} | "
          f"theta={np.sum(Q*M):+.6f} check={np.sum(rhs*M):+.6f}")
