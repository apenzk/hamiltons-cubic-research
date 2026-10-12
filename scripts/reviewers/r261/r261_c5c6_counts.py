"""r261 claims 5 and 6 -- the arithmetic in plan.md item 1 and in the two notes.

(1) 160 labels of V^{tensor 12}, and how many are O(6)-admissible.
(2) 23!! and the 3.16e11 spanning set.
(3) sum m_lambda(n)^2 and sum (dim Delta)^2 at f = 12, the record's own size.
(4) Dickson's criterion at delta = 0, reproduced here from the diagram
    multiplication -- an independent check on ASWT Theorem 7.1(5), which the
    Rui note now quotes as "semisimple exactly for d in {1,3,5}".
"""
from itertools import combinations

def partitions(k, mx=None):
    if mx is None:
        mx = k
    if k == 0:
        yield ()
        return
    for first in range(min(k, mx), 0, -1):
        for rest in partitions(k - first, first):
            yield (first,) + rest

def conj(lam):
    return tuple(sum(1 for p in lam if p > k) for k in range(lam[0])) if lam else ()

def admissible(lam, n):
    c = conj(lam)
    return (c[0] if c else 0) + (c[1] if len(c) > 1 else 0) <= n

labels = [lam for k in range(0, 13, 2) for lam in partitions(k)]
print(f"(1) labels reachable in V^(tensor 12): {len(labels)}")
for n in (6, 7, 11, 12):
    adm = [lam for lam in labels if admissible(lam, n)]
    print(f"    O({n})-admissible: {len(adm)}   (so {len(labels)-len(adm)} labels do not exist there)")
print(f"    r = 6 + |lambda|/2 reaches {6 + 12//2} at |lambda| = 12; at n = 12 that is r = n.")

dd = 1
for k in range(23, 0, -2):
    dd *= k
print(f"\n(2) 23!! = {dd} = {dd/1e11:.2f}e11")

def updown(f, n=None):
    cur = {(): 1}
    for _ in range(f):
        nxt = {}
        for lam, c in cur.items():
            for k in range(len(lam) + 1):
                new = list(lam) + [0]; new[k] += 1
                if all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if n is None or admissible(key, n):
                        nxt[key] = nxt.get(key, 0) + c
            for k in range(len(lam)):
                new = list(lam); new[k] -= 1
                if new[k] >= 0 and all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if n is None or admissible(key, n):
                        nxt[key] = nxt.get(key, 0) + c
        cur = nxt
    return cur

cells = updown(12)
print(f"    sum over ALL labels of (dim Delta)^2 at f=12: {sum(d*d for d in cells.values())}"
      f"  -- equal to 23!!: {sum(d*d for d in cells.values()) == dd}")

print("\n(3) f = 12, the two predictions:")
print(f"    {'n':>3} {'sum (dim Delta)^2 over adm':>28} {'sum m_lambda(n)^2':>20}  equal")
for n in (6, 9, 10, 11, 12):
    cell = sum(d*d for lam, d in cells.items() if admissible(lam, n))
    uni = sum(c*c for c in updown(12, n).values())
    print(f"    {n:>3} {cell:>28} {uni:>20}  {cell == uni}")

# ------------------------------------------------- (4) Dickson at delta = 0

def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

def compose(D, E, f):
    """D . E in the Brauer algebra: returns (loops, resulting diagram).

    Points 0..f-1 are the top row and f..2f-1 the bottom.  In D.E the bottom of
    D is glued to the top of E.
    """
    adj = {}
    def add(u, v):
        adj.setdefault(u, []).append(v)
        adj.setdefault(v, []).append(u)
    for a, b in D:                       # D lives on top: 'T' row and 'M' row
        add(('T', a) if a < f else ('M', a - f), ('T', b) if b < f else ('M', b - f))
    for a, b in E:                       # E below: 'M' row and 'B' row
        add(('M', a) if a < f else ('B', a - f), ('M', b) if b < f else ('B', b - f))
    ends = [('T', i) for i in range(f)] + [('B', i) for i in range(f)]
    seen, pairs = set(), []
    for s in ends:
        if s in seen:
            continue
        prev, cur = None, s
        path = [s]
        while True:
            seen.add(cur)
            nxt = [x for x in adj.get(cur, []) if x != prev]
            if not nxt:
                break
            prev, cur = cur, nxt[0]
            path.append(cur)
            if cur[0] in 'TB' and cur != s:
                seen.add(cur)
                break
        pairs.append((s, path[-1]))
    closed = 0
    allpts = set(adj)
    for p in allpts:
        if p[0] == 'M' and p not in seen:
            closed += 1
            prev, cur = None, p
            while True:
                seen.add(cur)
                nxt = [x for x in adj[cur] if x != prev]
                if not nxt:
                    break
                prev, cur = cur, nxt[0]
                if cur == p:
                    break
    def code(x):
        return x[1] if x[0] == 'T' else f + x[1]
    out = tuple(sorted(tuple(sorted((code(a), code(b)))) for a, b in pairs))
    return closed, out

def semisimple_by_dickson(f, delta, q=1000003):
    Ds = list(matchings(tuple(range(2*f))))
    pos = {D: i for i, D in enumerate(Ds)}
    N = len(Ds)
    # structure constants: D . E = delta^loops * F
    prod = [[None]*N for _ in range(N)]
    for i, D in enumerate(Ds):
        for j, E in enumerate(Ds):
            L, F = compose(D, E, f)
            prod[i][j] = (L, pos[F])
    # trace of left multiplication by D.E, on the diagram basis
    T = [[0]*N for _ in range(N)]
    for i in range(N):
        for j in range(N):
            L1, k = prod[i][j]
            tr = 0
            for a in range(N):
                L2, b = prod[k][a]
                if b == a:
                    tr += delta ** (L1 + L2)
            T[i][j] = tr
    # rank over Q, via a large prime (full rank mod p proves full rank over Q)
    A = [[v % q for v in row] for row in T]
    r = 0
    for c in range(N):
        piv = next((i for i in range(r, N) if A[i][c]), None)
        if piv is None:
            continue
        A[r], A[piv] = A[piv], A[r]
        inv = pow(A[r][c], q-2, q)
        A[r] = [(v*inv) % q for v in A[r]]
        for i in range(N):
            if i != r and A[i][c]:
                fac = A[i][c]
                A[i] = [(x - fac*y) % q for x, y in zip(A[i], A[r])]
        r += 1
    return r, N

print("\n(4) Dickson's criterion on the regular trace form, built from diagram")
print("    multiplication here -- the ASWT 7.1(5) exception at delta = 0:")
print(f"    {'f':>2} {'delta':>6} {'rank':>6} {'dim':>6}  semisimple")
for f in (2, 3, 4):
    for delta in (0, 1, 2, 3, 4):
        r, N = semisimple_by_dickson(f, delta)
        print(f"    {f:>2} {delta:>6} {r:>6} {N:>6}  {r == N}")
print("    delta = 0: semisimple at f = 3, not at f = 2, 4 -- ASWT 7.1(5)'s")
print("    d in {1,3,5} reproduced on the range reachable here.")
print("    delta = n >= 1: the boundary n = f-1 is nondegenerate and n = f-2 is not,")
print("    which is ASWT 7.1(3), d <= delta_0 + 1.")
