import numpy as np, sys, math, time
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
rng=np.random.default_rng(21)
for n in [6,8,10,12]:
    W=normalise(weyl_sphere_product(n,n//2))
    t=time.time(); k2,F=kappa2(W,starts=8,iters=250,rng=np.random.default_rng(5))
    print(f"n={n} balanced S x S : kappa2={k2:.10f} (expect 2)  time={time.time()-t:.1f}s")
for n in [6,8,10]:
    W=normalise(random_weyl(n,rng))
    t=time.time()
    vals=[]
    for s in [1,4,12,30]:
        k2,_=kappa2(W,starts=s,iters=300,rng=np.random.default_rng(100+s))
        vals.append(k2)
    print(f"n={n} random Weyl: kappa2 by starts {[f'{v:.6f}' for v in vals]}  K(I)^2={np.sum(Kmat(W)**2):.6f} time={time.time()-t:.1f}s")
