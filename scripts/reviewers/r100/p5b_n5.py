import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r100'))
from core import *
rng=np.random.default_rng(555)
for n in [4,5,6]:
    B=weyl_basis(n)
    p3m=[];p3o=[];sh=[];t4=[];ss=[];sm=[]
    for _ in range(300):
        M,_=random_weyl(n,B,rng); W=full_tensor(M,n); A=Wring(W,n); Ms=sharp(M,n)
        M2=M@M; A2=A@A
        p3m.append(np.trace(M@M2)); p3o.append(np.trace(A@A2)); sh.append(np.sum(Ms*M))
        t4.append(np.trace(M2@M2)); ss.append(np.sum(Ms*Ms)); sm.append(np.sum(Ms*M2))
    p3m=np.array(p3m);p3o=np.array(p3o);sh=np.array(sh);t4=np.array(t4);ss=np.array(ss);sm=np.array(sm)
    print(f"n={n}: |p3(mu)| max={np.abs(p3m).max():.3e}   |p3(om)| max={np.abs(p3o).max():.3e}  |theta| max={np.abs(1.5*p3m-0.5*p3o).max():.3e}")
    print(f"      residual trM^4 - 1/2<W#,W#> + 1/2<W#,W^2> : max |.| = {np.abs(t4-0.5*ss+0.5*sm).max():.3e}   (scale trM^4~{t4.mean():.4f})")
