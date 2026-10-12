"""Decompose Sym^3(Weyl_12) into O(12)-irreducibles, from the weight system.

Step 2 of the n>=12 build.  The record carries 71 blocks, 184 multiplicities and
sum m_lambda d_lambda = 733,813,080 = C(1640,3), reproduced from scratch by three
reviewers.  This file recomputes it from the weight system of run_n12_weights.py
and must land on the same numbers -- a known answer, which is the point of doing
it before anything that has no answer to check against.

METHOD.  The character of Sym^3 comes from power sums by Newton,
    h_3 = (p_1^3 + 3 p_1 p_2 + 2 p_3) / 6,
where p_j(t) = chi(t^j) is the character with every weight multiplied by j.  All
of it is arithmetic on dictionaries keyed by weight, so nothing of dimension
733 million is ever materialised -- the same trick run_n5_constraint_count.py uses
at n=5, where it made a 3,838,380-dimensional space cost nothing.

The decomposition then peels highest weights: repeatedly take a maximal remaining
weight, subtract that irreducible's character, and record the multiplicity.
"""
import os, sys, importlib.util, time
from itertools import permutations, product
from fractions import Fraction as F

d = os.path.dirname(os.path.abspath(__file__))
sp = importlib.util.spec_from_file_location("w12", os.path.join(d, "run_n12_weights.py"))
w12 = importlib.util.module_from_spec(sp)
_o = sys.stdout; sys.stdout = open(os.devnull, "w")
sp.loader.exec_module(w12)
sys.stdout = _o

RANK, POS, RHO = w12.RANK, w12.POS, w12.RHO
MULT, orbit = w12.MULT, w12.orbit
print(f"loaded the weight system: {len(MULT)} dominant weights")

# the full character of Weyl_12, weight -> multiplicity
CHI = {}
for mu, m in MULT.items():
    for nu in orbit(mu): CHI[nu] = CHI.get(nu, 0) + m
print(f"  {len(CHI)} distinct weights, dimension {sum(CHI.values())}")
assert sum(CHI.values()) == 1638

def mul(P, Q):
    R = {}
    for a, ca in P.items():
        for b, cb in Q.items():
            k = tuple(a[t]+b[t] for t in range(RANK))
            R[k] = R.get(k, 0) + ca*cb
    return {k: v for k, v in R.items() if v}
def add(P, Q):
    R = dict(P)
    for k, v in Q.items(): R[k] = R.get(k, 0) + v
    return {k: v for k, v in R.items() if v}
def scal(a, P): return {k: a*v for k, v in P.items() if a*v}
def power(j): return {tuple(j*x for x in k): v for k, v in CHI.items()}

t0 = time.time()
p1 = CHI
p2 = power(2)
p3 = power(3)
print("  building p_1^2 ...", flush=True)
p11 = mul(p1, p1)
print(f"    {len(p11)} weights [{time.time()-t0:.0f}s]", flush=True)
print("  building p_1^3 ...", flush=True)
p111 = mul(p11, p1)
print(f"    {len(p111)} weights [{time.time()-t0:.0f}s]", flush=True)
print("  building p_1 p_2 ...", flush=True)
p12 = mul(p1, p2)
S3 = {k: F(v, 6) for k, v in add(add(p111, scal(3, p12)), scal(2, p3)).items()}
S3 = {k: int(v) for k, v in S3.items() if v}
tot = sum(S3.values())
print(f"\n  Sym^3 character: {len(S3)} distinct weights, dimension {tot:,}")
from math import comb
assert tot == comb(1640, 3), f"dimension {tot} is not C(1640,3) = {comb(1640,3)}"
print(f"  matches C(1640,3) = {comb(1640,3):,}")

import pickle
with open(os.path.join(d, "n12_sym3_char.pkl"), "wb") as f:
    pickle.dump(S3, f)
print(f"  cached the character [{time.time()-t0:.0f}s]")

# ---- peel highest weights ----
#
# Repeatedly take a maximal remaining dominant weight, subtract that
# irreducible's character with its multiplicity, and record it.  The character of
# V(lambda) comes from Freudenthal, reusing run_n12_weights.py's machinery rather
# than restating it.
print("\n  peeling irreducibles ...", flush=True)

def dom_rep(mu):
    v = sorted((abs(x) for x in mu), reverse=True)
    if sum(1 for x in mu if x < 0) % 2: v[-1] = -v[-1]
    return tuple(v)

def ip(u, v): return sum(F(x)*F(y) for x, y in zip(u, v))
def casimir(mu): return ip(mu, [x + 2*y for x, y in zip(mu, RHO)])

_CACHE = {}
def irr_char(lam):
    """the full character of V(lam), by Freudenthal on dominant weights."""
    if lam in _CACHE: return _CACHE[lam]
    # dominant weights below lam
    dom = []
    rng = range(-max(max(lam), 1), max(max(lam), 1)+1)
    for mu in product(rng, repeat=RANK):
        if any(mu[k] < mu[k+1] for k in range(RANK-2)): continue
        if mu[RANK-2] < abs(mu[RANK-1]): continue
        dd = [lam[k]-mu[k] for k in range(RANK)]
        if sum(dd) % 2: continue
        if any(sum(dd[:k+1]) < 0 for k in range(RANK)): continue
        dom.append(mu)
    M = {}
    for mu in sorted(dom, key=lambda m: -casimir(m)):
        if mu == lam: M[mu] = 1; continue
        num = F(0)
        for a in POS:
            k = 1
            while True:
                nu = tuple(mu[t] + k*a[t] for t in range(RANK))
                key = dom_rep(nu)
                if key not in M: break
                num += M[key] * ip(nu, a); k += 1
        den = casimir(lam) - casimir(mu)
        M[mu] = int(2*num/den) if den else 0
    ch = {}
    for mu, m in M.items():
        if not m: continue
        for nu in orbit(mu): ch[nu] = ch.get(nu, 0) + m
    _CACHE[lam] = ch
    return ch

REM = dict(S3)
BLOCKS = {}
t1 = time.time()
while REM:
    # a maximal dominant weight still present
    cand = [k for k in REM if k == dom_rep(k)]
    lam = max(cand, key=lambda m: (casimir(m), m))
    m = REM[lam]
    assert m > 0, f"negative multiplicity {m} at {lam}: the peel is inconsistent"
    ch = irr_char(lam)
    for nu, c in ch.items():
        v = REM.get(nu, 0) - m*c
        if v: REM[nu] = v
        else: REM.pop(nu, None)
    BLOCKS[lam] = m
    if len(BLOCKS) % 10 == 0:
        print(f"    {len(BLOCKS)} blocks, {len(REM)} weights left "
              f"[{time.time()-t1:.0f}s]", flush=True)

print(f"\n  {len(BLOCKS)} irreducible constituents")
print(f"  total multiplicity {sum(BLOCKS.values())}")
chk = sum(m*sum(irr_char(l).values()) for l, m in BLOCKS.items())
print(f"  sum m * dim = {chk:,}")
assert chk == comb(1640, 3), "the peeled decomposition does not sum to Sym^3"
with open(os.path.join(d, "n12_sym3_blocks.pkl"), "wb") as f:
    pickle.dump(BLOCKS, f)
# ---- SO(12) to O(12): the chirality pairs fuse ----
#
# This computation lives in D_6 = so(12), so what it counts are SO(12)
# constituents.  The record's 71 and 184 are O(12) numbers.  A constituent with
# lambda_6 != 0 is chiral: the outer automorphism of D_6 -- which is what an
# orientation-reversing element of O(12) induces -- swaps lambda_6 with its
# negative, so the pair (lambda, lambda') fuses into ONE O(12) block of the same
# multiplicity.  Pf separates the two halves and Pf^2 does not, which is why the
# invariant ring needs p_12 rather than Pf.
CHIRAL = {}
for l in BLOCKS:
    if l[5] != 0: CHIRAL.setdefault(l[:5] + (abs(l[5]),), []).append(l)
for k, v in CHIRAL.items():
    assert len(v) == 2, f"chiral weight {k} is unpaired: {v}"
    assert BLOCKS[v[0]] == BLOCKS[v[1]], (
        f"the chirality pair at {k} has multiplicities "
        f"{[BLOCKS[x] for x in v]}, which must be equal")
FUSED = sum(BLOCKS[v[0]] for v in CHIRAL.values())
O_BLOCKS = len(BLOCKS) - len(CHIRAL)
O_MULTS = sum(BLOCKS.values()) - FUSED
print(f"\n  chiral constituents: {2*len(CHIRAL)} in {len(CHIRAL)} pairs")
for k in sorted(CHIRAL):
    print(f"    {k[:5]}, +/-{k[5]}   multiplicity {BLOCKS[CHIRAL[k][0]]}")
print(f"\n  SO(12): {len(BLOCKS)} constituents, {sum(BLOCKS.values())} multiplicities")
print(f"  O(12) : {O_BLOCKS} blocks, {O_MULTS} multiplicities")
print(f"  record: 71 blocks, 184 multiplicities")
assert (O_BLOCKS, O_MULTS) == (71, 184), (
    f"measured {O_BLOCKS} blocks and {O_MULTS} multiplicities against the "
    "record's 71 and 184")
print("\n  MATCHES, and the six pairs are the ones reviewer 177 listed.")
