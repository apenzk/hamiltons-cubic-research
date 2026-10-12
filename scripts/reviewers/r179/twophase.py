import sys, time
sys.path.insert(0,'scripts/reviewers/r179')
from weyl_invariants import dimension6
for n in [int(x) for x in sys.argv[1].split(',')]:
    t=time.time()
    r,ph = dimension6(n, 6, npts=100, seed=int(sys.argv[2])+n, cap=89,
                      stall4=2500, stall6=int(sys.argv[3]), verbose=True, tag=f"n{n} ")
    print(f"RESULT n={n} k=6: dim>={r}  (phase {ph}, {time.time()-t:.0f}s)", flush=True)
