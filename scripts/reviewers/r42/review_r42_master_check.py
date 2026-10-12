"""Numerical check of the operator identity behind the master formula, and of
   Cas(X) = c_S X on each highest-weight vector."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r42_core import *
from review_r42_spec import e_cpm
from review_r42_hw import hw_vector, Le_apply
from review_r42_closedform import Dreal, u_basis
from review_r42_r4hw import nu_of
np.random.seed(11)

for m in [3,4,5]:
    n=2*m; N=len(pairs(n)); e=e_cpm(m)
    J=Jmat(n); DJ=Dreal(n,J)
    Ub=u_basis(n); Ds=[]
    for r in range(Ub.shape[1]):
        Mr=sum(Ub[a,r]*phi(n,i,j) for a,(i,j) in enumerate(pairs(n)))
        Ds.append(Dreal(n,Mr))
    C2=sum(D@D for D in Ds)
    def Cas(X): return -sum(D@(D@X-X@D)-(D@X-X@D)@D for D in Ds)
    # random Weyl element
    M=np.random.randn(N,N); X=proj_weyl(n,M+M.T)
    lhs=Le_apply(n,e,X)
    rhs=0.5*(e@X+X@e)+X/(2*m-1)-(1/(4*(m+1)))*(Cas(X)+C2@X+X@C2)-(1/(2*(m+1)))*(DJ@X@DJ)
    print(f"m={m}: operator identity on random Weyl X : {np.abs(lhs-rhs).max()/np.abs(lhs).max():.2e}")
    # Casimir eigenvalue on each highest weight vector
    for nm in ['Lam2E','su(m)','V11;11','V21;1','V2;2','V22;0']:
        nu=nu_of(m,nm)
        if nu is None: continue
        out,dw,kh,vecs=hw_vector(m,nu)
        if out is None: continue
        Xh=vecs[:,0].reshape(N,N)
        cs=np.vdot(Xh.ravel(),Cas(Xh).ravel())/np.vdot(Xh.ravel(),Xh.ravel())
        res=np.linalg.norm(Cas(Xh)-cs*Xh)/np.linalg.norm(Xh)
        q=int(sum(nu))
        pred=1-(cs.real+q*q)/(4*(m+1))
        print(f"    {nm:8s} c_S={cs.real:+.9f} (res {res:.1e})  q={q}  master lambda={pred:+.9f}  measured={out[0][0].real:+.9f}")
