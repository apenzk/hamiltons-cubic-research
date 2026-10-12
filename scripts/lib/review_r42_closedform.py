"""Two closed forms for the sharp-bilinear against U(m)-invariant projectors."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r42_core import *
from review_r42_hw import Dmat
np.random.seed(3)

def Dreal(n, Y):
    P=pairs(n); N=len(P); D=np.zeros((N,N))
    for b,(i,j) in enumerate(P):
        pb=phi(n,i,j); C=Y@pb-pb@Y
        D[:,b]=[C[k,l] for (k,l) in P]
    return D

def u_basis(n):
    """orthonormal basis of u(m) inside Lambda^2 (coords in the phi basis)."""
    N=len(pairs(n)); U=P_u(n)
    w,V=np.linalg.eigh(U)
    return V[:,w>0.5]

for m in [3,4,5]:
    n=2*m; N=len(pairs(n))
    X=np.random.randn(N,N); X=X+X.T
    # (i) rank one:  sb(vv^T, X) = -1/2 D(v) X D(v)
    v=np.random.randn(N)
    Vmat=sum(v[a]*phi(n,i,j) for a,(i,j) in enumerate(pairs(n)))
    Dv=Dreal(n,Vmat)
    lhs=sb(n,np.outer(v,v),X); rhs=-0.5*Dv@X@Dv
    e1=np.abs(lhs-rhs).max()/np.abs(lhs).max()
    # (ii) P_omega
    J=Jmat(n); DJ=Dreal(n,J)
    lhs2=sb(n,P_omega(n),X); rhs2=-(1/(2*m))*DJ@X@DJ
    e2=np.abs(lhs2-rhs2).max()/np.abs(lhs2).max()
    # (iii) P_u  via the u(m)-Casimir
    Ub=u_basis(n); Ds=[]
    for r in range(Ub.shape[1]):
        Mr=sum(Ub[a,r]*phi(n,i,j) for a,(i,j) in enumerate(pairs(n)))
        Ds.append(Dreal(n,Mr))
    S=sum(D@X@D for D in Ds)
    lhs3=sb(n,P_u(n),X); rhs3=-0.5*S
    e3=np.abs(lhs3-rhs3).max()/np.abs(lhs3).max()
    C2=sum(D@D for D in Ds)
    Cas=-sum(D@(D@X-X@D)-(D@X-X@D)@D for D in Ds)
    rhs4=-0.25*(Cas+C2@X+X@C2)
    e4=np.abs(lhs3-rhs4).max()/np.abs(lhs3).max()
    # C2 scalars on the three blocks, DJ^2
    c2b=[np.sum(C2*P)/np.trace(P) for P in (P_mm(n),P_su(n),P_omega(n))]
    print(f"m={m}: rank1 {e1:.1e} | P_omega {e2:.1e} | P_u(sum) {e3:.1e} | P_u(Casimir) {e4:.1e} "
          f"| C2 blocks {[round(x,6) for x in c2b]} | DJ^2 = -4 P_m? {np.abs(DJ@DJ+4*P_mm(n)).max():.1e}")
