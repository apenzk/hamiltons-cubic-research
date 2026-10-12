"""R3 split, and R4 rows 1-3 (W, orbit, su(m)) from single test vectors."""
import numpy as np, sys
from fractions import Fraction as F
sys.path.insert(0, 'scripts/lib')
from review_r42_core import *
from review_r42_spec import e_cpm
from review_r42_hw import Le_apply
from review_r42_closedform import Dreal
np.random.seed(23)

for m in [3,4,5,6,7]:
    n=2*m; N=len(pairs(n)); e=e_cpm(m)
    a=-1.0/(2*m-1); b=(m-2)/((m+1)*(2*m-1)); c=2*(m-1)/(2*m-1)
    I=np.eye(N); Pu=P_u(n); Po=P_omega(n); Pm=P_mm(n)
    theta=np.sqrt((m+1)*(2*m-1)/(3.0*m*(m-1)))
    W=theta*e
    # --- R3: the split -------------------------------------------------
    M=np.random.randn(N,N); X=proj_weyl(n,M+M.T); X/=np.linalg.norm(X)
    lhs=Le_apply(n,e,X)
    rhs=0.5*(e@X+X@e)+a*sb(n,I,X)+(b-a)*sb(n,Pu,X)+(c-b)*sb(n,Po,X)
    split=np.abs(lhs-rhs).max()
    sbI=np.abs(sb(n,I,X)+X).max()
    # --- R4 row 1: W ---------------------------------------------------
    r1=np.linalg.norm(Le_apply(n,e,W)-W)/np.linalg.norm(W)
    # --- R4 row 2: the orbit ------------------------------------------
    vs=[]; vals=[]
    for _ in range(6):
        v=Pm@np.random.randn(N)
        Vm=sum(v[k]*phi(n,i,j) for k,(i,j) in enumerate(pairs(n)))
        Dv=Dreal(n,Vm); Xo=Dv@W-W@Dv
        if np.linalg.norm(Xo)<1e-10: continue
        Xo/=np.linalg.norm(Xo); vs.append(Xo)
        lo=np.vdot(Xo.ravel(),Le_apply(n,e,Xo).ravel())
        ro=np.linalg.norm(Le_apply(n,e,Xo)-0.5*Xo)
        pu=np.sum(Xo*sb(n,Pu,Xo)); po=np.sum(Xo*sb(n,Po,Xo))
        we=np.linalg.norm(Xo-proj_weyl(n,Xo))
        vals.append((lo,ro,pu,po,we))
    # orbit dimension: rank of  v -> [D(v),W]  over the m-part
    cols=[]
    for k,(i,j) in enumerate(pairs(n)):
        pk=Pm[:,k]
        Vm=sum(pk[t]*phi(n,p,q) for t,(p,q) in enumerate(pairs(n)))
        Dv=Dreal(n,Vm); cols.append((Dv@W-W@Dv).ravel())
    orb=np.linalg.matrix_rank(np.array(cols).T,tol=1e-8)
    # --- R4 row 3: su(m) ----------------------------------------------
    ws,Vv=np.linalg.eigh(P_su(n)); su=Vv[:,ws>0.5]
    S=su@np.random.randn(su.shape[1]); om=omega_vec(n)
    Xs=proj_weyl(n,0.5*(np.outer(S,om)+np.outer(om,S))); Xs/=np.linalg.norm(Xs)
    ls=np.vdot(Xs.ravel(),Le_apply(n,e,Xs).ravel())
    rs=np.linalg.norm(Le_apply(n,e,Xs)-((m+2)/(2*(m+1)))*Xs)
    print(f"m={m}: R3 split={split:.1e}  |sb(I,X)+X|={sbI:.1e}  | R4 W res={r1:.1e}"
          f" | orbit: rank={orb} (m(m-1)={m*(m-1)}) Le={vals[0][0]:.12f} res={vals[0][1]:.1e}"
          f" sb(Pu)={vals[0][2]:.9f} ~{F(vals[0][2]).limit_denominator(500)} (claim (m-2)/6={ (m-2)/6:.6f})"
          f" sb(Pom)={vals[0][3]:.1e} weylerr={vals[0][4]:.1e}"
          f" | su(m): Le={ls.real:.12f} claim={(m+2)/(2*(m+1)):.12f} res={rs:.1e}")
