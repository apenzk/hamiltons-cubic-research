"""Reviewer 193.  dim (Sym^k W_5)^{SO(5)} for k = 1..6, from the weights alone.

Method: Brauer / Klimyk alternating sum.  For any finite-dimensional module M of
a semisimple g,  mult_M(V_mu) = sum_{w in Weyl} sign(w) dim M_{w(mu+rho)-rho}.
With mu = 0 this counts invariants.  The weight multiplicities of Sym^k(V) are a
size-k multiset count over the 35 weights of W_5, done by a small DP -- nothing
of dimension 3838380 is materialised.

This is an INDEPENDENT route to the 14 the plan derives by Weyl integration in
Laurent polynomials, and to the "trivial multiplicity in Sym^3 is 1" the
trivial-block check in run_n5_assemble.py rests on.
"""
import json, os, itertools
from collections import defaultdict
from fractions import Fraction as F

d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
C = json.load(open(os.path.join(d, "n5_hw_cache.json")))
WT = [tuple(w) for w in C["weights"]]
assert len(WT) == 35

# --- the weight system must be Weyl-invariant, or the labels are not eps-coords
from collections import Counter
cnt = Counter(WT)
WEYL = []
for perm in itertools.permutations(range(2)):
    for s in itertools.product((1, -1), repeat=2):
        sgn = (1 if perm == (0, 1) else -1) * s[0] * s[1]
        WEYL.append((perm, s, sgn))
def act(w, v):
    perm, s, _ = w
    return (s[0]*v[perm[0]], s[1]*v[perm[1]])
inv = all(Counter(act(w, v) for v in WT) == cnt for w in WEYL)
print(f"weight system Weyl(B2)-invariant: {inv}   (must be True)")
print(f"highest weight present: {(2,2) in cnt}, its multiplicity {cnt[(2,2)]}")

RHO = (F(3, 2), F(1, 2))
def wrho_minus_rho(w):
    perm, s, _ = w
    v = (s[0]*RHO[perm[0]], s[1]*RHO[perm[1]])
    return (v[0]-RHO[0], v[1]-RHO[1])

# --- weight multiplicities of Sym^k, k = 0..6, by DP over the 35 letters
KMAX = 6
sym = [defaultdict(int) for _ in range(KMAX+1)]
sym[0][(0, 0)] = 1
for a in range(35):
    wa = WT[a]
    # allow 0..KMAX copies of letter a; process letters one at a time
    new = [defaultdict(int) for _ in range(KMAX+1)]
    for k in range(KMAX+1):
        for mu, m in sym[k].items():
            for r in range(0, KMAX-k+1):
                new[k+r][(mu[0]+r*wa[0], mu[1]+r*wa[1])] += m
    sym = new
for k in range(KMAX+1):
    tot = sum(sym[k].values())
    from math import comb
    assert tot == comb(35+k-1, k), (k, tot)
print(f"Sym^k dimensions reproduced for k<=6 (largest {sum(sym[6].values()):,})")

def trivial_mult(M):
    t = 0
    for w in WEYL:
        v = wrho_minus_rho(w)
        if v[0].denominator == 1 and v[1].denominator == 1:
            t += w[2] * M.get((int(v[0]), int(v[1])), 0)
    return t

# self-test: the alternating sum on V(2,2) itself must give 0 invariants
V1 = defaultdict(int)
for v in WT: V1[v] += 1
print(f"\nself-test  dim (W_5)^SO(5) = {trivial_mult(V1)}  (must be 0)")
print("\n k   dim Sym^k W_5      dim (Sym^k W_5)^SO(5)")
for k in range(1, KMAX+1):
    print(f" {k}   {sum(sym[k].values()):>12,}      {trivial_mult(sym[k])}")
print("\nplan.md carries 1,1,4,5,14 for k=2..6 from Weyl integration.")
