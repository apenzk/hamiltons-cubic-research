import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
rng=np.random.default_rng(3)
n=6; W=normalise(random_weyl(n,rng))
F,_=np.linalg.qr(rng.standard_normal((n,n)))
f,G=kgrad(W,F)
eps=1e-6; err=0
for m in range(n):
    for p in range(n):
        E=np.zeros((n,n)); E[m,p]=eps
        fp=kfro2(W,F+E); fm=kfro2(W,F-E)
        err=max(err,abs((fp-fm)/(2*eps)-G[m,p]))
print("grad max err", err, " f",f, " kfro2", kfro2(W,F))
