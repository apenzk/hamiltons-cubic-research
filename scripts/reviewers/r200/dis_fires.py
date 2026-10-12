"""Reviewer 200: does `assert dis == 0` still fire at p = 1000033?
197 established it at 65537 across 12 blocks; the prime changed underneath."""
import importlib.util, sys, os, pickle, itertools, collections, random
from fractions import Fraction as Fr
RUNS = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                    "..", "..", "runs"))
def load(name):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(RUNS, name))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m); sys.stdout = o
    return m
ev = load("run_n5_evaluate.py"); MONO, H, WT = ev.MONO, ev.H, ev.WT
RAW = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))
P = 1000033; IMOD = next(x for x in range(2, P) if pow(x, 2, P) == P-1)
_PERMS = list(itertools.permutations(range(3)))
def to_p(x):
    (a, b) = x
    return (a.numerator*pow(a.denominator % P, P-2, P)
            + b.numerator*pow(b.denominator % P, P-2, P)*IMOD) % P
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
                term = term*e % P
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
            if k: tot = (tot + cap*to_p((cb[0], -cb[1])) % P * k) % P
    return tot
def mwt(i):
    a, b, c = MONO[i]
    return (WT[a][0]+WT[b][0]+WT[c][0], WT[a][1]+WT[b][1]+WT[c][1])
def hmat(cs):
    m = len(cs)
    if m == 1: return [[1]]
    inv = pow(ip3(cs[0][0], cs[0][0]), P-2, P)
    return [[ip3(cs[i][0], cs[j][0])*inv % P for j in range(m)] for i in range(m)]
def disagree(cs, HM):
    d = s = 0
    for t in range(1, len(cs[0])):
        q = ip3(cs[0][t], cs[0][t])
        if not q: s += 1; continue
        inv = pow(q, P-2, P)
        for i in range(len(cs)):
            for j in range(len(cs)):
                if ip3(cs[i][t], cs[j][t])*inv % P != HM[i][j]: d += 1
    return d, s
for lam in [(2, 0), (2, 1), (3, 0)]:
    cs = [list(c) for c in RAW[lam]]
    HM = hmat(cs); d, s = disagree(cs, HM)
    print(f"lambda={lam} m={len(cs)} dim={len(cs[0])}: clean dis={d} skipped={s}")
    ws = [mwt(max(v)) for v in cs[0]]
    byw = collections.defaultdict(list)
    for t, w in enumerate(ws): byw[w].append(t)
    pr = next(((ts[0], ts[1]) for ts in byw.values() if len(ts) > 1), None)
    if pr is None: print("   no same-weight pair in this block"); continue
    t1, t2 = pr
    cs[1][t1], cs[1][t2] = cs[1][t2], cs[1][t1]
    HM2 = hmat(cs); d2, s2 = disagree(cs, HM2)
    print(f"   after transposing positions {pr} inside copy 1: dis={d2} "
          f"-> assert {'FIRES' if d2 else 'DOES NOT FIRE'}")
