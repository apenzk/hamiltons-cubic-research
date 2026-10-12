"""Claim 2, at the level of characters: is 'every weight block is square' able to fail?

The shipped check compares, per Sym^3 weight w,
    #monomials of weight w   against   #adapted vectors of weight w.
The second number is, block by block, the Freudenthal multiplicity of w in
V(lambda) times the number of copies.  So squareness is EXACTLY the character
identity  ch Sym^3(V(2,2)) = sum_lambda m_lambda ch V(lambda),  which is the
isotypic decomposition the record already fixed.  Verified here from the raw
weight list, with no adapted vector involved.
"""
import json, itertools, os, sys
from collections import Counter
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from freudenthal_b2 import mults, dimB2

d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
C = json.load(open(os.path.normpath(os.path.join(d, "n5_hw_cache.json"))))
WWT = [tuple(w) for w in C["weights"]]
MONO = list(itertools.combinations_with_replacement(range(35), 3))
MW = Counter(tuple(WWT[a][k]+WWT[b][k]+WWT[c][k] for k in (0, 1)) for a, b, c in MONO)
print(f"Sym^3 monomials {len(MONO)}, distinct weights {len(MW)}, "
      f"largest weight space {max(MW.values())}")

BLOCKS = {(4,2):4, (2,2):4, (3,2):3,
          (5,2):2, (4,3):2, (4,4):2, (4,1):2, (3,1):2, (4,0):2, (2,1):2, (3,0):2, (2,0):2,
          (0,0):1, (1,0):1, (3,3):1, (5,0):1, (5,1):1, (5,3):1,
          (6,0):1, (5,4):1, (6,2):1, (6,3):1, (6,4):1, (6,6):1}
acc = Counter()
for lam, m in BLOCKS.items():
    for w, k in mults(lam).items(): acc[w] += m*k
print(f"decomposition total {sum(acc.values())} (7770: {sum(acc.values())==7770}), "
      f"copies {sum(BLOCKS.values())} (41: {sum(BLOCKS.values())==41})")
bad = [w for w in set(MW) | set(acc) if MW[w] != acc[w]]
print(f"weights where the counts DIFFER: {len(bad)}  -> squareness holds identically: {not bad}")
for w in bad[:10]: print(f"   {w}: monomials {MW[w]} vs vectors {acc[w]}")

# what a mismatch would diagnose: perturb the block table and see the check fire
print("\nnegative controls on the squareness check:")
for name, tweak in (("drop one copy of (4,2)", {(4,2): 3}),
                    ("relabel (6,3) as (6,4)", None),
                    ("drop the trivial block", {(0,0): 0})):
    B = dict(BLOCKS)
    if tweak is None:
        B.pop((6,3)); B[(6,4)] = B.get((6,4), 0) + 1
    else:
        B.update(tweak)
    a2 = Counter()
    for lam, m in B.items():
        for w, k in mults(lam).items(): a2[w] += m*k
    diff = [w for w in set(MW) | set(a2) if MW[w] != a2[w]]
    print(f"  {name}: weights failing squareness {len(diff)}, "
          f"total {sum(a2.values())}")

print("\nmax weight multiplicity, blocks that occur vs blocks that do not:")
for lam in [(6,3),(6,4),(6,6),(6,5),(6,1),(7,4),(7,7)]:
    m = mults(lam)
    tag = "occurs" if lam in BLOCKS else "absent from Sym^3"
    print(f"  V{lam} dim {dimB2(lam):5d}  max weight mult {max(m.values()):3d}   [{tag}]")
