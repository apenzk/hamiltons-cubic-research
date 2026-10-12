"""Polish the new point in extended precision and test the robustness of lambda_max."""
import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
n=8; idx,pos,N,c,B=weyl_basis(n); d=len(B)
Bmat=np.array([b.reshape(-1) for b in B])
mat=lambda x: np.tensordot(x,B,axes=(0,0)); coef=lambda X: Bmat@X.reshape(-1)
W=np.load('scripts/reviewers/r305/out/r305_n8_ratio_lt1.npy')
x=coef(W); x/=np.linalg.norm(x)
# extended-precision Newton
cL=c.astype(np.longdouble); BL=B.astype(np.longdouble); BmL=Bmat.astype(np.longdouble)
matL=lambda z: np.tensordot(z,BL,axes=(0,0)); coefL=lambda X: BmL@X.reshape(-1)
def QL(R):
    M1=np.einsum('agd,ge->ade',cL,R,optimize=True)
    M2=np.einsum('bez,dz->bed',cL,R,optimize=True)
    return R@R+np.longdouble(0.5)*np.einsum('ade,bed->ab',M1,M2,optimize=True)
z=x.astype(np.longdouble)
for it in range(60):
    Wz=matL(z); Q=QL(Wz); th=np.sum(Wz*Q)
    G=coefL(Q)-th*z; nrm=float(np.linalg.norm(G))
    if nrm<1e-19: break
    Lmat=L_operator(c,B,np.array(Wz,dtype=float))
    qc=np.array(coefL(Q),dtype=float)
    J=2*Lmat-np.outer(np.array(z,dtype=float),3*qc-2*float(th)*np.array(z,dtype=float))-float(th)*np.eye(d)
    step=np.linalg.lstsq(np.vstack([J,2*np.array(z,dtype=float)]).astype(np.float64),-np.concatenate([np.array(G,dtype=float),np.array([0.0])]).astype(np.float64),rcond=None)[0]
    z=z+step.astype(np.longdouble); z=z/np.sqrt(np.sum(z*z))
Wz=matL(z); Q=QL(Wz); th=np.sum(Wz*Q)
print("longdouble polish: residual =",float(np.abs(Q-th*Wz).max()),"  theta =",float(th))
Wf=np.asarray(Wz).astype(np.float64); xf=np.asarray(z).astype(np.float64); xf/=np.linalg.norm(xf)
print("float64 residual after polish:",np.abs(Qmap(c,Wf)-P(c,Wf)*Wf).max())
thf=P(c,Wf); Lm=L_operator(c,B,Wf)/thf
lmax,_=lam_max_perp(Lm,xf)
print("theta =",thf," Delta =",Delta(c,Wf)," lambda_max =",lmax," ratio =",lmax/thf)
np.save('scripts/reviewers/r305/out/r305_n8_ratio_lt1.npy',Wf)
# robustness: perturb at the residual scale
rng=np.random.default_rng(0); dev=[]
for k in range(8):
    p=rng.normal(size=d); p/=np.linalg.norm(p)
    y=xf+1e-10*p; y/=np.linalg.norm(y); Wp=mat(y); tp=P(c,Wp)
    L2=L_operator(c,B,Wp)/tp
    dev.append(lam_max_perp(L2,y)[0])
print("lambda_max under 1e-10 perturbations: min %.12f max %.12f"%(min(dev),max(dev)))
