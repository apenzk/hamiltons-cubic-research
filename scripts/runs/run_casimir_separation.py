"""The n=5 block table and its Casimir separation, in closed form.

Derivation, checked here rather than established here.  For B_2 = so(5) with
rho = (3/2,1/2), c_2(lam) = <lam,lam+2rho> = lam1(lam1+3) + lam2(lam2+1), and
the Weyl dimension formula is a product of four linear factors.  So the whole
24-block table -- dimensions, multiplicities, Casimir spectrum, collisions --
is arithmetic on the highest weights, with no linear algebra on the 7770.

The separation question has a general answer.  The higher Casimirs have
Harish-Chandra images whose leading terms are the power sums p_{2k}(ell),
ell_i = lam_i + rho_i.  For a dominant weight ell is strictly decreasing, and
strictly positive for B_r, so p_2..p_{2r} determine {ell_i^2} as a multiset via
the elementary symmetric functions, hence determine lam.  Separation is
therefore forced, not measured.
"""
from fractions import Fraction as F

rhoB2 = (F(3,2), F(1,2))
ell   = lambda l: tuple(F(a)+b for a, b in zip(l, rhoB2))
c2    = lambda l: l[0]*(l[0]+3) + l[1]*(l[1]+1)
pk    = lambda l, k: sum(x**k for x in ell(l))
dim   = lambda l: (l[0]-l[1]+1)*(l[0]+l[1]+2)*(2*l[0]+3)*(2*l[1]+1)//6

# multiplicities as recorded; the twelve mult-1 blocks are SOLVED for below
NAMED = {(4,2):4, (2,2):4, (3,2):3,
         (5,2):2, (4,3):2, (4,4):2, (4,1):2, (3,1):2, (4,0):2, (2,1):2, (3,0):2, (2,0):2}
SPECTRUM = [0,4,10,12,16,18,20,24,28,30,30,34,40,40,42,46,48,52,54,60,60,66,74,96]

print("=== the twelve multiplicity-1 blocks, solved from the recorded spectrum ===")
# lam1 <= 6: Sym^3 of a weight with lam1 = 2.  Enumerate and match what is left.
allw = [(a,b) for a in range(7) for b in range(a+1)]
left = list(SPECTRUM)
for l, m in NAMED.items():
    left.remove(c2(l))
mult1 = []
for c in left:
    cands = [l for l in allw if c2(l) == c and l not in mult1 and NAMED.get(l, 0) == 0]
    assert cands, (c, "no candidate")   # c2 = 60 carries TWO mult-1 blocks
    mult1.append(cands[0])
    print(f"  c2 = {c:3d}  ->  {cands[0]}  dim {dim(cands[0])}")

BLOCKS = {**NAMED, **{l: 1 for l in mult1}}
tot = sum(m*dim(l) for l, m in BLOCKS.items())
print(f"\n  24 blocks: {len(BLOCKS)==24}   sum m*dim = {tot}  (= 7770: {tot==7770})")
print(f"  multiplicities sum to {sum(BLOCKS.values())} (= 41)"
      f"   unknowns {sum(m*(m+1)//2 for m in BLOCKS.values())} (= 65)")
print(f"  Casimir spectrum reproduced: {sorted(c2(l) for l in BLOCKS)==SPECTRUM}")
vals = [c2(l) for l in BLOCKS]
print(f"  c2 takes {len(set(vals))} distinct values across {len(vals)} blocks"
      f"   (24 less the three colliding pairs: {len(set(vals))==21})")

print("\n=== the three collisions, separated exactly by p_4 ===")
by_c = {}
for l in BLOCKS: by_c.setdefault(c2(l), []).append(l)
for c, ls in sorted(by_c.items()):
    if len(ls) > 1:
        p4 = [pk(l, 4) for l in ls]
        print(f"  c2 = {c:2d}: {ls}   p4 = {[str(x) for x in p4]}   split: {len(set(p4))==2}")

print("\n=== and it is forced, not measured ===")
print(f"  every block has ell_1 > ell_2 > 0: "
      f"{all(ell(l)[0] > ell(l)[1] > 0 for l in BLOCKS)}")
print(f"  (p2,p4) distinct across all 24: "
      f"{len({(pk(l,2),pk(l,4)) for l in BLOCKS})==24}")
print("  e1 = p2, e2 = (p2^2-p4)/2 in the variables ell_i^2 recover the multiset")
print("  {ell_1^2, ell_2^2}; ell strictly decreasing and positive then fixes lam.")

print("\n=== n = 12: D_6, rho = (5,4,3,2,1,0), so ell_6 = lam_6 ===")
print("  SIX invariants, not five.  p_2..p_10 are p_1..p_5 in the variables")
print("  ell_i^2, so Newton returns e_1..e_5 and stops; e_6 = Pf^2 is")
print("  independent, and what five power sums leave is a one-parameter family")
print("  rather than a sign.  With p_2..p_12 every e_1..e_6 is recovered, the")
print("  multiset {ell_i^2} is determined outright, and that multiset IS the")
print("  O(12) label since ell_1 > ... > ell_5 > |ell_6| >= 0 fixes lam_6 >= 0.")
print("  Both rings need six: W(D_6) takes p_2..p_10 plus Pf, O(12) takes")
print("  p_2..p_12.  They differ in the sixth element alone, and p_12 = Pf^2 is")
print("  the one that keeps the six chirality pairs fused rather than split.")
print("  (Reviewers 177 and 178, each refuting the five-Casimir argument.)")

print("\n=== the orbit constraint, checkable for the first time ===")
# Reviewer 174: Stab_{O(5)}(W_0) branches so that dim V_lam^H = 1 iff lam_2 is
# even, 0 otherwise.  Each such block loses one multiplicity to sigma(W_0) = 0.
# The twelve multiplicity-1 blocks were unnamed until this cycle, so this is the
# first time the consequence can be summed rather than asserted.
even = {l: m for l, m in BLOCKS.items() if l[1] % 2 == 0}
print(f"  blocks with lam_2 even: {len(even)} (174 says 16: {len(even)==16})")
print(f"  their dimensions sum to {sum(dim(l) for l in even)} "
      f"(174's measured span 3570: {sum(dim(l) for l in even)==3570})")

surv = {l: (m-1 if l in even else m) for l, m in BLOCKS.items()}
surv = {l: m for l, m in surv.items() if m > 0}
unk  = sum(m*(m+1)//2 for m in surv.values())
from collections import Counter
shape = Counter(surv.values())
print(f"  surviving multiplicities: {sum(surv.values())}  (65 -> {unk} unknowns)")
print(f"  shape: {shape[3]} 3x3, {shape[2]} 2x2, {shape[1]} scalars"
      f"   -- record says two 3x3, five 2x2, nine scalars:"
      f" {(shape[3],shape[2],shape[1])==(2,5,9)}")
print(f"  blocks that die outright: "
      f"{sorted(l for l in BLOCKS if l in even and BLOCKS[l]==1)}")

print("\n=== and the orbit constraint removes two of the three collisions ===")
dead = {l for l in BLOCKS if l in even and BLOCKS[l] == 1}
for c, ls in sorted(by_c.items()):
    if len(ls) > 1:
        live = [l for l in ls if l not in dead]
        tag = ("GONE -- both blocks die" if not live else
               "GONE -- one block dies" if len(live) == 1 else
               "SURVIVES -- needs the quartic")
        print(f"  c2 = {c:2d}: {ls} -> live {live}   {tag}")
print("  so the quartic is needed for ONE pair, not three.")
