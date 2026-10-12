"""The 184 covariants at n=12, by the highest-weight construction.  Step 3.

The route was closed in 537ab39 on a single number -- the trivial weight space of
Sym^3 is 635,220 -- and reopened after reviewer 216 refuted the inference and RAN
the construction on 61 of 77 blocks with 0 mismatches.  This is the production
version of that, carrying 216's two structural findings:

  * only the SIX SIMPLE raising operators are needed, not all 66 generators.
    They carry 6,714 nonzeros between them, density 4.2e-4.
  * the mod-p kernel is the REDUCTION of the rational one.  Over Q the nullity is
    at least m_lambda -- complete reducibility puts an m_lambda-dimensional
    multiplicity space in the kernel -- and reducing mod p can only lower the
    rank, hence only raise the nullity, so nullity_p >= nullity_Q >= m_lambda.
    A mod-p nullity EQUAL to m_lambda forces both inequalities to be equalities.

    WHAT THAT BUYS, stated correctly -- reviewer 221, who found this docstring
    claiming more.  nullity_Q = m_lambda is not the news: the CHARACTER already
    fixes it, independently of any linear algebra here.  What the equality
    establishes is that no rank was lost in the reduction, so the kernel computed
    mod p has the same dimension as the rational one and is its reduction -- which
    is what licenses taking the covariants from the mod-p computation at all.

SPARSE ELIMINATION IS THE RIGHT METHOD, AND THE ROUTINE BELOW IS NOT IT.  An
earlier version of this docstring recorded sparse as twenty times worse than
dense and closed the route.  Reviewer 221 refuted that on the SAME block: a
Markowitz elimination does 6,137 columns in 28.3 s against dense's 44.2 s -- the
sparse method is FASTER -- and the 1,943 s the dead-end rested on does not
reproduce, 221 measuring 69.6 s for this routine on this matrix while its
neighbours in the same log reproduce within 10 percent.  A route was closed on
one bad timing, for the second time in this build.

WHAT sparse_rank BELOW ACTUALLY DOES, which is not sparse elimination.  Live rows
are never updated: each row is reduced against the accumulated pivots and then
becomes a pivot itself, so the pivot rows fill in without bound and there is no
fill control at all.  On top of that, live.sort(key=len) runs inside the loop
while the live rows never change length, so every sort after the first re-sorts a
sorted list; and c0 = min(r, key=lambda c: (len(r), c)) has a key constant in its
first slot, so it is min(r) -- harmless, but it signals a pivot rule that was
meant to do something it does not do.

So the comparison that closed the route was a Python-dict echelon insertion
against vectorised numpy: a language-and-representation comparison rather than a
sparse-versus-dense one.

WHAT COVERS WHAT.  216's dense rank reaches 14,595 columns -- 61 of 77 blocks and
131 of 191 multiplicities, 0 mismatches.  The remaining 16 run from 21,664 to
635,220 columns.  A proper Markowitz elimination is the method for them, with
Wiedemann or block Lanczos still available if fill bites at the top of that
range; the nullities being at most 9 suits either.

THE TRIVIAL BLOCK IS NOT DONE HERE AND DOES NOT NEED TO BE.  Its multiplicity
space is the cubic O(12)-invariants, which contraction diagrams span by the first
fundamental theorem -- a theorem, not an obligation.  That is 216's third point
and it is why the 635,220 never blocked anything.

WHAT THE TAIL COSTS, AND WHY NO EXPONENT DESCRIBES IT.  An earlier version of
this docstring read a dim^1.77 scaling off two adjacent timings and extrapolated
the largest block to "about 42 hours".  THE NEXT POINT REFUTED IT:

    27,030 -> 34,731 cols :  578.6 s -> 897.5 s     exponent 1.75
    34,731 -> 39,660 cols :  897.5 s -> 1426.8 s    exponent 3.49

The exponent doubles between adjacent intervals, and the extrapolation to 635,220
columns moves from 54 hours to 272 hours depending on which pair is fitted.  Two
points were mistaken for a law.

THE REASON IS STRUCTURAL, NOT STATISTICAL.  Sparse elimination costs what FILL-IN
costs, and fill-in depends on the sparsity pattern rather than on the column
count -- so blocks of similar size and different structure have no reason to lie
on one curve, and fitting a power law across them assumes what needs proving.
No cost for the largest block should be quoted from these timings at all.  The chirality
pair (2,2,1,1,1,-1) and (2,2,1,1,1,1) is a free check on the timing: identical
dimensions and nullities, 901.0 s against 894.1 s.

The trivial block has a second route that skips elimination entirely -- its
multiplicity space is the cubic O(12)-invariants, which contraction diagrams span
by the first fundamental theorem -- so the 42 hours bound the worst case rather
than describe the intended path.
"""
import os, sys, time, pickle
from collections import defaultdict
from fractions import Fraction as F
from itertools import combinations_with_replacement as cwr

P = 2147483647
d = os.path.dirname(os.path.abspath(__file__))
RD = os.path.join(d, "..", "reviewers", "r216")
D = pickle.load(open(os.path.join(RD, "weyl12.pkl"), "rb"))
ALPHA = D["ALPHA"]
WDIM = D["WEYL"]
WTS = sorted(WDIM)
WRANK = {w: k for k, w in enumerate(WTS)}
OFF = {}; n = 0
for w in WTS: OFF[w] = n; n += WDIM[w]
assert n == 1638, f"the module has dimension {n}, not 1638"
GW = [None]*n
for w in WTS:
    for k in range(WDIM[w]): GW[OFF[w]+k] = w

Emod = [defaultdict(list) for _ in range(6)]
_nz = 0
for i in range(6):
    for w, cols in D["E"][i].items():
        tw = tuple(a+b for a, b in zip(w, ALPHA[i]))
        for j, col in enumerate(cols):
            for r, s in enumerate(col):
                x = F(s)
                if x:
                    Emod[i][OFF[w]+j].append(
                        (OFF[tw]+r,
                         x.numerator * pow(x.denominator % P, P-2, P) % P))
                    _nz += 1
print(f"six simple raising operators, {_nz:,} nonzeros in total "
      f"(density {_nz/(6*n*n):.2e})")

def sparse_rank(rows, ncols):
    """rank mod P by Markowitz-pivoted sparse elimination.

    THE PIVOT RULE IS THE WHOLE METHOD.  An earlier routine here reduced each row
    against the accumulated pivots and then made it a pivot, never updating the
    live rows -- so the pivot set filled in without bound and there was no fill
    control at all.  That is echelon-by-insertion, not sparse elimination, and
    timing it against vectorised numpy closed this route wrongly.  Here the live
    rows ARE updated, and the pivot minimises the Markowitz score
    (row length - 1) * (column count - 1), which is the standard estimate of the
    fill one elimination step creates.  Reviewer 221's implementation, on which
    sparse beats dense at 6,137 columns.
    """
    rowsd = {i: dict(r) for i, r in enumerate(rows) if r}
    colrows = defaultdict(set)
    for i, r in rowsd.items():
        for c in r: colrows[c].add(i)
    rank = 0
    while rowsd:
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
        for i in list(colrows[bc]):
            r = rowsd[i]
            f0 = r[bc]*inv % P
            for c, v in pr.items():
                old = r.get(c, 0)
                nv = (old - f0*v) % P
                if nv:
                    if not old: colrows[c].add(i)
                    r[c] = nv
                elif old:
                    colrows[c].discard(i); r.pop(c, None)
            if not r: del rowsd[i]
        rank += 1
    return rank

def hw_nullity(lam, S3dim, verbose=True):
    """dim of the highest-weight space at lam: kernel of the six raising ops."""
    t0 = time.time()
    # ENUMERATE BY WEIGHT, NOT BY FILTERING.  A first version scanned all
    # cwr(range(1638), 3) -- C(1640,3) = 733,813,080 triples -- for EVERY block,
    # which is minutes per block and was the whole reason this looked slow.
    # Grouping the module's basis by weight first makes the sum of three weights
    # the loop variable, so only compatible triples are ever formed: 216's build
    # takes 0.4 s and this one matches it.
    B = []
    for a, wa in enumerate(WTS):
        for b, wb in enumerate(WTS[a:], start=a):
            need = tuple(lam[t] - wa[t] - wb[t] for t in range(6))
            if need not in WDIM: continue
            # dict lookup, NOT WTS.index.  The linear scan sat inside a
            # double loop over 853 weights and cost 573 s at
            # (4,3,1,0,0,0) where every other block built in 0.3 s.
            c = WRANK[need]
            if c < b: continue
            for ia in range(OFF[wa], OFF[wa]+WDIM[wa]):
                for ib in range(max(ia, OFF[wb]), OFF[wb]+WDIM[wb]):
                    for ic in range(max(ib, OFF[need]), OFF[need]+WDIM[need]):
                        B.append((ia, ib, ic))
    assert len(B) == S3dim, f"basis {len(B)} against character {S3dim} at {lam}"
    idx = {m: j for j, m in enumerate(B)}
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
    t1 = time.time()
    rk = sparse_rank([dict(r) for r in rows.values()], len(B))
    nul = len(B) - rk
    if verbose:
        print(f"  {str(lam):24s} dim {len(B):>8,}  rows {len(rows):>9,}  "
              f"nullity {nul:>3d}  [build {t1-t0:.1f}s, rank {time.time()-t1:.1f}s]",
              flush=True)
    return nul

if __name__ == "__main__":
    BL = pickle.load(open(os.path.join(d, "n12_sym3_blocks.pkl"), "rb"))
    S3 = pickle.load(open(os.path.join(d, "n12_sym3_char.pkl"), "rb"))
    lo = int(sys.argv[1]) if len(sys.argv) > 1 else 0
    hi = int(sys.argv[2]) if len(sys.argv) > 2 else 20000
    todo = sorted(((S3[l], l, BL[l]) for l in BL))
    todo = [x for x in todo if lo < x[0] <= hi]
    print(f"\n{len(todo)} blocks with Sym^3 weight space in ({lo:,}, {hi:,}], "
          f"{sum(x[2] for x in todo)} multiplicities\n")
    bad, done = [], 0
    for dd, l, m in todo:
        nul = hw_nullity(l, dd)
        done += m
        if nul != m:
            bad.append((l, nul, m))
            print(f"     MISMATCH: character says {m}", flush=True)
    print(f"\n  {len(todo)} blocks, {done} multiplicities, {len(bad)} mismatches")
    assert not bad, f"the construction disagrees with the character at {bad}"
    print("  every nullity equals the multiplicity the character fixes, so each")
    print("  is pinned over Q -- nullity_Q >= m and rank_p <= rank_Q.")
