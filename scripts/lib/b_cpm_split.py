"""L_e at CP^m, split into the three pieces the closed form provides.

Since e = a Id + (b-a) P_u + (c-b) P_omega with a,b,c rational in m
(see b_cpm_closed_form.py), bilinearity of sharp_bilin gives

    L_e X = 1/2 (eX + Xe)  +  a sb(Id,X) + (b-a) sb(P_u,X) + (c-b) sb(P_omega,X),

verified here to 7e-16.  sb(Id,X) = -X on Weyl_n is already proved (Reviewers 38
and 39), so deriving the seven summand eigenvalues in closed form reduces to two
functions of m: the values of sb(P_u,.) and sb(P_omega,.) on each summand, together
with the anticommutator term.

Each of the four pieces is scalar on every eigenspace that is a single summand
(deviation ~1e-15) and non-scalar only on the zero eigenspace, which is the union of
V_{(2,1);(1)} and V_{(2);(2)} -- the same signature seen in the sphere-product case.

Kept small on purpose: the full-basis construction is O(D * N^3) and stalls from
m = 5 upward, so this runs at m = 3 and 4 and reports the rational values, which is
what the symbolic step needs.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from b_cpm_closed_form import projectors
from review_r30_core import adj, weyl_basis

def sharp_bilin(n, X, Y, A):
    N=A.shape[0]; A2=A.reshape(N*N,N)
    AX=(A2@X).reshape(N,N,N); AY=(A2@Y).reshape(N,N,N)
    T=AX.reshape(N,N*N)@AY.transpose(0,2,1).reshape(N,N*N).T
    return -0.25*(T+T.T)

def split(m):
    n=2*m; Pm,Psu,Pw,pairs,idx=projectors(m); N=len(pairs); A=adj(n)
    a=-1/(2*m-1); b=(m-2)/((m+1)*(2*m-1)); c=2*(m-1)/(2*m-1)
    Id=np.eye(N); Pu=Id-Pm; e=a*Pm+b*Psu+c*Pw
    B=weyl_basis(n); D=len(B)
    def opmat(f):
        M=np.zeros((D,D))
        for j,X in enumerate(B): M[:,j]=[np.tensordot(bb,f(X)) for bb in B]
        return 0.5*(M+M.T)
    Le  =opmat(lambda X: 0.5*(e@X+X@e)+sharp_bilin(n,e,X,A))
    parts={'anti':opmat(lambda X: 0.5*(e@X+X@e)),
           'sb(Id)':opmat(lambda X: sharp_bilin(n,Id,X,A)),
           'sb(Pu)':opmat(lambda X: sharp_bilin(n,Pu,X,A)),
           'sb(Pw)':opmat(lambda X: sharp_bilin(n,Pw,X,A))}
    lin=np.linalg.norm(opmat(lambda X: sharp_bilin(n,e,X,A))
                       -(a*parts['sb(Id)']+(b-a)*parts['sb(Pu)']+(c-b)*parts['sb(Pw)']))
    return Le, parts, lin, (a,b,c)

if __name__=="__main__":
    for m in (3,4):
        Le,parts,lin,(a,b,c)=split(m)
        D=Le.shape[0]; w,V=np.linalg.eigh(Le)
        print(f"m={m}: a={a:.6f} b={b:.6f} c={c:.6f}   bilinearity residual {lin:.1e}")
        i=0
        while i<D:
            j=i
            while j+1<D and abs(w[j+1]-w[i])<1e-8: j+=1
            U=V[:,i:j+1]; k=j-i+1
            vals={nm:np.trace(U.T@M@U)/k for nm,M in parts.items()}
            dev=max(np.linalg.norm(U.T@M@U-vals[nm]*np.eye(k)) for nm,M in parts.items())
            print(f"   lam={w[i]:+.6f} x{k:4d}  " +
                  "  ".join(f"{nm}={v:+.6f}" for nm,v in vals.items()) + f"   maxdev={dev:.1e}", flush=True)
            i=j+1
