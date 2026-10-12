import sys,time; sys.path.insert(0,'scripts/reviewers/r335')
import numpy as np, w335 as w, crit_lp as cl
from itertools import combinations
n=6; c,B,N,d=cl.setup(n)
seed=int(sys.argv[1]); NT=int(sys.argv[2])
rng=np.random.default_rng(seed)
def solve_one(x):
    x=x/np.linalg.norm(x)
    for it in range(120):
        g,W=cl.gmap(x,B,c); th=float(g@x)
        F=g-th*x
        if np.linalg.norm(F)<1e-13: return x,th,True
        J=cl.jac(x,B,c)-th*np.eye(d)
        Pp=np.eye(d)-np.outer(x,x)
        A=Pp@J@Pp + np.outer(x,x)   # make it nonsingular on span(x)
        try: dlt=np.linalg.solve(A,-F)
        except Exception: return x,th,False
        dlt=dlt-(dlt@x)*x
        nrm=np.linalg.norm(dlt)
        if nrm>1.0: dlt*=1.0/nrm
        x=x+dlt; x/=np.linalg.norm(x)
    g,W=cl.gmap(x,B,c); th=float(g@x)
    return x,th,np.linalg.norm(g-th*x)<1e-10
def rowmin(lam):
    best=np.inf
    for a in range(len(lam)):
        if abs(lam[a])<1e-10: continue
        idx=[b for b in range(len(lam)) if b!=a]
        pr=[lam[b]*lam[cc] for b,cc in combinations(idx,2)]
        v=lam[a]+(n-2)*((max(pr) if lam[a]>0 else min(pr))/lam[a])
        best=min(best,v)
    return best
t0=time.time(); res=[]
for t in range(NT):
    x,th,ok=solve_one(rng.normal(size=d))
    if not ok or abs(th)<1e-6: continue
    W=np.tensordot(x,B,axes=1); Q=w.Qmap(W,c); r=np.linalg.norm(Q-th*W)
    if th<0: W=-W; th=-th; x=-x   # take the positive-theta representative
    lam=np.sort(np.linalg.eigvalsh(W))
    nd=len(np.unique(np.round(lam,6)))
    lp,st=cl.lp_max_theta(lam,n)
    cap=lam[0]+(n-2)*lam[-1]; pib=(n-1)*abs(lam[0]); rm=rowmin(lam)
    print("%3d th=%.6f res=%.1e dist=%2d LP=%s gap=%s L70=%.6f Pi=%.6f rowmin=%.6f ratio=%.4f"%(
        t,th,r,nd,"%.6f"%lp if lp else "INF","%.6f"%(lp-th) if lp else "-",cap,pib,rm,lam[-1]/abs(lam[0])),flush=True)
    res.append(np.concatenate([[th,nd,lp if lp else np.nan,cap,pib,rm],lam]))
np.save('scripts/reviewers/r335/t10_%d.npy'%seed,np.array(res))
print("elapsed %.1f  found %d"%(time.time()-t0,len(res)))
