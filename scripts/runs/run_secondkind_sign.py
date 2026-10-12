"""Pin the R-ring sign convention against Li eq (2.2) / Dai-Fu Lemma 3.3."""
import numpy as np, itertools
rng=np.random.default_rng(5)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
def ring(W,order):
    n=W.shape[0]; idx=[(i,j) for i in range(n) for j in range(i,n)]
    def bs(i,j):
        h=np.zeros((n,n))
        if i==j: h[i,i]=1
        else: h[i,j]=h[j,i]=1/np.sqrt(2)
        return h
    B=[bs(i,j) for (i,j) in idx]; m=len(idx); Op=np.zeros((m,m))
    for a,h in enumerate(B):
        Wh=np.einsum(order+',kl->ij',W,h)
        for b,hb in enumerate(B): Op[a,b]=np.sum(Wh*hb)
    g=np.array([np.trace(bs(i,j)) for (i,j) in idx]); g/=np.linalg.norm(g)
    P=np.eye(m)-np.outer(g,g); return P@Op@P
for n in [6,7,8]:
    W=proj_weyl(rng.standard_normal((n,n,n,n)),n)
    M=np.array([[W[i,j,k,l] for (k,l) in itertools.combinations(range(n),2)] for (i,j) in itertools.combinations(range(n),2)])
    W=W/np.linalg.norm(M); M=M/np.linalg.norm(M)
    al=np.einsum('tpsq,tpkl,sqkl->',W,W,W); be=np.einsum('tspq,tjpl,sjql->',W,W,W)
    for name,order in [("W_ikjl (mine)",'ikjl'),("W_iklj (Li 2.2)",'iklj')]:
        R0=ring(W,order); t3=np.trace(R0@R0@R0); t2=np.trace(R0@R0)
        print(f"n={n} {name:16s}: tr(ring^3)={t3:+.9f}  alpha/8-beta={al/8-be:+.9f}  beta-alpha/8={be-al/8:+.9f}  match={'alpha/8-beta' if abs(t3-(al/8-be))<1e-9 else 'beta-alpha/8' if abs(t3-(be-al/8))<1e-9 else 'NEITHER'} | tr(ring^2)={t2:.6f} = 3|W|^2_{{L2}}={3*np.linalg.norm(M)**2:.6f}")
    print()
