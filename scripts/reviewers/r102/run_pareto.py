import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r102'))
import numpy as np, core, models, pareto
n=int(sys.argv[1]); nstart=int(sys.argv[2])
th0=np.sqrt(2*(n-1)*(n-2))/n
print('n',n,'theta0',th0,'c(n)=',12/((n+1)*(n+2)),flush=True)
rng=np.random.default_rng(600+n)
for lam in (0.0,0.15,0.3,0.5,0.8,1.2,1.8,2.5,4.0,8.0):
    best=None
    for s in range(nstart):
        W0=core.random_weyl(n,rng)
        th,k2,W=pareto.run(n,lam,W0,rng,outer=150)
        if best is None or th-lam*k2>best[0]-lam*best[1]: best=(th,k2)
    print(f'lam={lam:5.2f}  theta={best[0]:.6f}  kappa^2={best[1]:.6f}  theta/theta0={best[0]/th0:.4f}',flush=True)
