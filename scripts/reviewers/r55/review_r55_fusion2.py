"""Independent check of the E(1/2) fusion rule, via the circ route rather than
the Le_matrix route, at the C_5 blow-up and at (S^3)^3."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *
from review_r55_k2 import Le_matrix
from review_r55_blocks import solve_all, expand
from review_r55_k1 import c5_vertex

def check(name,n,W,trials=8):
    W=W/np.linalg.norm(W); th=float(np.tensordot(W,Q(n,W)))
    e=W/th; B=weyl_basis(n); D=B.shape[0]; Bf=np.ascontiguousarray(B.reshape(D,-1))
    M=Le_matrix(n,e,B); ev,V=np.linalg.eigh(0.5*(M+M.T))
    half=V[:,np.abs(ev-0.5)<1e-8]
    rng=np.random.default_rng(5); out=[]
    for _ in range(trials):
        a=rng.normal(size=half.shape[1]); a/=np.linalg.norm(a)
        v=half@a
        X=np.einsum('d,dij->ij', v, B)
        Y=circ(n,X,X)
        yc=Bf@Y.ravel()
        out.append((np.linalg.norm(half.T@yc), np.linalg.norm(yc)))
    out=np.array(out)
    print(f"{name:>30}: dim E(1/2)={half.shape[1]:3d}  "
          f"||Pi_E(v o v)|| max={out[:,0].max():.3e}  ||v o v|| median={np.median(out[:,1]):.4f}  "
          f"relative={out[:,0].max()/np.median(out[:,1]):.3e}")

lam,_=c5_vertex([2]*5)
check("C_5 blow-up n=10", 10, diag_operator(lam))

sols=solve_all([3,3,3], ntry=200, seed=2)
from review_r55_k4 import stats
for c in sols:
    lam3,C=expand([3,3,3],c); d=stats(C,[3,3,3])
    if d['tri']>0:
        check("(S^3)^3 n=9", 9, diag_operator(lam3)); break

def two_block(p,q):
    n=p+q; lam=np.zeros((n,n)); z=-1.0; x=q/(p-1); y=p/(q-1)
    lab=[0]*p+[1]*q
    for i in range(n):
        for j in range(n):
            if i==j: continue
            lam[i,j]= x if (lab[i]==0 and lab[j]==0) else (y if (lab[i]==1 and lab[j]==1) else z)
    return lam
n=10; N=45; W=np.zeros((N,N)); lam6=two_block(3,3)
for a,(i,j) in enumerate(pairs_of(10)):
    if i<6 and j<6: W[a,a]=lam6[i,j]
check("S^3 x S^3 padded into n=10", 10, W)
