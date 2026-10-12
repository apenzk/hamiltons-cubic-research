import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r102'))
import numpy as np, core
rng=np.random.default_rng(21)
for n in (11,12):
    dim=n*(n+1)*(n+2)*(n-3)//12
    S=np.array([core.random_weyl(n,rng).ravel() for _ in range(dim+25)])*0.5
    Qm,_=np.linalg.qr(S.T); B=Qm[:,:dim].T
    tot=0.0
    for a in range(dim):
        E=(2.0*B[a]).reshape(n,n,n,n)
        K=np.einsum('abab->ab',E).copy(); np.fill_diagonal(K,0.0)
        tot+=np.linalg.norm(K)**2
    print(f'n={n} dim={dim} c(n)={tot/dim:.12f} formula 12/((n+1)(n+2))={12/((n+1)*(n+2)):.12f}',flush=True)
