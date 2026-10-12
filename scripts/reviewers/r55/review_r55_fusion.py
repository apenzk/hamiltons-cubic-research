"""Is the second-order obstruction vacuous at OTHER degenerate critical points too?
Checks T(i,j,k) = <F_i, F_j o F_k> on E(1/2) at three further points."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *
from review_r55_k2 import Le_matrix
from review_r55_blocks import solve_all, expand

def two_block(p,q):
    n=p+q; lam=np.zeros((n,n))
    a=1.0; b=-(p-1)/q if False else None
    # solve row sums: within-block value x for block A, y for block B, cross z
    # ansatz: x on A, y on B, z across; row sums: (p-1)x + q z = 0, (q-1)y + p z = 0
    z=-1.0; x=q/(p-1); y=p/(q-1)
    lab=[0]*p+[1]*q
    for i in range(n):
        for j in range(n):
            if i==j: continue
            lam[i,j]= x if (lab[i]==0 and lab[j]==0) else (y if (lab[i]==1 and lab[j]==1) else z)
    return lam

def report(name, n, W):
    W=W/np.linalg.norm(W)
    th=float(np.tensordot(W,Q(n,W))); res=float(np.linalg.norm(Q(n,W)-th*W))
    if res>1e-8: print(f"{name}: NOT critical, residual {res:.1e}"); return
    e=W/th; B=weyl_basis(n); M=Le_matrix(n,e,B); Ms=0.5*(M+M.T)
    ev,V=np.linalg.eigh(Ms); half=V[:,np.abs(ev-0.5)<1e-8]
    F=np.einsum('dk,dij->kij', half, B); K=F.shape[0]
    OT=onb(orbit_tangent(n,W)); orb=OT.shape[0]
    T=np.zeros((K,K,K))
    for j in range(K): T[:,j,:]=Le_matrix(n,F[j],F)
    print(f"{name:>28}: n={n} theta={th:.6f} res={res:.1e} dim E(1/2)={K} orbit={orb} "
          f"excess={K-orb}  max|T on E(1/2)| = {np.abs(T).max():.3e}")

# padded S^3 x S^3 into n=10 (known degenerate, excess 9)
lam6=two_block(3,3)
n=10; N=n*(n-1)//2
W=np.zeros((N,N))
prs=pairs_of(n)
for a,(i,j) in enumerate(prs):
    if i<6 and j<6: W[a,a]=lam6[i,j]
report("S^3 x S^3 padded into n=10", 10, W)

# the balanced product S^5 x S^5 at n=10 (nondegenerate)
report("S^5 x S^5 at n=10", 10, diag_operator(two_block(5,5)))

# the 3-block product at n=9
sols=solve_all([3,3,3], ntry=200, seed=2)
best=None
for c in sols:
    lam,C=expand([3,3,3],c)
    W3=diag_operator(lam)
    if np.linalg.norm(W3)<1e-8: continue
    from review_r55_k4 import stats
    d=stats(C,[3,3,3])
    if d['tri']>0: best=(d,W3)
if best: report("(S^3)^3 at n=9", 9, best[1])
