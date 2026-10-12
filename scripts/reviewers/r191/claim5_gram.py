"""Claim 5, independently: the FULL 35x35 Gram, including the pairs that
run_n5_evaluate.py never computes.

evaluate.py writes
      for a ... for b ...:
          if WT[a] != WT[b]: continue
          ...
      print(... all(WT[a]==WT[b] for a,b in H))
so its "none across distinct weights" line is true by construction: the pairs
it would have to disprove are the ones the `continue` throws away.  Here every
one of the 1225 pairs is computed.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import *

full = [[Z]*35 for _ in range(35)]
for a in range(35):
    Ta = T[a]
    for b in range(35):
        Tb = T[b]
        re = im = F(0)
        for i in range(5):
            for j in range(5):
                for k in range(5):
                    for l in range(5):
                        x = gq(Ta[i][j][k][l]); y = gq(Tb[i][j][k][l])
                        if x == Z or y == Z: continue
                        re += x[0]*y[0] + x[1]*y[1]
                        im += x[1]*y[0] - x[0]*y[1]
        full[a][b] = (re, im)

nz = [(a, b) for a in range(35) for b in range(35) if full[a][b] != Z]
cross = [(a, b) for a, b in nz if WT[a] != WT[b]]
print(f"nonzero entries of the FULL Gram: {len(nz)} of 1225")
print(f"  entries pairing DISTINCT weights: {len(cross)}   (this is the check that can fail)")
print(f"  diagonal values: {sorted({full[a][a][0] for a in range(35)})}")
print(f"  Hermitian: {all(full[b][a] == cconj(full[a][b]) for a in range(35) for b in range(35))}")
print(f"  positive on the diagonal: {all(full[a][a][0] > 0 and full[a][a][1] == 0 for a in range(35))}")
from collections import Counter
print(f"  block sizes by weight: {dict(sorted(Counter(len(v) for v in BYW.values()).items()))}")
# every weight block must be nonsingular, else `coords` has no solution
import itertools as it
bad = []
for mu, idxs in BYW.items():
    m = len(idxs)
    M = [[full[r][c] for c in idxs] for r in idxs]
    # exact determinant by expansion (m <= 3)
    if m == 1: det = M[0][0]
    elif m == 2: det = csub(cmul(M[0][0], M[1][1]), cmul(M[0][1], M[1][0]))
    else:
        det = Z
        for p in it.permutations(range(3)):
            sgn = 1 if p in ((0,1,2),(1,2,0),(2,0,1)) else -1
            term = ONE
            for r in range(3): term = cmul(term, M[r][p[r]])
            det = cadd(det, term if sgn == 1 else (-term[0], -term[1]))
    if det == Z: bad.append(mu)
print(f"  every weight block nonsingular: {not bad}  {bad if bad else ''}")
