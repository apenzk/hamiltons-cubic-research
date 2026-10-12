"""Reviewer 200: pure combinatorics of the cached basis -- no inner products.
Feeds claim 1 (does the 60-pair cross sweep retain power?) and claim 4 (what
does the per-weight solve actually cost, and is 89 the right unknown count?)."""
import pickle, os, collections, itertools, random

RUNS = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                    "..", "..", "runs"))
RAW = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))

# rebuild MONO/WWT the cheap way: from run_n5_evaluate
import importlib.util, sys
def load(name):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(RUNS, name))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m); sys.stdout = o
    return m
ev = load("run_n5_evaluate.py")
MONO, WT = ev.MONO, ev.WT
def mwt(idx):
    a, b, c = MONO[idx]
    return (WT[a][0]+WT[b][0]+WT[c][0], WT[a][1]+WT[b][1]+WT[c][1])

print(f"len(MONO) = {len(MONO)}")
print(f"blocks {len(RAW)}, copies {sum(len(cs) for cs in RAW.items().__iter__().__next__()[1:][0]) if False else sum(len(cs) for cs in RAW.values())}")
mult = {lam: len(cs) for lam, cs in RAW.items()}
print(f"multiplicities: {dict(sorted(mult.items()))}")
print(f"sum m       = {sum(mult.values())}")
print(f"sum m^2     = {sum(m*m for m in mult.values())}   <- len(UNK) claim 89")
print(f"sum m(m+1)/2= {sum(m*(m+1)//2 for m in mult.values())}")

# ---- weight spaces of Sym^3 ----
MONS = collections.defaultdict(list)
for i in range(len(MONO)): MONS[mwt(i)].append(i)
sz = sorted((len(v) for v in MONS.values()), reverse=True)
print(f"\nSym^3 weight spaces: {len(MONS)} weights, largest {sz[0]}, "
      f"sum {sum(sz)}")
print(f"  sum of n^2 (one dense solve, back-substitution): {sum(s*s for s in sz):,}")
print(f"  sum of n^3 (full elimination, what solve_weight does PER SAMPLE): "
      f"{sum(s*s*s for s in sz):,}")

# ---- per-lambda weight structure of copy 0 ----
print(f"\n{'lambda':>9} {'m':>2} {'dim':>5} {'wts':>4} {'widest':>6} "
      f"{'pairs':>7} {'antidiag':>8} {'P(60 hits >=1 antidiag)':>24}")
tot_pairs = tot_anti = 0
sampled_anti = 0
rnd = random.Random(11)
for lam, cs in sorted(RAW.items()):
    c0 = cs[0]
    byw = collections.defaultdict(list)
    for t, v in enumerate(c0):
        if v: byw[mwt(max(v))].append(t)
    ws = list(byw)
    pairs = [(x, y) for x in range(len(ws)) for y in range(x+1, len(ws))]
    anti = [(x, y) for x, y in pairs if ws[x] == tuple(-z for z in ws[y])]
    tot_pairs += len(pairs); tot_anti += len(anti)
    n = len(pairs); k = min(60, n); a = len(anti)
    # P(at least one antidiagonal pair among k drawn without replacement)
    p = 1.0
    for j in range(k):
        p *= (n - a - j) / (n - j) if n - j > 0 else 0
    print(f"{str(lam):>9} {len(cs):>2} {len(c0):>5} {len(ws):>4} "
          f"{max(len(v) for v in byw.values()):>6} {n:>7} {a:>8} {1-p:>24.4f}")
print(f"  totals: cross-weight PAIRS {tot_pairs}, of which antidiagonal {tot_anti}")
print(f"  entries the sweep evaluates: <= 60 per lambda x 1 x 1 = "
      f"<= {60*len(RAW)}")
# full entry count
tot_entries = 0
for lam, cs in RAW.items():
    byw = collections.defaultdict(list)
    for t, v in enumerate(cs[0]):
        if v: byw[mwt(max(v))].append(t)
    ws = list(byw)
    for x in range(len(ws)):
        for y in range(x+1, len(ws)):
            tot_entries += len(byw[ws[x]]) * len(byw[ws[y]])
print(f"  cross-weight ENTRIES that exist: {tot_entries:,}  -> sampled fraction "
      f"{60*len(RAW)/tot_entries:.2e}")

# ---- h probe comparison counts (claim 1/3) ----
qtests = comps = 0
for lam, cs in RAW.items():
    m = len(cs)
    if m == 1: continue
    qtests += len(cs[0]) - 1
    comps += (len(cs[0]) - 1) * m * m
print(f"\nh multi-probe: q!=0 tests {qtests}, ratio comparisons {comps}")
for p in (65537, 1000033):
    print(f"  at p={p}: expected FALSE q==0 (skips) {qtests/p:.4f}, "
          f"expected FALSE agreements {comps/p:.4f}")
