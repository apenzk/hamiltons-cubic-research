"""Per-summand values of the L_e pieces at CP^m, without building a Weyl basis.

Following the closed form of b_cpm_closed_form.py, each summand's eigenvalue is
  L_e = anti + a*(-1) + (b-a)*sb(P_u) + (c-b)*sb(P_omega)
with a, b, c rational in m and sb(Id, X) = -X already proved.  Evaluating on one
test vector per summand gives that summand's row, and by Schur the value IS the
eigenvalue rather than a bound.

The point of doing it this way: constructing a basis of Weyl_2m stalls from m = 5
upward, while a single test vector costs O(N^2) and reaches m = 7 in seconds.

Rows closed so far.  <W> and the orbit need no projection (W and [ad(v),W] are
already in Weyl_n) and were checked to m = 8; the su(m) row projects, so with the
exact basis projection it is run to m = 6 here.
  <W>     : L_e = 1
  orbit   : sb(P_u) = (m-2)/6, sb(P_omega) = 0, and L_e = 1/2 exactly
  su(m)   : L_e = (m+2)/(2(m+1)), which is lambda_max

su(m) lies in the STABILISER of W, so [ad(u), W] = 0 and orbit directions cannot
reach that summand; the vector that does is S (x) omega symmetrised and projected to
Weyl, with S in su(m) -- omega is invariant, so the pair carries the adjoint.

What remains for nondegeneracy is ONE row: V_{(1,1);(1,1)} at 2/(m+1), the only
other summand that can reach 1/2 (it does, at m = 3, where its dimension vanishes).
The two summands at 0 and the one at -3/(m+1) need only an inequality, not a value.
"""
import numpy as np, sys
from fractions import Fraction as F
sys.path.insert(0, 'scripts/lib')
from b_cpm_closed_form import projectors, W_cpm
from b_cpm_split import sharp_bilin
from review_r30_core import adj

def weyl_project(n, X, pairs, idx):
    """Orthogonal projection onto Weyl_n, taken against an orthonormal basis.

    Done this way on purpose.  The tempting alternative -- remove the Lambda^4 part,
    then remove the Ricci part -- IS orthogonal in principle (totally antisymmetric
    tensors have vanishing traces, so Ricci annihilates Lambda^4 and the two steps
    commute), but only if every normalisation is exactly right.  Getting the
    Kulkarni-Nomizu or scalar-curvature factor wrong leaves a map that still fixes
    Weyl_n to 1e-16 while being 15-30% wrong on general input and not idempotent --
    a defect no test run on Weyl_n itself can see.  The basis costs more and cannot
    be wrong.
    """
    B = _weyl_basis_cached(n)
    return sum(float(np.tensordot(bb, X)) * bb for bb in B)


_WB = {}
def _weyl_basis_cached(n):
    if n not in _WB:
        from review_r30_core import weyl_basis
        _WB[n] = weyl_basis(n)
    return _WB[n]


def rows(m):
    n=2*m; Pm,Psu,Pw,pairs,idx=projectors(m); N=len(pairs); A=adj(n)
    a=-1/(2*m-1); b=(m-2)/((m+1)*(2*m-1)); c=2*(m-1)/(2*m-1)
    Pu=np.eye(N)-Pm; e=a*Pm+b*Psu+c*Pw
    W,_,_=W_cpm(m)
    out={}
    def row(nm,X):
        f=lambda M: float(np.tensordot(X,M))/float(np.tensordot(X,X))
        spu=f(sharp_bilin(n,Pu,X,A)); spw=f(sharp_bilin(n,Pw,X,A))
        anti=f(0.5*(e@X+X@e))
        out[nm]=(spu,spw,anti,anti-a+(b-a)*spu+(c-b)*spw)
    row('<W>',W)
    v=Pm@np.eye(N)[idx[(0,2)]]
    Av=sum(vv*A[k] for k,vv in enumerate(v) if abs(vv)>1e-12)
    T=Av@W-W@Av
    row('orbit',T/np.linalg.norm(T))
    J=np.zeros((n,n))
    for k in range(m): J[2*k,2*k+1]=1; J[2*k+1,2*k]=-1
    om=np.array([J[i,j] for (i,j) in pairs]); om/=np.linalg.norm(om)
    sv=Psu@np.eye(N)[idx[(0,1)]]
    if np.linalg.norm(sv)<1e-9: sv=Psu@np.eye(N)[idx[(0,2)]]
    sv/=np.linalg.norm(sv)
    Xs=weyl_project(n,0.5*(np.outer(sv,om)+np.outer(om,sv)),pairs,idx)
    if np.linalg.norm(Xs)>1e-9: row('su(m)',Xs/np.linalg.norm(Xs))
    return out

if __name__=="__main__":
    rat=lambda x: F(x).limit_denominator(5000)
    print(f"{'m':>3} {'summand':>8} {'sb(Pu)':>10} {'sb(Pw)':>8} {'anti':>12} {'L_e':>6} {'(m-2)/6':>9}")
    for m in (3,4,5,6):
        for nm,(spu,spw,anti,le) in rows(m).items():
            pred = f"{rat((m-2)/6)}" if nm=='orbit' else (f"{rat((m+2)/(2*(m+1)))}" if nm=='su(m)' else "")
            print(f"{m:3d} {nm:>8} {str(rat(spu)):>10} {str(rat(spw)):>8} {str(rat(anti)):>12} "
                  f"{str(rat(le)):>6} {pred:>9}", flush=True)
