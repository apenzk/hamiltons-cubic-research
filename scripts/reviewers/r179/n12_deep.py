import sys, time
sys.path.insert(0,'scripts/reviewers/r179')
from weyl_invariants import dimension3
seed = int(sys.argv[1]); mr = int(sys.argv[2]) if len(sys.argv)>2 else 4
t=time.time()
r,u = dimension3(12, 6, npts=140, seed=seed, stall=4000, cap=89, maxrank=mr,
                verbose=True, tag=f"seed{seed} mr{mr} ")
print(f"FINAL n=12 k=6 seed={seed} maxrank<={mr}: dim>={r} ({u} diagrams, {time.time()-t:.0f}s)")
