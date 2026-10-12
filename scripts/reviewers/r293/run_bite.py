"""Does the per-row criticality block BITE at a FIXED spectrum?  This is the rigorous
comparison: two LPs at the same lambda, so no search convergence is involved."""
import sys; sys.path.insert(0,'scripts/reviewers/r293'); sys.path.insert(0,'scripts/lib')
import numpy as np
from r293_lp import Relax
n = int(sys.argv[1]); R = Relax(n); N = R.N
def proj(x):
    x = x-x.mean(); return x/np.linalg.norm(x)
rng = np.random.default_rng(4)
kwA=dict(use_V=False,use_C=False); kwB=dict(use_V=True,use_C=False); kwC=dict(use_V=True,use_C=True)
print(f"n={n}  LP value at a FIXED spectrum, three constraint sets")
print(f"  {'spectrum':28s}{'A':>11}{'B':>11}{'C':>11}{'B-C':>10}")
rows=[]
import glob, os
for f in sorted(glob.glob(f"/tmp/r293_arg_{n}_*.npy")):
    v=np.load(f)
    if np.linalg.norm(v)>0: rows.append((os.path.basename(f)[:-4], proj(v)))
for t in range(8):
    rows.append((f"random {t}", proj(rng.normal(size=N))))
import r293_d123 as r
from r293_points import catalogue
for nn,W,lbl in catalogue():
    if nn==n: rows.append((lbl, np.linalg.eigvalsh(W/np.linalg.norm(W))))
nbite=0
for lbl,lam in rows:
    a=R.solve(lam,**kwA); b=R.solve(lam,**kwB); c=R.solve(lam,**kwC)
    f=lambda x: "infeas" if x is None else f"{x:.6f}"
    d = "-" if (b is None or c is None) else f"{b-c:.6f}"
    if b is not None and (c is None or b-c>1e-7): nbite+=1
    print(f"  {lbl:28s}{f(a):>11}{f(b):>11}{f(c):>11}{d:>10}")
print(f"  criticality rows bite (strictly, or infeasible) at {nbite}/{len(rows)} spectra")
