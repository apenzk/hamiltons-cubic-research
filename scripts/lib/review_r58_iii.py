"""Cross-check lam_max(Rring_e) on the (1 pos, 2 neg) stratum by THREE independent routes."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *
from review_r58_secondkind import circ
from review_r58_sk2 import Rring_mat, sigma_and_b

def weyl4_12(q,r):
    P=phis(4); pr=pairs(4); e=lambda i,j:P[pr.index((i,j))]
    SD=[(e(0,1)+e(2,3))/np.sqrt(2),(e(0,2)-e(1,3))/np.sqrt(2),(e(0,3)+e(1,2))/np.sqrt(2)]
    V=np.array([[0.5*np.trace(s.T@P[a]) for a in range(6)] for s in SD])
    W=(q+r)*np.outer(V[0],V[0])-q*np.outer(V[1],V[1])-r*np.outer(V[2],V[2])
    return W/fro(W)

def route_B(W,n):
    """max over frames of lam_max(K),  K_ab = <W(e_a^e_b), e_a^e_b>  -- random-frame lower bound + ascent"""
    from scipy.optimize import minimize
    pr=pairs(n); pidx={p:a for a,p in enumerate(pr)}
    rng=np.random.default_rng(0); best=-9
    def val(x):
        A=x.reshape(n,n); Qo,_=np.linalg.qr(A)
        K=np.zeros((n,n))
        P=phis(n)
        # bivector Q e_a ^ Q e_b in the phi basis
        B=np.zeros((n,n,len(pr)))
        for a in range(n):
            for b in range(n):
                M=np.outer(Qo[:,a],Qo[:,b])-np.outer(Qo[:,b],Qo[:,a])
                B[a,b]=[0.5*np.trace(M.T@P[p]) for p in range(len(pr))]
        for a in range(n):
            for b in range(n):
                if a==b: continue
                K[a,b]=B[a,b]@W@B[a,b]
        return -np.linalg.eigvalsh(K)[-1]
    for t in range(150):
        best=max(best,-val(rng.standard_normal(n*n)))
    best=max(best,-val(np.eye(n).reshape(-1)))
    return best

def route_C(W,n):
    """lam_max of block (a) of L_e, times 2  (uses the o-product path, no Rring at all)"""
    th=theta(W,n); e=W/th
    N=n*(n-1)//2; pr=pairs(n); pidx={p:a for a,p in enumerate(pr)}
    u=n-1; A_idx=[pidx[(i,u)] for i in range(n-1)]; m=len(A_idx)
    idx=[(i,j) for i in range(m) for j in range(i,m)]
    def hb(p):
        i,j=idx[p]; X=np.zeros((N,N))
        if i==j: X[A_idx[i],A_idx[i]]=1.0
        else: X[A_idx[i],A_idx[j]]=X[A_idx[j],A_idx[i]]=1/np.sqrt(2)
        return X
    M=np.zeros((len(idx),len(idx)))
    for q_ in range(len(idx)):
        LX=circ(e,hb(q_),n)
        for p in range(len(idx)): M[p,q_]=np.sum(hb(p)*LX)
    M=0.5*(M+M.T)
    return 2*np.linalg.eigvalsh(M)[-1]

print('Padded Weyl_4 stratum members, n=6.  e = W/theta.   All have exactly 1 positive and 2 negative eigenvalues.')
print(' q     r      theta      lam_max(Rring_W)  routeB(frames)  routeC(2*L_e|blk a)   lam_max(Rring_e)   2b*Sigma   2b*Sigma<=theta?')
for (q,r) in [(1,1),(1,0.7),(1,0.5),(1,0.4),(1,0.3),(2,0.3),(1,0.1)]:
    n=6; W=pad(weyl4_12(q,r),4,n)
    lam=np.linalg.eigvalsh(W)
    assert int(np.sum(lam>1e-9))==1 and int(np.sum(lam<-1e-9))==2, (q,r,lam)
    th=theta(W,n); lmW=np.linalg.eigvalsh(Rring_mat(W,n))[-1]
    rb=route_B(W,n); rc=route_C(W,n)
    b,S2,_,_=sigma_and_b(W,n)
    print(' %.1f   %.2f   %.6f   %14.9f  %13.9f  %17.9f  %14.9f   %.6f   %s'%(
        q,r,th,lmW,rb,rc,lmW/th,2*b*S2,'YES' if 2*b*S2<=th+1e-12 else 'NO'))
