import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r99'))
from wlib import *
from collections import Counter

def sphere_product_R(m1, m2, k1=1.0, k2=1.0):
    n=m1+m2; R=np.zeros((n,)*4)
    for (off,mm,k) in ((0,m1,k1),(m1,m2,k2)):
        idx=range(off,off+mm)
        for i in idx:
            for j in idx:
                for kk in idx:
                    for l in idx:
                        R[i,j,kk,l]=k*(( i==kk)*(j==l) - (i==l)*(j==kk))
    return R

for m in range(2,8):
    n=2*m
    R=sphere_product_R(m,m)
    # sanity: Einstein?
    Ric=np.einsum('ijil->jl',R)
    W=pr(R)
    nrm=np.linalg.norm(M_of(W)); Wn=W/nrm
    M=M_of(Wn); rw=ringW(Wn)
    ev=np.linalg.eigvalsh(rw); mu=np.linalg.eigvalsh(M)
    A=1.0/(m*np.sqrt((m-1)*(2*m-1)))
    pred=[(m*A,(m-1)*(m+2)),(-(m-1)*A,m*m),(-2*m*(m-1)*A,1)]
    # cluster observed
    c=Counter(np.round(ev/A,7))
    obs=sorted(c.items())
    p3o=float(np.sum(ev**3)); p3m=float(np.sum(mu**3))
    th=1.5*p3m-0.5*p3o
    print(f"m={m} n={n}  Ric diag const? {np.allclose(Ric,(m-1)*np.eye(n))}  ||M||_F(unnorm)={nrm:.6f}"
          f"  scale_pred={ (2*m-1)*A :.6f}")
    print(f"   omega/A observed (val,mult): {obs}")
    print(f"   predicted           : {[(round(v/A,7),k) for v,k in pred]}")
    print(f"   p3(mu)={p3m:.10f}  A={A:.10f}  p3(mu)-A={p3m-A:.2e}")
    print(f"   p3(om)={p3o:.10f}  pred={-(4*m*m-6*m-1)*A:.10f}  diff={p3o+ (4*m*m-6*m-1)*A:.2e}")
    print(f"   theta={th:.10f}  theta0({n})={theta0(n):.10f}  diff={th-theta0(n):.2e}")
    print(f"   mu spectrum (val,mult)/A: {sorted(Counter(np.round(mu/A,6)).items())}")
