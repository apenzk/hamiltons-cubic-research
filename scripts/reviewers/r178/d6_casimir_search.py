#!/usr/bin/env python3
"""r178: does p_2,p_4,p_6,p_8,p_10 separate dominant O(12) weights?
ell = lam + rho, rho = (5,4,3,2,1,0); dominant O(12) lam <=> ell strictly decreasing nonneg ints."""
from itertools import combinations
import sys
N = int(sys.argv[1]) if len(sys.argv)>1 else 35
pw = [[a**k for k in (2,4,6,8,10)] for a in range(N+1)]
seen = {}
coll = []
for S in combinations(range(N+1), 6):
    k = (0,0,0,0,0)
    k = tuple(sum(pw[a][j] for a in S) for j in range(5))
    prev = seen.get(k)
    if prev is None:
        seen[k] = S
    elif prev != S:
        coll.append((prev, S))
print("N =", N, " subsets =", len(seen)+len(coll), " collisions:", len(coll))
for p,s in coll[:20]:
    print("  ell A =", p, " ell B =", s,
          " lam A =", tuple(x-y for x,y in zip(p[::-1][::-1],(5,4,3,2,1,0))),
          " lam B =", tuple(x-y for x,y in zip(s,(5,4,3,2,1,0))))
