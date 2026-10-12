"""Re-solve a near-witness seed with the SAME Newton as hunt_near.py, then polish
the converged point in extended precision."""
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
cL=c.astype(np.longdouble); BL=B.astype(np.longdouble); BmL=Bmat.astype(np.longdouble)
matL=lambda z: np.tensordot(z,BL,axes=(0,0)); coefL=lambda X: BmL@X.reshape(-1)
def QL(R):
    M1=np.einsum('agd,ge->ade',cL,R,optimize=True); M2=np.einsum('bez,dz->bed',cL,R,optimize=True)
    return R@R+np.longdouble(0.5)*np.einsum('ade,bed->ab',M1,M2,optimize=True)

def newton64(x, iters=120):
    for it in range(iters):
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

def polish(x, iters=40):
    z=x.astype(np.longdouble)
    for it in range(iters):
        Wz=matL(z); Q=QL(Wz); th=np.sum(Wz*Q); G=coefL(Q)-th*z
        Gf=np.asarray(G).astype(np.float64)
        if np.linalg.norm(Gf)<1e-19: break
        Wf=np.asarray(Wz).astype(np.float64); zf=np.asarray(z).astype(np.float64)
        qc=np.asarray(coefL(Q)).astype(np.float64)
        Lmat=L_operator(c,B,Wf)
        J=2*Lmat-np.outer(zf,3*qc-2*float(th)*zf)-float(th)*np.eye(d)
        A=np.vstack([J,2*zf]).astype(np.float64); b=-np.concatenate([Gf,np.array([0.0])]).astype(np.float64)
        step=np.linalg.lstsq(A,b,rcond=None)[0]
        zn=z+step.astype(np.longdouble); zn=zn/np.sqrt(np.sum(zn*zn))
        Wn=matL(zn); Gn=coefL(QL(Wn))-np.sum(Wn*QL(Wn))*zn
        if np.linalg.norm(np.asarray(Gn).astype(np.float64))>np.linalg.norm(Gf): break
        z=zn
    return z

for s in [int(a) for a in sys.argv[1:]]:
    rng=np.random.default_rng(9000+s); a=anchors[s%3]; eps=[0.05,0.15,0.3,0.5,0.8][(s//3)%5]
    r=rng.normal(size=d); r/=np.linalg.norm(r)
    x=a/np.linalg.norm(a)*(1-eps)+eps*r; x/=np.linalg.norm(x)
    x=newton64(x)
    if x is None:
        print(f"seed {9000+s}: solver failed",flush=True); continue
    W0=mat(x); th0=P(c,W0)
    print(f"seed {9000+s}: float64 theta={th0:.12f} res={np.abs(Qmap(c,W0)-th0*W0).max():.2e}",flush=True)
    z=polish(x)
    W=np.asarray(matL(z)).astype(np.float64); xf=np.asarray(z).astype(np.float64); xf/=np.linalg.norm(xf)
    th=P(c,W); res=np.abs(Qmap(c,W)-th*W).max()
    Lm=L_operator(c,B,W)/th; lmax,_=lam_max_perp(Lm,xf)
    evs=np.sort(np.linalg.eigvalsh(0.5*(Lm+Lm.T))); ew,V=np.linalg.eigh(W)
    ranks=sorted(set(biv_rank(V[:,k],idx,n) for k in range(len(ew)) if np.sum(np.abs(ew-ew[k])<1e-9)==1))
    print(f"seed {9000+s}: theta={th:.15f} res={res:.2e} Delta={Delta(c,W):.9f} lam={lmax:.12f} ratio={lmax/th:.9f} "
          f"margin={lmax/0.5:.6f} dimE1={int(np.sum(np.abs(evs-1)<1e-8))} mult12={int(np.sum(np.abs(evs-0.5)<1e-8))} "
          f"ker={int(np.sum(np.abs(ew)<1e-9))} simple-ranks={ranks} <W,Wwit>={inner(W,Wt):.6f}",flush=True)
    np.save(f'scripts/reviewers/r305/out/r305_n8_seed{9000+s}.npy',W)
