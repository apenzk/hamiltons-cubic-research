"""Reviewer 200: is `cross == 0` capable of failing at all?

Claim to test: ip3(u, v) = 0 for ANY weight-homogeneous u, v of different Sym^3
weight, whatever their coefficients -- because the monomial form ip_mono is
already supported on equal Sym^3 weight.  If so `assert cross == 0` is implied
by `assert inhom == 0` plus a fixed H, carries no independent content, and
passes random garbage.
"""
import importlib.util, sys, os, itertools, collections, random, pickle
from fractions import Fraction as Fr

RUNS = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                    "..", "..", "runs"))
def load(name):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(RUNS, name))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m); sys.stdout = o
    return m
ev = load("run_n5_evaluate.py")
MONO, H, WT = ev.MONO, ev.H, ev.WT

# ---- 1. H's support on the 35 word-basis vectors ----
off = [(a, b) for (a, b), v in H.items() if WT[a] != WT[b] and v != (Fr(0), Fr(0))]
print(f"H entries stored: {len(H)}")
print(f"H entries with WT[a] != WT[b] and value != 0: {len(off)}")
zeros = [(a, b) for (a, b), v in H.items() if v == (Fr(0), Fr(0))]
print(f"H entries stored as exact zero: {len(zeros)}")
print(f"distinct weights among the 35: {len(set(map(tuple, WT)))}"
      if not isinstance(WT, dict) else
      f"distinct weights among the {len(WT)}: {len(set(WT.values()))}")

# ---- 2. therefore ip_mono vanishes across Sym^3 weights: check exhaustively
#         on a random sample of monomial pairs of unequal weight ----
def mwt(idx):
    a, b, c = MONO[idx]
    return (WT[a][0]+WT[b][0]+WT[c][0], WT[a][1]+WT[b][1]+WT[c][1])
_PERMS = list(itertools.permutations(range(3)))
def ip_mono_exact(t, s):
    tot = (Fr(0), Fr(0))
    for pm in _PERMS:
        term = (Fr(1), Fr(0))
        for i in range(3):
            e = H.get((t[i], s[pm[i]]))
            if e is None: term = (Fr(0), Fr(0)); break
            term = (term[0]*e[0] - term[1]*e[1], term[0]*e[1] + term[1]*e[0])
        tot = (tot[0]+term[0], tot[1]+term[1])
    return tot
rnd = random.Random(2000)
bad = 0; n = 200000
for _ in range(n):
    a = rnd.randrange(len(MONO)); b = rnd.randrange(len(MONO))
    if mwt(a) == mwt(b): continue
    if ip_mono_exact(MONO[a], MONO[b]) != (Fr(0), Fr(0)): bad += 1
print(f"\nrandom unequal-weight monomial pairs tested EXACTLY: {n}, nonzero: {bad}")

# ---- 3. the shipped sweep on RANDOM weight-homogeneous garbage ----
print("\n=== the shipped sweep on random garbage that respects homogeneity ===")
P = 1000033
IMOD = next(x for x in range(2, P) if pow(x, 2, P) == P - 1)
def to_p(x):
    (a, b) = x
    return (a.numerator * pow(a.denominator % P, P-2, P)
            + b.numerator * pow(b.denominator % P, P-2, P) * IMOD) % P
HP = {k: to_p(v) for k, v in H.items()}
_c = {}
def ip_mono(t, s):
    k = (t, s); r = _c.get(k)
    if r is None:
        tot = 0
        for pm in _PERMS:
            term = 1
            for i in range(3):
                e = HP.get((t[i], s[pm[i]]))
                if e is None: term = 0; break
                term = term * e % P
            tot = (tot + term) % P
        _c[k] = r = tot
    return r
def ip3(u, v):
    tot = 0
    for a, ca in u.items():
        cap = to_p(ca)
        if not cap: continue
        ta = MONO[a]
        for b, cb in v.items():
            k = ip_mono(ta, MONO[b])
            if k: tot = (tot + cap * to_p((cb[0], -cb[1])) % P * k) % P
    return tot

MONS = collections.defaultdict(list)
for i in range(len(MONO)): MONS[mwt(i)].append(i)
RAW = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))
# garbage: same block/copy/position shape, each vector a random dense vector
# inside the weight space its original occupied.
GARB = {}
for lam, cs in RAW.items():
    GARB[lam] = []
    for c in cs:
        nc = []
        for v in c:
            w = mwt(max(v))
            ms = MONS[w]
            nc.append({m: (Fr(rnd.randint(-9, 9)), Fr(rnd.randint(-9, 9)))
                       for m in ms})
        GARB[lam].append(nc)

def byweight(c0):
    d = collections.OrderedDict()
    for t, v in enumerate(c0):
        if v: d.setdefault(mwt(max(v)), []).append(t)
    return d
def shipped_sweep(adapted, seed=11, cap=60):
    rnd2 = random.Random(seed); cross = 0; tested = 0
    for lam in adapted:
        c0 = adapted[lam][0]
        byw = byweight(c0); ws = list(byw)
        pairs = [(x, y) for x in range(len(ws)) for y in range(x+1, len(ws))]
        rnd2.shuffle(pairs)
        for x, y in pairs[:cap]:
            for a in byw[ws[x]][:1]:
                for b in byw[ws[y]][:1]:
                    tested += 1
                    if ip3(c0[a], c0[b]): cross += 1
        if cross: break
    return cross, tested
c, t = shipped_sweep(GARB)
print(f"  RANDOM garbage basis: cross = {c} over {t} entries -> "
      f"assert {'FIRES' if c else 'PASSES'}")
# and the homogeneity assert on the same garbage
inhom = sum(1 for cs in GARB.values() for c_ in cs for v in c_
            if len({mwt(k) for k in v}) > 1)
print(f"  homogeneity on the same garbage: inhom = {inhom}")
