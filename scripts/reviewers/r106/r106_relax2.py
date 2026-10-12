import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r106'))
from r106_core import *
from r106_relax import relax_at_K
for n in [int(x) for x in sys.argv[1:]]:
    W=sphere_product(n//2,n//2); Kst=vertex_matrix(W)/np.linalg.norm(to_M(W))
    th0=theta0(n)
    print(f"n={n} theta0={th0:.6f}",flush=True)
    for c in [1.0,0.9999,0.999,0.99,0.95]:
        K=c*Kst; t=np.linalg.norm(K)**2; eps=2-t
        R=relax_at_K(K,n,12)
        print(f"   c={c:<7} 2-t={eps:<10.6f} R={R:.6f} R-th0={R-th0:+.6f} slope={(R-th0)/eps if eps>1e-12 else float('nan'):.4f}",flush=True)
