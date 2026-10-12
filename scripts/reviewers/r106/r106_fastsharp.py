import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys, time
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r106'))
from r106_core import *
from r106_hess import sharp
rng=np.random.default_rng(3)
def sharp_tensor(W):
    return (np.einsum('ipkq,jqlp->ijkl',W,W,optimize=True)
           -np.einsum('iplq,jqkp->ijkl',W,W,optimize=True))
for n in (5,6,7,8):
    W=rand_weyl(n,rng); M=to_M(W); M/=np.linalg.norm(M); W=from_M_ok=None
    # rebuild the tensor consistent with M
    import r106_hess as H
    Wt=H.from_M_fast(M,n)
    A=sharp(M,n); B=to_M(sharp_tensor(Wt))
    r=B/np.where(np.abs(A)>1e-10,A,np.nan)
    print(f"n={n}: ratio sharp_tensor/sharp_struct = {np.nanmedian(r):.8f}  spread={np.nanstd(r):.1e}")
t0=time.time(); n=14
K=np.zeros((n,n)); M=np.zeros((len(pairs(n)),)*2)
M=rng.standard_normal((len(pairs(n)),)*2); M=(M+M.T)/2
t0=time.time(); sharp(M,n); print(f"struct sharp n=14: {time.time()-t0:.2f}s")
Wt=None
import r106_hess as H
Wt=H.from_M_fast(M,n); t0=time.time(); sharp_tensor(Wt); print(f"tensor sharp n=14: {time.time()-t0:.2f}s")
