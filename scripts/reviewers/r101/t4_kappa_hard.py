import numpy as np, sys, math, time
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
# (a) padded CP^2 at n=4..12
for n in [4,6,8,10,12]:
    W=normalise(weyl_cpm(2,n=n))
    k2,_=kappa2(W,starts=30,iters=300,rng=np.random.default_rng(9))
    th,_=theta_of(W)
    print(f"padded CP^2 in n={n}: kappa2={k2:.10f} theta={th:.8f}")
# (b) hard multi-start / basin hopping on CP^m
rng=np.random.default_rng(77)
for m in [3,4,5]:
    n=2*m; W=normalise(weyl_cpm(m))
    k2,F=kappa2(W,starts=60,iters=400,rng=np.random.default_rng(500+m))
    # basin hop
    best=k2; bF=F
    for _ in range(40):
        A=rng.standard_normal((n,n))*0.35
        from scipy.linalg import expm
        F0=polar(expm(A-A.T)@bF)
        v,Fn=kappa2(W,starts=1,iters=500,rng=rng,F0list=[F0])
        if v>best+1e-12: best=v; bF=Fn
    print(f"CP^{m}: best kappa2={best:.12f}  3/(m+1)={3/(m+1):.12f}  diff={best-3/(m+1):.2e}")
