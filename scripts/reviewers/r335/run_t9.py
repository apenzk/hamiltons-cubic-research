import sys,time; sys.path.insert(0,'scripts/reviewers/r335')
import numpy as np, crit_lp as cl
from scipy.optimize import minimize
n=6; N=15
def proj(v):
    v=v-v.mean(); nv=np.linalg.norm(v)
    return v/nv if nv>0 else v
def val(v,use=('A','B','C')):
    lam=np.sort(proj(v))
    r,_=cl.lp_max_theta(lam,n,use=use)
    return r
seed=int(sys.argv[1]); rng=np.random.default_rng(seed)
best=-9; bl=None; t0=time.time()
for t in range(int(sys.argv[2])):
    v0=proj(rng.normal(size=N))
    r=minimize(lambda v: -(val(v) or -9), v0, method='Nelder-Mead',
               options=dict(maxiter=4000,maxfev=4000,fatol=1e-10,xatol=1e-9))
    v=proj(r.x); f=val(v)
    if f is not None and f>best:
        best=f; bl=np.sort(v)
        print("restart %d  LPmax=%.6f  spectrum=%s"%(t,best,np.round(bl,6)),flush=True)
        np.save('scripts/reviewers/r335/t9_best_%d.npy'%seed,bl)
print("BEST %.6f  elapsed %.0fs"%(best,time.time()-t0))
print("spectrum:",np.round(bl,8))
print("  distinct:",len(np.unique(np.round(bl,5))))
for u in [('A','C'),('A','B'),('A','B','C')]:
    print("  LP with",u,"=",val(bl,use=u))
