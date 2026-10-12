"""Reviewer 200, claim 1: can the three surviving asserts fail, and does the
60-pair witness sweep keep its power?

The sweep's stated job is to refute Q's weight block-diagonality.  The file
names the mechanism that would break it: the invariant BILINEAR Gram, supported
on (mu, -mu), which would make Q block-ANTI-diagonal (line 227-234).  So the
sabotage is exactly that -- drop the conjugation from ip3 -- and the question is
whether the shipped sampling sees it.

Then a LOCALISED sabotage: one adapted vector given a single foreign-weight
monomial, which makes exactly one cross-weight pair nonzero.
"""
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

ev = load("run_n5_evaluate.py")
MONO, H, WT = ev.MONO, ev.H, ev.WT
RAW = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))

P = 1000033
IMOD = next(x for x in range(2, P) if pow(x, 2, P) == P - 1)
print(f"p = {P}, i -> {IMOD}")
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
def ip3(u, v, conj=True):
    tot = 0
    for a, ca in u.items():
        cap = to_p(ca)
        if not cap: continue
        ta = MONO[a]
        for b, cb in v.items():
            k = ip_mono(ta, MONO[b])
            if k:
                cbp = to_p((cb[0], -cb[1]) if conj else (cb[0], cb[1]))
                tot = (tot + cap * cbp % P * k) % P
    return tot
def mwt(idx):
    a, b, c = MONO[idx]
    return (WT[a][0]+WT[b][0]+WT[c][0], WT[a][1]+WT[b][1]+WT[c][1])

def byweight(c0):
    d = collections.OrderedDict()
    for t, v in enumerate(c0):
        if v: d.setdefault(mwt(max(v)), []).append(t)
    return d

# ---------------- A. exhaustive cross-weight at the small blocks ----------
print("\n=== A. every cross-weight entry, Hermitian vs bilinear ===")
print(f"{'lambda':>8} {'entries':>8} {'herm nz':>8} {'bilin nz':>9} "
      f"{'bilin nz on (mu,-mu)':>21}")
for lam in [(0, 0), (1, 0), (2, 0), (2, 1)]:
    c0 = RAW[lam][0]
    byw = byweight(c0); ws = list(byw)
    ent = hz = bz = anti_nz = 0
    for x in range(len(ws)):
        for y in range(x+1, len(ws)):
            for a in byw[ws[x]]:
                for b in byw[ws[y]]:
                    ent += 1
                    if ip3(c0[a], c0[b], True): hz += 1
                    v = ip3(c0[a], c0[b], False)
                    if v:
                        bz += 1
                        if ws[x] == tuple(-z for z in ws[y]): anti_nz += 1
    print(f"{str(lam):>8} {ent:>8} {hz:>8} {bz:>9} {anti_nz:>21}")

# ---------------- B. the shipped sweep, verbatim, under the sabotage -------
print("\n=== B. the shipped 60-pair sweep, run verbatim ===")
def shipped_sweep(conj, adapted, seed=11, cap=60):
    rnd = random.Random(seed)
    cross = 0; tested = 0; first = None
    for lam in adapted:
        c0 = adapted[lam][0]
        byw = byweight(c0); ws = list(byw)
        pairs = [(x, y) for x in range(len(ws)) for y in range(x+1, len(ws))]
        rnd.shuffle(pairs)
        for x, y in pairs[:cap]:
            for a in byw[ws[x]][:1]:
                for b in byw[ws[y]][:1]:
                    tested += 1
                    if ip3(c0[a], c0[b], conj):
                        cross += 1
                        if first is None: first = (lam, ws[x], ws[y], a, b)
        if cross: break
    return cross, tested, first

c, t, f = shipped_sweep(True, RAW)
print(f"  clean, Hermitian : cross = {c}, entries computed = {t}  (assert passes)")
c, t, f = shipped_sweep(False, RAW)
print(f"  BILINEAR sabotage: cross = {c}, entries computed = {t}, "
      f"first witness {f}")
print(f"  -> the assert {'FIRES' if c else 'DOES NOT FIRE'} on the failure mode"
      f" the comment names")

# ---------------- C. a LOCALISED violation -------------------------------
print("\n=== C. one foreign monomial in one vector of one block ===")
# pick a large block, add a weight-mu' monomial to the vector at position 0 of
# some weight, so exactly the pairs involving that vector go nonzero.
import copy as _cp
for lam in [(6, 6), (6, 4), (5, 4)]:
    sab = {k: [list(c) for c in cs] for k, cs in RAW.items()}
    c0 = sab[lam][0]
    byw = byweight(RAW[lam][0]); ws = list(byw)
    # a position deep in the block, not the first of its weight
    victim = byw[ws[len(ws)//2]][-1]
    donor_w = ws[len(ws)//2 + 1]
    donor_mon = max(RAW[lam][0][byw[donor_w][0]])
    c0[victim] = dict(c0[victim]); c0[victim][donor_mon] = (Fr(1), Fr(0))
    c, t, f = shipped_sweep(False if False else True, sab)
    # how many cross-weight pairs does the corruption actually make nonzero?
    print(f"  lambda={lam}: corrupted position {victim} (weight {ws[len(ws)//2]}, "
          f"last of its weight, so byw[..][:1] never selects it)")
    print(f"     shipped sweep: cross = {c} over {t} entries -> "
          f"{'CAUGHT' if c else 'MISSED'}")
    # also confirm the corruption is real: the vector is now inhomogeneous
    print(f"     the homogeneity assert would see it: "
          f"{len({mwt(k) for k in c0[victim]}) > 1}")
