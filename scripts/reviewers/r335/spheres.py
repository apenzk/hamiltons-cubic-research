import sys; sys.path.insert(0,'scripts/reviewers/r335')
import numpy as np, w335 as w
def prod_weyl(n,p,k1=1.0,k2=1.0):
    P=w.pairs(n); N=len(P)
    S=np.zeros((N,N))
    for t,(i,j) in enumerate(P):
        if i<p and j<p: S[t,t]=k1
        elif i>=p and j>=p: S[t,t]=k2
    return S
for n in [5,6,8,10,12]:
    c=w.struct(n); B=w.weyl_basis(n)
    for p in range(2,n//2+1):
        S=prod_weyl(n,p)
        PW=w.proj_weyl(S,B)
        nn=np.sqrt((PW*PW).sum())
        if nn<1e-12: print("n=%d S^%dxS^%d : Weyl part zero"%(n,p,n-p)); continue
        W=PW/nn
        lam=np.linalg.eigvalsh(W); Q=w.Qmap(W,c); th=float((W*Q).sum())
        print("n=%2d S^%dxS^%-2d ratio=%.6f (n-2=%d) mirror=%.6f theta=%.6f critres=%.1e spec=%s"%(
            n,p,n-p,lam[-1]/abs(lam[0]),n-2,abs(lam[0])/lam[-1],th,np.linalg.norm(Q-th*W),
            np.round(np.unique(np.round(lam,7)),5)))
