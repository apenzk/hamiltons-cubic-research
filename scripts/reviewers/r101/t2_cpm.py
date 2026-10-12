import numpy as np, sys, math
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
print("m   n   theta        theta_pred    kappa2      3/(m+1)     ||K(I)||^2  theta0(n)")
for m in range(2,8):
    n=2*m
    W=normalise(weyl_cpm(m))
    th,M=theta_of(W)
    pred=math.sqrt((m+1)*(2*m-1)/(3*m*(m-1)))
    k2,F=kappa2(W,starts=25,iters=300,rng=np.random.default_rng(11+m))
    KI=np.sum(Kmat(W)**2)
    print(f"{m:2d} {n:3d} {th:.10f} {pred:.10f} {k2:.10f} {3/(m+1):.10f} {KI:.8f} {math.sqrt(2*(n-1)*(n-2))/n:.6f}")
