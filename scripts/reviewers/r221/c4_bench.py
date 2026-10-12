"""r221, claim 4.  Sparse against dense ON THE SAME BLOCK.

The commit concludes "sparse elimination is 20x WORSE than dense" from 6,137
columns sparse in 1,943 s against 13,444 columns dense in 103 s.  Those are
different blocks, and elimination is superlinear, so the comparison cannot
support the ratio it is used for.  This runs both on identical matrices.

Three rank routines, same input:
  S   the author's sparse_rank, copied verbatim from run_n12_covariants.py;
  D   r216's dense numpy rank_modp, copied verbatim;
  M   a sparse elimination done properly -- Markowitz pivoting on a live row set
      with the OTHER rows actually updated, which is what "sparse elimination"
      normally means.
"""
import pickle, os, sys, time
from fractions import Fraction as F
from collections import defaultdict
import numpy as np

P = 2147483647
d = os.path.dirname(os.path.abspath(__file__))
D = pickle.load(open(os.path.join(d, "..", "r216", "weyl12.pkl"), "rb"))
ALPHA = D["ALPHA"]; WDIM = D["WEYL"]; WTS = sorted(WDIM)
WRANK = {w: k for k, w in enumerate(WTS)}
OFF = {}; n = 0
for w in WTS: OFF[w] = n; n += WDIM[w]
GW = [None]*n
for w in WTS:
    for k in range(WDIM[w]): GW[OFF[w]+k] = w
R = 6
Emod = [defaultdict(list) for _ in range(6)]
for i in range(6):
    for w, cols in D["E"][i].items():
        tw = tuple(a+b for a, b in zip(w, ALPHA[i]))
        for j, col in enumerate(cols):
            for r, s in enumerate(col):
                x = F(s)
                if x:
                    Emod[i][OFF[w]+j].append(
                        (OFF[tw]+r, x.numerator*pow(x.denominator % P, P-2, P) % P))

def basis(lam):
    B = []
    for a, wa in enumerate(WTS):
        for b, wb in enumerate(WTS[a:], start=a):
            need = tuple(lam[t]-wa[t]-wb[t] for t in range(6))
            if need not in WDIM: continue
            if WRANK[need] < b: continue
            for ia in range(OFF[wa], OFF[wa]+WDIM[wa]):
                for ib in range(max(ia, OFF[wb]), OFF[wb]+WDIM[wb]):
                    for ic in range(max(ib, OFF[need]), OFF[need]+WDIM[need]):
                        B.append((ia, ib, ic))
    return B

def matrix(lam):
    B = basis(lam)
    rows = defaultdict(dict)
    for j, m in enumerate(B):
        for i in range(6):
            acc = defaultdict(int)
            for pos in range(3):
                for r, v in Emod[i].get(m[pos], ()):
                    key = tuple(sorted(m[:pos] + (r,) + m[pos+1:]))
                    acc[key] = (acc[key] + v) % P
            for key, v in acc.items():
                if v: rows[(i, key)][j] = v
    return len(B), [dict(r) for r in rows.values()]

# ---- S: the author's routine, verbatim -----------------------------------
def sparse_rank(rows, ncols):
    live = [r for r in rows if r]
    piv = {}
    rank = 0
    while live:
        live.sort(key=len)
        r = live.pop(0)
        while True:
            hit = next((c for c in r if c in piv), None)
            if hit is None: break
            pr = piv[hit]; f0 = r[hit] * pow(pr[hit], P-2, P) % P
            for c, v in pr.items():
                nv = (r.get(c, 0) - f0*v) % P
                if nv: r[c] = nv
                else: r.pop(c, None)
        if not r: continue
        c0 = min(r, key=lambda c: (len(r), c))
        piv[c0] = r
        rank += 1
    return rank

# ---- D: r216's dense numpy routine, verbatim ------------------------------
def rank_modp_dense(rows, ncol):
    M = np.zeros((len(rows), ncol), dtype=np.int64)
    for i, r in enumerate(rows):
        for j, v in r.items(): M[i, j] = v
    rk = 0
    for c in range(ncol):
        nz = np.nonzero(M[rk:, c])[0]
        if nz.size == 0: continue
        pr = rk + nz[0]
        if pr != rk: M[[rk, pr]] = M[[pr, rk]]
        inv = pow(int(M[rk, c]), P-2, P)
        M[rk] = (M[rk] * inv) % P
        col = M[rk+1:, c].copy()
        nzr = np.nonzero(col)[0]
        if nzr.size:
            M[rk+1:][nzr] = (M[rk+1:][nzr] - col[nzr, None]*M[rk][None, :]) % P
        rk += 1
        if rk == M.shape[0]: break
    return rk

# ---- M: sparse elimination as normally meant ------------------------------
def sparse_markowitz(rows, ncols):
    """Live rows are actually UPDATED, and the pivot is chosen to minimise
    fill by a Markowitz score (row length times column count)."""
    rowsd = {i: dict(r) for i, r in enumerate(rows) if r}
    colrows = defaultdict(set)
    for i, r in rowsd.items():
        for c in r: colrows[c].add(i)
    rank = 0
    while rowsd:
        # cheapest pivot: minimise (len(row)-1)*(len(col)-1)
        bi = bc = None; best = None
        for i, r in rowsd.items():
            lr = len(r) - 1
            if best == 0: break
            for c in r:
                sc = lr * (len(colrows[c]) - 1)
                if best is None or sc < best:
                    best, bi, bc = sc, i, c
                    if sc == 0: break
        pr = rowsd.pop(bi)
        for c in pr: colrows[c].discard(bi)
        inv = pow(pr[bc], P-2, P)
        targets = list(colrows[bc])
        for i in targets:
            r = rowsd[i]
            f0 = r[bc]*inv % P
            for c, v in pr.items():
                old = r.get(c, 0)
                nv = (old - f0*v) % P
                if nv:
                    if not old: colrows[c].add(i)
                    r[c] = nv
                else:
                    if old: colrows[c].discard(i); r.pop(c, None)
            if not r: del rowsd[i]
        rank += 1
    return rank

if __name__ == "__main__":
    RUNS = os.path.join(d, "..", "..", "runs")
    BL = pickle.load(open(os.path.join(RUNS, "n12_sym3_blocks.pkl"), "rb"))
    S3 = pickle.load(open(os.path.join(RUNS, "n12_sym3_char.pkl"), "rb"))
    which = sys.argv[1:] or ["794", "1697", "2614", "4186", "6137"]
    by = {S3[l]: l for l in BL}
    print(f"{'lambda':24s} {'cols':>7s} {'rows':>7s} {'nnz':>9s} "
          f"{'S author':>10s} {'D dense':>10s} {'M sparse':>10s}  nullities")
    for k in which:
        lam = by[int(k)]
        nc, rows = matrix(lam)
        nnz = sum(len(r) for r in rows)
        res = {}
        for tag, fn in (("D", rank_modp_dense), ("M", sparse_markowitz),
                        ("S", sparse_rank)):
            t = time.time()
            rk = fn([dict(r) for r in rows], nc)
            res[tag] = (time.time()-t, nc-rk)
        print(f"{str(lam):24s} {nc:>7,} {len(rows):>7,} {nnz:>9,} "
              f"{res['S'][0]:>9.1f}s {res['D'][0]:>9.1f}s {res['M'][0]:>9.1f}s  "
              f"S{res['S'][1]} D{res['D'][1]} M{res['M'][1]} m{BL[lam]}", flush=True)
