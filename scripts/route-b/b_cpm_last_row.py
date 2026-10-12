"""The last CP^m summand row: V_{(1,1);(1,1)} carries 2/(m+1).

This is the only summand besides the orbit that can reach 1/2, so it is the row
nondegeneracy actually turns on: 2/(m+1) = 1/2 exactly at m = 3, where the summand
has dimension m^2(m+1)(m-3)/4 = 0.  The other summands sit at 0 and -3/(m+1).

Method: take v, w in the m-part of Lambda^2, project v (x) w symmetrised onto Weyl,
then deflate the five eigenvalues already known in closed form
(1, (m+2)/(2(m+1)), 1/2, 0, -3/(m+1)).  What survives is an eigenvector for the
sixth, confirmed by its residual rather than by a Rayleigh quotient alone.

The row is also derivable rather than merely measured.  Splitting L_e by the closed
form of b_cpm_split.py, the three pieces on this summand are

    sb(P_u) = 1/3   (constant in m),   sb(P_omega) = 4/(3m),
    anticommutator C = -(m+4)/(3(m+1)(2m-1)),

and assembling with a, b, c gives 2/(m+1) identically in m.  All three are confirmed
here against the deflated eigenvector at m = 4,5,6.

A WARNING, because two attempts failed on it first.  The projection onto Weyl_n must
be taken against an orthonormal BASIS.  Removing the Lambda^4 part and then the Ricci
part IS orthogonal in principle -- antisymmetric tensors have vanishing traces, so
Ricci annihilates Lambda^4 and the steps commute -- but only if every normalisation
is exact.  Get one wrong and the map still fixes Weyl_n to 1e-16 while being 15-30%
off on general input and not idempotent, which no test run on Weyl_n can detect.
Measured against the true basis, e o X leaves Weyl_n by ~4e-16: there is no leak.
"""
import numpy as np, sys
from fractions import Fraction as F
sys.path.insert(0, 'scripts/lib')
from b_cpm_closed_form import projectors
from b_cpm_split import sharp_bilin
from review_r30_core import adj, weyl_basis

def last_row(m):
    n=2*m; Pm,Psu,Pw,pairs,idx=projectors(m); N=len(pairs); A=adj(n)
    a=-1/(2*m-1); b=(m-2)/((m+1)*(2*m-1)); c=2*(m-1)/(2*m-1)
    e=a*Pm+b*Psu+c*Pw
    B=weyl_basis(n)
    PW=lambda X: sum(float(np.tensordot(bb,X))*bb for bb in B)
    Le=lambda X: PW(0.5*(e@X+X@e)+sharp_bilin(n,e,X,A))
    v=Pm@np.eye(N)[idx[(0,2)]]; w=Pm@np.eye(N)[idx[(1,3)]]
    X=PW(0.5*(np.outer(v,w)+np.outer(w,v)))
    X/=np.linalg.norm(X)
    for lam in (1.0,(m+2)/(2*(m+1)),0.5,0.0,-3/(m+1)):
        X=Le(X)-lam*X
    nz=np.linalg.norm(X)
    if nz<1e-9: return None
    Y=X/nz
    lam=float(np.tensordot(Y,Le(Y)))
    Pu=np.eye(N)-Pm
    f=lambda M: float(np.tensordot(Y,M))
    pieces=(f(sharp_bilin(n,Pu,Y,A)), f(sharp_bilin(n,Pw,Y,A)), f(0.5*(e@Y+Y@e)))
    return lam, float(np.linalg.norm(Le(Y)-lam*Y)), nz, pieces

if __name__=="__main__":
    rat=lambda x: F(x).limit_denominator(20000)
    print(f"{'m':>3} {'eigenvalue':>12} {'2/(m+1)':>9} {'eigen residual':>15} {'||deflated||':>13}")
    for m in (4,5,6):
        r=last_row(m)
        if r is None: print(f"{m:3d}   (no component)"); continue
        lam,res,nz,(u,w,C)=r
        print(f"{m:3d} {str(rat(lam)):>12} {str(rat(2/(m+1))):>9} {res:15.2e} {nz:13.3e}", flush=True)
        print(f"      sb(P_u)={rat(u)} (want 1/3)   sb(P_om)={rat(w)} (want {rat(4/(3*m))})   "
              f"C={rat(C)} (want {rat(-(m+4)/(3*(m+1)*(2*m-1)))})", flush=True)
