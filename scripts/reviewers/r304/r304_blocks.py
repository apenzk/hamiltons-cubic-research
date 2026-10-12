"""Block-constant (generalised blow-up) diagonal critical points: theta, Delta, lam_diag."""
import sys, itertools; sys.path.insert(0,'scripts/reviewers/r304')
import numpy as np, r304_core as C
from scipy.optimize import least_squares
from r304_prize import lam_diag

def build(sizes, B):
    n=sum(sizes); lab=np.concatenate([[a]*k for a,k in enumerate(sizes)])
    M=B[np.ix_(lab,lab)].astype(float).copy(); np.fill_diagonal(M,0.0)
    return M

def solve_blocks(sizes, p0):
    m=len(sizes); iu=np.triu_indices(m)
    def toB(p):
        B=np.zeros((m,m)); B[iu]=p; B=B+B.T-np.diag(np.diag(B)); return B
    def res(p):
        M=build(sizes,toB(p)); s=np.sum(M*M)
        if s<1e-10: return np.ones(len(p)+m)*1e3
        M*=np.sqrt(2/s)
        R=C.crit_residual(M); rs=M.sum(1)
        lab=np.concatenate([[a]*k for a,k in enumerate(sizes)])
        out=[]
        for (a,b) in zip(*iu):
            ia=int(np.where(lab==a)[0][0]); ib=int(np.where(lab==b)[0][-1])
            if a==b and sizes[a]<2: out.append(0.0); continue
            out.append(R[ia,ib])
        out+= list(rs[[int(np.where(lab==a)[0][0]) for a in range(m)]])
        return np.array(out)
    s=least_squares(res,p0,xtol=1e-15,ftol=1e-15,gtol=1e-15,max_nfev=4000)
    M=build(sizes,toB(s.x)); v=np.sum(M*M)
    if v<1e-10: return None,1e9
    M*=np.sqrt(2/v)
    return M, float(np.abs(C.crit_residual(M)).max()+np.abs(M.sum(1)).max())

results=[]
rng=np.random.default_rng(int(sys.argv[1]) if len(sys.argv)>1 else 0)
for n in [8,10,12,14,16]:
    for m in [3,4,5]:
        for sizes in set(tuple(sorted(s)) for s in itertools.product(range(1,n-m+2),repeat=m) if sum(s)==n):
            for t in range(12):
                M,r=solve_blocks(list(sizes), rng.normal(size=m*(m+1)//2))
                if M is None or r>1e-11: continue
                th=C.theta_of(M)
                if th<=1e-6: continue
                d,_=C.defect_delta(M); lm=lam_diag(M)
                results.append((n,sizes,th,d,lm))
seen=set(); best=[]
for (n,sz,th,d,lm) in results:
    k=(n,sz,round(th,6),round(d,4))
    if k in seen: continue
    seen.add(k); best.append((n,sz,th,d,lm))
best.sort(key=lambda r:(-r[2]))
print(f"{len(best)} distinct block-constant critical points with theta>0")
hits=[b for b in best if b[3]>1e-7 and b[4]<=b[2]/2+1e-9]
print("PRIZE hits:",len(hits))
for h in hits: print("  ***",h)
print("top 25 by theta:")
for (n,sz,th,d,lm) in best[:25]:
    print(f"  n={n} sizes={sz} theta={th:+.6f} Delta={d:9.4f} lam_diag={lm:+.6f} theta/2={th/2:+.6f} "
          f"{'DIAG-OK' if lm<=th/2+1e-9 else 'violates'}")
print("largest theta among Delta>0:")
for (n,sz,th,d,lm) in [b for b in best if b[3]>1e-7][:12]:
    print(f"  n={n} sizes={sz} theta={th:+.6f} Delta={d:9.4f} lam_diag={lm:+.6f} gap={lm-th/2:+.6f}")
