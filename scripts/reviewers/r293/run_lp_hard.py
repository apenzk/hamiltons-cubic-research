"""Harder, equal-budget ascent: coarse multistart then fine polish of the best."""
import sys, time; sys.path.insert(0,'scripts/reviewers/r293'); sys.path.insert(0,'scripts/lib')
import numpy as np
from r293_lp import Relax
from r293_points import catalogue

def proj(x):
    x=x-x.mean(); return x/np.linalg.norm(x)

def climb(R,kw,lam0,iters,seed,step0):
    rng=np.random.default_rng(seed); lam=proj(lam0)
    v=R.solve(lam,**kw); best=-np.inf if v is None else v
    step=step0
    for i in range(iters):
        c=proj(lam+step*rng.normal(size=lam.size))
        v=R.solve(c,**kw)
        if v is not None and v>best: best,lam=v,c
        elif i%50==49: step=max(step*0.8,1e-3)
    return best,lam

n=int(sys.argv[1]); tag=sys.argv[2]
KW={"B":dict(use_V=True,use_C=False),"D":dict(use_V=True,use_C=False,use_D=True),
    "C":dict(use_V=True,use_C=True),"A":dict(use_V=False,use_C=False)}[tag]
R=Relax(n); N=R.N; rng=np.random.default_rng(77)
starts=[rng.normal(size=N) for _ in range(24)]
for nn,W,lbl in catalogue():
    if nn==n: starts.append(np.linalg.eigvalsh(W/np.linalg.norm(W)))
t0=time.time(); pool=[]
for s,l0 in enumerate(starts):
    v,l=climb(R,KW,l0,600,200+s,0.40); pool.append((v,l))
    print(f"  coarse start {s}: {v:.6f}  best {max(p[0] for p in pool):.6f}  {time.time()-t0:.0f}s",flush=True)
pool.sort(key=lambda p:-p[0])
best,arg=pool[0]
for r_ in range(4):
    for v0,l0 in pool[:4]:
        v,l=climb(R,KW,l0,1200,900+r_*10+int(v0*1e6)%7,0.12/(r_+1))
        if v>best: best,arg=v,l
    print(f"  polish round {r_}: best {best:.6f}  {time.time()-t0:.0f}s",flush=True)
print(f"FINAL n={n} class {tag}: sup_hat = {best:.6f}  ({time.time()-t0:.0f}s)",flush=True)
np.save(f"/tmp/r293h_{n}_{tag}.npy",arg)
