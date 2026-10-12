import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r106'))
from r106_core import *
for (p,q) in [(3,3),(4,4),(5,5),(6,6)]:
    n=p+q; W=sphere_product(p,q); M=to_M(W); Mn=M/np.linalg.norm(M)
    t3=np.trace(Mn@Mn@Mn); sh=sharp_inner(Mn,n,1.0)
    K=vertex_matrix(W); K=K/np.linalg.norm(M)
    print(f"n={n} tr(M^3)={t3:.6f} <M#,M>_raw={sh:.6f} theta0={theta0(n):.6f} "
          f"scale_needed={(theta0(n)-t3)/sh:.8f} t=|K|^2={np.linalg.norm(K)**2:.6f}")
