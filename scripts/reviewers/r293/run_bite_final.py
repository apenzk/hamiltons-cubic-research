import sys,glob,os; sys.path.insert(0,'scripts/reviewers/r293'); sys.path.insert(0,'scripts/lib')
import numpy as np
from r293_lp import Relax
from r293_points import catalogue
n=6; R=Relax(n)
def proj(x):
    x=x-x.mean(); return x/np.linalg.norm(x)
rows=[]
for f,lbl in ((f"/tmp/r293h_6_B.npy","argmax of class B"),(f"/tmp/r293h_6_C.npy","argmax of class C"),
              (f"/tmp/r293_arg_6_A.npy","argmax of class A")):
    if os.path.exists(f): rows.append((lbl, proj(np.load(f))))
rng=np.random.default_rng(4)
rows += [(f"random spectrum {t}", proj(rng.normal(size=R.N))) for t in range(6)]
for nn,W,lbl in catalogue():
    if nn==n: rows.append((lbl+"  (a real Weyl spectrum)", np.linalg.eigvalsh(W/np.linalg.norm(W))))
print(f"{'spectrum':34s}{'A':>10}{'B':>10}{'C':>10}{'cut B->C':>10}")
for lbl,lam in rows:
    a=R.solve(lam,use_V=False,use_C=False); b=R.solve(lam,use_V=True,use_C=False); c=R.solve(lam,use_V=True,use_C=True)
    f=lambda x:"infeas" if x is None else f"{x:.6f}"
    cut = "100%" if (b is not None and c is None) else ("-" if b is None else f"{100*(b-c)/abs(b):.1f}%")
    print(f"  {lbl:32s}{f(a):>10}{f(b):>10}{f(c):>10}{cut:>10}")
print("\nargmax spectra (unit norm, traceless):")
for f,lbl in (("/tmp/r293h_6_B.npy","B"),("/tmp/r293h_6_C.npy","C")):
    if os.path.exists(f): print(f"  {lbl}: {np.round(np.sort(proj(np.load(f))),6).tolist()}")
