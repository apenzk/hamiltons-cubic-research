"""CLAIM 3a. Is the new sparse_rank a correct rank computation?

Method: plant matrices of KNOWN rank, over the same prime the run uses, and
compare against SageMath's Matrix(GF(P)).rank() as an independent oracle.
Then MUTATE sparse_rank in four ways that each break a distinct part of the
method and confirm the harness fires on every mutant -- a check that cannot
fail proves nothing.

Run with:  sage -python scripts/reviewers/r223/c3_planted_rank.py
"""
import os, sys, random
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from extract import load
from collections import defaultdict
from sage.all import matrix, GF

P = 2147483647
sparse_rank, SRC = load(P)
F = GF(P)

def oracle(rows, ncols):
    nrows = len(rows)
    if nrows == 0: return 0
    M = matrix(F, nrows, ncols, sparse=True)
    for i, r in enumerate(rows):
        for c, v in r.items(): M[i, c] = v
    return M.rank()

def planted(nrows, ncols, rank, dens=None, seed=0):
    """rows of an explicit rank-`rank` product A*B, A nrows x rank, B rank x ncols."""
    rnd = random.Random(seed)
    A = [[rnd.randrange(1, P) for _ in range(rank)] for _ in range(nrows)]
    B = [[rnd.randrange(1, P) for _ in range(ncols)] for _ in range(rank)]
    rows = []
    for i in range(nrows):
        r = {}
        for c in range(ncols):
            v = sum(A[i][k]*B[k][c] for k in range(rank)) % P
            if v: r[c] = v
        rows.append(r)
    return rows

def sparse_planted(nrows, ncols, rank, seed=0):
    """A sparse matrix of known rank: rank random unit-ish rows, the rest exact
    random combinations of them, then a random column permutation."""
    rnd = random.Random(seed)
    basis = []
    for k in range(rank):
        supp = rnd.sample(range(ncols), min(ncols, rnd.randint(2, 6)))
        basis.append({c: rnd.randrange(1, P) for c in supp})
    rows = [dict(b) for b in basis]
    for _ in range(nrows - rank):
        r = defaultdict(int)
        for b in rnd.sample(basis, min(rank, rnd.randint(1, 3))):
            f = rnd.randrange(1, P)
            for c, v in b.items(): r[c] = (r[c] + f*v) % P
        rows.append({c: v for c, v in r.items() if v})
    rnd.shuffle(rows)
    perm = list(range(ncols)); rnd.shuffle(perm)
    return [{perm[c]: v for c, v in r.items()} for r in rows]

CASES = []
# structured, rank known with no oracle needed
CASES.append(("empty", [], 5, 0))
CASES.append(("all-zero rows", [{}, {}, {}], 4, 0))
CASES.append(("identity 30", [{i: 1} for i in range(30)], 30, 30))
CASES.append(("identity with duplicates", [{i % 10: 1} for i in range(30)], 10, 10))
CASES.append(("one row repeated 20x", [{0: 3, 5: 7, 9: 11}]*20, 12, 1))
# a dense square singular matrix: rank exactly 1 by construction
CASES.append(("rank-1 outer product", planted(25, 25, 1, seed=1), 25, 1))
for (nr, nc, rk, sd) in [(40, 40, 17, 2), (60, 45, 30, 3), (45, 60, 45, 4),
                         (80, 80, 79, 5), (50, 50, 50, 6)]:
    CASES.append((f"planted dense {nr}x{nc} rank {rk}", planted(nr, nc, rk, seed=sd), nc, rk))
for (nr, nc, rk, sd) in [(200, 150, 90, 7), (300, 300, 250, 8), (150, 400, 120, 9),
                         (400, 200, 200, 10), (250, 250, 1, 11)]:
    CASES.append((f"planted sparse {nr}x{nc} rank {rk}", sparse_planted(nr, nc, rk, seed=sd), nc, rk))

def run(fn, cases):
    out = []
    for name, rows, ncols, want in cases:
        try:
            got = fn([dict(r) for r in rows], ncols)
        except Exception as e:
            got = f"EXC {type(e).__name__}"
        out.append((name, want, got))
    return out

print("=" * 74)
print("PART 1 -- the shipped sparse_rank against planted rank and a Sage oracle")
print("=" * 74)
bad = 0
ORACLE = {}
for name, rows, ncols, want in CASES:
    orc = oracle(rows, ncols)
    ORACLE[name] = orc
    got = sparse_rank([dict(r) for r in rows], ncols)
    ok = (got == orc)
    bad += not ok
    flag = "ok " if ok else "BAD"
    note = "" if orc == want else f"   (generator's target {want} was itself optimistic)"
    print(f"  {flag} {name:38s} sage {orc:>4}  sparse_rank {got:>4}{note}")
print(f"\n  {len(CASES)} cases, {bad} disagreements with the Sage oracle")

print()
print("=" * 74)
print("PART 2 -- MUTANTS.  Each breaks one part of the method; the harness must fire.")
print("=" * 74)
MUT = [
 ("no live-row update (the old echelon-by-insertion defect)",
  "        for i in list(colrows[bc]):", "        for i in []:"),
 ("pivot not scaled: inv dropped",
  "        inv = pow(pr[bc], P-2, P)", "        inv = 1"),
 ("wrong elimination sign",
  "                nv = (old - f0*v) % P", "                nv = (old + f0*v) % P"),
 ("cancellation ignored, so zeros are kept and dependent rows survive",
  "                if nv:", "                if True:"),
 ("column occupancy never grows: fill-in rows dropped from colrows",
  "                    if not old: colrows[c].add(i)", "                    if False: colrows[c].add(i)"),
 ("eliminate only the first live row in the pivot column",
  "        for i in list(colrows[bc]):", "        for i in list(colrows[bc])[:1]:"),
]
for label, old, new in MUT:
    if old not in SRC:
        print(f"  SKIP (anchor missing): {label}")
        continue
    ns = {"P": P, "defaultdict": defaultdict}
    exec(compile(SRC.replace(old, new, 1), "<mutant>", "exec"), ns)
    mf = ns["sparse_rank"]
    fired = 0
    for name, rows, ncols, want in CASES:
        try:
            got = mf([dict(r) for r in rows], ncols)
        except Exception:
            got = "EXC"
        if got != ORACLE[name]: fired += 1
    verdict = "FIRES" if fired else "SILENT -- harness is blind here"
    print(f"  {verdict:34s} on {fired:>2}/{len(CASES)} cases : {label}")
