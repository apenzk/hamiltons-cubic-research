import sys; sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r37_core import *
from review_r37_k1 import mask_ppmix
from review_r37_k4b import lie_gens, dlambda2, commutant_dim
for (p,q) in [(3,3),(4,3),(4,5),(3,7),(3,6)]:
    n=p+q; A=struct_A(n); N=A.shape[0]; Ip=I_block(p,q,'p'); mask=mask_ppmix(p,q)
    bas=[]
    for a in range(N):
        for b in range(a+1,N):
            if mask[a,b]:
                E=np.zeros((N,N)); E[a,b]=E[b,a]=1/np.sqrt(2.0); bas.append(E)
    bas=np.array(bas); d=bas.shape[0]
    M=np.zeros((d,d))
    for j in range(d): M[:,j]=coords(bas, sharp_bilin(Ip,bas[j],A))
    w,v=np.linalg.eigh(0.5*(M+M.T))
    vals,cnt=np.unique(np.round(w,9),return_counts=True)
    sel=v[:, np.abs(w+0.5)<1e-8]
    Esub=np.einsum('kd,dij->kij', sel.T, bas)
    def rlie(sub):
        out=[]
        for X in lie_gens(p,q):
            dr=dlambda2(X,n)
            out.append(np.array([[np.tensordot(sub[a], dr@sub[b]+sub[b]@dr.T) for b in range(sub.shape[0])] for a in range(sub.shape[0])]))
        return out
    def rrefl(sub):
        out=[]
        for which in ('p','q'):
            g=np.eye(n)
            if which=='p': g[0,0]=-1
            else: g[p,p]=-1
            rho=lambda2(g)
            out.append(np.array([[np.tensordot(sub[a], rho@sub[b]@rho.T) for b in range(sub.shape[0])] for a in range(sub.shape[0])]))
        return out
    dso,do=commutant_dim(None, rlie(Esub), rrefl(Esub))
    print(f"({p},{q}) raw block dim {d}, spectrum {[(float(x),int(c)) for x,c in zip(vals,cnt)]}")
    print(f"      E(-1/2) dim {Esub.shape[0]} (X(p)q={p*(p*p-4)//3*q}): Comm_SO={dso}  Comm_O={do}", flush=True)
