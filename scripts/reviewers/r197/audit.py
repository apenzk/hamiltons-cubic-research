"""Reviewer 197: audit of the mod-p switch and the multi-probe h check.

Read-only.  Loads the cached adapted basis with pickle (the pickle is never
rewritten) and re-implements to_p / ip3 / det_p as run_n5_assemble.py has them,
except that sym3_ip is evaluated directly in F_p from H mod p, which is the same
function composed with the reduction map and is ~100x faster.
"""
import importlib.util, sys, os, pickle, itertools, time
from fractions import Fraction as Fr

RUNS = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                    "..", "..", "runs"))
def load(name):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(RUNS, name))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m); sys.stdout = o
    return m

PRIME = 65537
IMOD = 256

ev = load("run_n5_evaluate.py")
MONO, sym3_ip, H, WT = ev.MONO, ev.sym3_ip, ev.H, ev.WT

with open(os.path.join(RUNS, "n5_adapted.pkl"), "rb") as f:
    RAW = pickle.load(f)
ADAPTED = RAW      # {(l0,l1): [[{idx: (Fr, Fr)} ...] ...]}
print(f"blocks {len(ADAPTED)}, copies {sum(len(c) for c in ADAPTED.values())}, "
      f"vectors {sum(len(v) for cs in ADAPTED.values() for v in cs)}")

def to_p(x):
    (a, b) = x
    return (a.numerator * pow(a.denominator % PRIME, PRIME-2, PRIME)
            + b.numerator * pow(b.denominator % PRIME, PRIME-2, PRIME) * IMOD) % PRIME

HP = {k: to_p(v) for k, v in H.items()}
_PERMS = list(itertools.permutations(range(3)))
_IPC = {}
def sym3_ip_p(t, s):
    k = (t, s)
    r = _IPC.get(k)
    if r is None:
        tot = 0
        for pm in _PERMS:
            term = 1
            for i in range(3):
                e = HP.get((t[i], s[pm[i]]))
                if e is None: term = 0; break
                term = term * e % PRIME
            tot = (tot + term) % PRIME
        _IPC[k] = r = tot
    return r

def vec_p(v, conj=False):
    if conj: return {a: to_p((c[0], -c[1])) for a, c in v.items()}
    return {a: to_p(c) for a, c in v.items()}

def ip3p(up, vpc):
    tot = 0
    for a, cap in up.items():
        if not cap: continue
        ta = MONO[a]
        for b, cbp in vpc.items():
            k = sym3_ip_p(ta, MONO[b])
            if k: tot = (tot + cap * cbp % PRIME * k) % PRIME
    return tot

def mwt(idx):
    a, b, c = MONO[idx]
    return (WT[a][0]+WT[b][0]+WT[c][0], WT[a][1]+WT[b][1]+WT[c][1])

def det_p(M):
    M = [row[:] for row in M]; n = len(M); d = 1
    for c in range(n):
        piv = next((r for r in range(c, n) if M[r][c] % PRIME), None)
        if piv is None: return 0
        if piv != c: M[c], M[piv] = M[piv], M[c]; d = -d
        d = d * M[c][c] % PRIME
        inv = pow(M[c][c], PRIME-2, PRIME)
        for r in range(c+1, n):
            f = M[r][c] * inv % PRIME
            if f: M[r] = [(x - f*y) % PRIME for x, y in zip(M[r], M[c])]
    return d % PRIME

# ---------------- TEST A: is any coefficient p-singular? ----------------
print("\n=== A. p-divisibility in the data to_p() must digest ===")
badden = badnum = tot = 0; maxden = maxnum = 0
for cs in ADAPTED.values():
    for copy in cs:
        for vec in copy:
            for (a, b) in vec.values():
                for f in (a, b):
                    tot += 1
                    if f.denominator % PRIME == 0: badden += 1
                    if f.numerator % PRIME == 0 and f.numerator: badnum += 1
                    if f.denominator > maxden: maxden = f.denominator
                    if abs(f.numerator) > maxnum: maxnum = abs(f.numerator)
print(f"  adapted coefficients scanned: {tot:,}")
print(f"  p | denominator  (to_p returns a SILENT 0): {badden}")
print(f"  p | numerator, numerator nonzero (a genuine zero mod p): {badnum}")
print(f"  largest denominator {maxden}, largest |numerator| {maxnum}")
n2 = bd2 = bn2 = 0
for (re, im) in H.values():
    for f in (re, im):
        n2 += 1
        if f.denominator % PRIME == 0: bd2 += 1
        if f.numerator % PRIME == 0 and f.numerator: bn2 += 1
print(f"  H entries scanned {n2}: p|den {bd2}, p|num {bn2}")
print(f"  to_p((1/p, 0)) = {to_p((Fr(1, PRIME), Fr(0)))}  <- 1/p is not p-integral; to_p invents 0")
print(f"  to_p((p, 0))   = {to_p((Fr(PRIME), Fr(0)))}  <- a genuine zero")

# ---------------- TEST B: probe weights, norms, same-weight pairs -------
print("\n=== B. the multi-probe h check ===")
t0 = time.time()
rows = []
for lam, copies in sorted(ADAPTED.items()):
    m = len(copies)
    if m == 1: continue
    c0 = copies[0]
    ws = [mwt(max(v)) for v in c0]
    qs = [ip3p(vec_p(c0[t]), vec_p(c0[t], True)) for t in range(1, min(4, len(c0)))]
    seen = {}; fp = None
    for t, w in enumerate(ws):
        if w in seen: fp = (seen[w], t); break
        seen[w] = t
    rows.append((lam, m, ws[:4], qs, fp, len(c0)))
    print(f"  lam={str(lam):>8} m={m} dim={len(c0):4d} probe weights {ws[:4]} "
          f"q_1..3 = {qs} first same-weight pair {fp}")
print(f"  [{time.time()-t0:.0f}s]")
print(f"  probes t=1..3 with q == 0 mod p (silently skipped): "
      f"{sum(1 for r in rows for q in r[3] if q == 0)} of {sum(len(r[3]) for r in rows)}")
print(f"  blocks whose t=0..3 weights are all distinct: "
      f"{sum(1 for r in rows if len(set(r[2])) == 4)} of {len(rows)}")
print(f"  first same-weight position pair (t1,t2): t1 values "
      f"{sorted({r[4][0] for r in rows if r[4]})}, t2 values {sorted({r[4][1] for r in rows if r[4]})}")
print(f"  blocks where a same-weight transposition lands inside the probed range "
      f"(t1 <= 3): {sum(1 for r in rows if r[4] and r[4][0] <= 3)} of {len(rows)}")
