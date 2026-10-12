"""Item 1(iv): is there a relation coupling the FOURTH moments of mu and omega?

Degree 2 gives one:  sum omega^2 = 3 sum mu^2.   Degree 3 gives none (rank 2, established).
If degree 4 gives one, that is a second coupling equation and a two-spectrum bound has
something to work with beyond the norms.  Tested by rank over a spanning sample.
"""
import numpy as np, itertools
rng=np.random.default_rng(41)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
def ring(W):
    n=W.shape[0]; idx=[(i,j) for i in range(n) for j in range(i,n)]
    def bs(i,j):
        h=np.zeros((n,n))
        if i==j: h[i,i]=1
        else: h[i,j]=h[j,i]=1/np.sqrt(2)
        return h
    B=[bs(i,j) for (i,j) in idx]; m=len(idx); Op=np.zeros((m,m))
    for a,h in enumerate(B):
        Wh=np.einsum('iklj,kl->ij',W,h)
        for b,hb in enumerate(B): Op[a,b]=np.sum(Wh*hb)
    gv=np.array([np.trace(b) for b in B]); gv/=np.linalg.norm(gv)
    P=np.eye(m)-np.outer(gv,gv); Bas=np.linalg.svd(P)[0][:,:m-1]
    return Bas.T@Op@Bas
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
for n in [5,6,7,8]:
    rows=[]
    for _ in range(24):
        W=proj_weyl(rng.standard_normal((n,n,n,n)),n)
        pr=list(itertools.combinations(range(n),2))
        M=np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr]); nm=np.linalg.norm(M)
        M/=nm; W=W/nm
        Rw=ring(W); Sh=sharp(M,pr,n)
        rows.append([np.trace(M@M@M@M), np.trace(Rw@Rw@Rw@Rw), 1.0,
                     np.sum(Sh*Sh), np.sum(Sh*(M@M)), np.trace(M@M@M), np.trace(Rw@Rw@Rw)])
    A=np.array(rows)
    # relation among the pure quartics {tr M^4, tr ring^4, 1}?
    X=A[:,[0,1,2]]; sv=np.linalg.svd(X, compute_uv=False)
    # and with the other quartics included
    Y=A[:,[0,1,2,3,4]]; sv2=np.linalg.svd(Y, compute_uv=False)
    # and: is tr(ring^4) a function of tr(M^4) alone?
    fit=np.linalg.lstsq(A[:,[0,2]],A[:,1],rcond=None); res=np.abs(A[:,[0,2]]@fit[0]-A[:,1]).max()
    print(f"n={n}: rank[trM^4,tr ring^4,1] = {np.sum(sv>1e-9*sv[0])} (sv {sv[0]:.2e} {sv[1]:.2e} {sv[2]:.2e}) | "
          f"rank with <#,#> and <#,M^2> = {np.sum(sv2>1e-9*sv2[0])}/5 | "
          f"tr(ring^4) from tr(M^4) alone: maxres {res:.2e}")
    print(f"      ranges: trM^4 [{A[:,0].min():.4f},{A[:,0].max():.4f}]  tr ring^4 [{A[:,1].min():.4f},{A[:,1].max():.4f}]")
