import sys, time
sys.path.insert(0,'scripts/reviewers/r179')
from weyl_invariants import dimension6
print("=== k=5 (stable value 19, predicted threshold n=10) ===", flush=True)
for n in [7,8,9,10,11]:
    t=time.time(); r,ph = dimension6(n,5,npts=30,seed=31+n,cap=19,stall4=2000,stall6=150,verbose=False)
    print(f"k=5 n={n:2d}: dim>={r}   ({time.time()-t:.0f}s)", flush=True)
print("=== k=6 (stable value 89, predicted threshold n=12) ===", flush=True)
for n in [7,8,9,10]:
    t=time.time(); r,ph = dimension6(n,6,npts=95,seed=900+n,cap=89,stall4=2000,stall6=120,verbose=False)
    print(f"k=6 n={n:2d}: dim>={r}   ({time.time()-t:.0f}s)", flush=True)
