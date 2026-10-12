import sys,time; sys.path.insert(0,'scripts/reviewers/r293'); sys.path.insert(0,'scripts/lib')
import numpy as np
from r293_lp import Relax
from r293_points import catalogue
n=12; R=Relax(n); N=R.N
def proj(x):
    x=x-x.mean(); return x/np.linalg.norm(x)
rng=np.random.default_rng(4)
rows=[(f"random {t}", proj(rng.normal(size=N))) for t in range(4)]
for nn,W,lbl in catalogue():
    if nn==n: rows.append((lbl,np.linalg.eigvalsh(W/np.linalg.norm(W))))
print(f"n=12 N={N} triples={R.K}",flush=True)
for lbl,lam in rows:
    t0=time.time()
    a=R.solve(lam,use_V=False,use_C=False); b=R.solve(lam,use_V=True,use_C=False); c=R.solve(lam,use_V=True,use_C=True)
    f=lambda x:"infeas" if x is None else f"{x:.6f}"
    print(f"  {lbl:20s} A={f(a):>10} B={f(b):>10} C={f(c):>10}  ({time.time()-t0:.0f}s)",flush=True)
