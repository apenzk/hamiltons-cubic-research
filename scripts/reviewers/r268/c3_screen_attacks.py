"""r268 claim 4 (b), (c), (d) -- the pruning branch, the enumeration order, and
non-trivial lambda.

(d) THE PRUNING BRANCH.  run_basis_extraction.py keeps a running `rank` that is
    computed on `rows`, then DISCARDS rows when len(rows) > 4*target+40, keeping
    the ones with the largest max-abs entry.  Two defects are checked here:
      * the surviving rows can have SMALLER rank than the discarded set, and the
        `rank` variable is never lowered, so the loop can miss the moment the
        span reaches `target` and run on (or return None);
      * the ordering key is |entry| max, and the rows are n^{loops} * e_{m'}, so
        the branch keeps whichever images sit under the MOST closed loops -- a
        selection with nothing to do with independence.
    Measured by running the script's own algorithm with the branch on and off.

(c) THE ORDER.  `matchings` is a fixed lexicographic enumeration.  The cost under
    random orders is measured over many trials.

(b) NON-TRIVIAL lambda.  The screen only tests lambda = empty, whose seed is a
    matching vector.  Here the seed is iota_lambda tensor cup^{tensor k} for
    lambda = (1), (2), (1,1), and the target is the up-down count m_lambda(f,n).
"""
import random, itertools
import numpy as np

def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

def apply_diagram_fast(D, v, f, n):
    """nu(D) v, by enumerating the n^f consistent label assignments of D's pairs."""
    out = np.zeros(n ** f)
    pw = [n ** (f - 1 - p) for p in range(f)]
    pairs = list(D)
    for lab in itertools.product(range(n), repeat=len(pairs)):
        j = [0] * f; i = [0] * f
        for (a, b), t in zip(pairs, lab):
            for p in (a, b):
                if p < f: j[p] = t
                else: i[p - f] = t
        r = sum(j[p] * pw[p] for p in range(f))
        k = sum(i[p] * pw[p] for p in range(f))
        out[r] += v[k]
    return out

# ---------- seeds ----------
def cup(n):
    v = np.zeros(n * n)
    for a in range(n): v[a * n + a] = 1.0
    return v

def seed_empty(f, n):
    out = np.array([1.0])
    for _ in range(f // 2): out = np.kron(out, cup(n))
    return out

def iota(lam, n):
    """a nonzero vector of V_lambda inside V^{tensor |lambda|}, traceless by
    construction (all indices distinct), Young-symmetrised on the tableau."""
    d = sum(lam)
    if lam == (1,):
        v = np.zeros(n); v[0] = 1.0; return v
    if lam == (2,):
        v = np.zeros(n * n); v[0 * n + 1] += 1; v[1 * n + 0] += 1; return v
    if lam == (1, 1):
        v = np.zeros(n * n); v[0 * n + 1] += 1; v[1 * n + 0] -= 1; return v
    raise ValueError(lam)

def seed_lambda(lam, f, n):
    v = iota(lam, n)
    for _ in range((f - sum(lam)) // 2): v = np.kron(v, cup(n))
    return v

# ---------- multiplicity by the up-down recursion (general lambda) ----------
def conj(l): return tuple(sum(1 for p in l if p > k) for k in range(l[0])) if l else ()
def admissible(l, n):
    c = conj(l)
    return (c[0] if c else 0) + (c[1] if len(c) > 1 else 0) <= n
def m_lambda(lam, f, n):
    cur = {(): 1}
    for _ in range(f):
        nxt = {}
        for l, c in cur.items():
            for k in range(len(l) + 1):
                new = list(l) + [0]; new[k] += 1
                if all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if admissible(key, n): nxt[key] = nxt.get(key, 0) + c
            for k in range(len(l)):
                new = list(l); new[k] -= 1
                if new[k] >= 0 and all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if admissible(key, n): nxt[key] = nxt.get(key, 0) + c
        cur = nxt
    return cur.get(tuple(lam), 0)

# ---------- the script's algorithm, with the pruning branch switchable ----------
_cache = {}
def img(D, f, n, key, v):
    c = _cache.setdefault((key, f, n), {})
    if D not in c: c[D] = apply_diagram_fast(D, v, f, n)
    return c[D]

def cost_no_prune(f, n, target, v, order, key):
    """rank of the accumulated rows, by incremental orthogonalisation."""
    basis, used = [], 0
    for D in order:
        used += 1
        w = img(D, f, n, key, v).copy()
        for b in basis: w -= (w @ b) * b
        nw = np.linalg.norm(w)
        if nw > 1e-8:
            basis.append(w / nw)
            if len(basis) == target: return used, "reached"
    return None, "exhausted"

def cost_as_shipped(f, n, target, v, order, key):
    """faithful replay of run_basis_extraction.py, pruning branch included."""
    rows, rank, used = [], 0, 0
    for D in order:
        used += 1
        rows.append(img(D, f, n, key, v))
        r = np.linalg.matrix_rank(np.array(rows), tol=1e-9)
        if r > rank:
            rank = r
            if rank == target: return used, "reached"
        if len(rows) > 4 * target + 40:
            rows = list(np.array(rows)[np.argsort(-np.abs(np.array(rows)).max(1))][:target + 10])
    return None, "exhausted"

print("(d) THE PRUNING BRANCH -- same computation with the branch on and off\n")
print(f"    {'f':>2} {'n':>2} {'m_empty':>8} {'as shipped':>20} {'no pruning':>20}")
for f, n in ((4, 2), (4, 3), (4, 4), (6, 2), (6, 3)):
    t = m_lambda((), f, n)
    order = list(matchings(tuple(range(2 * f))))
    v = seed_empty(f, n)
    a, sa = cost_as_shipped(f, n, t, v, order, ('e', f, n))
    b, sb = cost_no_prune(f, n, t, v, order, ('e', f, n))
    print(f"    {f:>2} {n:>2} {t:>8} {str(a) + ' (' + sa + ')':>20} {str(b) + ' (' + sb + ')':>20}")

print("\n(c) THE ENUMERATION ORDER -- cost under random orders (no pruning)\n")
print(f"    {'f':>2} {'n':>2} {'m':>4} {'shipped order':>14} {'random min':>11} {'median':>8} {'max':>7}")
rng = random.Random(0)
for f, n in ((4, 2), (4, 3), (4, 4), (6, 2), (6, 3)):
    t = m_lambda((), f, n)
    base = list(matchings(tuple(range(2 * f))))
    v = seed_empty(f, n)
    shipped, _ = cost_no_prune(f, n, t, v, base, ('e', f, n))
    costs = []
    trials = 200 if f == 4 else 20
    for _ in range(trials):
        o = base[:]; rng.shuffle(o)
        c, _ = cost_no_prune(f, n, t, v, o, ('e', f, n))
        costs.append(c if c is not None else 10 ** 9)
    costs.sort()
    print(f"    {f:>2} {n:>2} {t:>4} {shipped:>14} {costs[0]:>11} {costs[len(costs)//2]:>8} {costs[-1]:>7}")

print("\n(b) NON-TRIVIAL lambda -- the seed is iota_lambda tensor cup^{tensor k}\n")
print(f"    {'lambda':>8} {'f':>2} {'n':>2} {'m_lambda':>9} {'used':>7} {'total':>7} {'used/m':>7}")
for lam, f, n in (((1,), 3, 3), ((1,), 3, 4), ((1,), 5, 3), ((1,), 5, 4),
                  ((2,), 4, 3), ((2,), 4, 4), ((1, 1), 4, 3), ((1, 1), 4, 4),
                  ((2,), 6, 3), ((1, 1), 6, 3)):
    t = m_lambda(lam, f, n)
    if t == 0: continue
    order = list(matchings(tuple(range(2 * f))))
    v = seed_lambda(lam, f, n)
    used, st = cost_no_prune(f, n, t, v, order, (lam, f, n))
    ratio = f"{used/t:.1f}" if used else "-"
    print(f"    {str(lam):>8} {f:>2} {n:>2} {t:>9} {str(used):>7} {len(order):>7} {ratio:>7}")
