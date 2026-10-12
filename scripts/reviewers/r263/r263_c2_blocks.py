"""r263 CLAIM 2 -- does the seed lemma cover all 71 blocks of the n=12 table?

The lemma needs, for label lambda:  |lambda| <= 12,  |lambda| = 12 mod 2,
and V_lambda O(12)-admissible (lambda'_1 + lambda'_2 <= 12).
k = (12-|lambda|)/2 is the number of cup pads.  k = 0 means NO PADDING AT ALL.

The block list is read from the record's own n12_sym3_blocks.pkl (77 so(12)
highest weights, chiral +/- pairs merged to 71 O(12) labels).
"""
import pickle, collections

raw = pickle.load(open('scripts/runs/n12_sym3_blocks.pkl', 'rb'))
print(f"so(12) highest weights in the record's table : {len(raw)}")
print(f"sum of so(12) multiplicities                 : {sum(raw.values())}")

# merge chiral pairs (a1..a5, +/-a6) -> the O(12) label, the partition |a|
o = {}
for hw, m in raw.items():
    key = tuple(abs(x) for x in hw)
    if key in o:
        # chiral partners are the two SO(12) halves of ONE O(12) irrep: same multiplicity,
        # and the O(12) multiplicity is that common value, NOT the sum.
        assert o[key] == m, (key, o[key], m)
    else:
        o[key] = m
print(f"chiral (+/-) SO pairs merged                 : "
      f"{len([k for k in raw if k[-1] < 0])}"
      f"   ({len([k for k in raw if k[-1] < 0 and sum(abs(x) for x in k) == 12])} of them at |lambda|=12)")
print(f"O(12) labels after merging chiral pairs      : {len(o)}")
print(f"sum of O(12) multiplicities                  : {sum(o.values())}")

def conj(lam):
    return tuple(sum(1 for p in lam if p > k) for k in range(lam[0])) if lam and lam[0] else ()

rows = []
for hw, m in o.items():
    lam = tuple(x for x in hw if x)
    s = sum(lam)
    c = conj(lam)
    adm = (c[0] if c else 0) + (c[1] if len(c) > 1 else 0)
    rows.append((s, lam, m, adm, (12 - s) // 2, s % 2 == 0 and s <= 12 and adm <= 12))
rows.sort(key=lambda r: (-r[0], r[1]))

bad = [r for r in rows if not r[5]]
print(f"\nlabels FAILING the lemma's hypotheses        : {len(bad)}  {bad}")

byk = collections.Counter(r[4] for r in rows)
print("\n  |lambda|   k = (12-|lambda|)/2   blocks   multiplicities")
for s in sorted({r[0] for r in rows}, reverse=True):
    sel = [r for r in rows if r[0] == s]
    print(f"     {s:>2}              {(12-s)//2:>2}            {len(sel):>3}        {sum(r[2] for r in sel):>3}")
print(f"\n  TOTAL                            {len(rows):>3}        {sum(r[2] for r in rows):>3}")

k0 = [r for r in rows if r[4] == 0]
print(f"\n  k = 0 (NO PADDING; c_0 = iota_lambda exactly): {len(k0)} blocks, "
      f"{sum(r[2] for r in k0)} multiplicities")
for r in k0:
    print(f"      lambda = {str(r[1]):<26} m = {r[2]}   lambda'_1+lambda'_2 = {r[3]}")

print("\n  widest label (most rows):",
      max(rows, key=lambda r: len(r[1]))[1], " -- rows =",
      len(max(rows, key=lambda r: len(r[1]))[1]))
