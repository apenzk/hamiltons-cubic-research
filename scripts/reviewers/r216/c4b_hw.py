"""r216, claim 4b, part 2.  Run the n=5 HIGHEST-WEIGHT construction at n=12.

The commit closes this route on a size: the trivial weight space of Sym^3 is
635,220, against 234 at n=5.  This file runs the route at n=12 on real blocks and
reports what it actually costs -- basis of the lambda weight space of Sym^3,
stack the six simple raising operators, take the kernel, compare its dimension
with the multiplicity m_lambda the character already fixes.

The kernel dimension is certified: over Q the nullity is at least m_lambda by
complete reducibility, and reducing mod p can only lower the rank, so a mod-p
nullity EQUAL to m_lambda pins the nullity over Q to m_lambda exactly.
"""
import pickle, os, sys, time
from fractions import Fraction as F
from itertools import combinations_with_replacement as cwr
from collections import defaultdict
import numpy as np

P = 2147483647
d = os.path.dirname(os.path.abspath(__file__))
D = pickle.load(open(os.path.join(d, "weyl12.pkl"), "rb"))
ALPHA = D["ALPHA"]; R = 6
WDIM = D["WEYL"]                                  # weight -> multiplicity
WTS = sorted(WDIM)
WRANK = {w: k for k, w in enumerate(WTS)}
OFF = {}; n = 0
for w in WTS: OFF[w] = n; n += WDIM[w]
assert n == 1638
GW = [None]*n
for w in WTS:
    for k in range(WDIM[w]): GW[OFF[w]+k] = w

# E[i] as a global sparse map: column j -> list of (row, coeff mod p)
Emod = [defaultdict(list) for _ in range(6)]
for i in range(6):
    for w, cols in D["E"][i].items():
        tw = tuple(a+b for a, b in zip(w, ALPHA[i]))
        for j, col in enumerate(cols):
            for r, s in enumerate(col):
                x = F(s)
                if x:
                    v = (x.numerator % P) * pow(x.denominator % P, P-2, P) % P
                    Emod[i][OFF[w]+j].append((OFF[tw]+r, v))
print(f"raising operators loaded: nnz {[sum(len(v) for v in e.values()) for e in Emod]}")

def sym3_basis(lam):
    """multisets {a<=b<=c} of weight-basis indices with wt sum lam."""
    out = []
    S = set(WTS)
    for i1, w1 in enumerate(WTS):
        for w2 in WTS[i1:]:
            w3 = tuple(lam[t]-w1[t]-w2[t] for t in range(R))
            if w3 not in S or WRANK[w3] < WRANK[w2]: continue
            A = range(OFF[w1], OFF[w1]+WDIM[w1])
            B = range(OFF[w2], OFF[w2]+WDIM[w2])
            C = range(OFF[w3], OFF[w3]+WDIM[w3])
            if w1 == w2 == w3:
                out.extend(cwr(A, 3))
            elif w1 == w2:
                out.extend((a, b, c) for a, b in cwr(A, 2) for c in C)
            elif w2 == w3:
                out.extend((a, b, c) for a in A for b, c in cwr(B, 2))
            else:
                out.extend((a, b, c) for a in A for b in B for c in C)
    return out

def rank_modp(rows, ncol):
    """rank over GF(P) of a sparse matrix given as {row: {col: val}}."""
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

def hw_dim(lam, verbose=True):
    t0 = time.time()
    B = sym3_basis(lam)
    ci = {m: k for k, m in enumerate(B)}
    tgt = {}
    rows = defaultdict(dict)
    for j, m in enumerate(B):
        for i in range(6):
            acc = defaultdict(int)
            for pos in range(3):
                a = m[pos]
                for r, v in Emod[i].get(a, ()):
                    key = tuple(sorted(m[:pos] + (r,) + m[pos+1:]))
                    acc[key] = (acc[key] + v) % P
            for key, v in acc.items():
                if v: rows[(i, key)][j] = v
    nrow = len(rows)
    t1 = time.time()
    rk = rank_modp(list(rows.values()), len(B))
    nul = len(B) - rk
    if verbose:
        print(f"  {str(lam):24s} dim {len(B):>7,}  rows {nrow:>8,}  "
              f"nullity {nul:>3d}  [build {t1-t0:.1f}s, rank {time.time()-t1:.1f}s]")
    return len(B), nul, time.time()-t0

if __name__ == "__main__":
    BL = pickle.load(open(os.path.join(d, "..", "..", "runs", "n12_sym3_blocks.pkl"), "rb"))
    S3 = pickle.load(open(os.path.join(d, "..", "..", "runs", "n12_sym3_char.pkl"), "rb"))
    cap = int(sys.argv[1]) if len(sys.argv) > 1 else 1200
    todo = sorted(((S3[l], l, BL[l]) for l in BL))
    todo = [x for x in todo if x[0] <= cap]
    print(f"\nrunning the highest-weight construction on {len(todo)} blocks of "
          f"Sym^3 weight space up to {cap}")
    bad = []
    tot = 0.0
    for dd, l, m in todo:
        n_, nul, el = hw_dim(l)
        tot += el
        if nul != m:
            bad.append((l, nul, m)); print("     MISMATCH: expected", m)
    print(f"\n  {len(todo)} blocks, {sum(x[2] for x in todo)} multiplicities, "
          f"{len(bad)} mismatches, total {tot:.1f}s")
