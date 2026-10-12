"""r257 claim 1 witness: what does the test still certify on a CORRUPTED cache?

The rank/support logic below is copied verbatim from
scripts/runs/run_hw_multiplicity_test.py so that the only variable is the cache.
"""
import pickle, random
from fractions import Fraction as F

BASE = pickle.load(open("scripts/runs/n5_adapted.pkl", "rb"))

def hw_support(copies):
    return sorted({t for t, v in enumerate(copies[0]) if v})

def rank_of_block(A, lam, comps):
    copies = A[lam]; m = len(copies); rows = []
    for t in comps:
        keys = sorted({k for i in range(m) if copies[i][t] for k in copies[i][t]})
        for k in keys:
            rows.append([copies[i][t].get(k, 0) if copies[i][t] else 0 for i in range(m)])
    if not rows: return 0, m
    M = [[F(x.r if hasattr(x, 'r') else x) if not isinstance(x, tuple) else F(x[0])
          for x in row] for row in rows]
    rank = 0
    for c in range(m):
        pr = next((t for t in range(rank, len(M)) if M[t][c] != 0), None)
        if pr is None: continue
        M[rank], M[pr] = M[pr], M[rank]
        iv = M[rank][c]; M[rank] = [x / iv for x in M[rank]]
        for t in range(len(M)):
            if t != rank and M[t][c] != 0:
                f0 = M[t][c]; M[t] = [x - f0 * y for x, y in zip(M[t], M[rank])]
        rank += 1
    return rank, m

def verdict(A, label):
    MULTI = sorted(((l, len(c)) for l, c in A.items() if len(c) > 1), key=lambda t: -t[1])
    bad = []
    for lam, m in MULTI:
        sup = hw_support(A[lam])
        if not sup: continue
        r, mm = rank_of_block(A, lam, sup[:3])
        if r != mm: bad.append((lam, r, mm))
    print(f"  {label:<58} {'PASSES (every block full rank)' if not bad else 'fails: '+str(bad)}")

def clone(A):
    return {l: [[dict(v) for v in c] for c in cs] for l, cs in A.items()}

ZERO = (F(0), F(0))
random.seed(257)

# W0 -- the cache as it stands
verdict(BASE, "W0  the real cache")

# W1 -- every vector past position 0 emptied: the whole lowering machinery gone
A = clone(BASE)
for l, cs in A.items():
    for c in cs:
        for t in range(1, len(c)): c[t] = {}
verdict(A, "W1  positions 1..dim emptied (no adapted basis left)")

# W2 -- every copy collapsed onto copy 0 past position 0: the identification of
#       copy i with copy j is destroyed, which is what the word list buys
A = clone(BASE)
for l, cs in A.items():
    for i in range(1, len(cs)):
        for t in range(1, len(cs[i])): cs[i][t] = dict(cs[0][t])
verdict(A, "W2  all copies identical past position 0")

# W3 -- every imaginary part deleted
A = clone(BASE)
for l, cs in A.items():
    for c in cs:
        for v in c:
            for k in v: v[k] = (v[k][0], F(0))
verdict(A, "W3  every imaginary part set to 0")

# W4 -- every imaginary part replaced by noise
A = clone(BASE)
for l, cs in A.items():
    for c in cs:
        for v in c:
            for k in v: v[k] = (v[k][0], F(random.randint(-9, 9)))
verdict(A, "W4  every imaginary part replaced by noise")

# W5 -- position 0 corrupted everywhere EXCEPT the nullspace unit columns
A = clone(BASE)
for l, cs in A.items():
    m = len(cs)
    if m < 2: continue
    keys = sorted({k for i in range(m) for k in cs[i][0]})
    unit = set()
    for k in keys:
        col = tuple(cs[i][0].get(k, ZERO) for i in range(m))
        for r in range(m):
            if col == tuple((F(1), F(0)) if i == r else ZERO for i in range(m)):
                unit.add(k)
    for k in keys:
        if k in unit: continue
        for i in range(m):
            if k in cs[i][0]: cs[i][0][k] = (F(random.randint(-9, 9)), F(random.randint(-9, 9)))
verdict(A, "W5  hw vectors randomised off the nullspace unit columns")

# W6 -- what DOES break it: delete the unit columns (an input no run can produce,
#       since nullspace_G writes them by construction)
A = clone(BASE)
for l, cs in A.items():
    m = len(cs)
    if m < 2: continue
    for i in range(m):
        for t in range(len(cs[i])): cs[i][t] = dict(cs[0][t])
verdict(A, "W6  every copy identical INCLUDING position 0 (control)")
