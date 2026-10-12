"""r261 claim 4 -- audit the NEW run_diagram_realisation.py, by routes that share no code.

(a) IS THE GRAM IDENTITY dim nu = rank[n^{loops}] CORRECT, AND WHY.
    nu(D)[j,i] = prod of deltas named by D, so the FROBENIUS inner product
    <nu(D), nu(E)> = #{ label assignments of the 2f points constant on every
    D-pair and every E-pair } = n^{#components of D u E}.  The union of two
    perfect matchings is a disjoint union of cycles, so that count is n^{loops}.
    The Frobenius form is POSITIVE DEFINITE on real matrices, so the Gram matrix
    of a finite set of vectors has rank equal to the dimension of their span:
    rank [n^{loops(D,E)}] = dim span{nu(D)} = dim nu(B_f(n)).  Checked here
    against the span dimension computed directly.

(b) IS `loops` COUNTING CYCLES CORRECTLY.  Re-walked here with union-find, which
    shares nothing with the reviewed traversal (the reviewed one filters the
    neighbour list by `x != prev`, which is the fragile step when D and E share
    an edge and the adjacency list is [b, b]).  Compared on EVERY pair at
    f <= 4 and on random pairs at f = 5, 6.

(c) IS THE RESTRICTED UP-DOWN COUNT THE TRUE MULTIPLICITY m_lambda(n) FOR O(n).
    Tested by the DIMENSION identity sum_lambda m_lambda(n) . dim V_lambda(n)
    = n^f, with dim V_lambda(n) from the El Samra-King formula for O(n) --
    a route that touches neither the Gram nor the double centraliser.  The
    "doubling at self-associate lambda" the brief asks about is tested by
    running the same identity with the doubling switched ON.

(d) IS TWO-PRIME AGREEMENT ADEQUATE.  Ranks are recomputed over several primes
    including deliberately small ones, and exactly over Q at f <= 4.
"""
import sys
from fractions import Fraction
from itertools import combinations

# ---------------------------------------------------------------- diagrams

def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

def loops_uf(D, E, f):
    """components of the multigraph D u E, by union-find -- no traversal."""
    par = list(range(2*f))
    def find(x):
        while par[x] != x:
            par[x] = par[par[x]]
            x = par[x]
        return x
    for a, b in tuple(D) + tuple(E):
        ra, rb = find(a), find(b)
        if ra != rb:
            par[ra] = rb
    return len({find(x) for x in range(2*f)})

def loops_reviewed(D, E, f):
    """verbatim copy of the reviewed traversal, for the comparison only."""
    m = {}
    for a, b in D:
        m.setdefault(a, []).append(b); m.setdefault(b, []).append(a)
    for a, b in E:
        m.setdefault(a, []).append(b); m.setdefault(b, []).append(a)
    seen, c = set(), 0
    for start in range(2*f):
        if start in seen:
            continue
        c += 1
        cur, prev = start, None
        while True:
            seen.add(cur)
            nxts = [x for x in m[cur] if x != prev] or [m[cur][0]]
            cur, prev = nxts[0], cur
            if cur == start:
                break
    return c

# ---------------------------------------------------------------- ranks

def rank_mod(rows, ncols, q):
    rows = [r[:] for r in rows]
    r = 0
    for c in range(ncols):
        piv = next((i for i in range(r, len(rows)) if rows[i][c] % q), None)
        if piv is None:
            continue
        rows[r], rows[piv] = rows[piv], rows[r]
        inv = pow(rows[r][c], q - 2, q)
        rows[r] = [(v * inv) % q for v in rows[r]]
        for i in range(len(rows)):
            if i != r and rows[i][c] % q:
                fac = rows[i][c]
                rows[i] = [(a - fac * b) % q for a, b in zip(rows[i], rows[r])]
        r += 1
        if r == len(rows):
            break
    return r

def rank_exact(rows, ncols):
    """rank over Q, with Fraction pivots -- no modular reduction anywhere."""
    rows = [[Fraction(v) for v in r] for r in rows]
    r = 0
    for c in range(ncols):
        piv = next((i for i in range(r, len(rows)) if rows[i][c] != 0), None)
        if piv is None:
            continue
        rows[r], rows[piv] = rows[piv], rows[r]
        pv = rows[r][c]
        rows[r] = [v / pv for v in rows[r]]
        for i in range(len(rows)):
            if i != r and rows[i][c] != 0:
                fac = rows[i][c]
                rows[i] = [a - fac * b for a, b in zip(rows[i], rows[r])]
        r += 1
        if r == len(rows):
            break
    return r

# ------------------------------------------- span of nu(D), without any Gram

def even_partitions(pts):
    """set partitions of pts with every block of EVEN size."""
    pts = tuple(pts)
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for k in range(1, len(rest) + 1, 2):            # block size a + k is even
        for extra in combinations(rest, k):
            blk = (a,) + extra
            left = tuple(x for x in rest if x not in extra)
            for tail in even_partitions(left):
                yield (blk,) + tail

def span_dim(f, n, primes=(1000003,)):
    """dim span{ nu(D) } computed WITHOUT the Gram.

    nu(D)[t] = 1 iff the index tuple t is constant on every pair of D, i.e. iff
    every D-pair lies inside one block of ker(t).  So the column indexed by t
    depends only on ker(t), and ker(t) is realisable iff it has at most n
    blocks.  Only partitions with all blocks of even size can contain a perfect
    matching, the rest giving zero columns.
    """
    Ds = list(matchings(tuple(range(2*f))))
    cols = []
    for pi in even_partitions(range(2*f)):
        if len(pi) > n:
            continue
        where = {}
        for bi, blk in enumerate(pi):
            for x in blk:
                where[x] = bi
        cols.append(where)
    A = [[1 if all(w[a] == w[b] for a, b in D) else 0 for w in cols] for D in Ds]
    ranks = {rank_mod(A, len(cols), q) for q in primes}
    ex = rank_exact(A, len(cols)) if len(cols) <= 600 and len(Ds) <= 200 else None
    return ranks, ex, len(Ds), len(cols)

def gram_rank(f, n, primes):
    Ds = list(matchings(tuple(range(2*f))))
    N = len(Ds)
    G = [[n ** loops_uf(Ds[i], Ds[j], f) for j in range(N)] for i in range(N)]
    out = {q: rank_mod(G, N, q) for q in primes}
    ex = rank_exact(G, N) if N <= 105 else None
    return out, ex, N

# ---------------------------------------------------------- O(n) irreps

def conj(lam):
    return tuple(sum(1 for p in lam if p > k) for k in range(lam[0])) if lam else ()

def admissible(lam, n):
    c = conj(lam)
    return (c[0] if c else 0) + (c[1] if len(c) > 1 else 0) <= n

def dim_On(lam, n):
    """El Samra-King dimension of the O(n) irreducible labelled by lam.

    dim = prod over cells (i,j) of lam of
        ( n + lam_i + lam_j - i - j ) / h(i,j)          if i <= j
        ( n - lam'_i - lam'_j + i + j - 2 ) / h(i,j)    if i >  j
    (one-based i = row, j = column).  Validated below on the cases whose
    dimensions are known independently.
    """
    if not lam:
        return 1
    lp = conj(lam)
    num, den = 1, 1
    for i in range(1, len(lam) + 1):
        for j in range(1, lam[i-1] + 1):
            hook = (lam[i-1] - j) + (lp[j-1] - i) + 1
            if i <= j:
                fac = n + lam[i-1] + lam[j-1] - i - j if j <= len(lam) else n + lam[i-1] + 0 - i - j
            else:
                lpi = lp[i-1] if i <= len(lp) else 0
                fac = n - lpi - lp[j-1] + i + j - 2
            num *= fac
            den *= hook
    assert num % den == 0, (lam, n, num, den)
    return num // den

def restricted_updown(f, n):
    cur = {(): 1}
    for _ in range(f):
        nxt = {}
        for lam, c in cur.items():
            for k in range(len(lam) + 1):
                new = list(lam) + [0]; new[k] += 1
                if all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if admissible(key, n):
                        nxt[key] = nxt.get(key, 0) + c
            for k in range(len(lam)):
                new = list(lam); new[k] -= 1
                if new[k] >= 0 and all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if admissible(key, n):
                        nxt[key] = nxt.get(key, 0) + c
        cur = nxt
    return cur

def unrestricted_updown(f):
    cur = {(): 1}
    for _ in range(f):
        nxt = {}
        for lam, c in cur.items():
            for k in range(len(lam) + 1):
                new = list(lam) + [0]; new[k] += 1
                if all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    nxt[key] = nxt.get(key, 0) + c
            for k in range(len(lam)):
                new = list(lam); new[k] -= 1
                if new[k] >= 0 and all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    nxt[key] = nxt.get(key, 0) + c
        cur = nxt
    return cur

# ================================================================== (b) loops

print("(b) `loops`: reviewed traversal vs union-find components")
for f in (2, 3, 4):
    Ds = list(matchings(tuple(range(2*f))))
    bad = [(D, E) for D in Ds for E in Ds
           if loops_uf(D, E, f) != loops_reviewed(D, E, f)]
    print(f"    f={f}: {len(Ds)**2} pairs, disagreements: {len(bad)}")
import random
random.seed(11)
for f in (5, 6):
    Ds = list(matchings(tuple(range(2*f))))
    bad = 0
    for _ in range(20000):
        D, E = random.choice(Ds), random.choice(Ds)
        if loops_uf(D, E, f) != loops_reviewed(D, E, f):
            bad += 1
    print(f"    f={f}: 20000 random pairs, disagreements: {bad}")
same = [(D, D) for D in matchings(tuple(range(8)))]
print(f"    f=4, D against itself (every edge doubled -- the fragile case): "
      f"loops == f in all {len(same)} cases: "
      f"{all(loops_reviewed(D, D, 4) == 4 for D, _ in same)}")

# ============================================== (a) the Gram identity, tested

print("\n(a) rank of the diagram Gram [n^loops] vs dim span{nu(D)}, computed apart")
print(f"    {'f':>2} {'n':>2} {'gram rank (mod p)':>18} {'gram rank exact':>16} "
      f"{'span dim (mod p)':>17} {'span exact':>11}")
PRIMES = (1000003, 999983, 2147483647)
for f in (2, 3, 4):
    for n in range(1, 6):
        gr, gex, N = gram_rank(f, n, PRIMES)
        sp, sex, nD, nC = span_dim(f, n, PRIMES)
        print(f"    {f:>2} {n:>2} {str(sorted(set(gr.values()))):>18} {str(gex):>16} "
              f"{str(sorted(sp)):>17} {str(sex):>11}")
        assert set(gr.values()) == sp == {gex} == {sex}, "Gram identity FAILS here"
print("    every cell: Gram rank == span dimension, exactly and modulo three primes")

# ==================================== (c) is the restricted count m_lambda(n)?

print("\n(c) dim V_lambda(n) by El Samra-King -- validation on known dimensions")
for n in (3, 4, 5, 6, 12):
    checks = {
        "()": (dim_On((), n), 1),
        "(1)": (dim_On((1,), n), n),
        "(2)": (dim_On((2,), n), n*(n+1)//2 - 1),
        "(1,1)": (dim_On((1, 1), n), n*(n-1)//2),
        "(1^n)": (dim_On(tuple([1]*n), n), 1),
        "(1^(n-1))": (dim_On(tuple([1]*(n-1)), n), n),
    }
    ok = all(a == b for a, b in checks.values())
    print(f"    n={n:>2}: {ok}  " + "  ".join(f"{k}={v[0]}" for k, v in checks.items()))
    assert ok

print("\n    the identity sum_lambda m_lambda(n) . dim V_lambda(n) = n^f")
print(f"    {'f':>2} {'n':>2} {'sum m.dim':>14} {'n^f':>14} {'ok':>5}   "
      f"{'with self-assoc DOUBLING':>26} {'ok':>5}")
for f in range(1, 7):
    for n in range(1, 9):
        mm = restricted_updown(f, n)
        tot = sum(c * dim_On(lam, n) for lam, c in mm.items())
        dbl = sum(c * (2 if (conj(lam)[0] if lam else 0) * 2 == n else 1) * dim_On(lam, n)
                  for lam, c in mm.items())
        print(f"    {f:>2} {n:>2} {tot:>14} {n**f:>14} {str(tot == n**f):>5}   "
              f"{dbl:>26} {str(dbl == n**f):>5}")
        assert tot == n**f, f"restricted up-down count is NOT the O(n) multiplicity at ({f},{n})"

print("\n    sum m_lambda(n)^2 vs dim nu(B_f(n)) [span dimension, no Gram]")
for f in (2, 3, 4):
    for n in range(1, 6):
        mm = restricted_updown(f, n)
        uni = sum(c*c for c in mm.values())
        sp, sex, _, _ = span_dim(f, n, PRIMES)
        cell = sum(d*d for lam, d in unrestricted_updown(f).items() if admissible(lam, n))
        print(f"    f={f} n={n}: sum m^2 = {uni:>5}, dim nu = {sex:>5}, "
              f"sum dimDelta^2 = {cell:>5}, n>=f-1: {n >= f-1}")
        assert uni == sex

# =========================================== (d) how much do the two primes buy

print("\n(d) modular ranks of the f=5 Gram over a range of primes")
for n in (2, 3, 4, 5):
    out, _, N = gram_rank(5, n, (2, 3, 5, 7, 11, 101, 46337, 1000003, 2147483647, 2147483629))
    uni = sum(c*c for c in restricted_updown(5, n).values())
    print(f"    f=5 n={n}: N={N}, sum m^2 = {uni}, ranks by prime: {out}")
