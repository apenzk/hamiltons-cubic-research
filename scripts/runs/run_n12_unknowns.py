"""The n=12 block arithmetic, checked against reviewer 177's decomposition.

Item 3c states its SDP as '477 unknowns' over '71 blocks' with '184
multiplicities' and a largest block of size 9.  Those had never been verified
here.  177 committed its independent D6 decomposition, so the check is free.

An O(12)-block is an SO(12)-constituent when lam_6 = 0, and the FUSION of the
+-lam_6 pair otherwise; the O-multiplicity is that of either half.
"""
import json, os
d = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                 "..", "reviewers", "r177", "decomp_D6.json")
rows = json.load(open(d))
C = 1640*1639*1638//6

print(f"SO(12) constituents: {len(rows)}   sum m*dim = {sum(m*x for _,m,x in rows)}")
print(f"  = C(1640,3) = {C}: {sum(m*x for _,m,x in rows) == C}")

O = {}
for lam, m, dim in rows:
    key = tuple(lam[:-1]) + (abs(lam[-1]),)
    if key in O:
        assert O[key][0] == m
        O[key] = (m, O[key][1] + dim, True)
    else:
        O[key] = (m, dim, False)

pairs = sorted(k for k, v in O.items() if v[2])
print(f"\nO(12) blocks: {len(O)} (71: {len(O)==71})   "
      f"chirality pairs: {len(pairs)} (6: {len(pairs)==6})")
for k in pairs: print(f"    {k}  mult {O[k][0]}  dim {O[k][1]}")
print(f"  77 = 65 + 2*6: {len(rows) == (len(O)-len(pairs)) + 2*len(pairs)}")

tot_m = sum(v[0] for v in O.values())
unk   = sum(v[0]*(v[0]+1)//2 for v in O.values())
print(f"\n  multiplicities  {tot_m}  (184: {tot_m==184})")
print(f"  unknowns        {unk}  (477: {unk==477})")
print(f"  largest block   {max(v[0] for v in O.values())}  (9)")
print(f"  sum m*dim       {sum(v[0]*v[1] for v in O.values())}  (= C(1640,3): "
      f"{sum(v[0]*v[1] for v in O.values()) == C})")

print("\n=== the orbit cut at n = 12, from the spherical criterion ===")
# O(12)/(O(6) x O(6)) is a SYMMETRIC pair -- the real Grassmannian -- so
# Cartan-Helgason caps dim V_lam^H at 1, the same cap as at n=5, and the
# spherical labels are exactly those with ALL PARTS EVEN.  (Reviewers 179, 180,
# independently; the record's 'a larger H has fewer invariants' is not the
# mechanism, since the cap is 1 in both cases.)
even = {k: v for k, v in O.items() if all(x % 2 == 0 for x in k)}
print(f"  spherical blocks (all parts even): {len(even)} of {len(O)}"
      f"   against 16 of 24 at n=5")
surv = {k: (v[0]-1 if k in even else v[0]) for k, v in O.items()}
surv = {k: m for k, m in surv.items() if m > 0}
unk2 = sum(m*(m+1)//2 for m in surv.values())
print(f"  477 -> {unk2} unknowns, a {100*(477-unk2)/477:.1f}% cut"
      f"   against 65 -> 36 at n=5, a {100*(65-36)/65:.1f}% cut")
print(f"  multiplicities {tot_m} -> {sum(surv.values())}")
print("  CONDITIONAL: this assumes every evaluation map is nonzero, which at")
print("  n=5 took reviewer 178's mod-p rank argument.  Unproved at n=12, so")
print(f"  {unk2} is a LOWER bound on the unknowns.")
