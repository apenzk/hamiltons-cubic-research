import numpy as np, sys, math
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
W4=normalise(weyl_cpm(2))            # genuine Weyl of CP^2 in n=4
print("check padded stays Weyl / theta invariant / kappa:")
for n in [4,6,8,10,12]:
    W=pad(W4,n)
    print("  n=%2d  |Ric|=%.1e  bianchi=%.1e  |M|=%.10f"%(n,
        np.abs(np.einsum('ijil->jl',W)).max(), np.abs(W+W.transpose(0,2,3,1)+W.transpose(0,3,1,2)).max(),
        np.linalg.norm(Mmat(W))))
    th,_=theta_of(W)
    k2,_=kappa2(W,starts=30,iters=350,rng=np.random.default_rng(31))
    print(f"        theta={th:.10f}  kappa2={k2:.10f}")
