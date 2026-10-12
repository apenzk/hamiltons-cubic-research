"""Reviewer 199: the negative control the cross-weight sweep never had.

Claim under test: `assert cross == 0` in run_n5_assemble.py can fail.

The sweep calls ip3, ip3 calls sym3_ip, and sym3_ip reads H.  H is built in
run_n5_evaluate.py under `if WT[a] != WT[b]: continue`, so it holds no
cross-weight key at all, and sym3_ip breaks out of a bijection the moment
H.get returns None.  So ip3 between two WEIGHT-HOMOGENEOUS vectors of distinct
Sym^3 weight is a sum of empty bijection sums, whatever the vectors are.

Three tests:
  1. exhaustive over H's keys -- no cross-weight key exists;
  2. exhaustive over every ordered pair of Sym^3 monomials of distinct weight
     drawn from a random sample -- sym3_ip returns exactly (0, 0);
  3. THE CONTROL -- the shipped sweep, verbatim, on a basis of random garbage
     that is merely weight-homogeneous.  If cross is still 0 there, the assert
     has no error state on homogeneous input.
"""
import importlib.util, sys, os, random
from fractions import Fraction as Fr, Fraction as F
d = os.path.dirname(os.path.abspath(__file__))
def load(name, quiet=True):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(d, name))
    m = importlib.util.module_from_spec(sp)
    if quiet:
        o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m)
    if quiet: sys.stdout = o
    return m

hw = load("run_n5_highest_weight.py")
MONO, WWT = hw.MONO, hw.WWT
G = hw.G
def mwt(i):
    a, b, c = MONO[i]
    return (WWT[a][0]+WWT[b][0]+WWT[c][0], WWT[a][1]+WWT[b][1]+WWT[c][1])
ev = load("run_n5_evaluate.py")
H, sym3_ip, cmul, cadd, cconj = ev.H, ev.sym3_ip, ev.cmul, ev.cadd, ev.cconj
WT = ev.WT

# ---- to_p / sym3_ip_p / ip3, lifted VERBATIM out of the file under review ----
src = open(os.path.join(d, "base_assemble.py")).read()
a = src.index("PRIME = 1000033"); b = src.index("def ip3_exact")
exec(compile(src[a:b], "base_assemble.py:PRIME..ip3", "exec"))
print(f"lifted the arithmetic verbatim: PRIME={PRIME}, IMOD={IMOD}")

# ---- 1. H has no cross-weight key ----
bad = [(x, y) for (x, y) in H if WT[x] != WT[y]]
print(f"\n1. H keys with WT[a] != WT[b]: {len(bad)} of {len(H)}   "
      f"(H is BUILT under `if WT[a] != WT[b]: continue`)")

# ---- 2. sym3_ip is identically zero across Sym^3 weights ----
random.seed(199)
smp = random.sample(range(len(MONO)), 400)
n = nz = 0
for i in smp:
    for j in smp:
        if mwt(i) == mwt(j): continue
        n += 1
        if sym3_ip(MONO[i], MONO[j]) != (Fr(0), Fr(0)): nz += 1
print(f"2. sym3_ip on {n:,} cross-weight monomial pairs: {nz} nonzero")

# ---- 3. the shipped sweep on RANDOM weight-homogeneous garbage ----
MONS = {}
for i in range(len(MONO)): MONS.setdefault(mwt(i), []).append(i)
ws = [w for w in MONS if len(MONS[w]) >= 3]
random.shuffle(ws); ws = ws[:40]
c0 = []
byw_ = {}
for w in ws:
    for _ in range(4):                       # 4 garbage vectors per weight
        v = {k: G(F(random.randint(-9, 9)), F(random.randint(-9, 9)))
             for k in random.sample(MONS[w], min(3, len(MONS[w])))}
        byw_.setdefault(w, []).append(len(c0)); c0.append(v)
print(f"3. control basis: {len(c0)} random vectors over {len(ws)} weights, "
      f"each homogeneous, none of them an adapted vector")
cross = 0
_rnd = random
_rnd.seed(11)
pairs = [(x, y) for x in range(len(ws)) for y in range(x+1, len(ws))]
_rnd.shuffle(pairs)
for x, y in pairs[:60]:                      # the shipped sampling, verbatim
    for a_ in byw_[ws[x]][:1]:
        for b_ in byw_[ws[y]][:1]:
            if ip3(c0[a_], c0[b_]): cross += 1
print(f"   shipped sweep (60 pairs, one vector each) on the garbage: cross = {cross}")
full = 0
for x in range(len(ws)):
    for y in range(x+1, len(ws)):
        for a_ in byw_[ws[x]]:
            for b_ in byw_[ws[y]]:
                if ip3(c0[a_], c0[b_]): full += 1
tot = sum(len(byw_[ws[x]])*len(byw_[ws[y]])
          for x in range(len(ws)) for y in range(x+1, len(ws)))
print(f"   EXHAUSTIVE over all {tot:,} cross-weight entries of the garbage: {full}")
print("\nVERDICT: the check returns 0 on a basis with no mathematical content,"
      "\n         so its only reachable error state is non-homogeneity, which"
      "\n         line 341 asserts separately and with certainty.")
