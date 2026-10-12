import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r106'))
from r106_core import *
print("anchors (scale=1/2):")
for m in (2,3,4,5):
    W=cpm(m); n=2*m
    print(f"  CP^{m} n={n}: theta={theta(W):.6f}  resid={max(residuals(W).values()):.1e} t={np.linalg.norm(vertex_matrix(W))**2/np.linalg.norm(to_M(W))**2:.6f}")
W=pad(cpm(2),6); print(f"  CP^2 padded to n=6: theta={theta(W):.6f} resid={max(residuals(W).values()):.1e}")
W=pad(cpm(2),12); print(f"  CP^2 padded to n=12: theta={theta(W):.6f}")
for (p,q) in [(3,5),(5,7),(4,6)]:
    W=sphere_product(p,q); print(f"  S^{p}xS^{q}: theta={theta(W):.6f}")
print(f"  sqrt(3/2)={np.sqrt(1.5):.6f} sqrt(56/45)={np.sqrt(56/45):.6f} sqrt(264/175)={np.sqrt(264/175):.6f}")
