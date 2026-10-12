"""Reviewer 187, claim 2.  Is the raising-operator check meaningful?

run_n5_highest_weight.py DEFINES the 41 vectors as the joint nullspace of E1C
and E2C acting by raise_mono.  run_n5_cubic_forms.py then reads E1C, E2C and the
vectors from the same cache and applies raise_vec -- the same formula, character
for character -- and reports 41/41 annihilated.  The check re-verifies a
nullspace with the operator that defined it.  It can fail only if the JSON
round-trip corrupts a coefficient.

Below: (i) the two routines are shown to be the same map; (ii) a check on the
same cache that CAN fail -- the block table against the Weyl dimension formula
for B_2, which the cache's own contents must reproduce.
"""
import json, os, sys, difflib
from fractions import Fraction as F

ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..")
HW  = os.path.join(ROOT, "scripts", "runs", "run_n5_highest_weight.py")
CF  = os.path.join(ROOT, "scripts", "runs", "run_n5_cubic_forms.py")
CACHE = os.path.join(ROOT, "scripts", "runs", "n5_hw_cache.json")

def body(path, name):
    src = open(path).read().splitlines()
    i = next(k for k, l in enumerate(src) if l.startswith(f"def {name}"))
    out = []
    for l in src[i+1:]:
        if l and not l[0].isspace(): break
        out.append(l.rstrip())
    return [l for l in out if l.strip() and not l.strip().startswith(('"""', '#'))]

print("=== (i) raise_mono (definer) vs raise_vec (checker) ===")
a, b = body(HW, "raise_mono"), body(CF, "raise_vec")
print("raise_mono (run_n5_highest_weight.py, builds the nullspace):")
for l in a: print("   ", l.strip())
print("raise_vec (run_n5_cubic_forms.py, checks the nullspace):")
for l in b: print("   ", l.strip())
core = lambda ls: [x.strip().replace("ZERO", "G()").replace("co*", "").replace("v", "")
                   for x in ls]
print("\nBoth walk the same three monomial slots, substitute EC[x][t] and sum;")
print("the only differences are the accumulator's zero element and the extra")
print("factor co, which raise_mono folds in through the nullspace solve instead.")
print("=> the annihilation check exercises the JSON round-trip, not the algebra.")

print("\n=== (ii) a check on the same cache that CAN fail ===")
C = json.load(open(CACHE))
BLOCKS = {}
for key, v in C["hw"].items():
    lam = tuple(int(x) for x in key.split(","))
    BLOCKS[lam] = len(v["vecs"])
def dimB2(l):
    a, b_ = F(2*l[0]+3, 2), F(2*l[1]+1, 2)
    d = F(2, 3)*a*b_*(a-b_)*(a+b_)
    assert d.denominator == 1, (l, d)
    return int(d)
tot = sum(m*dimB2(l) for l, m in BLOCKS.items())
print(f"  blocks in the cache: {len(BLOCKS)}, multiplicities summing to "
      f"{sum(BLOCKS.values())}")
print(f"  sum_lambda mult(lambda) * dim V_lambda = {tot}")
print(f"  dim Sym^3(Weyl_5) = C(35+2,3) = {35*36*37//6}")
print(f"  -> {'MATCH' if tot == 35*36*37//6 else 'MISMATCH'}")
print("  This one could have failed: it is the Weyl dimension formula for B_2")
print("  against a table the cache never used, and a single wrong multiplicity")
print("  or a wrong lambda moves the total by at least 1.")

print("\n  perturbation: what a single wrong multiplicity would give")
for l in sorted(BLOCKS)[:4]:
    bad = dict(BLOCKS); bad[l] += 1
    print(f"    mult{l} -> {bad[l]}: total {sum(m*dimB2(k) for k, m in bad.items())}"
          f" (off by {dimB2(l)})")

print("\n=== (iii) the weights the cache records must be consistent with lambda ===")
WWT = [tuple(w) for w in C["weights"]]
from itertools import combinations_with_replacement
MONO = list(combinations_with_replacement(range(35), 3))
bad = 0; checked = 0
for key, v in C["hw"].items():
    lam = tuple(int(x) for x in key.split(","))
    for col in v["cols"]:
        a_, b_, c_ = MONO[col]
        w = tuple(WWT[a_][k]+WWT[b_][k]+WWT[c_][k] for k in (0, 1))
        checked += 1
        if w != lam: bad += 1
print(f"  every support monomial of every hw vector carries weight lambda: "
      f"{checked-bad}/{checked}")
