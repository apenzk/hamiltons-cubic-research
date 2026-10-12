"""Reviewer 49: the remaining validation the brief names -- dim Weyl_14 = 3080."""
import sys, time
import numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r49_core as C
for n in (13, 14):
    t = time.time()
    d = C.weyl_basis(n).shape[0]
    print(f"n={n}: measured {d}  formula {C.dim_weyl(n)}  "
          f"{'OK' if d == C.dim_weyl(n) else 'MISMATCH'}  [{time.time()-t:.0f}s]", flush=True)
