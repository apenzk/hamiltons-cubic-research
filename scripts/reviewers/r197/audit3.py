"""Reviewer 197, part 3: the cross-weight screen's exposure, its missing
positive control, and what the cache assert does not check."""
import importlib.util, sys, os, pickle, itertools, json, hashlib
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
with open(os.path.join(RUNS, "n5_adapted.pkl"), "rb") as f:
    ADAPTED = pickle.load(f)
P, IMOD = 65537, 256
_PERMS = list(itertools.permutations(range(3)))
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
def mwt(idx):
    a, b, c = MONO[idx]
    return (WT[a][0]+WT[b][0]+WT[c][0], WT[a][1]+WT[b][1]+WT[c][1])

# ---- how many entries does `cross` test, and can the counter increment? ----
print("=== H. the cross-weight screen ===")
tested = 0
for lam, cs in ADAPTED.items():
    byw = {}
    for t, v in enumerate(cs[0]): byw.setdefault(mwt(max(v)), []).append(t)
    ws = list(byw)
    for x in range(len(ws)):
        for y in range(x+1, len(ws)):
            tested += len(byw[ws[x]][:2]) * len(byw[ws[y]][:2])
print(f"  entries the shipped loop evaluates: {tested:,}")
print(f"  chance one of them is a FALSE zero, if the true value were a generic")
print(f"  nonzero p-integral rational: 1 - (1 - 1/{P})^{tested} = "
      f"{1 - (1 - 1/P)**tested:.4f}")

print("\n  the positive control the loop lacks: SAME-weight entries, same code path")
for lam in [(2, 2), (3, 2), (4, 2)]:
    cs = ADAPTED[lam]; c0 = cs[0]
    byw = {}
    for t, v in enumerate(c0): byw.setdefault(mwt(max(v)), []).append(t)
    nz = z = 0
    for w, ts in byw.items():
        for a in ts[:3]:
            for b in ts[:3]:
                if a < b:
                    if ip3(c0[a], c0[b]): nz += 1
                    else: z += 1
    print(f"    lambda={lam}: same-weight off-diagonal entries nonzero {nz}, zero {z}")

# ---- what the cache assert does not check ----
def dimB2(l): return (l[0]-l[1]+1)*(l[0]+l[1]+2)*(2*l[0]+3)*(2*l[1]+1)//6
n = sum(len(v) for cs in ADAPTED.values() for v in cs)
print(f"  vectors {n}  (the assert)")
bad = [(lam, len(cs), len(cs[0]), dimB2(lam)) for lam, cs in ADAPTED.items()
       if any(len(c) != dimB2(lam) for c in cs)]
print(f"  blocks whose copies do not all have dim = dimB2(lambda): {bad}")
print(f"  sum over blocks of m * dimB2 = "
      f"{sum(len(cs)*dimB2(lam) for lam, cs in ADAPTED.items())}")
# a cache with the right count but the wrong vectors: swap two blocks' copies
alt = dict(ADAPTED)
ks = [k for k in ADAPTED if len(ADAPTED[k]) > 1]
print(f"  a corrupted cache the assert accepts: replace every vector of block "
      f"{ks[0]} copy 1 by copy 0's -> still {n} vectors, assert still passes")
C = json.load(open(os.path.join(RUNS, "n5_hw_cache.json")))
print(f"  the pickle records nothing about the weight basis it is written in;")
print(f"  n5_hw_cache.json currently hashes to "
      f"{hashlib.sha256(open(os.path.join(RUNS,'n5_hw_cache.json'),'rb').read()).hexdigest()[:16]}")
print(f"  mtime(n5_adapted.pkl) = {os.path.getmtime(os.path.join(RUNS,'n5_adapted.pkl')):.0f}, "
      f"mtime(n5_hw_cache.json) = {os.path.getmtime(os.path.join(RUNS,'n5_hw_cache.json')):.0f}")
# is the cached basis consistent with the CURRENT weight basis at all?
print(f"  weight of position 0 equals lambda in every block: "
      f"{all(mwt(max(cs[0][0])) == lam for lam, cs in ADAPTED.items())}")
inhom = sum(1 for cs in ADAPTED.values() for c in cs for v in c
            if len({mwt(k) for k in v}) > 1)
print(f"  adapted vectors carrying more than one weight (the assert that never "
      f"runs): {inhom}")

# the corruption the count assert accepts, run rather than described
k = next(l for l in ADAPTED if len(ADAPTED[l]) > 1)
corrupt = {l: ([cs[0], cs[0]] + list(cs[2:]) if l == k else cs)
           for l, cs in ADAPTED.items()}
n2 = sum(len(v) for cs in corrupt.values() for v in cs)
print(f"  corrupted cache (block {k}, copy 1 replaced by copy 0): n = {n2}, "
      f"assert n == 7770 passes: {n2 == 7770}")
print(f"    and its h is {[[1,1],[1,1]]}-shaped: det = 0, so the block is coincident")
