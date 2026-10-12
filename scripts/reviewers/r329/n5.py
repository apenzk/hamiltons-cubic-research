import sys; sys.path.insert(0,'scripts/reviewers/r329')
import numpy as np; from core import *; from solve import solve_crit
n=5; idx,B,c=struct_consts(n); Bo=weyl_basis(n)
rng=np.random.default_rng(21); res=[]
for t in range(30):
    x0=rng.normal(size=Bo.shape[0]); x0/=np.linalg.norm(x0)
    x,W,r=solve_crit(Bo,c,x0)
    if r<1e-10:
        d=crit_data(W,c,n,Bo); res.append(d)
sl=sorted(d['slack'] for d in res)
print("n=5: %d critical points; slack range %.6f .. %.6f ; max crit res %.1e ; max dist(W_5) %.1e"%(
    len(res),sl[0],sl[-1],max(d['res'] for d in res),max(d['dist'] for d in res)))
print("theta range: %.6f .. %.6f ; theta0(5)=%.6f"%(min(d['theta'] for d in res),max(d['theta'] for d in res),theta0(5)))
