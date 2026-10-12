"""Negative controls for run_n5_assemble.py's "every weight block is square".

The shipped check is a COUNT:
    square = all(len(MONS.get(w, [])) == len(COLS[w]) for w in COLS)
with each adapted vector labelled by  mwt(max(v))  -- the weight of the
monomial of largest index in its support.

This script (1) reproduces it on the true basis, (2) runs it on four corrupted
bases, (3) runs the check the claim actually asserts -- that the vectors of a
weight are a BASIS of that weight space, i.e. the per-weight matrix is
nonsingular -- on the same five inputs.
"""
import pickle, os, sys, itertools, json, random, time
from fractions import Fraction as Fr

d = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                 "..", "..", "runs"))
C = json.load(open(os.path.join(d, "n5_hw_cache.json")))
WT = [tuple(w) for w in C["weights"]]
MONO = list(itertools.combinations_with_replacement(range(35), 3))
RAW = pickle.load(open(os.path.join(d, "n5_adapted.pkl"), "rb"))
# vectors as {monomial index: (Fraction re, Fraction im)}
def conv(x):
    r, i = x
    return (Fr(r), Fr(i))
ADAPTED = {lam: [[{k: conv(v) for k, v in vec.items()} for vec in copy]
                 for copy in cs] for lam, cs in RAW.items()}
print(f"loaded {sum(len(v) for cs in ADAPTED.values() for v in cs)} adapted vectors")

def mwt(idx):
    a, b, c = MONO[idx]
    return (WT[a][0]+WT[b][0]+WT[c][0], WT[a][1]+WT[b][1]+WT[c][1])

MONS = {}
for idx in range(len(MONO)): MONS.setdefault(mwt(idx), []).append(idx)

def shipped_square(adapted):
    """lines 60-155 of run_n5_assemble.py, verbatim in substance."""
    BYW = {}
    for lam, copies in adapted.items():
        for i, c in enumerate(copies):
            for t, v in enumerate(c):
                if not v: continue
                BYW.setdefault(mwt(max(v)), []).append((lam, i, t, v))
    tot = sum(len(v) for v in BYW.values())
    COLS = BYW
    square = all(len(MONS.get(w, [])) == len(COLS[w]) for w in COLS)
    return square, tot, COLS

# ---------- the check the CLAIM makes: each weight block is a basis ----------
P = 1000000009                      # prime, P % 4 == 1
I = next(t for g in range(2, 200)
         for t in [pow(g, (P-1)//4, P)] if (t*t) % P == P-1)   # sqrt(-1) mod P

def red(x):
    """Gaussian rational -> element of F_P (i |-> I).  None if P | denominator."""
    r, im = x
    if r.denominator % P == 0 or im.denominator % P == 0: return None
    a = r.numerator * pow(r.denominator, P-2, P) % P
    b = im.numerator * pow(im.denominator, P-2, P) % P
    return (a + b*I) % P

def rank_modp(cols, rows):
    """rank over F_P of the |rows| x |cols| matrix of the given vectors."""
    ridx = {m: k for k, m in enumerate(rows)}
    M = []
    for (_, _, _, v) in cols:
        col = [0]*len(rows)
        for k, c in v.items():
            if k not in ridx: return None          # support leaves the weight space
            e = red(c)
            if e is None: return None
            col[ridx[k]] = e
        M.append(col)
    # eliminate on the transpose (columns as rows)
    r = 0; n = len(rows)
    for c in range(n):
        p = next((k for k in range(r, len(M)) if M[k][c]), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        inv = pow(M[r][c], P-2, P)
        M[r] = [x*inv % P for x in M[r]]
        for k in range(len(M)):
            if k != r and M[k][c]:
                f = M[k][c]
                M[k] = [(x - f*y) % P for x, y in zip(M[k], M[r])]
        r += 1
        if r == len(M): break
    return r

def basis_check(COLS, limit=None):
    """for every weight: are the labelled vectors a basis of that weight space?"""
    bad = []
    ws = sorted(COLS, key=lambda w: -len(COLS[w]))
    if limit: ws = ws[:limit]
    for w in ws:
        rows = MONS.get(w, [])
        rk = rank_modp(COLS[w], rows)
        if rk is None:
            bad.append((w, "support outside the weight space", len(COLS[w]), len(rows)))
        elif rk != len(rows) or rk != len(COLS[w]):
            bad.append((w, f"rank {rk}", len(COLS[w]), len(rows)))
    return bad

# ---------- homogeneity, which nothing in the pipeline tests ----------
def homogeneous(adapted):
    bad = 0
    for lam, cs in adapted.items():
        for c in cs:
            for v in c:
                if not v: continue
                ws = {mwt(k) for k in v}
                if len(ws) != 1: bad += 1
    return bad

# ---------- corruptions ----------
def clone(a):
    return {lam: [[dict(v) for v in c] for c in cs] for lam, cs in a.items()}

def corrupt_duplicate(a):
    """replace one vector by a copy of another vector of the SAME weight."""
    a = clone(a)
    byw = {}
    for lam, cs in a.items():
        for i, c in enumerate(cs):
            for t, v in enumerate(c):
                if v: byw.setdefault(mwt(max(v)), []).append((lam, i, t))
    for w, ent in byw.items():
        if len(ent) >= 2:
            (l1, i1, t1), (l2, i2, t2) = ent[0], ent[1]
            a[l2][i2][t2] = dict(a[l1][i1][t1])
            return a, f"weight {w}: vector ({l2},{i2},{t2}) := ({l1},{i1},{t1})"
    return a, "none"

def corrupt_nonhomog(a):
    """v := v + v', v' of a DIFFERENT weight with a smaller max index, so the
    shipped label mwt(max(v)) is unchanged."""
    a = clone(a)
    flat = [(lam, i, t) for lam, cs in a.items() for i, c in enumerate(cs)
            for t, v in enumerate(c) if v]
    for (l1, i1, t1) in flat:
        v1 = a[l1][i1][t1]; m1 = max(v1)
        for (l2, i2, t2) in flat:
            v2 = a[l2][i2][t2]
            if mwt(max(v2)) == mwt(m1) or max(v2) >= m1: continue
            new = dict(v1)
            for k, c in v2.items():
                cur = new.get(k, (Fr(0), Fr(0)))
                new[k] = (cur[0]+c[0], cur[1]+c[1])
            if max(new) != m1: continue
            a[l1][i1][t1] = new
            return a, (f"({l1},{i1},{t1}) += ({l2},{i2},{t2}); label "
                       f"{mwt(m1)} unchanged, support now spans "
                       f"{len({mwt(k) for k in new})} weights")
    return a, "none"

def corrupt_scale(a):
    """multiply one vector by 7 -- still a basis, a benign change."""
    a = clone(a)
    for lam, cs in a.items():
        for c in cs:
            for t, v in enumerate(c):
                if v:
                    c[t] = {k: (7*x[0], 7*x[1]) for k, x in v.items()}
                    return a, f"one vector of lambda={lam} scaled by 7"
    return a, "none"

def corrupt_copyclone(a):
    """TWO COPIES COINCIDE -- plan.md's seventh vacuous check, verbatim.
    replay() applies a FIXED word list, so setting u_1 := u_0 reproduces copy 0
    vector by vector; no recomputation is needed to realise it exactly."""
    a = clone(a)
    for lam, cs in a.items():
        if len(cs) > 1:
            cs[1] = [dict(v) for v in cs[0]]
            return a, f"lambda={lam}: copy 1 := copy 0 (u_1 = u_0)"
    return a, "none"

def corrupt_delete(a):
    """zero one vector -- the ONE corruption the count can see."""
    a = clone(a)
    for lam, cs in a.items():
        for c in cs:
            for t, v in enumerate(c):
                if v:
                    c[t] = {}
                    return a, f"one vector of lambda={lam} zeroed"
    return a, "none"

t0 = time.time()
CASES = [("TRUE adapted basis", ADAPTED, "-")]
for f in (corrupt_duplicate, corrupt_nonhomog, corrupt_copyclone, corrupt_scale, corrupt_delete):
    b, note = f(ADAPTED)
    CASES.append((f.__name__[8:], b, note))

LIMIT = int(sys.argv[1]) if len(sys.argv) > 1 else 0
if os.environ.get("TRUE_ONLY"): CASES = CASES[:1]
print(f"\n{'case':12s} {'shipped square?':16s} {'#vec':>6s} {'non-homog':>10s}  "
      f"{'basis check':s}")
for name, a, note in CASES:
    sq, tot, COLS = shipped_square(a)
    nh = homogeneous(a)
    bad = basis_check(COLS, LIMIT or None)
    verdict = "PASS" if not bad else f"FIRES on {len(bad)} weights, e.g. {bad[0]}"
    print(f"{name:12s} {str(sq):16s} {tot:6d} {nh:10d}  {verdict}")
    print(f"             note: {note}")
print(f"\n[{time.time()-t0:.0f}s]  weights checked per case: "
      f"{LIMIT if LIMIT else 'all'}")
