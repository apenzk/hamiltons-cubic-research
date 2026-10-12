import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r100'))
from core import *
rng=np.random.default_rng(556)
print("Testing hypothesis  p3(omega) = -3 p3(mu)  and  trM^4 = 1/2<W#,W#> - 1/2<W#,W^2>")
for n in [4,5,6,7,8]:
    B=weyl_basis(n); r1=[];r2=[]
    for _ in range(200):
        M,_=random_weyl(n,B,rng,normalise=False)   # unnormalised: tests homogeneous identity
        W=full_tensor(M,n); A=Wring(W,n); Ms=sharp(M,n); M2=M@M; A2=A@A
        pm=np.trace(M@M2); po=np.trace(A@A2)
        r1.append(po+3*pm)
        r2.append(np.trace(M2@M2)-0.5*np.sum(Ms*Ms)+0.5*np.sum(Ms*M2))
    r1=np.array(r1);r2=np.array(r2)
    print(f"n={n}: max|p3(om)+3p3(mu)| = {np.abs(r1).max():.3e}   max|deg4 residual| = {np.abs(r2).max():.3e}")
