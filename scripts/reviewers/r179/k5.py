import sys, time
sys.path.insert(0,'scripts/reviewers/r179')
from weyl_invariants import dimension6
for n in [6,7,8,9,10,11]:
    t=time.time()
    r,ph = dimension6(n, 5, npts=40, seed=31+n, cap=19, stall4=2500, stall6=200,
                      verbose=False, tag=f"n{n} ")
    print(f"k=5 n={n}: dim>={r}  (phase {ph}, {time.time()-t:.0f}s)", flush=True)
