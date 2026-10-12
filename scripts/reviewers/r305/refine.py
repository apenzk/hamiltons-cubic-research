"""Refine the ratio<1 point found near the witness and characterise it."""
import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
from census import biv_rank
from k1defs import sphere_M
n=8; idx,pos,N,c,B=weyl_basis(n); d=len(B)
Bmat=np.array([b.reshape(-1) for b in B])
mat=lambda x: np.tensordot(x,B,axes=(0,0)); coef=lambda X: Bmat@X.reshape(-1)
Wt=np.load('scripts/data/w_n8_nondiagonal_witness.npy'); Wt/=np.sqrt(inner(Wt,Wt))
anchors=[coef(Wt),coef(diag_to_operator(sphere_M(3,5),pos)),coef(diag_to_operator(sphere_M(4,4),pos))]
s=3; rng=np.random.default_rng(9000+s); a=anchors[s%3]; eps=[0.05,0.15,0.3,0.5,0.8][(s//3)%5]
r=rng.normal(size=d); r/=np.linalg.norm(r)
x=a/np.linalg.norm(a)*(1-eps)+eps*r; x/=np.linalg.norm(x)
for it in range(400):
    W=mat(x); QW=Qmap(c,W); th=inner(W,QW)
    G=coef(QW)-th*x; nrm=np.linalg.norm(G)
    if nrm<1e-15: break
    Lmat=L_operator(c,B,W); qc=coef(QW)
    J=2*Lmat-np.outer(x,3*qc-2*th*x)-th*np.eye(d)
    step=np.linalg.lstsq(np.vstack([J,2*x]),-np.concatenate([G,[0.0]]),rcond=None)[0]
    t=1.0
    for _ in range(50):
        xn=(x+t*step); xn/=np.linalg.norm(xn)
        Wn=mat(xn); Qn=Qmap(c,Wn)
        if np.linalg.norm(coef(Qn)-inner(Wn,Qn)*xn)<nrm: break
        t*=0.5
    x=xn
W=mat(x); QW=Qmap(c,W); th=inner(W,QW)
print("criticality residual ||Q(W)-thW||_max =",np.abs(QW-th*W).max())
print("theta =",repr(th))
D=Delta(c,W); print("Delta =",D)
Lm=L_operator(c,B,W)/th; lmax,ev=lam_max_perp(Lm,x)
print("lambda_max(L_e|e-perp) =",lmax,"  ratio =",lmax/th)
evs=np.sort(np.linalg.eigvalsh(0.5*(Lm+Lm.T)))
print("top 6:",np.round(evs[-6:],9)," dim E(1)=",int(np.sum(np.abs(evs-1)<1e-8))," mult(1/2)=",int(np.sum(np.abs(evs-0.5)<1e-8)))
ew,V=np.linalg.eigh(W)
print("W spectrum:",np.round(ew,6))
print("ker dim:",int(np.sum(np.abs(ew)<1e-9)))
ranks=[(round(ew[k],6),biv_rank(V[:,k],idx,n)) for k in range(len(ew)) if np.sum(np.abs(ew-ew[k])<1e-9)==1]
print("simple eigenvalues and their bivector ranks:",ranks)
print("max |off-diagonal| of the pair matrix:",np.abs(W-np.diag(np.diag(W))).max())
np.save('scripts/reviewers/r305/out/r305_n8_ratio_lt1.npy',W)
# distance to the recorded witness, up to nothing (raw)
print("||W - W_witness|| =",np.linalg.norm(W-Wt), "  <W,W_witness> =",inner(W,Wt))
