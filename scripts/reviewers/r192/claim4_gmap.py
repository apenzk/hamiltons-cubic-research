"""Claim 4: does replaying ONE word list on every copy realise the unique
G-map u_i -> u_j?

The test with teeth is not spanning.  Fix a block lambda of multiplicity m and
let R_i[t] be copy i's replayed vector for word t.  If -- and only if -- the
identification R_i[t] <-> R_j[t] is the unique G-map phi_j phi_i^{-1}, the full
Gram of the adapted basis factors as a Kronecker product

    <R_i[s], R_j[t]>  =  h_ij * Q[s,t],      h_ij = <u_i,u_j> / <u_1,u_1>,

because Schur's lemma makes the space of invariant sesquilinear pairings
V(lambda) x V(lambda) -> C one-dimensional.  A different G-map on copy j
rescales one row of h but ALSO permutes/mixes the t index, which no single
scalar can absorb.

Negative control: replay copy 2 with its OWN echelon-selected word list -- the
per-copy behaviour run_n5_adapted.py was written to eliminate.  It still spans
(so it passes the shipped check) and it must break the factorisation.
"""
import json, os, sys, itertools, time
from fractions import Fraction as F

HERE = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.join(HERE, "..", "..", "runs")
C = json.load(open(os.path.join(RUNS, "n5_hw_cache.json")))
L = json.load(open(os.path.join(HERE, "low_cache.json")))

def gq(pr):
    (rn, rd), (inn, idd) = pr
    return (F(rn, rd), F(inn, idd))

Z = (F(0), F(0))
def cadd(x, y): return (x[0]+y[0], x[1]+y[1])
def cmul(x, y): return (x[0]*y[0]-x[1]*y[1], x[0]*y[1]+x[1]*y[0])
def cconj(x): return (x[0], -x[1])
def cdiv(x, y):
    d = y[0]*y[0]+y[1]*y[1]
    return ((x[0]*y[0]+x[1]*y[1])/d, (x[1]*y[0]-x[0]*y[1])/d)

WT = [tuple(w) for w in C["weights"]]
assert [tuple(w) for w in L["WWT"]] == WT, "weight-basis ordering mismatch"
T = C["wbasis_tensors"]
LOW = [[[gq(x) for x in row] for row in L["F1C"]],
       [[gq(x) for x in row] for row in L["F2C"]]]

MONO = list(itertools.combinations_with_replacement(range(35), 3))
MIDX = {m: i for i, m in enumerate(MONO)}

# ---------- the Hermitian Gram H of the weight basis (r192's own build) ----------
H = {}
for a in range(35):
    for b in range(35):
        re = im = F(0)
        for i in range(5):
            for j in range(5):
                for k in range(5):
                    for l in range(5):
                        x = gq(T[a][i][j][k][l]); y = gq(T[b][i][j][k][l])
                        re += x[0]*y[0]+x[1]*y[1]
                        im += x[1]*y[0]-x[0]*y[1]
        if (re, im) != Z: H[(a, b)] = (re, im)
print(f"H: {len(H)} nonzero entries", flush=True)

_ip_cache = {}
def perm3(t, s):
    key = (t, s)
    v = _ip_cache.get(key)
    if v is not None: return v
    tot = Z
    for p in itertools.permutations(range(3)):
        term = (F(1), F(0)); ok = True
        for i in range(3):
            e = H.get((t[i], s[p[i]]))
            if e is None: ok = False; break
            term = cmul(term, e)
        if ok: tot = cadd(tot, term)
    _ip_cache[key] = tot
    return tot

def wtrip(t): return tuple(sorted(WT[x] for x in t))

def ip(u, v):
    """<u, v> on Sym^3, sesquilinear in the second slot."""
    byw = {}
    for s, cs in v.items(): byw.setdefault(wtrip(MONO[s]), []).append((s, cs))
    tot = Z
    for t, ct in u.items():
        for s, cs in byw.get(wtrip(MONO[t]), ()):
            p = perm3(MONO[t], MONO[s])
            if p != Z: tot = cadd(tot, cmul(cmul(ct, cconj(cs)), p))
    return tot

# ---------- module action ----------
def lower(vec, EC):
    out = {}
    for idx, co in vec.items():
        a, b, c = MONO[idx]
        for pos, x in enumerate((a, b, c)):
            rest = [y for j, y in enumerate((a, b, c)) if j != pos]
            for t in range(35):
                if EC[x][t] != Z:
                    j = MIDX[tuple(sorted(rest + [t]))]
                    out[j] = cadd(out.get(j, Z), cmul(co, EC[x][t]))
    return {k: v for k, v in out.items() if v != Z}

def reduce_full(w, ech):
    w = dict(w)
    while w:
        piv = max(w)
        if piv not in ech: break
        f = cdiv(w[piv], ech[piv][piv])
        for k, c in ech[piv].items():
            w[k] = (w.get(k, Z)[0]-cmul(f, c)[0], w.get(k, Z)[1]-cmul(f, c)[1])
        w = {k: c for k, c in w.items() if c != Z}
    return w

def word_list(u, cap, order=(0, 1)):
    """BFS from u recording words.  `order` picks which lowering operator is
    tried first -- the only freedom, and enough to produce a DIFFERENT list."""
    ech, words, out = {}, [], []
    frontier = [([], u)]
    while frontier and len(out) < cap:
        nxt = []
        for word, v in frontier:
            r = reduce_full(v, ech)
            if not r: continue
            ech[max(r)] = r; out.append(v); words.append(word)
            for oi in order:
                nv = lower(v, LOW[oi])
                if nv: nxt.append((word + [oi], nv))
        frontier = nxt
    return words, out

def replay(u, words):
    out = []
    for w in words:
        v = u
        for oi in w: v = lower(v, LOW[oi])
        out.append(v)
    return out

def rank_of(vecs):
    ech = {}; r = 0
    for v in vecs:
        w = reduce_full(v, ech)
        if w: ech[max(w)] = w; r += 1
    return r

def dimB2(l): return (l[0]-l[1]+1)*(l[0]+l[1]+2)*(2*l[0]+3)*(2*l[1]+1)//6

# ---------- run on the small multiplicity>=2 blocks ----------
TARGETS = [(2, 0), (2, 2)]
NPROBE = int(sys.argv[1]) if len(sys.argv) > 1 else 6

for lam in TARGETS:
    key = f"{lam[0]},{lam[1]}"
    cols = C["hw"][key]["cols"]
    ns = [[gq(x) for x in v] for v in C["hw"][key]["vecs"]]
    m = len(ns); want = dimB2(lam)
    print(f"\n=== lambda={lam}  dim {want}  multiplicity {m} ===", flush=True)
    us = [{cols[j]: v[j] for j in range(len(cols)) if v[j] != Z} for v in ns]
    t0 = time.time()
    words, out1 = word_list(us[0], want)
    print(f"  shared word list from copy 1: {len(words)} words (dim {want}) "
          f"[{time.time()-t0:.0f}s]", flush=True)
    assert len(words) == want
    R = [replay(u, words) for u in us]
    print(f"  replay reproduces copy 1's BFS vectors exactly: "
          f"{all(R[0][t] == out1[t] for t in range(want))}")
    for i in range(m):
        print(f"  copy {i+1}: replayed list rank {rank_of(R[i])} of {want}")

    # multiplicity Gram h_ij = <u_i, u_j> / <u_1,u_1>
    hraw = [[ip(us[i], us[j]) for j in range(m)] for i in range(m)]
    n11 = hraw[0][0]
    h = [[cdiv(hraw[i][j], n11) for j in range(m)] for i in range(m)]
    print("  multiplicity Gram h_ij = <u_i,u_j>/<u_1,u_1>:")
    for i in range(m):
        print("    " + "  ".join(f"{h[i][j][0]}{'+' if h[i][j][1]>=0 else '-'}{abs(h[i][j][1])}i"
                                 for j in range(m)))
    isdiag = all(h[i][j] == Z for i in range(m) for j in range(m) if i != j)
    isid = isdiag and all(h[i][i] == (F(1), F(0)) for i in range(m))
    print(f"  h is diagonal: {isdiag}   h is the identity: {isid}")

    # Kronecker factorisation on a probe window of words
    P = min(NPROBE, want)
    Q = [[ip(R[0][s], R[0][t]) for t in range(P)] for s in range(P)]
    fails = []
    for i in range(m):
        for j in range(m):
            for s in range(P):
                for t in range(P):
                    lhs = ip(R[i][s], R[j][t])
                    rhs = cmul(h[i][j], Q[s][t])
                    if lhs != rhs: fails.append((i, j, s, t, lhs, rhs))
    print(f"  Kronecker test <R_i[s],R_j[t]> == h_ij Q[s,t] on {P}x{P} words, "
          f"all {m}x{m} copy pairs: {len(fails)} failures of {m*m*P*P}")
    if fails:
        for f_ in fails[:5]: print(f"    !! {f_}")

    # ---- negative control: copy 2 gets its OWN word list ----
    if m >= 2:
        words2, out2 = word_list(us[1], want, order=(1, 0))
        assert len(words2) == want
        R2 = replay(us[1], words2)
        print(f"  [control] copy 2's own word list: rank {rank_of(R2)} of {want} "
              f"-- the shipped spanning check PASSES: {rank_of(R2) == want}")
        print(f"  [control] word lists differ: {words2 != words}")
        cf = 0
        for s in range(P):
            for t in range(P):
                if ip(R[0][s], R2[t]) != cmul(h[0][1], Q[s][t]): cf += 1
        print(f"  [control] Kronecker failures with the per-copy list: {cf} of {P*P}")
