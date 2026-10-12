"""Reviewer 199: exact coverage of the witness-based cross-weight sweep.

Counts, per lambda, (a) how many unordered cross-weight Q entries exist in
copy 0, (b) how many the shipped sweep can EVER touch (both indices first in
their weight class), (c) how many it actually computes with pairs[:60].
No sampling: these are exact counts.
"""
import importlib.util, sys, os, pickle
from itertools import combinations_with_replacement
d = os.path.dirname(os.path.abspath(__file__))
sp = importlib.util.spec_from_file_location("hw", os.path.join(d, "run_n5_highest_weight.py"))
hw = importlib.util.module_from_spec(sp)
o = sys.stdout; sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(hw); sys.stdout = o
MONO, WWT = hw.MONO, hw.WWT
def mwt(idx):
    a, b, c = MONO[idx]
    return (WWT[a][0]+WWT[b][0]+WWT[c][0], WWT[a][1]+WWT[b][1]+WWT[c][1])

with open(os.path.join(d, "n5_adapted.pkl"), "rb") as f: raw = pickle.load(f)

import random as _rnd
_rnd.seed(11)                       # the shipped seed, replayed exactly
TOT = REACH = COMP = 0
rows = []
for lam in raw:                     # dict order = the order QB iterates
    c0 = raw[lam][0]
    byw = {}
    for t, v in enumerate(c0):
        if v: byw.setdefault(mwt(max(v)), []).append(t)
    ws = list(byw)
    n = [len(byw[w]) for w in ws]
    S = sum(n)
    tot = (S*S - sum(x*x for x in n))//2          # unordered cross-weight entries
    reach = len(ws)*(len(ws)-1)//2                # both indices first-in-class
    pairs = [(x, y) for x in range(len(ws)) for y in range(x+1, len(ws))]
    _rnd.shuffle(pairs)
    comp = len(pairs[:60])
    rows.append((lam, len(raw[lam]), S, len(ws), tot, reach, comp))
    TOT += tot; REACH += reach; COMP += comp

print(f"{'lambda':>8} {'copies':>6} {'dim':>5} {'#wts':>5} {'cross entries':>14} {'reachable':>10} {'computed':>9}")
for lam, m, S, nw, tot, reach, comp in rows:
    print(f"{str(lam):>8} {m:>6} {S:>5} {nw:>5} {tot:>14,} {reach:>10,} {comp:>9}")
print(f"\nTOTAL cross-weight Q entries in copy 0 across all lambda: {TOT:,}")
print(f"TOTAL reachable by this code at any sample size:           {REACH:,}"
      f"   ({100*REACH/TOT:.4f}%)")
print(f"TOTAL actually computed with pairs[:60]:                   {COMP:,}"
      f"   ({100*COMP/TOT:.6f}%)")
print(f"\nDetection probability for ONE uniformly-placed cross-weight nonzero:"
      f" {COMP/TOT:.3e}")
print(f"Expected number of violations needed for a 50% chance of a hit: "
      f"{0.693*TOT/COMP:,.0f}")
