import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
n=8; idx,pos,N,c,B=weyl_basis(n); d=len(B)
Bmat=np.array([b.reshape(-1) for b in B]); mat=lambda x: np.tensordot(x,B,axes=(0,0))
for f in ['r305_n8_ratio_lt1','r305_n8_seed9018','r305_n8_seed9033']:
    W=np.load(f'scripts/reviewers/r305/out/{f}.npy')
    x=np.array([inner(b,W) for b in B]); x/=np.linalg.norm(x)
    th=P(c,W); base=lam_max_perp(L_operator(c,B,W)/th,x)[0]
    rng=np.random.default_rng(1); dev=[]
    for k in range(6):
        p=rng.normal(size=d); p/=np.linalg.norm(p)
        y=x+1e-9*p; y/=np.linalg.norm(y); Wp=mat(y); tp=P(c,Wp)
        dev.append(lam_max_perp(L_operator(c,B,Wp)/tp,y)[0])
    print(f"{f}: lam={base:.12f} under 1e-9 perturbation min={min(dev):.12f} max={max(dev):.12f} spread={max(dev)-min(dev):.2e}")
