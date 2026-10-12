"""Reviewer 55, K4f: broad sweep -- does ANY connected non-bipartite S=0 blow-up
beat 1/sqrt(2) = 0.70710678?"""
import numpy as np, sys, itertools, random
sys.path.insert(0, 'scripts/lib')
from review_r55_blocks import solve_all, expand
from review_r55_k4 import stats
from review_r55_k5 import coarse_partition
from review_r55_core import theta0

best=(0.0,None)
rows=[]
cases=[]
for k in (5,6,7):
    for _ in range(6):
        cases.append([random.Random(k*100+_).randint(1,4) for __ in range(k)])
cases += [[2]*5,[3]*5,[4]*5,[2,2,2,3,3],[3,3,3,4,4],[2,3,4,5,6],[1,2,3,4,5],
          [2]*6,[3]*6,[2]*7,[1,1,2,2,3,3],[4,4,4,4,4],[5,5,5,5,5],[2,2,4,4,4]]
seen=set()
print(f"{'sizes':>26} {'n':>4} {'#sol':>5} {'best S=0 conn non-bip':>22} {'best any':>10}")
for sizes in cases:
    key=tuple(sorted(sizes))
    if key in seen: continue
    seen.add(key)
    n=sum(sizes); k=len(sizes)
    if n>26 or k>7: continue
    try:
        sols=solve_all(list(sizes), ntry=600 if k<=6 else 900, seed=3)
    except Exception as e:
        print(f"{str(sizes):>26} error {e}"); continue
    bb=0.0; anyb=0.0
    for c in sols:
        lam,C=expand(list(sizes),c)
        d=stats(C,list(sizes)); grp=coarse_partition(C,list(sizes))
        anyb=max(anyb,d['ratio'])
        if len(grp)==k and d['tri']==0 and (not d['bip']) and d['comps']==1 and d['isolated']==0:
            bb=max(bb,d['ratio'])
            if d['ratio']>best[0]: best=(d['ratio'],(tuple(sizes),np.round(C,5)))
    print(f"{str(sizes):>26} {n:4d} {len(sols):5d} {bb:22.6f} {anyb:10.6f}")
print(f"\nGLOBAL BEST over the sweep, S=0 connected non-bipartite k-block: {best[0]:.9f}")
print(f"   1/sqrt(2) = {1/np.sqrt(2):.9f}")
if best[1] is not None:
    print(f"   at sizes {best[1][0]}\n{best[1][1]}")
