#!/usr/bin/env python3
# r178: separation power of Casimirs on the 71 O(12) blocks of Sym^3(Weyl_12)
# (block list produced independently by scripts/reviewers/r178/d6_sym3.sage)
from itertools import combinations
from collections import Counter, defaultdict
so12 = """(2,2,2,2,2,2):1 (3,3,2,2,1,1):1 (3,3,3,3,0,0):1 (4,2,2,2,2,0):1 (4,3,2,2,1,0):1
(4,3,3,1,1,0):1 (4,4,1,1,1,1):1 (4,4,2,2,0,0):2 (4,4,4,0,0,0):1 (5,3,2,1,1,0):1 (5,3,3,1,0,0):1
(5,4,2,1,0,0):1 (5,5,1,1,0,0):1 (6,2,2,2,0,0):1 (6,4,2,0,0,0):1 (6,6,0,0,0,0):1 (2,2,2,2,2,0):1
(3,2,2,1,1,1):1 (3,2,2,2,1,0):2 (3,3,2,1,1,0):3 (3,3,2,2,0,0):1 (3,3,3,1,0,0):2 (4,2,1,1,1,1):1
(4,2,2,1,1,0):2 (4,2,2,2,0,0):3 (4,3,1,1,1,0):2 (4,3,2,1,0,0):5 (4,3,3,0,0,0):1 (4,4,1,1,0,0):1
(4,4,2,0,0,0):3 (5,2,1,1,1,0):1 (5,2,2,1,0,0):2 (5,3,1,1,0,0):3 (5,3,2,0,0,0):2 (5,4,1,0,0,0):2
(6,2,2,0,0,0):1 (6,3,1,0,0,0):1 (6,4,0,0,0,0):1 (2,2,1,1,1,1):2 (2,2,2,1,1,0):1 (2,2,2,2,0,0):4
(3,2,1,1,1,0):4 (3,2,2,1,0,0):6 (3,3,1,1,0,0):8 (3,3,2,0,0,0):2 (4,1,1,1,1,0):2 (4,2,1,1,0,0):4
(4,2,2,0,0,0):8 (4,3,1,0,0,0):6 (4,4,0,0,0,0):4 (5,1,1,1,0,0):2 (5,2,1,0,0,0):4 (5,3,0,0,0,0):1
(6,2,0,0,0,0):2 (2,1,1,1,1,0):2 (2,2,1,1,0,0):3 (2,2,2,0,0,0):6 (3,1,1,1,0,0):6 (3,2,1,0,0,0):9
(3,3,0,0,0,0):2 (4,1,1,0,0,0):4 (4,2,0,0,0,0):7 (5,1,0,0,0,0):1 (6,0,0,0,0,0):1 (1,1,1,1,0,0):3
(2,1,1,0,0,0):3 (2,2,0,0,0,0):8 (3,1,0,0,0,0):3 (4,0,0,0,0,0):3 (2,0,0,0,0,0):3 (0,0,0,0,0,0):2"""
blocks=[]
for tok in so12.split():
    lam,m = tok.split(":")
    blocks.append((tuple(int(x) for x in lam.strip("()").split(",")), int(m)))
assert len(blocks)==71, len(blocks)
rho=(5,4,3,2,1,0)
def ell(l): return tuple(l[i]+rho[i] for i in range(6))
def p(l,k): return sum(e**k for e in ell(l))
c2={l:p(l,2)-55 for l,_ in blocks}
g=defaultdict(list)
for l,_ in blocks: g[c2[l]].append(l)
singles=[k for k,v in g.items() if len(v)==1]
fused={k:v for k,v in g.items() if len(v)>1}
print("c2 alone: separates %d of 71; %d blocks fuse into %d classes; widest class %d"
      % (len(singles), sum(len(v) for v in fused.values()), len(fused),
         max(len(v) for v in fused.values())))
print("widest:", [v for v in fused.values() if len(v)==max(len(v) for v in fused.values())])
for kk in (4,6,8,10):
    key=lambda l: tuple(p(l,j) for j in range(2,kk+1,2))
    print("p_2..p_%d: distinct keys = %d of 71" % (kk, len(set(key(l) for l,_ in blocks))))
# exhaustive: p2..p10 over ALL dominant O(12) weights with ell in {0..11} (covers lam_1<=6)
seen={}
bad=[]
for S in combinations(range(12),6):
    k=tuple(sum(a**j for a in S) for j in (2,4,6,8,10))
    if k in seen: bad.append((seen[k],S))
    seen[k]=S
print("exhaustive over all 924 dominant O(12) weights with ell<=11: collisions =", len(bad))
# does e_6 vary at fixed (e_1..e_5)?  -> the actual logical gap
print("split O(12) blocks (lam_6 != 0):", [l for l,_ in blocks if l[5]!=0])

sizes=Counter(len(v) for v in g.values())
print("c2 fibre sizes at n=12 (size:count):", sorted(sizes.items()))
print("number of distinct c2 values =", len(g), "; singletons =", sizes[1],
      "; fused blocks =", 71-sizes[1], "in", len(g)-sizes[1], "classes")
print("classes of width 5:", sum(1 for v in g.values() if len(v)==5))
