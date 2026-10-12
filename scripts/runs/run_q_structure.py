"""Q_gamma = sum_ab lam_a lam_b T_{gab}.  Two exact constraints, and what they give.
  sum_g Q_g          =?  -2 ||W||^2
  sum_g lam_g Q_g    =?  2 <W#,W>
and whether they reproduce sum g = 4(n-1) and sum lam g = -4 theta -- i.e. whether the Q
structure is definitional (no new information) or carries something extra.
"""
import numpy as np, itertools
rng=np.random.default_rng(419)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
for n in [5,6,7,8]:
    pr=list(itertools.combinations(range(n),2)); N=len(pr)
    def E(i,j):
        A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; return A
    B=[E(i,j) for (i,j) in pr]; c=np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            C=B[a]@B[b]-B[b]@B[a]
            for g_,(k,l) in enumerate(pr): c[a,b,g_]=C[k,l]
    W=proj_weyl(rng.standard_normal((n,n,n,n)),n)
    M=np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr]); M/=np.linalg.norm(M)
    lam,V=np.linalg.eigh(M)
    cE=np.einsum('abg,aA,bB,gG->ABG',c,V,V,V,optimize=True); T=cE**2
    sharp=0.5*np.einsum('agd,bez,ge,dz->ab',c,c,M,M,optimize=True)
    th=np.trace(M@M@M)+np.sum(sharp*M); sh=np.sum(sharp*M)
    Q=np.einsum('a,b,gab->g',lam,lam,T)
    R2=np.einsum('gab->ga',T)
    gv=np.einsum('ab,gab->g',(lam[:,None]-lam[None,:])**2,T)
    m2=np.einsum('a,ga->g',lam**2,R2)
    print(f"n={n}: sum Q = {Q.sum():+.9f} (pred -2)   sum lam*Q = {np.sum(lam*Q):+.9f} (pred 2<W#,W> = {2*sh:+.9f})")
    print(f"      g = 2*m2 - 2*Q ?  max dev {np.abs(gv-(2*m2-2*Q)).max():.1e}   sum g = {gv.sum():.9f} (=4(n-1)={4*(n-1)})")
