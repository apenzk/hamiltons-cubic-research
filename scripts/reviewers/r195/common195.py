"""r195 shared machinery, INDEPENDENT of the modules under review.

H and the Sym^3 Hermitian form are rebuilt here from n5_hw_cache.json (data,
not code), so nothing in run_n5_evaluate.py is trusted -- and importing it is
in any case unusable, since its module level runs three kappa trials on dense
Sym^3 cubes.

The lowering operators are the one thing only run_n5_highest_weight.py has;
they are computed once and cached to the scratchpad.
"""
import importlib.util, sys, os, json, pickle, itertools, time
from fractions import Fraction as Fr

RUNS = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                     "..", "..", "runs"))
SCRATCH = "/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad"
os.makedirs(SCRATCH, exist_ok=True)

C = json.load(open(os.path.join(RUNS, "n5_hw_cache.json")))
WT = [tuple(w) for w in C["weights"]]
MONO = list(itertools.combinations_with_replacement(range(35), 3))
MIDX = {m: i for i, m in enumerate(MONO)}

def gq(pr):
    (rn, rd), (inn, idd) = pr
    return (Fr(rn, rd), Fr(inn, idd))
def cmul(x, y): return (x[0]*y[0] - x[1]*y[1], x[0]*y[1] + x[1]*y[0])
def cadd(x, y): return (x[0] + y[0], x[1] + y[1])
def csub(x, y): return (x[0] - y[0], x[1] - y[1])
def cconj(x):   return (x[0], -x[1])
ZC = (Fr(0), Fr(0))
def cdiv(g, q):
    d = q[0]*q[0] + q[1]*q[1]
    return ((g[0]*q[0] + g[1]*q[1])/d, (g[1]*q[0] - g[0]*q[1])/d)

def mwt(idx):
    a, b, c = MONO[idx]
    return tuple(WT[a][k] + WT[b][k] + WT[c][k] for k in (0, 1))

# ---------- H, rebuilt with NO weight filter: every one of the 1225 pairs ----------
_hp = os.path.join(SCRATCH, "r195_H.pkl")
if os.path.exists(_hp):
    HFULL = pickle.load(open(_hp, "rb"))
else:
    T = [[gq(C["wbasis_tensors"][a][i][j][k][l])
          for i in range(5) for j in range(5) for k in range(5) for l in range(5)]
         for a in range(35)]
    HFULL = {}
    for a in range(35):
        for b in range(35):
            re = im = Fr(0)
            for x, y in zip(T[a], T[b]):
                if (x[0] or x[1]) and (y[0] or y[1]):
                    re += x[0]*y[0] + x[1]*y[1]
                    im += x[1]*y[0] - x[0]*y[1]
            if (re, im) != ZC: HFULL[(a, b)] = (re, im)
    pickle.dump(HFULL, open(_hp, "wb"))

def sym3_ip(t, s):
    """FISCHER: plain sum over bijections t -> s of prod H(t_i, s_sigma(i))."""
    tot = ZC
    for perm in itertools.permutations(range(3)):
        term = (Fr(1), Fr(0)); ok = True
        for i in range(3):
            e = HFULL.get((t[i], s[perm[i]]))
            if e is None: ok = False; break
            term = cmul(term, e)
        if ok: tot = cadd(tot, term)
    return tot

def ip3(u, v, conj=True):
    tot = ZC
    for a, ca in u.items():
        ta = MONO[a]
        for b, cb in v.items():
            k = sym3_ip(ta, MONO[b])
            if k != ZC:
                cb2 = cconj(cb) if conj else cb
                tot = cadd(tot, cmul(cmul(ca, cb2), k))
    return tot

# ---------- highest-weight vectors, straight from the cache ----------
HWC = {}
for key, val in C["hw"].items():
    lam = tuple(int(x) for x in key.split(","))
    HWC[lam] = (val["cols"], [[gq(x) for x in v] for v in val["vecs"]])

# ---------- the lowering operators ----------
_lp = os.path.join(SCRATCH, "r195_LOW.pkl")
if os.path.exists(_lp):
    LOW = pickle.load(open(_lp, "rb"))
else:
    sp = importlib.util.spec_from_file_location(
        "hwmod", os.path.join(RUNS, "run_n5_highest_weight.py"))
    hwm = importlib.util.module_from_spec(sp)
    _o = sys.stdout; sys.stdout = open(os.devnull, "w")
    try: sp.loader.exec_module(hwm)
    finally: sys.stdout = _o
    RV = [hwm.root_vector(-1, 1), hwm.root_vector(0, -1)]
    LOW = [[[(x.r, x.i) for x in row] for row in
            hwm.to_weight_coords([hwm.apply(hwm.lin({k: R[k] for k in range(10) if R[k]}), v)
                                  for v in hwm.WBASIS])] for R in RV]
    pickle.dump(LOW, open(_lp, "wb"))

def lower(vec, EC):
    out = {}
    for idx, co in vec.items():
        a, b, c = MONO[idx]
        for pos, x in enumerate((a, b, c)):
            rest = [y for j, y in enumerate((a, b, c)) if j != pos]
            for t in range(35):
                e = EC[x][t]
                if e != ZC:
                    j = MIDX[tuple(sorted(rest + [t]))]
                    out[j] = cadd(out.get(j, ZC), cmul(co, e))
    return {k: v for k, v in out.items() if v != ZC}

def reduce_full(w, ech):
    w = dict(w)
    while w:
        piv = max(w)
        if piv not in ech: break
        f = cdiv(w[piv], ech[piv][piv])
        for k, c in ech[piv].items():
            w[k] = csub(w.get(k, ZC), cmul(f, c))
        w = {k: c for k, c in w.items() if c != ZC}
    return w

def word_list(u, cap):
    ech, words, out = {}, [], []
    frontier = [([], u)]
    while frontier and len(out) < cap:
        nxt = []
        for word, v in frontier:
            r = reduce_full(v, ech)
            if not r: continue
            ech[max(r)] = r; out.append(v); words.append(word)
            for oi, EC in enumerate(LOW):
                nv = lower(v, EC)
                if nv: nxt.append((word + [oi], nv))
        frontier = nxt
    return words

def replay(u, words):
    out = []
    for w in words:
        v = u
        for oi in w: v = lower(v, LOW[oi])
        out.append(v)
    return out

def hwvecs(lam):
    cols, ns = HWC[lam]
    return [{cols[j]: v[j] for j in range(len(cols)) if v[j] != ZC} for v in ns]

def dimB2(l): return (l[0]-l[1]+1)*(l[0]+l[1]+2)*(2*l[0]+3)*(2*l[1]+1)//6

def build(lam, shared=True):
    us = hwvecs(lam); want = dimB2(lam)
    if shared:
        words = word_list(us[0], want)
        assert len(words) == want, (lam, len(words), want)
        return [replay(u, words) for u in us], words
    lists = [word_list(u, want) for u in us]
    return [replay(us[i], lists[i]) for i in range(len(us))], lists
