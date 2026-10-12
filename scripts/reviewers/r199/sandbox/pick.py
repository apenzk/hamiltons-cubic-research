"""Reviewer 199: replay the shipped sweep's seed and name three plant sites."""
import importlib.util, sys, os, pickle, random
d = os.path.dirname(os.path.abspath(__file__))
sp = importlib.util.spec_from_file_location("hw", os.path.join(d, "run_n5_highest_weight.py"))
hw = importlib.util.module_from_spec(sp)
o = sys.stdout; sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(hw); sys.stdout = o
MONO, WWT = hw.MONO, hw.WWT
def mwt(i):
    a,b,c = MONO[i]
    return (WWT[a][0]+WWT[b][0]+WWT[c][0], WWT[a][1]+WWT[b][1]+WWT[c][1])
raw = pickle.load(open(os.path.join(d, "n5_adapted.pkl"), "rb"))

random.seed(11)                          # the shipped seed
COMPUTED = {}
BYWS = {}
for lam in raw:
    c0 = raw[lam][0]
    byw = {}
    for t, v in enumerate(c0):
        if v: byw.setdefault(mwt(max(v)), []).append(t)
    BYWS[lam] = byw
    ws = list(byw)
    pairs = [(x,y) for x in range(len(ws)) for y in range(x+1,len(ws))]
    random.shuffle(pairs)
    COMPUTED[lam] = {tuple(sorted((byw[ws[x]][0], byw[ws[y]][0]))) for x,y in pairs[:60]}

LAM = (6, 4)
byw = BYWS[LAM]; ws = list(byw)
comp = COMPUTED[LAM]
print(f"lambda={LAM}: {len(ws)} weights, dim {sum(len(v) for v in byw.values())}, "
      f"{len(comp)} entries computed by the shipped sweep")
print("  A  IN the computed 1330:", sorted(comp)[0])
firsts = {byw[w][0] for w in ws}
reach_not = None
for w1 in ws:
    for w2 in ws:
        if w1 >= w2: continue
        k = tuple(sorted((byw[w1][0], byw[w2][0])))
        if k not in comp: reach_not = k; break
    if reach_not: break
print("  B  first-of-class pair the sweep did NOT draw:", reach_not)
un = None
for w1 in ws:
    for w2 in ws:
        if w1 >= w2 or len(byw[w1]) < 2 or len(byw[w2]) < 2: continue
        un = (byw[w1][1], byw[w2][1]); break
    if un: break
print("  C  unreachable at ANY sample size (neither index first-in-class):", un)
print(f"     weights {mwt(max(raw[LAM][0][un[0]]))} vs {mwt(max(raw[LAM][0][un[1]]))}")
