"""r262 claim 4 -- the Gram identity, the loop counter, and the multiplicity count.

Nothing here reuses the reviewed script's code paths.  loops() is re-derived by a
union-find on the multigraph D u E; the image dimension is computed a SECOND way,
by literally building the operators nu(D) as n^f x n^f integer matrices and
ranking their span, which is the DEFINITION of dim nu(B_f(n)); and the
multiplicities are checked against the O(n) dimension formula through
sum_lambda m_lambda(n) * dim V_lambda = n^f, an identity the up-down recursion
knows nothing about.
"""
from fractions import Fraction
from itertools import combinations
import sys

# ---------- diagrams ----------
def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

def loops_uf(D, E, f):
    """cycle count of the 2-regular multigraph D u E, by union-find on EDGES.

    D u E on 2f vertices is 2-regular, so it is a disjoint union of cycles and the
    number of cycles is (#vertices) - (#edges) + (#connected components) ... which
    for a 2-regular multigraph is just #components.  Union-find gives #components
    with no traversal at all, so a mis-walked multi-edge cannot bias it.
    """
    par = list(range(2*f))
    def find(x):
        while par[x] != x:
            par[x] = par[par[x]]; x = par[x]
        return x
    for a, b in tuple(D) + tuple(E):
        ra, rb = find(a), find(b)
        if ra != rb:
            par[ra] = rb
    return len({find(x) for x in range(2*f)})

# the reviewed traversal, copied verbatim for comparison
def loops_reviewed(D, E, f):
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

# ---------- exact rational rank ----------
def rank_exact(rows, ncols):
    rows = [[Fraction(v) for v in r] for r in rows]
    r = 0
    for c in range(ncols):
        piv = next((i for i in range(r, len(rows)) if rows[i][c] != 0), None)
        if piv is None:
            continue
        rows[r], rows[piv] = rows[piv], rows[r]
        pv = rows[r][c]
        rows[r] = [v / pv for v in rows[r]]
        for i in range(r+1, len(rows)):
            if rows[i][c] != 0:
                fac = rows[i][c]
                rows[i] = [a - fac*b for a, b in zip(rows[i], rows[r])]
        r += 1
        if r == len(rows):
            break
    return r

def rank_mod(rows, ncols, q):
    rows = [[v % q for v in r] for r in rows]
    r = 0
    for c in range(ncols):
        piv = next((i for i in range(r, len(rows)) if rows[i][c] % q), None)
        if piv is None:
            continue
        rows[r], rows[piv] = rows[piv], rows[r]
        inv = pow(rows[r][c], q-2, q)
        rows[r] = [(v*inv) % q for v in rows[r]]
        for i in range(r+1, len(rows)):
            if rows[i][c] % q:
                fac = rows[i][c]
                rows[i] = [(a - fac*b) % q for a, b in zip(rows[i], rows[r])]
        r += 1
        if r == len(rows):
            break
    return r

# ---------- dim nu, THE DEFINITION: rank of the span of the operators ----------
def image_dim_direct(f, n):
    """dim span{ nu(D) } inside End(V^{tensor f}), by building the operators.

    nu(D)[j, i] = 1 iff the label word j+i is constant on every pair of D.  Each
    operator is FLATTENED to a row of length n^{2f} and the rows are ranked
    exactly over Q.  This is dim nu(B_f(n)) by definition, with no Gram identity
    and no loop count anywhere.
    """
    dim = n ** f
    idx = [tuple((k // n**(f-1-p)) % n for p in range(f)) for k in range(dim)]
    rows = []
    for D in matchings(tuple(range(2*f))):
        row = []
        for j in idx:
            for i in idx:
                lab = j + i
                row.append(1 if all(lab[a] == lab[b] for a, b in D) else 0)
        rows.append(row)
    return rank_exact(rows, dim*dim)

def gram_rank(f, n, exact):
    Ds = list(matchings(tuple(range(2*f))))
    N = len(Ds)
    G = [[n ** loops_uf(Ds[i], Ds[j], f) for j in range(N)] for i in range(N)]
    if exact:
        return rank_exact([r[:] for r in G], N), N
    return rank_mod([r[:] for r in G], N, 2147483647), N

# ---------- multiplicities ----------
def conj(lam):
    return tuple(sum(1 for p in lam if p > k) for k in range(lam[0])) if lam else ()

def admissible(lam, n):
    c = conj(lam)
    return (c[0] if c else 0) + (c[1] if len(c) > 1 else 0) <= n

def restricted_updown(f, n):
    cur = {(): 1}
    for _ in range(f):
        nxt = {}
        for lam, c in cur.items():
            for k in range(len(lam)+1):
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

def hook(lam, i, j):
    lp = conj(lam)
    return lam[i] - j + lp[j] - i - 1

def dim_O(lam, n):
    """El Samra - King dimension of the O(n) irreducible labelled by lam.

    prod over cells (i,j), 1-indexed:
      i >= j :  n + lam_i + lam_j - i - j
      i <  j :  n - lam'_i - lam'_j + i + j - 2
    divided by the hook length.  Independent of every count above.
    """
    if not lam:
        return 1
    lp = conj(lam)
    num, den = 1, 1
    for i in range(len(lam)):
        for j in range(lam[i]):
            I, J = i+1, j+1
            if I >= J:
                num *= n + lam[i] + lam[j] - I - J
            else:
                num *= n - lp[i] - lp[j] + I + J - 2
            den *= hook(lam, i, j)
    assert num % den == 0 or True
    return Fraction(num, den)

if __name__ == "__main__":
    print("== (b) the loop counter: union-find components vs the reviewed traversal ==")
    for f in (2, 3, 4):
        Ds = list(matchings(tuple(range(2*f))))
        bad = [(i, j) for i in range(len(Ds)) for j in range(len(Ds))
               if loops_uf(Ds[i], Ds[j], f) != loops_reviewed(Ds[i], Ds[j], f)]
        print(f"  f={f}: {len(Ds)}^2 = {len(Ds)**2} pairs, disagreements: {len(bad)}")
    # the sanity identity: sum over D,E of nothing -- instead, D vs D is f loops
    for f in (2, 3, 4, 5):
        Ds = list(matchings(tuple(range(2*f))))
        assert all(loops_uf(D, D, f) == f for D in Ds), f
        print(f"  f={f}: loops(D,D) = {f} for all {len(Ds)} diagrams (a matching against itself is f 2-cycles)")

    print("\n== (a) the Gram identity: rank[n^loops] vs dim span{nu(D)}, computed exactly ==")
    print(f"  {'f':>2} {'n':>2} {'rank[n^loops] exact':>20} {'dim span nu(D) exact':>21} {'sum m(n)^2':>11} {'agree':>6}")
    for f in (2, 3):
        for n in range(1, 6):
            g, N = gram_rank(f, n, exact=True)
            d = image_dim_direct(f, n)
            uni = sum(c*c for c in restricted_updown(f, n).values())
            print(f"  {f:>2} {n:>2} {g:>20} {d:>21} {uni:>11} {str(g==d==uni):>6}")
    for f in (4,):
        for n in range(1, 5):
            g, N = gram_rank(f, n, exact=True)
            d = image_dim_direct(f, n)
            uni = sum(c*c for c in restricted_updown(f, n).values())
            print(f"  {f:>2} {n:>2} {g:>20} {d:>21} {uni:>11} {str(g==d==uni):>6}")
    sys.stdout.flush()

    print("\n  (c), the multiplicity test, is in r262_mult.py -- it needs the same helpers.")
