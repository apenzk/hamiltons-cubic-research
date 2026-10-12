import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r55_k4 import *
from review_r55_core import theta0

def show(tag,G,sizes,seeds=120,seed=1):
    sols=solve_blowup(G,sizes,seeds=seeds,seed=seed)
    if not sols:
        print(f"{tag:>34} {str(sizes):>20} : no sign-consistent solution"); return None
    best=None
    for C in sols:
        d=stats(C,sizes)
        if best is None or d['ratio']>best[0]['ratio']: best=(d,C)
    d,C=best
    print(f"{tag:>34} {str(sizes):>20} n={d['n']:3d} th/th0={d['ratio']:.6f} "
          f"tri={d['tri']:4d} bip={str(d['bip']):5s} comps={d['comps']} rows={d['distinct_rows']}")
    return d

print("=== C_5 blow-up, equal blocks m ===")
for m in [1,2,3,4,5,6,8,10,15,20,30,50,100]:
    show("C5",cycle(5),[m]*5,seeds=60)
