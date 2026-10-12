import sys, json, time
sys.path.insert(0, 'scripts/reviewers/r179')
from weyl_invariants import dimension2
ks = [int(x) for x in sys.argv[1].split(',')]
ns = [int(x) for x in sys.argv[2].split(',')]
mr = int(sys.argv[3]) if len(sys.argv) > 3 else 4
out = {}
for k in ks:
    for n in ns:
        if n < 4: continue
        t = time.time()
        r, u, tr = dimension2(n, k, seed=101+n+7*k, stall=140, maxrank=mr,
                              npts=130, verbose=False)
        out[f"{k},{n}"] = r
        print(f"k={k} n={n:3d}  dim={r:4d}   ({u} diagrams, {time.time()-t:.0f}s)", flush=True)
print(json.dumps(out))
