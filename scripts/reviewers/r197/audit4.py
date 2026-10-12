"""Reviewer 197, part 4: what the probe range t = 1..3 costs and what widening
it buys.  Runs the same dis loop over EVERY position, on clean data and on data
carrying one same-weight transposition inside copy 1."""
import importlib.util, sys, os, pickle, itertools, time
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
ADAPTED = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))
P, IMOD = 65537, 256
_PERMS = list(itertools.permutations(range(3)))
def to_p(x):
    (a, b) = x
    return (a.numerator * pow(a.denominator % P, P-2, P)
            + b.numerator * pow(b.denominator % P, P-2, P) * IMOD) % P
HP = {k: to_p(v) for k, v in H.items()}
_c = {}
def ip_mono(t, s):
    r = _c.get((t, s))
    if r is None:
        tot = 0
        for pm in _PERMS:
            term = 1
            for i in range(3):
                e = HP.get((t[i], s[pm[i]]))
                if e is None: term = 0; break
                term = term * e % P
            tot = (tot + term) % P
        _c[(t, s)] = r = tot
    return r
_VP = {}
def vp(v, conj):
    k = (id(v), conj)
    r = _VP.get(k)
    if r is None:
        r = _VP[k] = {a: to_p((c[0], -c[1]) if conj else c) for a, c in v.items()}
    return r
def ip3(u, v):
    tot = 0
    for a, cap in vp(u, False).items():
        if not cap: continue
        ta = MONO[a]
        for b, cbp in vp(v, True).items():
            k = ip_mono(ta, MONO[b])
            if k: tot = (tot + cap * cbp % P * k) % P
    return tot
def mwt(i):
    a, b, c = MONO[i]
    return (WT[a][0]+WT[b][0]+WT[c][0], WT[a][1]+WT[b][1]+WT[c][1])
def hmat(cs):
    m = len(cs)
    q = ip3(cs[0][0], cs[0][0]); inv = pow(q, P-2, P)
    return [[ip3(cs[i][0], cs[j][0]) * inv % P for j in range(m)] for i in range(m)]
def dis_range(cs, HM, ts):
    m = len(cs); dis = 0; skip = 0
    for t in ts:
        q = ip3(cs[0][t], cs[0][t])
        if not q: skip += 1; continue
        inv = pow(q, P-2, P)
        for i in range(m):
            for j in range(m):
                if ip3(cs[i][t], cs[j][t]) * inv % P != HM[i][j]: dis += 1
    return dis, skip

print(f"{'lambda':>9} {'m':>2} {'dim':>4} | clean dis (all t) | swap pair | dis t<=3 | dis all t | secs")
tot_clean = tot_skip = 0; caught3 = catchall = 0; T = 0
for lam, cs in sorted(ADAPTED.items()):
    m = len(cs)
    if m == 1: continue
    t0 = time.time()
    HM = hmat(cs)
    allt = range(1, len(cs[0]))
    d, s = dis_range(cs, HM, allt); tot_clean += d; tot_skip += s
    # the earliest same-weight pair, whatever position it sits at
    byw = {}
    for t, v in enumerate(cs[0]): byw.setdefault(mwt(max(v)), []).append(t)
    pair = min(((ts[0], ts[1]) for ts in byw.values() if len(ts) > 1), key=lambda pr: pr[1])
    mod = [list(c) for c in cs]
    mod[1][pair[0]], mod[1][pair[1]] = mod[1][pair[1]], mod[1][pair[0]]
    HMm = hmat(mod)
    d3, _ = dis_range(mod, HMm, range(1, min(4, len(mod[0]))))
    da, _ = dis_range(mod, HMm, range(1, len(mod[0])))
    if d3: caught3 += 1
    if da: catchall += 1
    dt = time.time()-t0; T += dt
    print(f"{str(lam):>9} {m:>2} {len(cs[0]):>4} | {d:>5} (skipped {s}) | {str(pair):>9} | "
          f"{d3:>5} | {da:>5} | {dt:6.1f}")
print(f"\n  clean data, EVERY position probed: dis = {tot_clean}, skipped {tot_skip}")
print(f"  earliest same-weight transposition caught by t <= 3: {caught3} of 12")
print(f"  earliest same-weight transposition caught by all t : {catchall} of 12")
print(f"  total time for the full-range check: {T:.0f}s")
