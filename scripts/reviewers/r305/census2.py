"""High-theta census: k power-iteration steps (which raise theta) then Gauss-Newton onto
criticality.  Aimed at Delta>0 points with LARGE theta, where lambda_max/theta can be small
and where a V3 refutation (Delta>0 with lambda_max <= 1/2) would live."""
import numpy as np, sys, time, json
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
from census import biv_rank

def run(n,nstart,seed0,kpow_choices):
    idx,pos,N,c,B=weyl_basis(n); d=len(B)
    Bmat=np.array([b.reshape(-1) for b in B])
    mat=lambda x: np.tensordot(x,B,axes=(0,0))
    coef=lambda X: Bmat@X.reshape(-1)
    for s in range(nstart):
        rng=np.random.default_rng(seed0+s)
        x=rng.normal(size=d); x/=np.linalg.norm(x)
        kp=kpow_choices[s%len(kpow_choices)]
        for _ in range(kp):
            W=mat(x); q=coef(Qmap(c,W))
            if np.linalg.norm(q)<1e-12: break
            x=q/np.linalg.norm(q)
        for it in range(120):
            W=mat(x); QW=Qmap(c,W); th=inner(W,QW)
            G=coef(QW)-th*x; nrm=np.linalg.norm(G)
            if nrm<1e-13: break
            Lmat=L_operator(c,B,W); qc=coef(QW)
            J=2*Lmat-np.outer(x,3*qc-2*th*x)-th*np.eye(d)
            Jf=np.vstack([J,2*x]); rf=np.concatenate([G,[0.0]])
            step=np.linalg.lstsq(Jf,-rf,rcond=None)[0]
            t=1.0
            for _ in range(40):
                xn=(x+t*step); xn/=np.linalg.norm(xn)
                Wn=mat(xn); Qn=Qmap(c,Wn); thn=inner(Wn,Qn)
                if np.linalg.norm(coef(Qn)-thn*xn)<nrm: break
                t*=0.5
            x=xn
        W=mat(x); QW=Qmap(c,W); th=inner(W,QW); r=np.abs(QW-th*W).max()
        if r>1e-11 or th<1e-6: continue
        Lmat=L_operator(c,B,W)/th
        lmax,_=lam_max_perp(Lmat,x)
        D=Delta(c,W); ew,V=np.linalg.eigh(W)
        nd=0
        for k in range(len(ew)):
            if np.sum(np.abs(ew-ew[k])<1e-9)==1: nd=max(nd,biv_rank(V[:,k],idx,n))
        rec=dict(n=n,seed=int(seed0+s),kpow=kp,theta=float(th),Delta=float(D),lam=float(lmax),
                 ratio=float(lmax/th),res=float(r),simple_rank=int(nd),kerdim=int(np.sum(np.abs(ew)<1e-9)))
        print(json.dumps(rec),flush=True)
        if D>1e-6 and lmax<=0.5+1e-9:
            np.save(f'scripts/reviewers/r305/out/REFUTER_n{n}_{seed0+s}.npy',W)
            print("### V3 REFUTER CANDIDATE SAVED",flush=True)

if __name__=="__main__":
    n=int(sys.argv[1]); ns=int(sys.argv[2]); s0=int(sys.argv[3])
    run(n,ns,s0,[1,2,3,5,8,15])
