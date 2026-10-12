"""r215 claim 3: the SO(12) -> O(12) fusion, from my own Racah blocks.

Also tests the consequences of the Newell-Littlewood row/column bound, which is
what rules out det-twisted O(12) labels and is therefore what makes 71 a number
the SO(12) data can determine at all."""
import os, pickle
from fractions import Fraction as F
SC = "/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad"
BL = pickle.load(open(os.path.join(SC, "r215_blocks.pkl"), "rb"))
AUT = pickle.load(open(os.path.join(SC, "authorrun", "n12_sym3_blocks.pkl"), "rb"))
print("my Racah blocks == the file's peel:", BL == AUT)

CH = {}
for l in BL:
    if l[5] != 0: CH.setdefault(l[:5] + (abs(l[5]),), []).append(l)
print(f"\nchiral constituents (lambda_6 != 0): {sum(len(v) for v in CH.values())} in {len(CH)} classes")
for k in sorted(CH):
    v = CH[k]
    print(f"  {k[:5]} +/-{k[5]}   members {sorted(v)}   multiplicities {[BL[x] for x in v]}"
          f"   {'PAIRED' if len(v)==2 and BL[v[0]]==BL[v[1]] else 'UNPAIRED/UNEQUAL'}")

r177 = [((2,2,2,2,2),2), ((3,3,2,2,1),1), ((4,4,1,1,1),1),
        ((3,2,2,1,1),1), ((4,2,1,1,1),1), ((2,2,1,1,1),1)]
mine = {k[:5]: k[5] for k in CH}
print("\nreviewer 177's six pairs, against mine:")
ok = True
for head, tail in r177:
    got = mine.get(head)
    m = BL[head + (tail,)] if head + (tail,) in BL else None
    line = f"  ({','.join(map(str,head))},+/-{tail})  in my list: {got == tail}  multiplicity {m}"
    print(line)
    ok = ok and got == tail and m is not None
print("  set of six identical:", set(mine.items()) == set((h, t) for h, t in r177), " all found:", ok)

FUSED = sum(BL[v[0]] for v in CH.values())
print(f"\nSO(12): {len(BL)} constituents, {sum(BL.values())} multiplicities")
print(f"O(12) : {len(BL)-len(CH)} blocks, {sum(BL.values())-FUSED} multiplicities")
print(f"multiplicity carried by the six pairs (one copy each): {FUSED}"
      f"  -> 191 - {FUSED} = {191-FUSED}")

# --- Newell-Littlewood consequences.  [2,2] x [2,2] x [2,2] over O(12):
#     l(lambda) <= 6, lambda_1 <= 6, |lambda| <= 12 and even.
print("\nNewell-Littlewood predictions for constituents of [2,2]^{x3}:")
mx_row = max(sum(1 for x in l if x != 0) for l in BL)
mx_col = max(max(abs(x) for x in l) for l in BL)
mx_sz  = max(sum(abs(x) for x in l) for l in BL)
odd    = [l for l in BL if sum(abs(x) for x in l) % 2]
print(f"  rows  l(lambda) <= 6 : max observed {mx_row}   {'ok' if mx_row <= 6 else 'VIOLATED'}")
print(f"  cols  lambda_1 <= 6  : max observed {mx_col}   {'ok' if mx_col <= 6 else 'VIOLATED'}")
print(f"  size  |lambda| <= 12 : max observed {mx_sz}    {'ok' if mx_sz <= 12 else 'VIOLATED'}")
print(f"  size even            : odd ones {odd}")
print(f"  constituents attaining 6 rows: {sorted(l for l in BL if sum(1 for x in l if x != 0) == 6)}")
print(f"  trivial block multiplicity (cubic invariants): {BL[(0,)*6]}")

# --- dimensions of the six chiral constituents, against r177's table
POS = []
for i in range(6):
    for j in range(i+1, 6):
        a=[0]*6; a[i]=1; a[j]=-1; POS.append(tuple(a))
        b=[0]*6; b[i]=1; b[j]=1;  POS.append(tuple(b))
RHO = tuple(F(5-k) for k in range(6))
def ip(u,v): return sum(F(x)*F(y) for x,y in zip(u,v))
def wdim(l):
    n=d=F(1)
    for a in POS:
        n*=ip([x+y for x,y in zip(l,RHO)],a); d*=ip(RHO,a)
    return n/d
r177dim = {(2,2,2,2,2,2):28314, (3,3,2,2,1,1):2814669, (4,4,1,1,1,1):4679675,
           (3,2,2,1,1,1):462462, (4,2,1,1,1,1):750750, (2,2,1,1,1,1):21450}
print("\ndimensions of the six chiral halves, against r177's table:")
for l, d0 in sorted(r177dim.items()):
    w = wdim(l)
    print(f"  {l}: Weyl formula {int(w):,}   r177 {d0:,}   {'match' if w == d0 else 'MISMATCH'}")
