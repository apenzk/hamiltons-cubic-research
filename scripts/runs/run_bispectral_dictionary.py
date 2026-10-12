"""Derive theta = c1*tr_{Lambda^2}(W^3) + c2*tr_{S^2_0}(Wring^3) from Dai-Fu's alpha,beta.
Establishes the dictionary  alpha,beta  <->  tr(M^3), <M^#,M>  and locates the low-n syzygy."""
import numpy as np, itertools
rng=np.random.default_rng(7)
def random_weyl(n):
    A=rng.standard_normal((n,n,n,n))
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    W=R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
    return W/np.sqrt(np.einsum('ijkl,ijkl',W,W))
def lam2(W):
    n=W.shape[0]; pr=list(itertools.combinations(range(n),2))
    return np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr]),pr
def sharp(M,pr,n):
    N=len(pr); E=lambda i,j:(lambda A:(A.__setitem__((i,j),1),A.__setitem__((j,i),-1),A)[2])(np.zeros((n,n)))
    B=[E(i,j) for (i,j) in pr]; c=np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            C=B[a]@B[b]-B[b]@B[a]
            for g,(k,l) in enumerate(pr): c[a,b,g]=C[k,l]
    return 0.5*np.einsum('agd,bez,ge,dz->ab',c,c,M,M,optimize=True)
def ring(W):
    n=W.shape[0]; idx=[(i,j) for i in range(n) for j in range(i,n)]
    def bs(i,j):
        h=np.zeros((n,n))
        if i==j: h[i,i]=1
        else: h[i,j]=h[j,i]=1/np.sqrt(2)
        return h
    B=[bs(i,j) for (i,j) in idx]; m=len(idx); Op=np.zeros((m,m))
    for a,h in enumerate(B):
        Wh=np.einsum('ikjl,kl->ij',W,h)
        for b,hb in enumerate(B): Op[a,b]=np.sum(Wh*hb)
    g=np.array([np.trace(bs(i,j)) for (i,j) in idx]); g/=np.linalg.norm(g)
    P=np.eye(m)-np.outer(g,g); return P@Op@P
print(f"{'n':>3} {'alpha/trM3':>12} {'beta/<M#,M>':>13} {'trRing3 vs a/8-b':>18} {'rank[trM3,trRing3]':>20} {'ratio trRing3/trM3':>20}")
for n in range(4,10):
    rows=[]
    for _ in range(14):
        W=random_weyl(n); M,pr=lam2(W); M=M/np.linalg.norm(M); W=W/(2*np.linalg.norm(lam2(W)[0]))*2
        M,pr=lam2(W); nrm=np.linalg.norm(M); M/=nrm; W=W/nrm
        al=np.einsum('tpsq,tpkl,sqkl->',W,W,W); be=np.einsum('tspq,tjpl,sjql->',W,W,W)
        t1=np.trace(M@M@M); sh=np.sum(sharp(M,pr,n)*M); R0=ring(W); t2=np.trace(R0@R0@R0)
        rows.append([al,be,t1,sh,t2])
    A=np.array(rows)
    r_a=A[:,0]/A[:,2]; r_b=A[:,1]/A[:,3]
    dfu=np.abs(A[:,4]-(A[:,0]/8-A[:,1])).max()
    X=A[:,[2,4]]; rk=np.linalg.matrix_rank(X,tol=1e-9)
    rat=A[:,4]/A[:,2]
    print(f"{n:>3} {r_a.mean():>12.6f} {r_b.mean():>13.6f} {dfu:>18.2e} {rk:>20d} {rat.mean():>13.6f}+-{rat.std():.0e}")
