"""Claim 4: the cheap-basis cap is not a free parameter.

Exact fact first.  A matching produced by WI.random_matching pairs no two slots of
the same vertex, so all 12 edges of the 6-vertex multigraph are non-loops.  A given
non-loop edge {u,v} is cut by exactly 6 of the 10 balanced 3+3 splittings (choose the
other two members of u's half from the remaining four).  Hence

    sum over the 10 splittings of cross(S) = 6 * 12 = 72,   always,

so the mean cut is 7.2 and, cuts being even, max cut >= 8 for EVERY diagram.  CAP = 8
is therefore the extreme value, and CAP = 12 is no filter at all (a cut can never
exceed 12).  This script checks both endpoints numerically and prints the achievable
distribution of the worst cross-pair count.
"""
import os, sys, random
from itertools import combinations
import numpy as np

d = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(d, "..", "r179"))
import weyl_invariants as WI

SPLITS = [frozenset(c) for c in combinations(range(6), 3) if 0 in c]
assert len(SPLITS) == 10

def cuts(m):
    return [sum(1 for a, b in m if ((a//4) in S) != ((b//4) in S)) for S in SPLITS]

pyrng = random.Random(1234)
from collections import Counter
hist = Counter(); sums = Counter()
for _ in range(200000):
    m = WI.random_matching(6, pyrng)
    c = cuts(m)
    sums[sum(c)] += 1
    hist[max(c)] += 1
print(f"sum of the 10 cuts, over 200000 random matchings: {dict(sums)}   (identity: always 72)")
print(f"worst cross-pair count distribution: {dict(sorted(hist.items()))}")
tot = sum(hist.values())
for k in sorted(hist):
    print(f"   worst = {k:2d}: {hist[k]:7d}  ({100*hist[k]/tot:.3f} %)")
print(f"fraction reaching the minimum 8: {hist[8]/tot:.5f}")
print(f"fraction with worst <= 12 (i.e. no filter at all): {sum(hist.values())/tot:.5f}")
