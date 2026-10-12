"""W_{CP^m} in closed form, as a combination of three isotypic projectors.

Lambda^2(R^2m) = so(2m) splits under U(m) into <omega>, su(m), and the complement
m of dimension m(m-1).  W_{CP^m}, being U(m)-invariant and symmetric, is a
combination of the three projectors, and the coefficients are RATIONAL in m:

    e = W/theta = -1/(2m-1) P_m  +  (m-2)/((m+1)(2m-1)) P_su  +  2(m-1)/(2m-1) P_omega

with theta^2 = (m+1)(2m-1)/(3m(m-1)).  The surd cancels out of e, which is what makes
a symbolic derivation of the L_e eigenvalues per summand possible -- the step still
owed for Observation 28.

Building W this way avoids constructing a basis of Weyl_2m altogether (dim 4004 at
m=7, which is where the direct route stalls), so it reaches m = 8, 9 and beyond.
Verified critical, Ricci-flat and Bianchi to ~1e-16 at m = 3,5,7,8,9, with P(W)
reproducing the closed-form theta.
"""
import numpy as np, math, sys
sys.path.insert(0, 'scripts/lib')
from b_cpm_spectrum import um_basis
from review_r30_core import pair_index, Q

def projectors(m):
    """P_m, P_su, P_omega on Lambda^2(R^2m), and the pair index."""
    n=2*m; pairs,idx=pair_index(n); N=len(pairs)
    J=np.zeros((n,n))
    for k in range(m): J[2*k,2*k+1]=1; J[2*k+1,2*k]=-1
    om=np.array([J[i,j] for (i,j) in pairs]); om/=np.linalg.norm(om)
    U=np.array([[E[i,j] for (i,j) in pairs] for E in um_basis(m)])
    Qu,_=np.linalg.qr(U.T); Pu=Qu@Qu.T
    Pw=np.outer(om,om)
    return np.eye(N)-Pu, Pu-Pw, Pw, pairs, idx

def theta(m): return math.sqrt((m+1)*(2*m-1)/(3*m*(m-1)))

def W_cpm(m):
    """The unit-norm CP^m Weyl operator, straight from the closed form."""
    Pm,Psu,Pw,pairs,idx = projectors(m)
    e = (-1/(2*m-1))*Pm + ((m-2)/((m+1)*(2*m-1)))*Psu + (2*(m-1)/(2*m-1))*Pw
    W = theta(m)*e
    return W/np.linalg.norm(W), pairs, idx

def check(m):
    n=2*m; W,pairs,idx = W_cpm(m)
    th=float(np.tensordot(W,Q(n,W)))
    def g(X,i,j,k,l):
        if i==j or k==l: return 0.0
        s=1.0
        if i>j: i,j,s=j,i,-s
        if k>l: k,l,s=l,k,-s
        return s*X[idx[(i,j)],idx[(k,l)]]
    ric=max(abs(sum(g(W,i,k,j,k) for k in range(n))) for i in range(n) for j in range(n))
    bia=max(abs(g(W,i,j,k,l)+g(W,i,k,l,j)+g(W,i,l,j,k))
            for i in range(n) for j in range(i+1,n) for k in range(j+1,n) for l in range(k+1,n))
    return float(np.linalg.norm(Q(n,W)-th*W)), ric, bia, th

if __name__=="__main__":
    print(f"{'m':>3} {'||Q(W)-thW||':>13} {'|Ric|max':>10} {'Bianchi':>10} {'P(W)':>13} {'closed form':>13}")
    for m in (3,4,5,6,7,8,9):
        crit,ric,bia,th=check(m)
        print(f"{m:3d} {crit:13.2e} {ric:10.2e} {bia:10.2e} {th:13.9f} {theta(m):13.9f}", flush=True)
