"""r268 claim 4 -- the shipped routine's OWN code at the next leg count, and what
the pruning branch does when it actually fires.

Everything below is run_basis_extraction.py's own functions, imported by reading
the file, so nothing is reimplemented.  Two questions:

  1. What does extraction_cost return at (f, n) = (6, 2), the first cell beyond
     the four the script reports -- and does the script's own assert
     `used <= 12 * target + 5` survive it?
  2. The pruning branch only fires when len(rows) > 4*target+40, which never
     happens at f = 4 (used = 31 < 52).  At f = 6 it fires repeatedly.  Does the
     rank of the SURVIVING rows ever fall below the running `rank` variable --
     which the loop never lowers?
"""
import numpy as np, time
src = open('scripts/runs/run_basis_extraction.py').read()
ns = {'np': np}
exec(src[:src.index('print("  diagrams consumed')], ns)
matchings, apply_diagram, seed, m_empty = (ns['matchings'], ns['apply_diagram'],
                                           ns['seed'], ns['m_empty'])

def instrumented(f, n, target):
    """extraction_cost verbatim, plus a record of what pruning does."""
    v = seed(f, n)
    rows, rank, used = [], 0, 0
    prunes, drops = 0, []
    for D in matchings(tuple(range(2 * f))):
        used += 1
        rows.append(apply_diagram(D, v, f, n))
        r = np.linalg.matrix_rank(np.array(rows), tol=1e-9)
        if r > rank:
            rank = r
            if rank == target:
                return used, rank, prunes, drops
        if len(rows) > 4 * target + 40:
            before = np.linalg.matrix_rank(np.array(rows), tol=1e-9)
            rows = list(np.array(rows)[np.argsort(-np.abs(np.array(rows)).max(1))][:target + 10])
            after = np.linalg.matrix_rank(np.array(rows), tol=1e-9)
            prunes += 1
            if after < before: drops.append((used, before, after))
    return None, rank, prunes, drops

for f, n in ((4, 3), (6, 2)):
    t = m_empty(f, n)
    t0 = time.time()
    used, rank, prunes, drops = instrumented(f, n, t)
    print(f"  (f,n) = ({f},{n})  m_empty = {t}  used = {used}  "
          f"prunes = {prunes}  rank-dropping prunes = {len(drops)}  "
          f"[{time.time()-t0:.0f}s]", flush=True)
    if drops:
        print(f"    first rank-dropping prune at diagram {drops[0][0]}: "
              f"{drops[0][1]} -> {drops[0][2]}")
    guard = 12 * t + 5
    print(f"    the script's own assert `used <= 12*m + 5` = {guard}: "
          f"{'HOLDS' if used is not None and used <= guard else 'FAILS'}"
          f" (used = {used})\n", flush=True)
