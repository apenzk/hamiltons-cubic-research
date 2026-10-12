import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
from scipy.stats import ortho_group
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r100'))
from core import *

def sphere_prod_weyl(m):
    n=2*m; B=weyl_basis(n)
    R=np.zeros((n,n,n,n))
    for off in (0,m):
        g=np.zeros((n,n))
        for a in range(off,off+m): g[a,a]=1.0
        R+=np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g)
    MW,_=project_weyl(M_from_tensor(R,n),B,n)
    return MW/np.linalg.norm(MW), n, B

print("=== Is 'the diagonal is blind' a property of the NPW frame, or of Wring? ===")
rng=np.random.default_rng(404)
for m in [3,4]:
    MW,n,B=sphere_prod_weyl(m)
    W0=full_tensor(MW,n)
    om=np.linalg.eigvalsh(Wring(W0,n)); P3=p3(om)
    best=-1e9; worst=1e9; vals=[]
    for t in range(200):
        O=ortho_group.rvs(n,random_state=rng.integers(1<<30))
        W=np.einsum('ai,bj,ck,dl,ijkl->abcd',O,O,O,O,W0,optimize=True)
        d=np.diag(Wring(W,n)); s=float(np.sum(d**3)); vals.append(s)
    vals=np.array(vals)
    print(f"m={m} n={n}: p3(omega)={P3:.6f}")
    print(f"   sum d^3 over 200 random O(n) frames: min {vals.min():+.6f} max {vals.max():+.6f}")
    print(f"   ratio range: [{vals.min()/P3:+.4f}, {vals.max()/P3:+.4f}]   (NPW frame gave {np.sum(np.diag(Wring(W0,n))**3)/P3:+.4f})")
    print(f"   ATTAINABLE in the S^2_0 EIGENbasis: sum d^3 = p3(omega) = {P3:.6f}, ratio +1.0000")
