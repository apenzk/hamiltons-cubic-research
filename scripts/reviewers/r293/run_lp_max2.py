"""Identical ascent budget and identical starts for each constraint set."""
import sys, time; sys.path.insert(0,'scripts/reviewers/r293'); sys.path.insert(0,'scripts/lib')
import numpy as np
from r293_lp import Relax
from r293_points import catalogue

def proj(x):
    x = x-x.mean(); return x/np.linalg.norm(x)

def climb(R, kw, lam0, iters, seed, step0=0.35):
    rng=np.random.default_rng(seed); lam=proj(lam0)
    best=R.solve(lam,**kw); best=-np.inf if best is None else best
    step=step0
    for i in range(iters):
        cand=proj(lam+step*rng.normal(size=lam.size))
        v=R.solve(cand,**kw)
        if v is not None and v>best: best,lam=v,cand
        elif i%40==39: step*=0.75
    return best,lam

n=int(sys.argv[1]); nstart=int(sys.argv[2]); iters=int(sys.argv[3])
R=Relax(n); N=R.N
rng=np.random.default_rng(11)
starts=[rng.normal(size=N) for _ in range(nstart)]
for nn,W,lbl in catalogue():
    if nn==n: starts.append(np.linalg.eigvalsh(W/np.linalg.norm(W)))
CL=(("A  (T>=0,marg,cap,tr)",dict(use_V=False,use_C=False)),
    ("B  = A + vector id  ",dict(use_V=True,use_C=False)),
    ("B+D3 rows          ",dict(use_V=True,use_C=False,use_D=True)),
    ("C  = B + D2 rows    ",dict(use_V=True,use_C=True)))
print(f"n={n} N={N} triples={R.K} starts={len(starts)} iters={iters}",flush=True)
for tag,kw in CL:
    t0=time.time(); best=-np.inf; arg=None
    for s,l0 in enumerate(starts):
        v,l=climb(R,kw,l0,iters,100+s)
        if v>best: best,arg=v,l
    print(f"  {tag}  sup_hat = {best:.6f}   ({time.time()-t0:.0f}s)",flush=True)
    np.save(f"/tmp/r293b_{n}_{tag.split()[0]}.npy",arg)
