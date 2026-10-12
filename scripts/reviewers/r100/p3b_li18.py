import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
from collections import Counter
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r100'))
from core import *

def spaceform_R(m,k):
    g=np.eye(m)
    return k*(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g))

def prod_R(m1,k1,m2,k2):
    n=m1+m2; R=np.zeros((n,n,n,n))
    for off,mm,k in ((0,m1,k1),(m1,m2,k2)):
        g=np.zeros((n,n))
        for a in range(off,off+mm): g[a,a]=1.0
        R+=k*(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g))
    return R

def spec(R,n): return np.sort(np.linalg.eigvalsh(Wring(R,n)))

print("=== Li 2022 Thm 1.8 independent check (Ring on FULL Riemann tensor) ===")
cases=[(3,1.0,3,1.0),(2,1.0,4,1.0),(3,1.0,5,1.0),(3,2.0,4,0.5),(2,3.0,3,1.0),(4,1.0,4,2.0),(2,1.0,2,1.0)]
for (m1,k1,m2,k2) in cases:
    n=m1+m2
    got=spec(prod_R(m1,k1,m2,k2),n)
    s1 = spec(spaceform_R(m1,k1),m1) if m1>=2 else np.array([])
    s2 = spec(spaceform_R(m2,k2),m2) if m2>=2 else np.array([])
    rho1=k1*(m1-1); rho2=k2*(m2-1)
    extra = -(m1*rho2+m2*rho1)/(m1+m2)
    pred=np.sort(np.concatenate([s1,s2,np.zeros(m1*m2),[extra]]))
    ok = len(pred)==len(got) and np.allclose(pred,got,atol=1e-9)
    print(f"S^{m1}({k1}) x S^{m2}({k2}) n={n}: dims got {len(got)} pred {len(pred)}  MATCH={ok}  maxdiff={np.abs(pred-got).max() if len(pred)==len(got) else 'NA'}")
    if not ok:
        print("   got :",np.round(got,6))
        print("   pred:",np.round(pred,6))
