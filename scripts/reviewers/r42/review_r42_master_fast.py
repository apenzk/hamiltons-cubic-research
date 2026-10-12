import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r42_core import *
from review_r42_spec import e_cpm, weyl_basis, Le_matrix
from review_r42_hw import Le_apply
from review_r42_closedform import Dreal, u_basis
np.random.seed(31)
for m in [3,4,5]:
    n=2*m; N=len(pairs(n)); e=e_cpm(m); DJ=Dreal(n,Jmat(n))
    Ub=u_basis(n); Ds=[]
    for r in range(Ub.shape[1]):
        Mr=sum(Ub[a,r]*phi(n,i,j) for a,(i,j) in enumerate(pairs(n)))
        Ds.append(Dreal(n,Mr))
    C2=sum(D@D for D in Ds)
    def Cas(X): return -sum(D@(D@X-X@D)-(D@X-X@D)@D for D in Ds)
    M=np.random.randn(N,N); X=proj_weyl(n,M+M.T)
    lhs=Le_apply(n,e,X)
    rhs=0.5*(e@X+X@e)+X/(2*m-1)-(1/(4*(m+1)))*(Cas(X)+C2@X+X@C2)-(1/(2*(m+1)))*(DJ@X@DJ)
    print(f"m={m} operator identity on random Weyl X: {np.abs(lhs-rhs).max()/np.abs(lhs).max():.2e}")
    # Casimir + charge on each L_e eigenspace
    B=weyl_basis(n); L,_=Le_matrix(n,e,B); L=0.5*(L+L.T)
    w,V=np.linalg.eigh(L)
    # charge operator: X -> [DJ, X] has eigenvalue i*q ; use  -[DJ,[DJ,X]] = q^2 X
    groups=[]
    for k,x in enumerate(w):
        if groups and abs(x-groups[-1][0])<1e-8: groups[-1][1].append(k)
        else: groups.append((x,[k]))
    for x,idx in groups:
        Y=[ (B@V[:,k]).reshape(N,N) for k in idx ]
        cs=np.mean([np.sum(y*Cas(y))/np.sum(y*y) for y in Y])
        q2=np.mean([-np.sum(y*(DJ@(DJ@y-y@DJ)-(DJ@y-y@DJ)@DJ))/np.sum(y*y) for y in Y])
        pred=1-(cs+q2)/(4*(m+1))
        print(f"   lam={x:+.9f} mult={len(idx):5d}  c_S={cs:+.6f}  q^2={q2:+.6f}  master={pred:+.9f}")
