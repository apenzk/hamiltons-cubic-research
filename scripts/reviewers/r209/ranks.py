"""r209, claim 1: reproduce the sampled rank 14 and the restricted rank 13
independently -- own prime (1000003, 3 mod 4, so F_p[i] is a FIELD), own sample
points, own elimination, own restriction, and the restriction built from the
LAST admissible position rather than the first.
"""
import importlib.util, sys, os, time, random
from fractions import Fraction as F

D = "scripts/runs"
def load(n):
    sp = importlib.util.spec_from_file_location(n[:-3], os.path.join(D, n))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m); sys.stdout = o
    return m
t0 = time.time()
ad = load("run_n5_adapted.py"); ev = load("run_n5_evaluate.py")
wm = load("run_n5_weyl_module.py"); ex = load("run_n5_extremiser.py")
ADAPTED, MONO, WWT = ad.ADAPTED, ad.MONO, ad.WWT
IDXOF = {t: k for k, t in enumerate(MONO)}
print(f"[{time.time()-t0:.0f}s] modules", flush=True)

P = 1000003
assert P % 4 == 3
def gp(x):
    a, b = (x.r, x.i) if hasattr(x, "r") else x
    assert a.denominator % P and b.denominator % P
    return (a.numerator * pow(a.denominator % P, P-2, P) % P,
            b.numerator * pow(b.denominator % P, P-2, P) % P)
def mul(u, v): return ((u[0]*v[0]-u[1]*v[1]) % P, (u[0]*v[1]+u[1]*v[0]) % P)
def add(u, v): return ((u[0]+v[0]) % P, (u[1]+v[1]) % P)
def sub(u, v): return ((u[0]-v[0]) % P, (u[1]-v[1]) % P)
def cj(u):     return (u[0], (-u[1]) % P)
def inv(u):
    n = (u[0]*u[0]+u[1]*u[1]) % P
    assert n, "zero norm"
    ni = pow(n, P-2, P); return (u[0]*ni % P, (-u[1]*ni) % P)
ZP = (0, 0)

bad = sum(1 for cs in ADAPTED.values() for c in cs for v in c for x in v.values()
          if gp(x) == ZP and (x.r or x.i))
print(f"  cached coefficients vanishing mod {P}: {bad}  (must be 0)", flush=True)
assert bad == 0

def mwt(i):
    a, b, c = MONO[i]
    return (WWT[a][0]+WWT[b][0]+WWT[c][0], WWT[a][1]+WWT[b][1]+WWT[c][1])
MONS, IDX = {}, {}
for i in range(len(MONO)): MONS.setdefault(mwt(i), []).append(i)
for lam, cs in ADAPTED.items():
    for i, c in enumerate(cs):
        for t, v in enumerate(c):
            if v: IDX.setdefault(mwt(max(v)), []).append((lam, i, t, v))
assert all(len(MONS[w]) == len(IDX[w]) for w in IDX)
print(f"  {len(IDX)} weight blocks", flush=True)

# ---- Q, the abstract Gram of copy 0, block diagonal by weight ----
_C = {}
def ipg(u, v):
    tot = ZP
    for a, ca in u.items():
        ta = MONO[a]; cap = gp(ca)
        if cap == ZP: continue
        for b, cb in v.items():
            k = _C.get((a, b))
            if k is None:
                k = gp(ev.sym3_ip(ta, MONO[b])); _C[(a, b)] = k
            if k != ZP: tot = add(tot, mul(mul(cap, cj(gp(cb))), k))
    return tot
t1 = time.time()
QW = {}
for lam, cs in ADAPTED.items():
    c0 = cs[0]; byw = {}
    for t, v in enumerate(c0):
        if v: byw.setdefault(mwt(max(v)), []).append(t)
    QW[lam] = (byw, {w: [[ipg(c0[a], c0[b]) for b in ts] for a in ts]
                     for w, ts in byw.items()})
    print(f"    Q {lam} done [{time.time()-t1:.0f}s]", flush=True)
print(f"[{time.time()-t0:.0f}s] Q built", flush=True)

# ---- factor each weight block once ----
INV = {}
t1 = time.time()
for w in sorted(IDX, key=lambda w: -len(IDX[w])):
    ent = IDX[w]; mons = MONS[w]; n = len(ent)
    mi = {k: r for r, k in enumerate(mons)}
    A = [[ZP]*n for _ in range(n)]
    for j, (_, _, _, v) in enumerate(ent):
        for k, cv in v.items(): A[mi[k]][j] = gp(cv)
    I = [[(1, 0) if a == b else ZP for b in range(n)] for a in range(n)]
    r = 0
    for c in range(n):
        pv = next((t for t in range(r, n) if A[t][c] != ZP), None)
        assert pv is not None, f"singular at weight {w}"
        A[r], A[pv] = A[pv], A[r]; I[r], I[pv] = I[pv], I[r]
        iv = inv(A[r][c])
        A[r] = [mul(x, iv) for x in A[r]]; I[r] = [mul(x, iv) for x in I[r]]
        for t in range(n):
            if t != r and A[t][c] != ZP:
                f0 = A[t][c]
                A[t] = [sub(x, mul(f0, y)) for x, y in zip(A[t], A[r])]
                I[t] = [sub(x, mul(f0, y)) for x, y in zip(I[t], I[r])]
        r += 1
    INV[w] = (mi, I)
print(f"[{time.time()-t0:.0f}s] {len(INV)} blocks inverted ({time.time()-t1:.0f}s)", flush=True)

def expand(cub):
    byw = {}
    for k, cv in cub.items(): byw.setdefault(mwt(IDXOF[k]), {})[IDXOF[k]] = cv
    X = {lam: [dict() for _ in ADAPTED[lam]] for lam in ADAPTED}
    for w, tgt in byw.items():
        mi, I = INV[w]; n = len(MONS[w])
        b = [ZP]*n
        for k, cv in tgt.items(): b[mi[k]] = gp(cv)
        for row, (lam, i, t, _) in zip(I, IDX[w]):
            acc = ZP
            for aa, bb in enumerate(b):
                if bb != ZP: acc = add(acc, mul(row[aa], bb))
            if acc != ZP: X[lam][i][t] = acc
    return X

def grams(X):
    GS = {}
    for lam in ADAPTED:
        byw, Qb = QW[lam]; m = len(ADAPTED[lam])
        Gm = [[ZP]*m for _ in range(m)]
        for w, ts in byw.items():
            Qm = Qb[w]
            for i in range(m):
                xi = X[lam][i]
                for j in range(m):
                    xj = X[lam][j]; acc = ZP
                    for ti, t in enumerate(ts):
                        a = xi.get(t)
                        if a is None: continue
                        for si, s in enumerate(ts):
                            b = xj.get(s)
                            if b is None: continue
                            acc = add(acc, mul(mul(a, cj(b)), Qm[ti][si]))
                    Gm[i][j] = add(Gm[i][j], acc)
        GS[lam] = Gm
    return GS

ORD = sorted(ADAPTED, key=lambda l: (-len(ADAPTED[l]), l))
def row_of(GS, TR=None):
    out = []
    for lam in ORD:
        Gm = GS[lam]; m = len(Gm)
        if TR is None: Hm = Gm
        else:
            T = TR.get(lam)
            if not T: continue
            k = len(T)
            Hm = [[ZP]*k for _ in range(k)]
            for a in range(k):
                for b in range(k):
                    acc = ZP
                    for i in range(m):
                        if T[a][i] == ZP: continue
                        for j in range(m):
                            if T[b][j] == ZP: continue
                            acc = add(acc, mul(mul(T[a][i], cj(T[b][j])), Gm[i][j]))
                    Hm[a][b] = acc
        for i in range(len(Hm)):
            out.append(Hm[i][i][0])
            for j in range(i+1, len(Hm)):
                out.append(Hm[i][j][0]); out.append(Hm[i][j][1])
    return out

def rank(rows):
    if not rows: return 0
    M = [list(c) for c in zip(*rows)]; r = 0
    for c in range(len(rows)):
        pv = next((t for t in range(r, len(M)) if M[t][c] % P), None)
        if pv is None: continue
        M[r], M[pv] = M[pv], M[r]
        iv = pow(M[r][c], P-2, P); M[r] = [x*iv % P for x in M[r]]
        for t in range(len(M)):
            if t != r and M[t][c] % P:
                f0 = M[t][c]; M[t] = [(x-f0*y) % P for x, y in zip(M[t], M[r])]
        r += 1
    return r

S = ex.S
W0T = wm.sym2_to_R({(a, b): S[a][b] for a in range(len(S))
                    for b in range(a, len(S)) if S[a][b]})
X0 = expand(ev.cube(ev.coords(W0T))); GS0 = grams(X0)

rnd = random.Random(209209)
def rand_w():
    v = [F(rnd.randint(-4, 4)) for _ in range(35)]
    full = [sum(v[j]*wm.BASIS[j][c] for j in range(35) if v[j])
            for c in range(len(wm.SPAIRS))]
    return wm.sym2_to_R({wm.SPAIRS[c]: full[c] for c in range(len(full)) if full[c]})
NS = 22
GSAMP = []
for s in range(NS):
    GSAMP.append(grams(expand(ev.cube(ev.coords(rand_w())))))
    print(f"    sample {s+1}/{NS} [{time.time()-t0:.0f}s]", flush=True)

nh = sum(1 for GS in GSAMP for lam in GS for i in range(len(GS[lam]))
         for j in range(len(GS[lam])) if GS[lam][i][j] != cj(GS[lam][j][i]))
print(f"\n  non-Hermitian Gram entries across {NS} points: {nh}  (must be 0)", flush=True)

R = [row_of(g) for g in GSAMP]
print(f"  unknowns per point: {len(R[0])}  (must be 89)")
print(f"  UNRESTRICTED sampled rank at {NS} points, mod {P}: {rank(R)}", flush=True)

def build_T(pick):
    TR = {}
    for lam in ADAPTED:
        m = len(ADAPTED[lam])
        cols = {t: [X0[lam][i].get(t, ZP) for i in range(m)] for t in
                sorted({t for i in range(m) for t in X0[lam][i]})}
        cols = {t: v for t, v in cols.items() if any(c != ZP for c in v)}
        if not cols:
            TR[lam] = [[(1, 0) if a == b else ZP for b in range(m)] for a in range(m)]
            continue
        u = cols[pick(sorted(cols))]
        k = next(i for i in range(m) if u[i] != ZP)
        rows = []
        for i in range(m):
            if i == k: continue
            v = [ZP]*m; v[i] = (1, 0)
            v[k] = mul((P-1, 0), mul(u[i], inv(u[k])))
            rows.append(v)
        TR[lam] = rows
    return TR

for name, pick in (("FIRST position", lambda ts: ts[0]),
                   ("LAST position", lambda ts: ts[-1]),
                   ("MIDDLE position", lambda ts: ts[len(ts)//2])):
    TR = build_T(pick)
    r0 = row_of(GS0, TR)
    RR = [row_of(g, TR) for g in GSAMP]
    print(f"  T from the {name}: {len(RR[0])} unknowns, row at W_0 nonzero "
          f"{sum(1 for v in r0 if v % P)}/{len(r0)}, RESTRICTED rank {rank(RR)}",
          flush=True)

# the two restrictions the author tried and the assert rejected
_c2 = load("../reviewers/r209/none.py") if False else None
print(f"\n[{time.time()-t0:.0f}s] done", flush=True)
