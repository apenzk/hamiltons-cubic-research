import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
from scipy.optimize import minimize, linprog
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r99'))
from wlib import *
from fast import Mfast,ringfast
def sphere_product_R(m1,m2):
    n=m1+m2; R=np.zeros((n,)*4)
    for (off,mm) in ((0,m1),(m1,m2)):
        I=range(off,off+mm)
        for i in I:
            for j in I:
                for k in I:
                    for l in I: R[i,j,k,l]=(i==k)*(j==l)-(i==l)*(j==k)
    return R
print("min sum(om^3) s.t. om >> d (Schur-Horn), sum om = 0, sum om^2 = 3")
for m in [3,4,6]:
    n=2*m; D=(n-1)*(n+2)//2
    W=pr(sphere_product_R(m,m)); W/=np.linalg.norm(Mfast(W))
    rw=ringfast(W); d=np.sort(np.diag(rw))[::-1]; cd=np.cumsum(d)
    def f(x): return float(np.sum(x**3))
    def gf(x): return 3*x**2
    cons=[{'type':'eq','fun':lambda x: np.sum(x)},
          {'type':'eq','fun':lambda x: np.sum(x**2)-3.0},
          {'type':'ineq','fun':lambda x: x[:-1]-x[1:]},
          {'type':'ineq','fun':lambda x: np.cumsum(x)[:-1]-cd[:-1]}]
    best=None
    rng=np.random.default_rng(7)
    a=np.sqrt(3.0)/np.sqrt(D*(D-1)); b=np.sqrt(3.0)*np.sqrt((D-1)/D)
    starts=[np.array([a]*(D-1)+[-b]), np.sort(np.linalg.eigvalsh(rw))[::-1]]
    for _ in range(12):
        z=np.sort(rng.standard_normal(D))[::-1]; z-=z.mean(); z*=np.sqrt(3)/np.linalg.norm(z); starts.append(z)
    for s in starts:
        r=minimize(f,s,jac=gf,constraints=cons,method='SLSQP',options={'maxiter':600,'ftol':1e-10})
        if r.success:
            x=r.x
            feas=(np.min(np.cumsum(x)[:-1]-cd[:-1])>-1e-7) and abs(np.sum(x))<1e-6 and abs(np.sum(x**2)-3)<1e-6
            if feas and (best is None or r.fun<best): best=r.fun
    ok=-(3**1.5)*(D-2)/np.sqrt(D*(D-1))
    actual=float(np.sum(np.linalg.eigvalsh(rw)**3))
    relax=1.5*(n*(n-1)//2-2)/np.sqrt((n*(n-1)//2)*(n*(n-1)//2-1)) - 0.5*best
    relax0=1.5*(n*(n-1)//2-2)/np.sqrt((n*(n-1)//2)*(n*(n-1)//2-1)) - 0.5*ok
    print(f"  m={m} n={n} D={D}: Okumura floor {ok:+.5f} | Schur-Horn-constrained min {best:+.5f} | actual {actual:+.5f}")
    print(f"       relaxation with SH: {relax:.5f}   without SH: {relax0:.5f}   truth theta0(n)={theta0(n):.5f}")
