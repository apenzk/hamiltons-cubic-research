"""r221, claim 2.  Does the by-weight enumeration produce exactly the lambda
weight space of Sym^3 V, each unordered triple once?

Three enumerations compared as SETS, not as counts, so a compensating
miss-plus-double-count cannot hide:
  A  the author's loop, copied verbatim from run_n12_covariants.py;
  B  an independent loop with a different shape -- iterate over BASIS INDICES
     ia <= ib and solve for the third weight, instead of iterating over weight
     PAIRS and solving for the third weight;
  C  r216's sym3_basis, which splits into four cwr cases.
Plus the count against the symmetric-function character of r216's c4a.
"""
import pickle, os, sys
from collections import defaultdict
from itertools import combinations_with_replacement as cwr

d = os.path.dirname(os.path.abspath(__file__))
D = pickle.load(open(os.path.join(d, "..", "r216", "weyl12.pkl"), "rb"))
WDIM = D["WEYL"]; WTS = sorted(WDIM); WRANK = {w: k for k, w in enumerate(WTS)}
OFF = {}; n = 0
for w in WTS: OFF[w] = n; n += WDIM[w]
GW = [None]*n
for w in WTS:
    for k in range(WDIM[w]): GW[OFF[w]+k] = w
R = 6

def enumA(lam):                       # verbatim from run_n12_covariants.py
    B = []
    for a, wa in enumerate(WTS):
        for b, wb in enumerate(WTS[a:], start=a):
            need = tuple(lam[t] - wa[t] - wb[t] for t in range(6))
            if need not in WDIM: continue
            c = WRANK[need]
            if c < b: continue
            for ia in range(OFF[wa], OFF[wa]+WDIM[wa]):
                for ib in range(max(ia, OFF[wb]), OFF[wb]+WDIM[wb]):
                    for ic in range(max(ib, OFF[need]), OFF[need]+WDIM[need]):
                        B.append((ia, ib, ic))
    return B

def enumB(lam):                       # independent: loop over basis indices
    B = []
    for ia in range(n):
        wa = GW[ia]
        for ib in range(ia, n):
            wb = GW[ib]
            need = tuple(lam[t] - wa[t] - wb[t] for t in range(R))
            if need not in WDIM: continue
            lo = max(ib, OFF[need]); hi = OFF[need] + WDIM[need]
            for ic in range(lo, hi): B.append((ia, ib, ic))
    return B

def enumC(lam):                       # r216's four-case version
    out = []; S = set(WTS)
    for i1, w1 in enumerate(WTS):
        for w2 in WTS[i1:]:
            w3 = tuple(lam[t]-w1[t]-w2[t] for t in range(R))
            if w3 not in S or WRANK[w3] < WRANK[w2]: continue
            A = range(OFF[w1], OFF[w1]+WDIM[w1])
            Bb = range(OFF[w2], OFF[w2]+WDIM[w2])
            C = range(OFF[w3], OFF[w3]+WDIM[w3])
            if w1 == w2 == w3: out.extend(cwr(A, 3))
            elif w1 == w2: out.extend((a, b, c) for a, b in cwr(A, 2) for c in C)
            elif w2 == w3: out.extend((a, b, c) for a in A for b, c in cwr(Bb, 2))
            else: out.extend((a, b, c) for a in A for b in Bb for c in C)
    return out

# --- symmetric-function character, independent of the pickled weight system ---
def e_(i, s):
    v = [0]*R; v[i] = s; return tuple(v)
X = [e_(i, s) for i in range(R) for s in (1, -1)]
def h(k):
    dd = defaultdict(int)
    for c in cwr(X, k): dd[tuple(sum(t) for t in zip(*c))] += 1
    return dict(dd)
def mul(P_, Q):
    dd = defaultdict(int)
    for a, ca in P_.items():
        for b, cb in Q.items(): dd[tuple(a[t]+b[t] for t in range(R))] += ca*cb
    return {k: v for k, v in dd.items() if v}
def subd(P_, Q):
    dd = defaultdict(int, P_)
    for k, v in Q.items(): dd[k] -= v
    return {k: v for k, v in dd.items() if v}
h1, h2, h3 = h(1), h(2), h(3)
CHI = subd(subd(mul(h2, h2), mul(h3, h1)), h2)
assert sum(CHI.values()) == 1638
# CHI must equal the pickled weight system -- otherwise everything downstream differs
print("CHI == pickled WDIM:", CHI == WDIM)
C2 = mul(CHI, CHI)
P2 = {tuple(2*x for x in k): v for k, v in CHI.items()}
P3 = {tuple(3*x for x in k): v for k, v in CHI.items()}
def dim_sym3(lam):
    A1 = sum(c*C2.get(tuple(lam[t]-w[t] for t in range(R)), 0) for w, c in CHI.items())
    A2 = sum(c*P2.get(tuple(lam[t]-w[t] for t in range(R)), 0) for w, c in CHI.items())
    A3 = P3.get(lam, 0)
    q, r = divmod(A1 + 3*A2 + 2*A3, 6)
    assert r == 0
    return q

RUNS = os.path.join(d, "..", "..", "runs")
BL = pickle.load(open(os.path.join(RUNS, "n12_sym3_blocks.pkl"), "rb"))
S3 = pickle.load(open(os.path.join(RUNS, "n12_sym3_char.pkl"), "rb"))
cap = int(sys.argv[1]) if len(sys.argv) > 1 else 900
todo = sorted(((S3[l], l) for l in BL))
todo = [x for x in todo if x[0] <= cap]
print(f"{len(todo)} blocks with weight space <= {cap}")
bad = 0
for dd, lam in todo:
    A = enumA(lam); Bl = enumB(lam); C = enumC(lam)
    sA, sB, sC = set(A), set(Bl), set(C)
    ok = (len(A) == len(sA) == len(Bl) == len(sB) == len(C) == len(sC)
          and sA == sB == sC and len(A) == dd == S3[lam] == dim_sym3(lam))
    # weight of every triple must be lam
    wok = all(tuple(GW[t[0]][k]+GW[t[1]][k]+GW[t[2]][k] for k in range(R)) == lam for t in A)
    sortok = all(t[0] <= t[1] <= t[2] for t in A)
    if not (ok and wok and sortok):
        bad += 1
        print(f"  DISAGREE {lam}: |A|={len(A)} uniq {len(sA)} |B|={len(Bl)} uniq {len(sB)} "
              f"|C|={len(C)} uniq {len(sC)} char {dd} symfun {dim_sym3(lam)} "
              f"wt-ok {wok} sorted {sortok}")
        print("   in A not B:", list(sA-sB)[:5], " in B not A:", list(sB-sA)[:5])
    else:
        print(f"  ok {str(lam):24s} dim {len(A):>7,}  A=B=C as sets, no repeats, "
              f"all sorted, weight correct, = character = symmetric-function count")
print(f"\n{len(todo)} blocks, {bad} disagreements")
