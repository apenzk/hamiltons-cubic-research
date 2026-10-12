"""Full-space critical-point census at n=6,7,8 by Gauss-Newton with the ANALYTIC Jacobian.
Records theta, Delta, lambda_max(L_e|e-perp), the ratio lambda_max/theta, and a
proof-of-non-diagonality certificate (a simple eigenvalue whose eigenvector has bivector rank > 2).
"""
import numpy as np, sys, time, json
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *

def biv_rank(v, idx, n):
    A=np.zeros((n,n))
    for k,(i,j) in enumerate(idx):
        A[i,j]=v[k]; A[j,i]=-v[k]
    return int(np.linalg.matrix_rank(A,tol=1e-8))

def run(n, nstart, seed0, out):
    idx,pos,N,c,B=weyl_basis(n); d=len(B)
    Bmat=np.array([b.reshape(-1) for b in B])
    def mat(x): return np.tensordot(x,B,axes=(0,0))
    def coef(X): return Bmat@X.reshape(-1)
    res=[]
    for s in range(nstart):
        rng=np.random.default_rng(seed0+s)
        x=rng.normal(size=d); x/=np.linalg.norm(x)
        ok=False
        for it in range(80):
            W=mat(x); QW=Qmap(c,W); th=inner(W,QW)
            G=coef(QW)-th*x
            nrm=np.linalg.norm(G)
            if nrm<1e-13: ok=True; break
            Lmat=L_operator(c,B,W)
            qc=coef(QW)
            J=2*Lmat-np.outer(x,3*qc-2*th*x)-th*np.eye(d)
            Jf=np.vstack([J,2*x]); rf=np.concatenate([G,[np.dot(x,x)-1.0]])
            try:
                step=np.linalg.lstsq(Jf,-rf,rcond=None)[0]
            except Exception: break
            t=1.0
            for _ in range(30):
                xn=x+t*step; xn=xn/np.linalg.norm(xn)
                Wn=mat(xn); Qn=Qmap(c,Wn); thn=inner(Wn,Qn)
                if np.linalg.norm(coef(Qn)-thn*xn)<nrm: break
                t*=0.5
            x=xn
        W=mat(x); QW=Qmap(c,W); th=inner(W,QW)
        r=np.abs(QW-th*W).max()
        if r>1e-11 or th<1e-6: continue
        Lmat=L_operator(c,B,W)/th
        lmax,_=lam_max_perp(Lmat,x)
        D=Delta(c,W)
        ew,V=np.linalg.eigh(W)
        nd=0
        for k in range(len(ew)):
            if np.sum(np.abs(ew-ew[k])<1e-9)==1:
                nd=max(nd,biv_rank(V[:,k],idx,n))
        rec=dict(n=n,seed=int(seed0+s),theta=float(th),Delta=float(D),lam=float(lmax),
                 ratio=float(lmax/th),res=float(r),simple_rank=int(nd))
        res.append(rec)
        print(json.dumps(rec),flush=True)
    return res

if __name__=="__main__":
    n=int(sys.argv[1]); ns=int(sys.argv[2]); s0=int(sys.argv[3])
    t0=time.time(); r=run(n,ns,s0,None)
    print(f"# n={n} starts={ns} converged={len(r)} [{time.time()-t0:.0f}s]",flush=True)
