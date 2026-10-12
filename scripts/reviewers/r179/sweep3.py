import sys, time
sys.path.insert(0, 'scripts/reviewers/r179')
from weyl_invariants import dimension3
ks = [int(x) for x in sys.argv[1].split(',')]
ns = [int(x) for x in sys.argv[2].split(',')]
mr = int(sys.argv[3]); stall = int(sys.argv[4]); seed = int(sys.argv[5]) if len(sys.argv)>5 else 1
for k in ks:
    for n in ns:
        t = time.time()
        r, u = dimension3(n, k, stall=stall, maxrank=mr, npts=130, seed=seed+n+7*k,
                          verbose=False, cap=89 if k==6 else None)
        print(f"k={k} n={n:3d} maxrank<={mr}  dim>={r:4d}  ({u} diagrams, {time.time()-t:.0f}s)", flush=True)
