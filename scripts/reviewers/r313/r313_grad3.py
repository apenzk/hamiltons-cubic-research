"""Exhaustive-in-practice grading search: any g with [Lambda^2(g),W]=0 commutes with every
O(n)-equivariant symmetric 2-tensor built from W, so V must be a sum of joint eigenspaces
of ric(W^m) = sum_j (W^m)_{ijpj}."""
import sys, numpy as np, itertools
sys.path.insert(0,'scripts/reviewers/r313')
import r313_lib as R
from r313_m3 import gauss_newton
from r313_grading import lam2_of
n=8; P=R.pairs(n); N=len(P); D=R.pidx(n)

def tens(S):
    Wt=np.zeros((n,n,n,n))
    for (i,j),(a,sa) in D.items():
        for (k,l),(b,sb) in D.items(): Wt[i,j,k,l]=sa*sb*S[a,b]
    return Wt

def ric_pow(W, m):
    S=np.linalg.matrix_power(W,m)
    return np.einsum('ijpj->ip', tens(S))

def joint_frame(W, seed=3):
    rng=np.random.default_rng(seed)
    Z=np.zeros((n,n))
    for m in (2,3,4,5,6):
        A=ric_pow(W,m); A=0.5*(A+A.T)
        Z += rng.standard_normal()*A/max(np.linalg.norm(A),1e-30)
    ev,V=np.linalg.eigh(Z)
    groups=[]; i=0
    while i<len(ev):
        j=i
        while j+1<len(ev) and abs(ev[j+1]-ev[i])<1e-7: j+=1
        groups.append(list(range(i,j+1))); i=j+1
    return V, groups, ev

def gradings(W):
    V,groups,ev=joint_frame(W)
    found=[]
    for r in range(1,len(groups)+1):
        for sub in itertools.combinations(range(len(groups)),r):
            cols=[c for s in sub for c in groups[s]]
            k=len(cols)
            if k==0 or k>n//2: continue
            g=np.eye(n)-2*V[:,cols]@V[:,cols].T
            L=lam2_of(n,g)
            if np.linalg.norm(L@W-W@L)<1e-7:
                rest=[c for c in range(n) if c not in cols]
                Rot=np.column_stack([V[:,cols],V[:,rest]])
                if np.linalg.det(Rot)<0: Rot[:,-1]*=-1
                found.append((k,Rot))
    return found,[len(g) for g in groups]

if __name__=='__main__':
    import r313_m56 as M
    def load(f):
        W=np.load(f"scripts/reviewers/r305/out/{f}.npy")
        W=gauss_newton(n,W); return W if R.theta_of(n,W)>0 else -W
    for nm,W in (("S3xS5",M.sphere_W(8,3)),("witness(9015)",load("r305_n8_seed9015")),
                 ("9018",load("r305_n8_seed9018")),("9033",load("r305_n8_seed9033"))):
        f,gs=gradings(W)
        print(f"{nm}: joint eigengroup sizes {gs}; gradings with dim V = {sorted(k for k,_ in f)}", flush=True)
