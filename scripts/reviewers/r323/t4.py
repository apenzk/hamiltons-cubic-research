import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core
# does Q map Weyl_n into Weyl_n?
for n in [5,6,7,8]:
    c=core.Ctx(n); rng=np.random.default_rng(1); worst=0
    for _ in range(5):
        z=rng.normal(size=c.W.shape[0]); W=np.einsum('k,kab->ab',z,c.W); W/=np.sqrt(np.trace(W@W))
        QW=core.Qmap(c,W); worst=max(worst,np.linalg.norm(QW-core.proj_weyl(c,QW))/np.linalg.norm(QW))
    print(f'n={n}: max rel dist of Q(W) from Weyl_n over 5 random W = {worst:.2e}')
