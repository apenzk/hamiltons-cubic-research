"""CLAIM 2 -- test Rui's criterion "B_f(n) semisimple over char-0 iff n >= f-1"
WITHOUT the paywalled source, by Dickson's criterion:

    over a field of characteristic 0, a finite-dimensional algebra A is
    SEMISIMPLE iff the trace form  (x,y) |-> tr(L_{xy})  on the regular
    representation is NONDEGENERATE.

So: build the Brauer algebra B_f(delta) multiplication on diagrams, form the
Gram matrix M[x][y] = tau(x*y) with tau(z) = tr(L_z), and measure its rank.
Full rank mod a prime p  ==>  full rank over Q  ==>  semisimple.
Deficient mod several primes ==> not semisimple (reported with the primes used).

delta is an integer here, so every entry of M is an integer.
"""
import sys, numpy as np
from itertools import combinations

def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

def as_map(D):
    d = {}
    for a, b in D:
        d[a] = b; d[b] = a
    return d

def compose(D1, D2, f):
    """D1 * D2 in B_f: stack D1 ABOVE D2.  Points 0..f-1 top, f..2f-1 bottom.
    Returns (loops, matching) with the result = delta^loops * matching."""
    # nodes: ('t',i) top of D1 ; ('m',i) D1-bottom = D2-top ; ('b',i) bottom of D2
    adj = {}
    def add(u, v, layer):
        adj.setdefault((u, layer), []).append((v, layer))
        adj.setdefault((v, layer), []).append((u, layer))
    def nm1(p): return ('t', p) if p < f else ('m', p - f)
    def nm2(p): return ('m', p) if p < f else ('b', p - f)
    e1, e2 = {}, {}
    for a, b in D1:
        u, v = nm1(a), nm1(b)
        e1.setdefault(u, []).append(v); e1.setdefault(v, []).append(u)
    for a, b in D2:
        u, v = nm2(a), nm2(b)
        e2.setdefault(u, []).append(v); e2.setdefault(v, []).append(u)
    seen = set()
    out = []
    # walk from each free endpoint (top of D1, bottom of D2)
    ends = [('t', i) for i in range(f)] + [('b', i) for i in range(f)]
    for s in ends:
        if s in seen:
            continue
        seen.add(s)
        cur, use1 = s, True   # from a 't' node the first edge is a D1 edge
        if s[0] == 'b':
            use1 = False
        while True:
            nxt = (e1 if use1 else e2)[cur][0]
            if nxt[0] in ('t', 'b'):
                seen.add(nxt)
                a = cur if cur[0] in ('t', 'b') else None
                out.append((s, nxt))
                break
            seen.add(nxt)
            cur, use1 = nxt, not use1
    loops = 0
    for i in range(f):
        if ('m', i) not in seen:
            # closed cycle through the middle
            loops += 1
            cur, use1 = ('m', i), True
            seen.add(cur)
            while True:
                nxt = (e1 if use1 else e2)[cur][0]
                if nxt in seen and nxt == ('m', i) :
                    break
                seen.add(nxt)
                cur, use1 = nxt, not use1
    res = []
    for u, v in out:
        pu = u[1] if u[0] == 't' else u[1] + f
        pv = v[1] if v[0] == 't' else v[1] + f
        res.append((min(pu, pv), max(pu, pv)))
    return loops, tuple(sorted(res))

def canon(D):
    return tuple(sorted((min(a, b), max(a, b)) for a, b in D))

def build(f):
    basis = [canon(D) for D in matchings(tuple(range(2*f)))]
    index = {D: i for i, D in enumerate(basis)}
    # product table: (loops, index)
    N = len(basis)
    table = [[None]*N for _ in range(N)]
    for i, A in enumerate(basis):
        for j, B in enumerate(basis):
            L, C = compose(A, B, f)
            table[i][j] = (L, index[C])
    return basis, index, table

def rank_mod(M, p):
    A = (M % p).astype(np.int64)
    rows, cols = A.shape
    r = 0
    for c in range(cols):
        piv = None
        for i in range(r, rows):
            if A[i, c] % p:
                piv = i; break
        if piv is None:
            continue
        A[[r, piv]] = A[[piv, r]]
        inv = pow(int(A[r, c]), p-2, p)
        A[r] = (A[r] * inv) % p
        col = A[r+1:, c].copy()
        nz = np.nonzero(col)[0]
        if nz.size:
            A[r+1:][nz] = (A[r+1:][nz] - col[nz][:, None] * A[r][None, :]) % p
        r += 1
        if r == rows:
            break
    return r

PRIMES = [46337, 46021, 45989, 45943, 45893]

print("Dickson: A semisimple over char 0  <=>  trace form tr(L_xy) nondegenerate.\n")
print("  f   delta   dim B_f   rank of trace form   semisimple?   Rui says (n>=f-1)")
maxf = int(sys.argv[1]) if len(sys.argv) > 1 else 4
for f in range(2, maxf+1):
    basis, index, table = build(f)
    N = len(basis)
    # tau(z) = tr(L_z) as a polynomial in delta: coefficient list
    # tau(z) = sum_E [coeff of E in z*E]
    taupoly = [dict() for _ in range(N)]   # power of delta -> count
    for i in range(N):
        d = taupoly[i]
        for j in range(N):
            L, k = table[i][j]
            if k == j:
                d[L] = d.get(L, 0) + 1
    for delta in range(0, 8):
        tau = np.array([sum(c * delta**L for L, c in d.items()) for d in taupoly], dtype=object)
        M = np.zeros((N, N), dtype=object)
        for i in range(N):
            row = M[i]
            ti = table[i]
            for j in range(N):
                L, k = ti[j]
                row[j] = (delta**L) * tau[k]
        Mi = np.array([[int(x) for x in r] for r in M], dtype=object)
        ranks = []
        for p in PRIMES:
            Mp = np.array([[int(x) % p for x in r] for r in Mi], dtype=np.int64)
            ranks.append(rank_mod(Mp, p))
            if ranks[-1] == N:
                break
        rk = max(ranks)
        ss = (rk == N)
        rui = (delta >= f - 1)
        flag = "" if ss == rui else "   <<< DISAGREES WITH RUI"
        print(f"  {f}   {delta:>5}   {N:>7}   {rk:>18}   {str(ss):>11}   {str(rui):>5}{flag}")
    print()
