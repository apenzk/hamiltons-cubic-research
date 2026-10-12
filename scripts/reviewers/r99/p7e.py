import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
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
print("Does the Okumura minimiser of sum(om^3) majorize the NPW diagonal at S^m x S^m?")
print("(if yes, Schur-Horn from the diagonal adds nothing to the unconstrained floor)")
for m in [3,4,5,6]:
    n=2*m; D=(n-1)*(n+2)//2
    W=pr(sphere_product_R(m,m)); W/=np.linalg.norm(Mfast(W))
    rw=ringfast(W); d=np.sort(np.diag(rw))[::-1]
    a=np.sqrt(3.0)/np.sqrt(D*(D-1)); b=np.sqrt(3.0)*np.sqrt((D-1)/D)
    om=np.array([a]*(D-1)+[-b])
    p3_ok=float(np.sum(om**3)); p3_true=float(np.sum(np.linalg.eigvalsh(rw)**3))
    sd=np.cumsum(d); so=np.cumsum(om)
    slack=so-sd
    print(f"  m={m} n={n} D={D}: sum d={d.sum():.1e} sum om={om.sum():.1e}  majorizes={np.all(slack>=-1e-12)}  "
          f"min slack={slack.min():+.6f}  Okumura floor p3(om)={p3_ok:.4f}  actual p3(om)={p3_true:.4f}")
    print(f"      diag range [{d.min():+.5f},{d.max():+.5f}]  Okumura vector entries a={a:+.5f} b={-b:+.5f}")
