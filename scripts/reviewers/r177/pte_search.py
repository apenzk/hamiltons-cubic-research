#!/usr/bin/env python3
"""Witness search: two 6-sets of distinct non-negative integers (admissible
ell = lambda+rho for D_6) with equal p_2,p_4,p_6,p_8,p_10 but different multisets.
If one exists, 'the only ambiguity the power sums leave is the sign of lam_6' is
refuted outright."""
import itertools, sys
from collections import defaultdict
N = int(sys.argv[1]) if len(sys.argv) > 1 else 40
pw = [[v**k for k in range(0, 11)] for v in range(N + 1)]
g = defaultdict(list)
hits = 0
for c in itertools.combinations(range(N + 1), 6):
    key = (sum(pw[v][2] for v in c), sum(pw[v][4] for v in c),
           sum(pw[v][6] for v in c), sum(pw[v][8] for v in c),
           sum(pw[v][10] for v in c))
    if key in g:
        g[key].append(c); hits += 1
        if hits <= 20:
            print("COLLISION", g[key])
    else:
        g[key] = [c]
print("N =", N, " total 6-sets", sum(len(v) for v in g.values()), " colliding keys", hits)
