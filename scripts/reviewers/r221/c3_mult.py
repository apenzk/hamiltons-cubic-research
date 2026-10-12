"""r221, claim 3a.  Recompute m_lambda from scratch, sharing nothing with
n12_sym3_blocks.pkl.

Route: the 12 weights of C^12 -> char Weyl_12 = h2^2 - h3 h1 - h2 (symmetric
functions only) -> full weight multiplicity function of Sym^3 by
(p1^3 + 3 p1 p2 + 2 p3)/6 -> Racah:
      c_lambda = sum_{w in W(D6)} sgn(w) m(lambda + rho - w rho),
which follows from multiplying char M by the Weyl denominator and reading off the
coefficient of e^{lambda+rho}.  W(D6) = signed permutations with an even number of
sign changes, and sgn(w) = sgn(sigma) because the sign flips multiply to +1.
"""
import pickle, os, time
from collections import defaultdict
from itertools import combinations_with_replacement as cwr, permutations, product

R = 6
d = os.path.dirname(os.path.abspath(__file__))
def e_(i, s):
    v = [0]*R; v[i] = s; return tuple(v)
X = [e_(i, s) for i in range(R) for s in (1, -1)]
def h(k):
    dd = defaultdict(int)
    for c in cwr(X, k): dd[tuple(sum(t) for t in zip(*c))] += 1
    return dict(dd)
def mul(A, B):
    dd = defaultdict(int)
    for a, ca in A.items():
        for b, cb in B.items(): dd[tuple(a[t]+b[t] for t in range(R))] += ca*cb
    return {k: v for k, v in dd.items() if v}
def sub(A, B):
    dd = defaultdict(int, A)
    for k, v in B.items(): dd[k] -= v
    return {k: v for k, v in dd.items() if v}
def add(A, B, s=1):
    dd = defaultdict(int, A)
    for k, v in B.items(): dd[k] += s*v
    return {k: v for k, v in dd.items() if v}

t0 = time.time()
h1, h2, h3 = h(1), h(2), h(3)
CHI = sub(sub(mul(h2, h2), mul(h3, h1)), h2)
assert sum(CHI.values()) == 1638
P1 = CHI
P2 = {tuple(2*x for x in k): v for k, v in CHI.items()}
P3 = {tuple(3*x for x in k): v for k, v in CHI.items()}
C3 = mul(mul(P1, P1), P1)
T = add(add(C3, mul(P1, P2), 3), P3, 2)
SYM3 = {}
for k, v in T.items():
    q, r = divmod(v, 6)
    assert r == 0, (k, v)
    if q: SYM3[k] = q
print(f"Sym^3 weight system: {len(SYM3):,} distinct weights, "
      f"dim {sum(SYM3.values()):,}  [{time.time()-t0:.1f}s]")
N = 1638
assert sum(SYM3.values()) == N*(N+1)*(N+2)//6

RHO = (5, 4, 3, 2, 1, 0)
Wel = []
for sg in permutations(range(R)):
    # sgn of the permutation
    s = 1; seen = [0]*R
    perm = list(sg)
    for i in range(R):
        for j in range(i+1, R):
            if perm[i] > perm[j]: s = -s
    for eps in product((1, -1), repeat=R):
        if eps.count(-1) % 2: continue
        wr = [0]*R
        for i in range(R): wr[sg[i]] = eps[sg[i]]*RHO[i]
        Wel.append((s, tuple(wr)))
print("W(D6) elements:", len(Wel))
assert len(Wel) == 23040
# sanity: identity present with sign +1 and w rho = rho
assert (1, RHO) in Wel

def racah(lam):
    base = tuple(lam[t] + RHO[t] for t in range(R))
    tot = 0
    for s, wr in Wel:
        m = SYM3.get(tuple(base[t]-wr[t] for t in range(R)))
        if m: tot += s*m
    return tot

RUNS = os.path.join(d, "..", "..", "runs")
BL = pickle.load(open(os.path.join(RUNS, "n12_sym3_blocks.pkl"), "rb"))
S3 = pickle.load(open(os.path.join(RUNS, "n12_sym3_char.pkl"), "rb"))
print(f"\nrecomputing all {len(BL)} block multiplicities by Racah")
bad = []
tot = 0
for lam in sorted(BL, key=lambda l: S3[l]):
    c = racah(lam); tot += c
    flag = "" if c == BL[lam] else "   <-- DISAGREE"
    if c != BL[lam]: bad.append((lam, c, BL[lam]))
    print(f"  {str(lam):24s} wtspace {S3[lam]:>7,}  racah {c:>3d}  cached {BL[lam]:>3d}{flag}")
print(f"\n{len(BL)} blocks, {len(bad)} disagreements, total multiplicity "
      f"{tot} (cached {sum(BL.values())})")

# is the block LIST complete?  every dominant weight of Sym^3 with nonzero
# multiplicity must appear in BL, or covariants are being missed outright.
dom = [w for w in SYM3 if all(w[t] >= w[t+1] for t in range(R-1)) and w[R-2] >= -w[R-1]]
print(f"dominant weights carried by Sym^3: {len(dom):,}")
extra = []
for w in dom:
    if w in BL: continue
    c = racah(w)
    if c: extra.append((w, c))
print(f"dominant weights with nonzero multiplicity MISSING from the block list: "
      f"{len(extra)}")
for x in sorted(extra)[:20]: print("   MISSING", x)
