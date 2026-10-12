"""r262 claim 4(b) -- the traversal against union-find, EXHAUSTIVELY at f=5.

892,025 ordered pairs of the 945 perfect matchings on 10 points.  The reviewed
traversal re-walks a multigraph and falls back to m[cur][0] when every neighbour
is the vertex it came from; union-find counts connected components instead, which
for a 2-regular multigraph is the cycle count with no walking at all.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r262_gram import matchings, loops_uf
from r262_gram import loops_reviewed

for f in (5,):
    Ds = list(matchings(tuple(range(2*f))))
    n = len(Ds)
    bad = 0
    for i in range(n):
        for j in range(n):
            if loops_uf(Ds[i], Ds[j], f) != loops_reviewed(Ds[i], Ds[j], f):
                bad += 1
        if i % 200 == 0:
            print(f"  f={f}: {i}/{n} rows, disagreements so far {bad}", flush=True)
    print(f"  f={f}: {n*n} ordered pairs, DISAGREEMENTS = {bad}")
