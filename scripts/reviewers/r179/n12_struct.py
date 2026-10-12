import sys, time
sys.path.insert(0,'scripts/reviewers/r179')
from weyl_invariants import dimension4
n = int(sys.argv[1]); seed = int(sys.argv[2])
t=time.time()
r,u = dimension4(n, 6, npts=140, seed=seed, stall=5000, cap=89, maxrank=4,
                verbose=True, tag=f"struct s{seed} ")
print(f"FINAL n={n} k=6 structured seed={seed}: dim>={r} ({u} diagrams, {time.time()-t:.0f}s)")
