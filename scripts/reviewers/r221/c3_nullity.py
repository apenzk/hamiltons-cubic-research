"""r221, claim 3b.  Recompute the highest-weight nullities WITHOUT the prime.

Two independent recomputations per block:
  Q    exact rational Gaussian elimination on the raising-operator matrix built
       from the ORIGINAL Fraction structure constants -- no reduction anywhere,
       so this is nullity_Q itself, not a certificate for it;
  p2   a second prime, 1,000,003, far from 2^31-1.
Enumeration comes from the independent index loop of c2_basis (enumB), not from
the author's weight loop, so the whole pipeline is disjoint from the one under
review except for the pickled structure constants.
"""
import pickle, os, sys, time
from fractions import Fraction as F
from collections import defaultdict

d = os.path.dirname(os.path.abspath(__file__))
D = pickle.load(open(os.path.join(d, "..", "r216", "weyl12.pkl"), "rb"))
ALPHA = D["ALPHA"]; WDIM = D["WEYL"]; WTS = sorted(WDIM)
OFF = {}; n = 0
for w in WTS: OFF[w] = n; n += WDIM[w]
GW = [None]*n
for w in WTS:
    for k in range(WDIM[w]): GW[OFF[w]+k] = w
R = 6

EQ = [defaultdict(list) for _ in range(6)]         # exact rationals
for i in range(6):
    for w, cols in D["E"][i].items():
        tw = tuple(a+b for a, b in zip(w, ALPHA[i]))
        for j, col in enumerate(cols):
            for r, s in enumerate(col):
                x = F(s)
                if x: EQ[i][OFF[w]+j].append((OFF[tw]+r, x))

def enumB(lam):
    B = []
    for ia in range(n):
        wa = GW[ia]
        for ib in range(ia, n):
            wb = GW[ib]
            need = tuple(lam[t]-wa[t]-wb[t] for t in range(R))
            if need not in WDIM: continue
            for ic in range(max(ib, OFF[need]), OFF[need]+WDIM[need]):
                B.append((ia, ib, ic))
    return B

def build(lam, red):
    """red maps a Fraction to the working field element."""
    B = enumB(lam)
    rows = defaultdict(dict)
    for j, m in enumerate(B):
        for i in range(6):
            acc = defaultdict(F)
            for pos in range(3):
                for r, v in EQ[i].get(m[pos], ()):
                    key = tuple(sorted(m[:pos] + (r,) + m[pos+1:]))
                    acc[key] += v
            for key, v in acc.items():
                if v:
                    vv = red(v)
                    if vv: rows[(i, key)][j] = vv
    return len(B), [dict(r) for r in rows.values()]

def rank_generic(rows, inv, zero):
    """rank by shortest-row-first elimination in any field."""
    live = [r for r in rows if r]
    piv = {}; rk = 0
    while live:
        live.sort(key=len)
        r = live.pop(0)
        while True:
            hit = next((c for c in r if c in piv), None)
            if hit is None: break
            pr = piv[hit]; f0 = r[hit]*inv(pr[hit])
            for c, v in pr.items():
                nv = r.get(c, zero) - f0*v
                nv = nv if not isinstance(nv, int) else nv
                if nv: r[c] = nv
                else: r.pop(c, None)
            if hit in r: r.pop(hit, None)
        if not r: continue
        piv[min(r)] = r; rk += 1
    return rk

def rank_modp(rows, P):
    live = [dict(r) for r in rows if r]
    piv = {}; rk = 0
    while live:
        live.sort(key=len)
        r = live.pop(0)
        while True:
            hit = next((c for c in r if c in piv), None)
            if hit is None: break
            pr = piv[hit]; f0 = r[hit]*pow(pr[hit], P-2, P) % P
            for c, v in pr.items():
                nv = (r.get(c, 0) - f0*v) % P
                if nv: r[c] = nv
                else: r.pop(c, None)
        if not r: continue
        piv[min(r)] = r; rk += 1
    return rk

def rank_Q(rows):
    live = [dict(r) for r in rows if r]
    piv = {}; rk = 0
    while live:
        live.sort(key=len)
        r = live.pop(0)
        while True:
            hit = next((c for c in r if c in piv), None)
            if hit is None: break
            pr = piv[hit]; f0 = r[hit]/pr[hit]
            for c, v in pr.items():
                nv = r.get(c, F(0)) - f0*v
                if nv: r[c] = nv
                else: r.pop(c, None)
        if not r: continue
        piv[min(r)] = r; rk += 1
    return rk

P2 = 1000003
RUNS = os.path.join(d, "..", "..", "runs")
BL = pickle.load(open(os.path.join(RUNS, "n12_sym3_blocks.pkl"), "rb"))
S3 = pickle.load(open(os.path.join(RUNS, "n12_sym3_char.pkl"), "rb"))
capQ = int(sys.argv[1]) if len(sys.argv) > 1 else 400
capP = int(sys.argv[2]) if len(sys.argv) > 2 else 1500
todo = sorted(((S3[l], l) for l in BL))
bad = []
for dd, lam in todo:
    if dd > capP: break
    t0 = time.time()
    nc, rowsP = build(lam, lambda x: x.numerator*pow(x.denominator % P2, P2-2, P2) % P2)
    nulP = nc - rank_modp(rowsP, P2)
    line = (f"  {str(lam):24s} dim {nc:>6,}  nullity_p2 {nulP:>3d}  "
            f"m_lambda {BL[lam]:>3d}")
    nulQ = None
    if dd <= capQ:
        nc2, rowsQ = build(lam, lambda x: x)
        assert nc2 == nc
        nulQ = nc - rank_Q(rowsQ)
        line += f"  nullity_Q {nulQ:>3d}"
    line += f"   [{time.time()-t0:.1f}s]"
    ok = (nulP == BL[lam]) and (nulQ is None or nulQ == BL[lam])
    if not ok:
        bad.append((lam, nulP, nulQ, BL[lam])); line += "   <-- DISAGREE"
    print(line, flush=True)
print(f"\n{len(bad)} disagreements")
