"""Locate the Z2-grading of each n=8 witness through the O(n)-invariant support operator T:
any g with [Lambda^2(g),W]=0 commutes with T, so the +1 eigenspace of g is spanned by
T-eigenvectors (when T's eigenvalues are simple enough)."""
import sys, numpy as np, itertools
sys.path.insert(0,'scripts/reviewers/r313')
import r313_lib as R
from r313_m3 import gauss_newton, support_op
from r313_grading import lam2_of

n=8
def load(f):
    W=np.load(f"scripts/reviewers/r305/out/{f}.npy")
    W=gauss_newton(n,W); return W if R.theta_of(n,W)>0 else -W

import r313_m56 as M
pts={"S3xS5":M.sphere_W(8,3),"witness(9015)":load("r305_n8_seed9015"),
     "9018":load("r305_n8_seed9018"),"9033":load("r305_n8_seed9033")}

results={}
for nm,W in pts.items():
    T=support_op(n,W); ev,V=np.linalg.eigh(T)
    groups=[]; i=0
    while i<len(ev):
        j=i
        while j+1<len(ev) and abs(ev[j+1]-ev[i])<1e-8: j+=1
        groups.append((ev[i], list(range(i,j+1)))); i=j+1
    print(f"--- {nm}: T eigengroups " + ", ".join(f"{a:.6f}x{len(b)}" for a,b in groups))
    found=[]
    for r in range(1,len(groups)+1):
        for sub in itertools.combinations(range(len(groups)), r):
            cols=[c for s in sub for c in groups[s][1]]
            k=len(cols)
            if k>n//2: continue
            F=V[:,cols]
            g=np.eye(n)-2*F@F.T
            L=lam2_of(n,g)
            d=np.linalg.norm(L@W-W@L)
            if d<1e-7: found.append((k,d,cols))
    for k,d,cols in sorted(found):
        print(f"    grading found: dim V = {k}  ||[Lambda^2(g),W]|| = {d:.2e}")
    results[nm]=(V,groups,found)
np.save('scripts/reviewers/r313/_tmp.npy', np.zeros(1))
