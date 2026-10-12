"""Independent decomposition of Sym^3(V_(2,2)) for B2 = so(5), by characters.

Uses NO part of the record's pipeline: no GENS, no BASIS, no raising operators,
no n5_hw_cache.json.  Only Weyl/Freudenthal machinery for B2.  It settles two
things the shipped scripts assume rather than test:
  * the weight system of Weyl_5 (the record's 35 WWT labels);
  * the block table BLOCKS hardcoded in run_n5_highest_weight.py, INCLUDING
    whether it is complete -- the shipped loop iterates over the lambdas the
    table already lists, so an omitted block cannot be seen by it.
"""
from fractions import Fraction as Fr
from itertools import combinations_with_replacement
from collections import Counter

POS = [(1, -1), (0, 1), (1, 0), (1, 1)]      # positive roots of B2, e-coordinates
A1, A2 = (1, -1), (0, 1)                     # simple roots (long, short)
RHO = (Fr(3, 2), Fr(1, 2))
ip  = lambda x, y: Fr(x[0])*Fr(y[0]) + Fr(x[1])*Fr(y[1])
add = lambda x, y: (x[0]+y[0], x[1]+y[1])
dominant = lambda m: m[0] >= m[1] >= 0
wdom = lambda m: (max(abs(m[0]), abs(m[1])), min(abs(m[0]), abs(m[1])))

def dim_weyl(lam):
    num = den = Fr(1); lr = add(lam, RHO)
    for a in POS: num *= ip(lr, a); den *= ip(RHO, a)
    return num/den

def is_weight(mu, lam):
    """mu is a weight of V_lam iff its dominant conjugate is <= lam (B2 root
    lattice is Z^2, so the coset condition is automatic for integral mu)."""
    d = wdom(mu)
    return lam[0]-d[0] >= 0 and (lam[0]+lam[1])-(d[0]+d[1]) >= 0

_cache = {}
def weights_of(lam):
    """multiplicity of every weight of V_lam, by Freudenthal."""
    if lam in _cache: return _cache[lam]
    lr = add(lam, RHO); n2 = ip(lr, lr)
    layers = {}
    for p in range(0, 2*(lam[0]+lam[1])+2):
        for q in range(0, 2*(lam[0]+lam[1])+2):
            mu = (lam[0]-p, lam[1]+p-q)
            if is_weight(mu, lam): layers.setdefault(p+q, []).append(mu)
    mult = {lam: 1}
    for h in sorted(layers):
        for mu in layers[h]:
            if mu in mult: continue
            d = n2 - ip(add(mu, RHO), add(mu, RHO))
            assert d != 0, (lam, mu)
            s = Fr(0)
            for a in POS:
                k = 1
                while True:
                    nu = (mu[0]+k*a[0], mu[1]+k*a[1])
                    if not is_weight(nu, lam): break
                    s += mult.get(nu, 0)*ip(nu, a); k += 1
            m = 2*s/d
            assert m.denominator == 1 and m >= 0, (lam, mu, m)
            if m: mult[mu] = int(m)
    _cache[lam] = mult
    return mult

LAM = (2, 2)
W = weights_of(LAM)
print(f"V_(2,2): dim by Weyl dimension formula   = {dim_weyl(LAM)}")
print(f"         dim by weight multiplicities    = {sum(W.values())}")
print(f"         weight multiplicities: {dict(sorted(W.items()))}")

# ---- cross-check against the record's WWT (the ONE place the cache is read) ----
import json, os
CACHE = "scripts/runs/n5_hw_cache.json"
if os.path.exists(CACHE):
    WWT = [tuple(w) for w in json.load(open(CACHE))["weights"]]
    rec = Counter(WWT)
    print(f"\n  record's 35 weight labels agree with the character theory: "
          f"{dict(rec) == {k: v for k, v in W.items()}}")

# ---- Sym^3 weight multiplicities ----
flat = [w for w, m in sorted(W.items()) for _ in range(m)]
assert len(flat) == 35, len(flat)
S3 = Counter()
for t in combinations_with_replacement(range(35), 3):
    S3[(flat[t[0]][0]+flat[t[1]][0]+flat[t[2]][0],
        flat[t[0]][1]+flat[t[1]][1]+flat[t[2]][1])] += 1
print(f"\nSym^3: total weight count = {sum(S3.values())} (7770: {sum(S3.values())==7770})")

# ---- peel off irreducibles, highest dominant weight first ----
rem = dict(S3); decomp = Counter()
while any(v for v in rem.values()):
    doms = [m for m, v in rem.items() if v > 0 and dominant(m)]
    lam = max(doms, key=lambda m: (m[0]+m[1], m[0]))
    mult = rem[lam]; decomp[lam] += mult
    for mu, c in weights_of(lam).items(): rem[mu] = rem.get(mu, 0) - mult*c
    rem = {k: v for k, v in rem.items() if v}
    assert all(v >= 0 for v in rem.values()), ("negative multiplicity", lam)

tot = sum(decomp.values())
print(f"\nSym^3(V_(2,2)) = {tot} irreducible summands over {len(decomp)} distinct lambdas")
print(f"dimension check: {sum(int(dim_weyl(l))*m for l, m in decomp.items())} (7770)")
for l in sorted(decomp, key=lambda l: (-(l[0]+l[1]), -l[0])):
    print(f"   V_{l}  dim {int(dim_weyl(l)):5d}   multiplicity {decomp[l]}")

BLOCKS = {(4,2):4, (2,2):4, (3,2):3,
          (5,2):2, (4,3):2, (4,4):2, (4,1):2, (3,1):2, (4,0):2, (2,1):2, (3,0):2, (2,0):2,
          (0,0):1, (1,0):1, (3,3):1, (5,0):1, (5,1):1, (5,3):1,
          (6,0):1, (5,4):1, (6,2):1, (6,3):1, (6,4):1, (6,6):1}
print(f"\nrecord's hardcoded BLOCKS: {sum(BLOCKS.values())} summands, {len(BLOCKS)} lambdas")
print(f"  truth minus table: {{l: m for ...}} -> "
      f"{ {l: m for l, m in decomp.items() if BLOCKS.get(l,0) != m} }")
print(f"  table minus truth: { {l: m for l, m in BLOCKS.items() if decomp.get(l,0) != m} }")
print(f"  TABLE CORRECT AND COMPLETE: {dict(decomp) == BLOCKS}")
