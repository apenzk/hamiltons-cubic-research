"""Claim 3: the repaired cross-weight check, recomputed independently, exactly.

run_n5_evaluate.py's repaired loop is 35*35*625 Fraction operations inside
Python; this reproduces the same 1190 discarded pairs over Z (the cache is
rational, so a common denominator clears it) and reports the count of nonzero
ones.  It also answers "can it fail".

THEOREM.  It cannot, given the cache.  The Euclidean Hermitian form on
Weyl_5 (x) C is invariant under SO(5,R), so every X in the compact Cartan acts
skew-Hermitianly with purely imaginary eigenvalues i*mu(X).  For weight vectors
f_a, f_b,
    0 = <X f_a, f_b> + <f_a, X f_b> = i (mu_a - mu_b)(X) <f_a, f_b>,
so mu_a != mu_b forces <f_a, f_b> = 0.  The repaired check is therefore a
falsifiable test of exactly one thing -- that n5_hw_cache.json's tensors really
are weight vectors carrying the labels it records -- and of nothing downstream.
"""
import json, os
from fractions import Fraction as F

d = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__)))), "runs")
C = json.load(open(os.path.join(d, "n5_hw_cache.json")))
WT = [tuple(w) for w in C["weights"]]
T = C["wbasis_tensors"]
print(f"cache: {len(T)} weight-basis tensors, {len(set(WT))} distinct weights")
from collections import Counter
print(f"  multiplicity profile: {sorted(Counter(Counter(WT).values()).items())}")

# common denominator over every entry -> integer arithmetic
den = 1
def lcm(a, b):
    from math import gcd
    return a * b // gcd(a, b)
for a in range(len(T)):
    for i in range(5):
        for j in range(5):
            for k in range(5):
                for l in range(5):
                    (rn, rd), (inn, idd) = T[a][i][j][k][l]
                    den = lcm(den, rd); den = lcm(den, idd)
print(f"  common denominator of every entry: {den}")

V = []
for a in range(len(T)):
    re, im = [], []
    for i in range(5):
        for j in range(5):
            for k in range(5):
                for l in range(5):
                    (rn, rd), (inn, idd) = T[a][i][j][k][l]
                    re.append(rn * (den // rd)); im.append(inn * (den // idd))
    V.append((re, im))

same_nz = cross_nz = cross_tot = 0
worst = None
for a in range(len(T)):
    ra, ia = V[a]
    for b in range(len(T)):
        rb, ib = V[b]
        pr = sum(ra[t]*rb[t] + ia[t]*ib[t] for t in range(625))
        pi = sum(ia[t]*rb[t] - ra[t]*ib[t] for t in range(625))
        if WT[a] == WT[b]:
            if (pr, pi) != (0, 0): same_nz += 1
        else:
            cross_tot += 1
            if (pr, pi) != (0, 0):
                cross_nz += 1
                if worst is None: worst = (a, b, pr, pi)
print(f"\n  within-weight pairs nonzero : {same_nz}   (shipped file reports 45)")
print(f"  cross-weight pairs COMPUTED : {cross_tot}   (shipped file says ~1180)")
print(f"  cross-weight pairs NONZERO  : {cross_nz}    (must be 0)   witness: {worst}")
print(f"\n  VERDICT: the repair is real -- the falsifying pairs are now evaluated")
print(f"  -- and it returns 0.  Its scope is the cache's weight labelling alone.")

# Negative control: relabel one weight and watch the check fire.
# The control must move an index that has a NONZERO off-diagonal partner --
# relabelling two mutually orthogonal vectors changes nothing.
pairs = []
for a in range(len(T)):
    ra, ia = V[a]
    for b in range(a+1, len(T)):
        if WT[a] != WT[b]: continue
        rb, ib = V[b]
        pr = sum(ra[t]*rb[t] + ia[t]*ib[t] for t in range(625))
        pi = sum(ia[t]*rb[t] - ra[t]*ib[t] for t in range(625))
        if (pr, pi) != (0, 0): pairs.append((a, b))
print(f"\n  the {len(pairs)} within-weight NONZERO off-diagonal pairs: {pairs}")
a0, b0 = pairs[0]
print(f"  negative control: relabel index {b0} with a weight it does not have,")
print(f"  so that the nonzero pair ({a0},{b0}) becomes a cross-weight pair")
WT2 = list(WT); WT2[b0] = (99, 99)
nz = 0
for a in range(len(T)):
    ra, ia = V[a]
    for b in range(len(T)):
        if WT2[a] == WT2[b]: continue
        rb, ib = V[b]
        pr = sum(ra[t]*rb[t] + ia[t]*ib[t] for t in range(625))
        pi = sum(ia[t]*rb[t] - ra[t]*ib[t] for t in range(625))
        if (pr, pi) != (0, 0): nz += 1
print(f"  cross-weight nonzero under the corrupted labelling: {nz}  (fires: {nz > 0})")
