"""Targeted V3-refutation hunt: Newton onto criticality from starts near the high-theta
region -- blends of the n=8 witness, S^3xS^5, S^4xS^4 and random Weyl directions."""
import numpy as np, sys, json
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
from census import biv_rank
from k1defs import sphere_M
n=8
idx,pos,N,c,B=weyl_basis(n); d=len(B)
Bmat=np.array([b.reshape(-1) for b in B])
mat=lambda x: np.tensordot(x,B,axes=(0,0)); coef=lambda X: Bmat@X.reshape(-1)
Wt=np.load('scripts/data/w_n8_nondiagonal_witness.npy'); Wt/=np.sqrt(inner(Wt,Wt))
anchors=[coef(Wt),coef(diag_to_operator(sphere_M(3,5),pos)),coef(diag_to_operator(sphere_M(4,4),pos))]
def newton(x):
    for it in range(120):
        W=mat(x); QW=Qmap(c,W); th=inner(W,QW)
        G=coef(QW)-th*x; nrm=np.linalg.norm(G)
        if nrm<1e-13: break
        Lmat=L_operator(c,B,W); qc=coef(QW)
        J=2*Lmat-np.outer(x,3*qc-2*th*x)-th*np.eye(d)
        try:
            step=np.linalg.lstsq(np.vstack([J,2*x]),-np.concatenate([G,[0.0]]),rcond=None)[0]
        except Exception:
            return None
        t=1.0
        for _ in range(40):
            xn=(x+t*step); xn/=np.linalg.norm(xn)
            Wn=mat(xn); Qn=Qmap(c,Wn)
            if np.linalg.norm(coef(Qn)-inner(Wn,Qn)*xn)<nrm: break
            t*=0.5
        x=xn
    return x
seen=[]
for s in range(200):
    rng=np.random.default_rng(9000+s)
    a=anchors[s%3]; eps=[0.05,0.15,0.3,0.5,0.8][(s//3)%5]
    r=rng.normal(size=d); r/=np.linalg.norm(r)
    x=a/np.linalg.norm(a)*(1-eps)+eps*r; x/=np.linalg.norm(x)
    x=newton(x)
    if x is None: continue
    W=mat(x); QW=Qmap(c,W); th=inner(W,QW); res=np.abs(QW-th*W).max()
    if res>1e-11 or th<1e-6: continue
    Lm=L_operator(c,B,W)/th; lmax,_=lam_max_perp(Lm,x); D=Delta(c,W)
    key=(round(th,7),round(D,5),round(lmax,6))
    if key in seen: continue
    seen.append(key)
    ew,V=np.linalg.eigh(W); nd=0
    for k in range(len(ew)):
        if np.sum(np.abs(ew-ew[k])<1e-9)==1: nd=max(nd,biv_rank(V[:,k],idx,n))
    print(json.dumps(dict(seed=9000+s,eps=eps,theta=float(th),Delta=float(D),lam=float(lmax),
                          ratio=float(lmax/th),simple_rank=int(nd),res=float(res))),flush=True)
    if D>1e-6 and lmax<=0.5+1e-9:
        np.save(f'scripts/reviewers/r305/out/REFUTER_near_{s}.npy',W); print("### V3 REFUTER CANDIDATE",flush=True)
