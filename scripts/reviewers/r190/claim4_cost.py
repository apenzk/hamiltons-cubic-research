"""Consistency of the enumeration, and what the cap-8 obstruction actually costs.

(a) orbit-counting check: sum over iso classes of 720/|Aut| must equal the labelled count.
(b) the record measures cost by the WORST cut, but the pairing is assembled splitting by
    splitting, so the honest cost of a diagram is sum over the 10 splittings of 5^cut.
    Compute the cheapest 14-element basis under that measure and see how much of the
    5^12 headline survives.
"""
import os, sys
from itertools import combinations, permutations, product
import numpy as np
d = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, d); sys.path.insert(0, os.path.join(d, "..", "r179"))
import weyl_invariants as WI
import claim4_exhaustive as X

classes, SPLITS, PAIRS = X.classes, X.SPLITS, X.PAIRS

def aut(g):
    n = 0
    for perm in permutations(range(6)):
        if all(g.get(tuple(sorted((perm[u], perm[v]))), 0) == g.get((u, v), 0)
               for (u, v) in PAIRS): n += 1
    return n
tot = sum(720 // aut(g) for g in classes.values())
print(f"orbit-count check: sum 720/|Aut| = {tot}, labelled graphs = {len(X.GR)}, "
      f"match = {tot == len(X.GR)}")

def profile(g):
    return sorted(sum(m for (u, v), m in g.items() if ((u in S) != (v in S)))
                  for S in SPLITS)
print("\nall 24 classes: maxcut, cut profile, sum(5^cut) cost")
rowsinfo = []
for key, g in sorted(classes.items(), key=lambda kv: (X.maxcut(kv[1]),)):
    pr = profile(g)
    cost = sum(5**c for c in pr)
    rowsinfo.append((X.maxcut(g), pr, cost, key))
    print(f"  maxcut {X.maxcut(g):2d}  profile {pr}  cost {cost:,}")

best12 = min((r for r in rowsinfo if r[0] == 12), key=lambda r: r[2])
n12 = sum(1 for c in best12[1] if c == 12)
print(f"\ncheapest cut-12 class: profile {best12[1]}, cost {best12[2]:,}, "
      f"{n12} of its 10 splittings sit at 5^12")
cheap8 = min((r for r in rowsinfo if r[0] == 8), key=lambda r: r[2])
print(f"cheapest cut-8 class:  profile {cheap8[1]}, cost {cheap8[2]:,}")
