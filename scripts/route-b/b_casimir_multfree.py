"""Multiplicity-freeness of Weyl_n under SO(p) x SO(q), via the two block Casimirs.

Schur makes L_e a scalar on each summand of Nienhaus Prop 4.6 only if no two
summands are isomorphic.  Two irreducibles with different Casimir eigenvalues are
non-isomorphic, so computing the JOINT spectrum of the two block Casimirs
C_P = -sum_{a in Lambda^2 P} G_a^2 and C_Q likewise -- which commute with the whole
action and with each other -- labels the summands.  Ten distinct joint eigenvalues
whose multiplicities are the ten predicted summand dimensions is the statement.

This is D x D work (D = dim Weyl_n <= 770), not D^2 x D^2.
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, adj, sphere_product_W, Q, weyl_basis

def block_casimirs(p,q):
    n=p+q; pairs,idx=pair_index(n); A=adj(n)
    B=weyl_basis(n); D=len(B); Bf=np.array([b.ravel() for b in B])
    def gen(a):
        M=np.empty((D,D))
        for c,X in enumerate(B):
            M[:,c]=Bf@(A[a]@X-X@A[a]).ravel()
        return M
    CP=np.zeros((D,D)); CQ=np.zeros((D,D))
    for (i,j) in pairs:
        if i<p and j<p:   G=gen(idx[(i,j)]); CP-=G@G
        elif i>=p:        G=gen(idx[(i,j)]); CQ-=G@G
    return CP,CQ,D,B,n

def predicted(p,q):
    Wd=lambda m: m*(m+1)*(m+2)*(m-3)//12
    s=lambda m:(m+2)*(m-1)//2; c=lambda m:m*(m-1)//2
    X=lambda m: m*(m*m-4)//3
    return sorted([1, Wd(p), Wd(q), p*q, s(p), s(q), s(p)*s(q), c(p)*c(q),
                   X(p)*q, X(q)*p])

if __name__=="__main__":
    print(f"{'(p,q)':>8} {'D':>5} {'joint eigs':>11} {'mults match Prop 4.6':>22} {'t':>6}")
    for (p,q) in [(3,3),(3,5),(4,4),(4,6),(5,5)]:
        t0=time.time()
        CP,CQ,D,B,n=block_casimirs(p,q)
        # simultaneous eigenvalues: CP and CQ commute, diagonalise CP + pi*CQ
        M=CP+np.pi*CQ; M=0.5*(M+M.T)
        ev=np.linalg.eigvalsh(M)
        uniq=[]; 
        for v in ev:
            if not uniq or abs(v-uniq[-1][0])>1e-6: uniq.append([v,1])
            else: uniq[-1][1]+=1
        mults=sorted(m for _,m in uniq)
        pred=[x for x in predicted(p,q) if x>0]
        print(f"{str((p,q)):>8} {D:5d} {len(uniq):11d} {str(mults==sorted(pred)):>22} {time.time()-t0:5.1f}s", flush=True)
        if mults!=sorted(pred):
            print(f"      got {mults}\n      pred {sorted(pred)}")
