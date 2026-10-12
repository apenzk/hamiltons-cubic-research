"""Claim 5, independently: the Hermitian Gram H of the 35 weight-basis Weyl
tensors under the full 4-index contraction <A,B> = sum_ijkl A_ijkl conj(B_ijkl).

Independent of run_n5_evaluate.py: exact integer arithmetic after clearing a
single common denominator, and the block structure is read off afterwards
rather than imposed by a `continue` on unequal weights.
"""
import json, os, math
from fractions import Fraction as F
from collections import Counter

d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
C = json.load(open(os.path.join(d, "n5_hw_cache.json")))
WT = [tuple(w) for w in C["weights"]]
T = C["wbasis_tensors"]

def gq(pr):
    (rn, rd), (inn, idd) = pr
    return (F(rn, rd), F(inn, idd))

# flatten: A[a] = list of 625 Gaussian rationals
A = [[gq(T[a][i][j][k][l]) for i in range(5) for j in range(5)
      for k in range(5) for l in range(5)] for a in range(35)]

# common denominator -> exact integer arithmetic
den = 1
for row in A:
    for (r, im) in row:
        den = den * r.denominator // math.gcd(den, r.denominator)
        den = den * im.denominator // math.gcd(den, im.denominator)
print(f"common denominator of every tensor entry: {den}")
Ai = [[(int(r*den), int(im*den)) for (r, im) in row] for row in A]

H = {}
for a in range(35):
    Aa = Ai[a]
    for b in range(35):
        Ab = Ai[b]
        re = im = 0
        for p in range(625):
            xr, xi = Aa[p]
            if not xr and not xi: continue
            yr, yi = Ab[p]
            re += xr*yr + xi*yi
            im += xi*yr - xr*yi
        if re or im:
            H[(a, b)] = (F(re, den*den), F(im, den*den))

print(f"nonzero entries: {len(H)} of {35*35}")
print(f"all nonzero entries share a weight: {all(WT[a]==WT[b] for a, b in H)}")
offw = [(a, b) for (a, b) in H if WT[a] != WT[b]]
print(f"  entries across distinct weights: {len(offw)}")
diag = sorted({H[(a, a)] for a in range(35)})
print(f"diagonal values: {sorted(set(x[0] for x in diag))}  (imag all zero: "
      f"{all(x[1]==0 for x in diag)})")
print(f"diagonal multiset: {sorted(Counter(H[(a,a)][0] for a in range(35)).items())}")
offd = {(a, b): H[(a, b)] for (a, b) in H if a != b}
print(f"off-diagonal nonzero entries: {len(offd)}")
for (a, b), v in sorted(offd.items()):
    print(f"   H[{a},{b}] = {v}   weights {WT[a]} {WT[b]}")

# weight multiplicities
byw = {}
for a in range(35): byw.setdefault(WT[a], []).append(a)
print(f"\n{len(byw)} distinct weights; multiplicity multiset "
      f"{sorted(Counter(len(v) for v in byw.values()).items())}")
print(f"predicted nonzero cap if H were full on each weight block: "
      f"{sum(len(v)**2 for v in byw.values())}")

# Hermitian?
herm = all(H.get((b, a), (F(0), F(0))) == (H[(a, b)][0], -H[(a, b)][1]) for (a, b) in H)
print(f"H is Hermitian: {herm}")
# positive definite on each weight block (Sylvester on <=3x3, exact)
import itertools
def posdef(idxs):
    n = len(idxs)
    M = [[H.get((idxs[r], idxs[c]), (F(0), F(0))) for c in range(n)] for r in range(n)]
    for k in range(1, n+1):
        sub = [row[:k] for row in M[:k]]
        # exact complex determinant by cofactor (k <= 3)
        def det(m):
            if len(m) == 1: return m[0][0]
            tot = (F(0), F(0))
            for j in range(len(m)):
                minor = [r[:j]+r[j+1:] for r in m[1:]]
                dm = det(minor)
                s = m[0][j]
                p = (s[0]*dm[0]-s[1]*dm[1], s[0]*dm[1]+s[1]*dm[0])
                if j % 2: p = (-p[0], -p[1])
                tot = (tot[0]+p[0], tot[1]+p[1])
            return tot
        dv = det(sub)
        if dv[1] != 0 or dv[0] <= 0: return False, k, dv
    return True, n, None
allpd = all(posdef(v)[0] for v in byw.values())
print(f"H positive definite on every weight block: {allpd}")
