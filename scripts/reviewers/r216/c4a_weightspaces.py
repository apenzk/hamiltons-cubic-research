"""r216, claim 4a.  dim (Sym^3 Weyl_12)_lambda, independently of Freudenthal.

The author's number comes from a Freudenthal weight system, Weyl-group orbits and
a Newton power-sum character, then a peel.  This file reaches the same quantity
along a route that shares none of those steps:

  * the 12 weights of C^12 under the so(12) Cartan are +-e_1..+-e_6;
  * Weyl_12 is the GL(12) Schur functor S_(2,2) with the O(12) traces removed.
    Littlewood's restriction rule with beta over even-row partitions gives
    S_(2,2) = W_(2,2) + W_(2) + W_(0), so
        char Weyl_12 = s_22 - (h_2 - 1) - 1 = s_22 - h_2,
    and Jacobi-Trudi gives s_22 = h_2^2 - h_3 h_1 -- symmetric functions only, no
    Lie theory at all;
  * dim Sym^3(V)_lambda = (A_1 + 3 A_2 + 2 A_3)/6 with A_j the coefficient of
    lambda in p_1^3, p_1 p_2, p_3.
"""
import pickle, os, sys
from collections import defaultdict
from itertools import combinations_with_replacement as cwr

R = 6
def e(i, s):
    v = [0]*R; v[i] = s; return tuple(v)
X = [e(i, s) for i in range(R) for s in (1, -1)]          # the 12 weights of C^12
assert len(X) == 12

def h(k):
    d = defaultdict(int)
    for c in cwr(X, k):
        d[tuple(sum(t) for t in zip(*c))] += 1
    return dict(d)

def mul(P, Q):
    d = defaultdict(int)
    for a, ca in P.items():
        for b, cb in Q.items():
            d[tuple(a[t]+b[t] for t in range(R))] += ca*cb
    return {k: v for k, v in d.items() if v}
def sub(P, Q):
    d = defaultdict(int, P)
    for k, v in Q.items(): d[k] -= v
    return {k: v for k, v in d.items() if v}

h1, h2, h3 = h(1), h(2), h(3)
s22 = sub(mul(h2, h2), mul(h3, h1))
assert sum(s22.values()) == 1716, sum(s22.values())
CHI = sub(s22, h2)
print(f"char Weyl_12 : {len(CHI)} distinct weights, dimension {sum(CHI.values())}")
assert sum(CHI.values()) == 1638
assert all(v > 0 for v in CHI.values())

# cross-check against the author's weight system if it is loadable
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs"))

C2 = mul(CHI, CHI)
P2 = {tuple(2*x for x in k): v for k, v in CHI.items()}
P3 = {tuple(3*x for x in k): v for k, v in CHI.items()}
print(f"  |chi^2| = {len(C2)}")

def dim_sym3(lam):
    A1 = sum(c*C2.get(tuple(lam[t]-w[t] for t in range(R)), 0) for w, c in CHI.items())
    A2 = sum(c*P2.get(tuple(lam[t]-w[t] for t in range(R)), 0) for w, c in CHI.items())
    A3 = P3.get(lam, 0)
    n, r = divmod(A1 + 3*A2 + 2*A3, 6)
    assert r == 0, (lam, A1, A2, A3)
    return n

Z = (0,)*R
print(f"\nCLAIM 4a: dim (Sym^3 Weyl_12)_0 = {dim_sym3(Z):,}   (author: 635,220)")

# the whole table over the author's 77 block highest weights
d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
B = pickle.load(open(os.path.join(d, "n12_sym3_blocks.pkl"), "rb"))
S3 = pickle.load(open(os.path.join(d, "n12_sym3_char.pkl"), "rb"))
bad = []
mine = {}
for l in B:
    mine[l] = dim_sym3(l)
    if mine[l] != S3[l]: bad.append((l, mine[l], S3[l]))
print(f"  77 block weights: {len(bad)} disagreements with the cached character")
vals = sorted(mine.values(), reverse=True)
print(f"  largest {vals[0]:,}   median {vals[len(vals)//2]:,}   smallest {vals[-1]:,}")
print(f"  above 10,000 {sum(1 for v in vals if v > 10000)}   total {sum(vals):,}")
print(f"  total over the 76 non-trivial blocks: {sum(vals)-mine[Z]:,}")
print(f"  largest non-trivial: {vals[1]:,}")
print(f"  dim Sym^3 = {sum(CHI.values())*(sum(CHI.values())+1)*(sum(CHI.values())+2)//6:,}")
if bad:
    for x in bad[:10]: print("   DISAGREE", x)
