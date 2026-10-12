"""U3: the strongest honest version of 'R13 step 1 with the lam_a lam_b <-> c^2 pairing kept'.

Unknowns: a nonnegative totally symmetric array t_{abc}=c_{abc}^2 supported off the diagonal,
zero on m x m x m (that IS S_mmm=0), with per-index mass n-2, satisfying the criticality
identity  sum_{b<c} lam_b lam_c t_{abc} = lam_a (theta - lam_a)  for EVERY a.
Maximise theta.  This drops only frame-realizability of t; it keeps the full pairing.
"""
import numpy as np, itertools, sys
from scipy.optimize import linprog

def lp_ceiling(lam, n, negmask):
    N=len(lam)
    tri=[tuple(s) for s in itertools.combinations(range(N),3)]
    tidx={s:i for i,s in enumerate(tri)}
    nt=len(tri)
    # variables: t (nt), theta (1)
    Aeq=[]; beq=[]
    for a in range(N):
        row=np.zeros(nt+1)
        for (b,c) in itertools.combinations([x for x in range(N) if x!=a],2):
            s=tuple(sorted((a,b,c))); row[tidx[s]] = lam[b]*lam[c]
        row[nt] = -lam[a]
        Aeq.append(row); beq.append(-lam[a]**2)
    for a in range(N):
        row=np.zeros(nt+1)
        for (b,c) in itertools.combinations([x for x in range(N) if x!=a],2):
            row[tidx[tuple(sorted((a,b,c)))]] = 1.0
        Aeq.append(row); beq.append(n-2.0)
    bounds=[(0,None)]*nt+[(None,None)]
    for i,s in enumerate(tri):
        if all(negmask[x] for x in s): bounds[i]=(0,0)
    c=np.zeros(nt+1); c[nt]=-1.0
    r=linprog(c, A_eq=np.array(Aeq), b_eq=np.array(beq), bounds=bounds, method='highs')
    return (r.x[nt] if r.success else None), r.status

n=6; N=n*(n-1)//2
th0=np.sqrt(2*(n-1)*(n-2))/n
# spectrum of the balanced sphere product
lam=np.array([-np.sqrt(0.4/9)]*9+[np.sqrt(0.1)]*6)
neg=lam<0
print("n=6, true S^3xS^3 spectrum. theta_0 =",th0)
v,st=lp_ceiling(lam,n,neg); print("  LP ceiling with pairing kept, all rows, S_mmm=0 support:",v, "status",st)
v2,_=lp_ceiling(lam,n,np.zeros(N,bool)); print("  same LP WITHOUT the S_mmm=0 support condition:",v2)

# search over spectra with dim m <= floor(n^2/4)=9
rng=np.random.default_rng(5)
best=(-9,None)
for D in [1,3,5,7,9]:
    for t in range(12):
        mu=np.abs(rng.standard_normal(D))+0.1; nu=np.abs(rng.standard_normal(N-D))+0.1
        nu*= mu.sum()/nu.sum()
        l=np.concatenate([-mu,nu]); l/=np.linalg.norm(l)
        v,_=lp_ceiling(l,n,l<0)
        if v is not None and v>best[0]: best=(v,(D,l.copy()))
    print(f"  dim m={D}: best LP ceiling so far {best[0]:.4f}")
print("BEST over sampled spectra:",best[0], " vs theta_0(6)=",th0)
np.save('/tmp/r321_lp_done.npy',np.array([best[0]]))
