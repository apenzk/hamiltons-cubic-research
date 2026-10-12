"""r216, claim 5 support.  The 191 multiplicities WITHOUT the peel.

Claim 5's check -- "the covariants' Gram has rank m_lambda per block" -- can only
discharge the span obligation if m_lambda is exactly right, so the whole
obligation now rests on the peel in run_n12_sym3.py.  The highest-weight route
carried no such dependency: its vectors are a basis by construction and their
count MEASURES m_lambda.

This file supplies the missing independent count.  Racah's alternating sum,
    m_lambda = sum_{w in W} sgn(w) * N(lambda + rho - w rho),
with N the Sym^3 weight multiplicity and W = W(D_6) of order 23,040.  Characters
come from the Littlewood + Jacobi-Trudi route of claim 4a, so nothing here
touches Freudenthal, the peel, or the author's caches.
"""
import pickle, os, time
from collections import defaultdict
from itertools import combinations_with_replacement as cwr, permutations, product
from fractions import Fraction as F
from math import comb

R = 6
X = [tuple((s if k == i else 0) for k in range(R)) for i in range(R) for s in (1, -1)]
def h(k):
    dd = defaultdict(int)
    for c in cwr(X, k): dd[tuple(sum(t) for t in zip(*c))] += 1
    return dict(dd)
def mul(P, Q):
    dd = defaultdict(int)
    for a, ca in P.items():
        for b, cb in Q.items(): dd[tuple(a[t]+b[t] for t in range(R))] += ca*cb
    return {k: v for k, v in dd.items() if v}
def sub(P, Q):
    dd = defaultdict(int, P)
    for k, v in Q.items(): dd[k] -= v
    return {k: v for k, v in dd.items() if v}

t0 = time.time()
h1, h2, h3 = h(1), h(2), h(3)
CHI = sub(sub(mul(h2, h2), mul(h3, h1)), h2)
assert sum(CHI.values()) == 1638
p2 = {tuple(2*x for x in k): v for k, v in CHI.items()}
p3 = {tuple(3*x for x in k): v for k, v in CHI.items()}
print(f"char Weyl_12 built [{time.time()-t0:.0f}s]; cubing ...", flush=True)
p111 = mul(mul(CHI, CHI), CHI)
p12 = mul(CHI, p2)
acc = defaultdict(int, p111)
for k, v in p12.items(): acc[k] += 3*v
for k, v in p3.items(): acc[k] += 2*v
N = {}
for k, v in acc.items():
    q, r = divmod(v, 6)
    assert r == 0
    if q: N[k] = q
print(f"Sym^3 character: {len(N):,} distinct weights, dimension {sum(N.values()):,} "
      f"[{time.time()-t0:.0f}s]")
assert sum(N.values()) == comb(1640, 3)

# ---- W(D_6) and Racah ----
RHO = (5, 4, 3, 2, 1, 0)
WEL = []
for sg in permutations(range(R)):
    s = 1
    for i in range(R):
        for j in range(i+1, R):
            if sg[i] > sg[j]: s = -s
    for eps in product((1, -1), repeat=R):
        if eps.count(-1) % 2: continue
        WEL.append((tuple(eps[i]*RHO[sg[i]] for i in range(R)), s))
assert len(WEL) == 23040
# collapse repeated w*rho
WR = defaultdict(int)
for v, s in WEL: WR[v] += s
WR = {k: v for k, v in WR.items() if v}
print(f"W(D_6): {len(WEL)} elements, {len(WR)} distinct w*rho after cancellation")

def racah(lam):
    return sum(s*N.get(tuple(lam[t]+RHO[t]-v[t] for t in range(R)), 0)
               for v, s in WR.items())

def weyl_dim(lam):
    POS = []
    for i in range(R):
        for j in range(i+1, R):
            a = [0]*R; a[i] = 1; a[j] = -1; POS.append(tuple(a))
            b = [0]*R; b[i] = 1; b[j] = 1;  POS.append(tuple(b))
    num = den = F(1)
    for a in POS:
        num *= sum((lam[t]+RHO[t])*a[t] for t in range(R))
        den *= sum(RHO[t]*a[t] for t in range(R))
    return num/den

d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
B = pickle.load(open(os.path.join(d, "n12_sym3_blocks.pkl"), "rb"))
bad = []
tot = 0
mine = {}
for l in B:
    m = racah(l)
    mine[l] = m
    tot += m*weyl_dim(l)
    if m != B[l]: bad.append((l, m, B[l]))
print(f"\nRacah against the peel over the author's 77 constituents:")
print(f"  disagreements: {len(bad)}")
print(f"  total multiplicity: {sum(mine.values())}  (peel: {sum(B.values())})")
print(f"  sum m*dim V(lambda) = {int(tot):,}  vs C(1640,3) = {comb(1640,3):,}")
print(f"  {'COMPLETE -- no constituent is missing' if int(tot) == comb(1640,3) else 'INCOMPLETE'}")
for x in bad[:10]: print("   DISAGREE", x)

# ---- O(12) fusion, recomputed ----
CH = defaultdict(list)
for l in mine:
    if l[5] != 0: CH[l[:5]+(abs(l[5]),)].append(l)
fused = sum(mine[v[0]] for v in CH.values())
print(f"\n  chiral pairs: {len(CH)}, each with equal multiplicities "
      f"{all(mine[v[0]] == mine[v[1]] for v in CH.values())}")
for k in sorted(CH): print(f"    {k[:5]}, +/-{k[5]}   multiplicity {mine[CH[k][0]]}")
print(f"  O(12): {len(mine)-len(CH)} blocks, {sum(mine.values())-fused} multiplicities "
      f"(record: 71 and 184)")
