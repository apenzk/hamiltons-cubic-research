"""r222 claim 2b: recompute highest-weight nullities at a THIRD prime with an
independent rank routine.

Independent of the code under review in three places:
  * prime 1,000,000,007.  Production uses 2^31-1; r221 used 1,000,003.
  * the rank routine is a right-looking elimination with a MIN-COLUMN-DEGREE
    pivot (fewest live rows in the column, ties by shortest row), not the
    Markowitz product rule of run_n12_covariants.sparse_rank.
  * the basis size is checked against the multiplicity function this reviewer
    built by convolution in r222_mult.py, not against n12_sym3_char.pkl.

usage: r222_nullity3.py lam1,..,lam6 [more lambdas]   or  --selftest
"""
import pickle, os, sys, time
from fractions import Fraction as F
from collections import defaultdict
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r222_mult import sym3_weights

P = 1000000007
d = os.path.dirname(os.path.abspath(__file__))
D = pickle.load(open(os.path.join(d, "..", "r216", "weyl12.pkl"), "rb"))
ALPHA, WDIM = D["ALPHA"], D["WEYL"]
WTS = sorted(WDIM); WRANK = {w: k for k, w in enumerate(WTS)}
OFF = {}; _n = 0
for w in WTS: OFF[w] = _n; _n += WDIM[w]
assert _n == 1638

def build_E(corrupt=None):
    E = [defaultdict(list) for _ in range(6)]
    for i in range(6):
        for w, cols in D["E"][i].items():
            tw = tuple(a+b for a, b in zip(w, ALPHA[i]))
            for j, col in enumerate(cols):
                for r, s in enumerate(col):
                    x = F(s)
                    if corrupt is not None and (i, w, j, r) == corrupt[0]:
                        x = x + corrupt[1]
                    if x:
                        E[i][OFF[w]+j].append(
                            (OFF[tw]+r,
                             x.numerator * pow(x.denominator % P, P-2, P) % P))
    return E

def basis(lam):
    """multisets {a<=b<=c} of module basis vectors of total weight lam."""
    B = []
    for wa in WTS:
        for wb in WTS[WRANK[wa]:]:
            need = tuple(lam[t]-wa[t]-wb[t] for t in range(6))
            if need not in WDIM or WRANK[need] < WRANK[wb]: continue
            ra, rb, rc = range(OFF[wa], OFF[wa]+WDIM[wa]), None, None
            for ia in ra:
                for ib in range(max(ia, OFF[wb]), OFF[wb]+WDIM[wb]):
                    for ic in range(max(ib, OFF[need]), OFF[need]+WDIM[need]):
                        B.append((ia, ib, ic))
    return B

def rows_of(lam, E):
    B = basis(lam)
    rows = defaultdict(dict)
    for j, m in enumerate(B):
        for i in range(6):
            acc = defaultdict(int)
            for pos in range(3):
                for r, v in E[i].get(m[pos], ()):
                    acc[tuple(sorted(m[:pos] + (r,) + m[pos+1:]))] += v
            for key, v in acc.items():
                if v % P: rows[(i, key)][j] = v % P
    return len(B), [dict(r) for r in rows.values()]

def rank_mincol(rows):
    """min-column-degree pivoting; live rows updated in place."""
    rowsd = {i: r for i, r in enumerate(rows) if r}
    colrows = defaultdict(set)
    for i, r in rowsd.items():
        for c in r: colrows[c].add(i)
    live = {c: len(s) for c, s in colrows.items() if s}
    rank = 0
    while live:
        bc = min(live, key=lambda c: (live[c], c))
        bi = min(colrows[bc], key=lambda i: (len(rowsd[i]), i))
        pr = rowsd.pop(bi)
        for c in pr:                       # the pivot row leaves the live set
            colrows[c].discard(bi)
        inv = pow(pr[bc], P-2, P)
        for i in list(colrows[bc]):        # eliminate column bc from every row
            r = rowsd[i]; f0 = r[bc]*inv % P
            for c, v in pr.items():
                o = r.get(c, 0); nv = (o - f0*v) % P
                if nv:
                    if not o: colrows[c].add(i)
                    r[c] = nv
                elif o:
                    colrows[c].discard(i); r.pop(c, None)
            if not r: del rowsd[i]
        assert not colrows[bc], "pivot column survived elimination"
        colrows.pop(bc)                    # ONLY the pivot column dies
        for c in pr:                       # refresh counts touched by the step
            if c != bc:
                live[c] = len(colrows[c])
        for c in list(live):
            if c not in colrows or not colrows[c]: live.pop(c, None)
        rank += 1
    return rank

def run(lam, E=None, tag=""):
    t0 = time.time()
    E = E or build_E()
    nc, rows = rows_of(lam, E)
    t1 = time.time()
    rk = rank_mincol(rows)
    print(f"  {str(lam):22s}{tag} dim {nc:>8,} rows {len(rows):>9,} "
          f"nullity_p3 {nc-rk:>3d}  [build {t1-t0:.1f}s rank {time.time()-t1:.1f}s]",
          flush=True)
    return nc, nc-rk

if __name__ == "__main__":
    SY = sym3_weights(WDIM)
    BL = pickle.load(open(os.path.join(d, "..", "..", "runs", "n12_sym3_blocks.pkl"), "rb"))
    args = sys.argv[1:]
    print(f"prime {P:,}  (production 2,147,483,647; r221 1,000,003)")
    bad = 0
    for a in args:
        lam = tuple(int(x) for x in a.split(","))
        nc, nul = run(lam)
        exp_dim, exp_m = SY[lam], BL[lam]
        ok_d, ok_m = nc == exp_dim, nul == exp_m
        print(f"      dim vs my own character: {exp_dim:,} -> {ok_d};"
              f"  nullity vs m_lambda {exp_m}: {ok_m}")
        bad += (not ok_d) + (not ok_m)
    print(f"\n  {len(args)} blocks, {bad} disagreements")
