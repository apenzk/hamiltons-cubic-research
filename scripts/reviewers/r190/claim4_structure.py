"""What the three cap-8 multigraphs actually are, and the rank at three primes.

A mod-p rank is a LOWER bound for the rank over Q, so "the cap-8 family spans only
10" is the direction a single prime cannot certify.  Repeating at independent primes
with independent sample points is the check.
"""
import os, sys, time
from itertools import combinations, permutations, product
import numpy as np

d = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, d); sys.path.insert(0, os.path.join(d, "..", "r179"))
import weyl_invariants as WI
import claim4_exhaustive as X    # reuse the enumeration

classes = X.classes
PAIRS = X.PAIRS
for key, g in sorted(classes.items(), key=lambda kv: X.maxcut(kv[1])):
    mc = X.maxcut(g)
    if mc > 8: continue
    prof = sorted(sum(m for (u, v), m in g.items() if ((u in S) != (v in S)))
                  for S in X.SPLITS)
    mults = sorted((m for m in g.values() if m), reverse=True)
    print(f"cap-8 class  maxcut={mc}  cut profile {prof}  edge multiplicities {mults}")

print()
for PP, seed in ((10007, 1), (65537, 2), (999983, 3)):
    rng = np.random.default_rng(seed)
    PTS = [WI.random_weyl(5, PP, rng) for _ in range(30)]
    rows, piv = [], []
    def add(v):
        v = [x % PP for x in v]
        for p0, r in zip(piv, rows):
            if v[p0]:
                f = v[p0]; v = [(a - f*b) % PP for a, b in zip(v, r)]
        nz = next((i for i, x in enumerate(v) if x), None)
        if nz is None: return
        inv = pow(v[nz], PP-2, PP); rows.append([x*inv % PP for x in v]); piv.append(nz)
    nd = 0
    for key, g in classes.items():
        if X.maxcut(g) > 8: continue
        for assign in product(range(3), repeat=6):
            m = X.matchings(g, assign)
            if any(a//4 == b//4 for a, b in m): continue
            add([WI.eval_diagram(W, m, 6, PP) % PP for W in PTS]); nd += 1
    print(f"p = {PP:7d}: {nd} cap-8 diagrams, rank {len(rows)}")
