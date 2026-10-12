import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
from scipy.optimize import minimize
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r99'))
from wlib import *
from fast import Mfast,ringfast
def sp(m):
    n=2*m; R=np.zeros((n,)*4)
    for off in (0,m):
        I=range(off,off+m)
        for i in I:
            for j in I:
                for k in I:
                    for l in I: R[i,j,k,l]=(i==k)*(j==l)-(i==l)*(j==k)
    return R
for m in [3,6]:
    n=2*m; D=(n-1)*(n+2)//2
    W=pr(sp(m)); W/=np.linalg.norm(Mfast(W)); rw=ringfast(W)
    d=np.sort(np.diag(rw))[::-1]; cd=np.cumsum(d)
    cons=[{'type':'eq','fun':lambda x: np.sum(x)},
          {'type':'eq','fun':lambda x: np.sum(x**2)-3.0},
          {'type':'ineq','fun':lambda x: x[:-1]-x[1:]},
          {'type':'ineq','fun':lambda x: np.cumsum(x)[:-1]-cd[:-1]}]
    rng=np.random.default_rng(99); best=1e9; vals=[]
    for t in range(150):
        z=np.sort(rng.standard_normal(D)*rng.uniform(0.2,3))[::-1]; z-=z.mean(); z*=np.sqrt(3)/np.linalg.norm(z)
        r=minimize(lambda x: float(np.sum(x**3)), z, jac=lambda x:3*x**2, constraints=cons,
                   method='SLSQP', options={'maxiter':800,'ftol':1e-11})
        if r.success:
            x=r.x
            if np.min(np.cumsum(x)[:-1]-cd[:-1])>-1e-7 and abs(np.sum(x))<1e-6 and abs(np.sum(x**2)-3)<1e-6:
                vals.append(r.fun); best=min(best,r.fun)
    vals=np.array(sorted(vals))
    print(f"m={m} D={D}: {len(vals)} feasible optima, best={best:.6f}, 5 lowest={np.array2string(vals[:5],precision=5)}"
          f"  Okumura={-(3**1.5)*(D-2)/np.sqrt(D*(D-1)):.5f} actual={float(np.sum(np.linalg.eigvalsh(rw)**3)):.5f}")
