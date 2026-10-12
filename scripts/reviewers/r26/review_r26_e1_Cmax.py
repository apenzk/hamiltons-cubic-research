import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r26_core import *

def Cmax(n, ntrial=200, seed=0, iters=4000):
    """max ||[X,Y]||^2 over orthonormal pairs X,Y in so(n), by projected gradient ascent."""
    C = struct_const(n); N = C.shape[0]
    rng = np.random.default_rng(seed)
    best = 0.0; bestXY = None
    for t in range(ntrial):
        x = rng.normal(size=N); y = rng.normal(size=N)
        for it in range(iters):
            # orthonormalize
            x = x/np.linalg.norm(x)
            y = y - (y@x)*x; y = y/np.linalg.norm(y)
            z = np.einsum('abg,a,b->g', C, x, y)   # [X,Y] coefficients
            f = z@z
            gx = 2*np.einsum('abg,b,g->a', C, y, z)
            gy = 2*np.einsum('abg,a,g->b', C, x, z)
            x = x + 0.05*gx; y = y + 0.05*gy
        x = x/np.linalg.norm(x); y = y-(y@x)*x; y=y/np.linalg.norm(y)
        z = np.einsum('abg,a,b->g', C, x, y); f = z@z
        if f > best: best, bestXY = f, (x.copy(), y.copy())
    return best, bestXY

print("n   max||[X,Y]||^2 over orthonormal pairs (200 random starts, PGA)")
for n in [3,4,5,6,7,8,9,10,12]:
    b, xy = Cmax(n, ntrial=60 if n<=8 else 30, seed=3, iters=1500)
    print(f"{n:3d}  {b:.10f}")
