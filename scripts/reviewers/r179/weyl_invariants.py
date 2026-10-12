"""Reviewer 179.  Finite-n dimension of the degree-k O(n)-invariant polynomials on Weyl_n.

Independent method.
  * FFT for O(n): every polynomial O(n)-invariant of W is a linear combination of
    complete metric contractions of W^{otimes k}.  So the degree-k invariant space
    is spanned by the diagram functionals D_m(W), m a perfect matching of the 4k
    index slots (self-pairings at a vertex vanish: Weyl is traceless and pair-
    antisymmetric, so they are dropped).
  * dim = rank of the evaluation matrix [ D_m(W_i) ], computed over F_p with exact
    integer arithmetic.  A mod-p rank is a LOWER bound for the char-0 dimension.
"""
import numpy as np, random, sys, time

def kn(h, k):
    return (np.einsum('ac,bd->abcd', h, k) + np.einsum('bd,ac->abcd', h, k)
            - np.einsum('ad,bc->abcd', h, k) - np.einsum('bc,ad->abcd', h, k))

def random_weyl(n, p, rng):
    T = rng.integers(0, p, size=(n,n,n,n)).astype(np.int64)
    A = T - T.transpose(1,0,2,3) - T.transpose(0,1,3,2) + T.transpose(1,0,3,2)
    A = (A + A.transpose(2,3,0,1)) % p
    R = (3*A - (A + A.transpose(0,2,3,1) + A.transpose(0,3,1,2))) % p
    g = np.eye(n, dtype=np.int64)
    Ric = np.einsum('abad->bd', R) % p
    s = int(np.trace(Ric)) % p
    inv = lambda x: pow(int(x) % p, p-2, p)
    W = (R - inv(n-2)*kn(Ric, g) + (s*inv(2*(n-1)*(n-2)) % p)*kn(g, g)) % p
    assert not np.any(np.einsum('abad->bd', W) % p)
    assert not np.any((W + W.transpose(1,0,2,3)) % p)
    assert not np.any((W - W.transpose(2,3,0,1)) % p)
    assert not np.any((W + W.transpose(0,2,3,1) + W.transpose(0,3,1,2)) % p)  # 1st Bianchi
    return W

def eval_diagram(W, matching, k, p, maxsize=None):
    legs = {}
    for a, b in matching:
        legs[a] = b; legs[b] = a
    tensors = [(W, [4*v+j for j in range(4)]) for v in range(k)]
    while True:
        best = None
        for i in range(len(tensors)):
            for j in range(i+1, len(tensors)):
                li, lj = tensors[i][1], tensors[j][1]
                sh = [(a, legs[a]) for a in li if legs.get(a) in lj]
                if not sh: continue
                out = len(li) + len(lj) - 2*len(sh)
                if best is None or out < best[0]: best = (out, i, j, sh)
        if best is None: break
        out, i, j, sh = best
        if maxsize is not None and out > maxsize: return None
        Ti, li = tensors[i]; Tj, lj = tensors[j]
        ax0 = [li.index(a) for a, b in sh]; ax1 = [lj.index(b) for a, b in sh]
        Tn = np.tensordot(Ti, Tj, axes=(ax0, ax1)) % p
        ln = [l for x, l in enumerate(li) if x not in ax0] + \
             [l for x, l in enumerate(lj) if x not in ax1]
        for a, b in sh: legs.pop(a, None); legs.pop(b, None)
        tensors = [t for x, t in enumerate(tensors) if x not in (i, j)] + [(Tn, ln)]
    # remaining tensors are all scalars (disconnected diagram = product of invariants)
    val = 1
    for T, l in tensors:
        assert T.ndim == 0, f"leftover legs {l}"
        val = val * int(T) % p
    return val

def random_matching(k, rng):
    """Perfect matching of 4k slots with no two slots of the same vertex paired."""
    while True:
        slots = list(range(4*k)); rng.shuffle(slots)
        pairs = [(slots[2*i], slots[2*i+1]) for i in range(2*k)]
        if all(a//4 != b//4 for a, b in pairs): return pairs

def rank_modp(M, p):
    M = np.array(M, dtype=np.int64) % p
    rows, cols = M.shape; r = 0
    for c in range(cols):
        piv = None
        for i in range(r, rows):
            if M[i, c] % p: piv = i; break
        if piv is None: continue
        M[[r, piv]] = M[[piv, r]]
        inv = pow(int(M[r, c]), p-2, p)
        M[r] = M[r] * inv % p
        nz = np.nonzero(M[r+1:, c])[0]
        if len(nz): M[r+1:][nz] = (M[r+1:][nz] - np.outer(M[r+1:][nz][:, c], M[r])) % p
        r += 1
        if r == rows: break
    return r

def dimension(n, k, p=10007, npts=None, ndiag=None, seed=1, stall=60, verbose=True,
              maxsize=None, cap=None):
    rng = np.random.default_rng(seed)
    npts = npts or (cap+20 if cap else 140)
    pts = [random_weyl(n, p, rng) for _ in range(npts)]
    rows = []; r = 0; since = 0; used = 0
    t0 = time.time()
    while True:
        m = random_matching(k, rng)
        vals = [eval_diagram(Wp, m, k, p, maxsize) for Wp in pts]
        if any(v is None for v in vals): continue
        used += 1
        rows.append(vals)
        nr = rank_modp(rows, p)
        if nr > r: r = nr; since = 0
        else: since += 1
        if verbose and used % 25 == 0:
            print(f"  n={n} k={k}: {used} diagrams, rank {r}, stall {since}, {time.time()-t0:.0f}s", flush=True)
        if cap and r >= cap: break
        if since >= stall: break
        if ndiag and used >= ndiag: break
    return r, used

if __name__ == "__main__":
    n = int(sys.argv[1]); k = int(sys.argv[2])
    cap = int(sys.argv[3]) if len(sys.argv) > 3 else None
    seed = int(sys.argv[4]) if len(sys.argv) > 4 else 1
    r, used = dimension(n, k, cap=cap, seed=seed)
    print(f"RESULT n={n} k={k} dim>={r} (from {used} diagrams)")

# ---------- optimal contraction ordering (DP over subsets of the k vertices) ----------
from functools import lru_cache
def best_tree(k, matching):
    """Return (maxrank, tree) minimising the largest intermediate tensor rank."""
    adj = [[0]*k for _ in range(k)]
    for a, b in matching:
        u, v = a//4, b//4
        adj[u][v] += 1; adj[v][u] += 1
    full = (1 << k) - 1
    def cut(S):
        c = 0
        for u in range(k):
            if S >> u & 1:
                for v in range(k):
                    if not (S >> v & 1): c += adj[u][v]
        return c
    memo = {}
    def f(S):
        if S in memo: return memo[S]
        if bin(S).count('1') == 1: return (4, S)
        bestv = None
        A = (S-1) & S
        while A:
            B = S ^ A
            if A < B:
                ra, ta = f(A); rb, tb = f(B)
                v = max(ra, rb, cut(S))
                if bestv is None or v < bestv[0]: bestv = (v, (ta, tb))
            A = (A-1) & S
        memo[S] = bestv
        return bestv
    # split into connected components first
    comps = []; seen = 0
    for u in range(k):
        if seen >> u & 1: continue
        stack = [u]; C = 0
        while stack:
            x = stack.pop()
            if C >> x & 1: continue
            C |= 1 << x
            for y in range(k):
                if adj[x][y] and not (C >> y & 1): stack.append(y)
        seen |= C; comps.append(C)
    res = [f(C) for C in comps]
    return max(r for r, _ in res), [t for _, t in res]

def eval_tree(W, matching, k, p, trees):
    legs = {}
    for a, b in matching: legs[a] = b; legs[b] = a
    base = {1 << v: (W, [4*v+j for j in range(4)]) for v in range(k)}
    def go(t):
        if isinstance(t, int): return base[t]
        Ti, li = go(t[0]); Tj, lj = go(t[1])
        sh = [(a, legs[a]) for a in li if legs.get(a) in lj]
        ax0 = [li.index(a) for a, b in sh]; ax1 = [lj.index(b) for a, b in sh]
        Tn = np.tensordot(Ti, Tj, axes=(ax0, ax1)) % p
        ln = [l for x, l in enumerate(li) if x not in ax0] + \
             [l for x, l in enumerate(lj) if x not in ax1]
        return Tn, ln
    val = 1
    for t in trees:
        T, l = go(t); assert T.ndim == 0
        val = val * int(T) % p
    return val

def dimension2(n, k, p=10007, npts=140, seed=1, stall=90, cap=None, maxrank=6, verbose=True):
    rng = np.random.default_rng(seed)
    pts = [random_weyl(n, p, rng) for _ in range(npts)]
    rows = []; r = 0; since = 0; used = 0; tried = 0; t0 = time.time()
    while True:
        m = random_matching(k, rng); tried += 1
        mr, trees = best_tree(k, m)
        if mr > maxrank: continue
        used += 1
        rows.append([eval_tree(Wp, m, k, p, trees) for Wp in pts])
        nr = rank_modp(rows, p)
        if nr > r: r, since = nr, 0
        else: since += 1
        if verbose and used % 20 == 0:
            print(f"  n={n} k={k}: {used}/{tried} diagrams, rank {r}, stall {since}, {time.time()-t0:.0f}s", flush=True)
        if cap and r >= cap: break
        if since >= stall: break
    return r, used, tried

# ---------- incremental rank ----------
class IncRank:
    def __init__(self, p):
        self.p = p; self.piv = {}          # pivot column -> reduced row
    def add(self, row):
        p = self.p
        v = np.array(row, dtype=np.int64) % p
        for c, r in self.piv.items():
            if v[c]: v = (v - v[c]*r) % p
        nz = np.nonzero(v)[0]
        if not len(nz): return False
        c = int(nz[0]); v = v * pow(int(v[c]), p-2, p) % p
        for c2 in list(self.piv):
            r = self.piv[c2]
            if r[c]: self.piv[c2] = (r - r[c]*v) % p
        self.piv[c] = v
        return True
    def rank(self): return len(self.piv)

def dimension3(n, k, p=10007, npts=130, seed=1, stall=500, cap=None, maxrank=4,
               verbose=True, tag=""):
    rng = np.random.default_rng(seed)
    pts = [random_weyl(n, p, rng) for _ in range(npts)]
    R = IncRank(p); since = 0; used = 0; t0 = time.time()
    while True:
        m = random_matching(k, rng)
        mr, trees = best_tree(k, m)
        if mr > maxrank: continue
        used += 1
        if R.add([eval_tree(Wp, m, k, p, trees) for Wp in pts]): since = 0
        else: since += 1
        if verbose and used % 200 == 0:
            print(f"  {tag}n={n} k={k}: {used} diagrams, rank {R.rank()}, stall {since}, {time.time()-t0:.0f}s", flush=True)
        if cap and R.rank() >= cap: break
        if since >= stall: break
    return R.rank(), used

def structured_matching(k, rng):
    """Half the time force a disconnected diagram: partition the k vertices into
    blocks of size >= 2 and match inside each block.  Products of lower-degree
    invariants are a large part of the degree-6 space and random matchings on
    4k slots produce a disconnected multigraph only ~1.4% of the time at k=6."""
    if rng.random() < 0.5:
        return random_matching(k, rng)
    verts = list(range(k)); rng.shuffle(verts)
    blocks = []; i = 0
    while i < k:
        rem = k - i
        s = 2 if rem < 4 else int(rng.integers(2, min(rem, k)+1))
        if rem - s == 1: s = rem
        blocks.append(verts[i:i+s]); i += s
    pairs = []
    for b in blocks:
        while True:
            slots = [4*v+j for v in b for j in range(4)]; rng.shuffle(slots)
            pp = [(slots[2*i], slots[2*i+1]) for i in range(len(slots)//2)]
            if all(a//4 != c//4 for a, c in pp): break
        pairs += pp
    return pairs

def dimension4(n, k, p=10007, npts=140, seed=1, stall=4000, cap=None, maxrank=4,
               verbose=True, tag=""):
    rng = np.random.default_rng(seed)
    pts = [random_weyl(n, p, rng) for _ in range(npts)]
    R = IncRank(p); since = 0; used = 0; t0 = time.time()
    while True:
        m = structured_matching(k, rng)
        mr, trees = best_tree(k, m)
        if mr > maxrank: continue
        used += 1
        if R.add([eval_tree(Wp, m, k, p, trees) for Wp in pts]): since = 0
        else: since += 1
        if verbose and used % 200 == 0:
            print(f"  {tag}n={n} k={k}: {used} diagrams, rank {R.rank()}, stall {since}, {time.time()-t0:.0f}s", flush=True)
        if cap and R.rank() >= cap: break
        if since >= stall: break
    return R.rank(), used

# ---------- BLAS-backed exact mod-p evaluation ----------
# Values are kept as float64 integers in [0,p).  A tensordot is a dgemm; with
# p = 10007 every partial sum is at most p^2 * n^(#contracted) <= 1e8 * 12^6
# = 3e14 < 2^53, so the float64 arithmetic is EXACT and the result is reduced
# mod p afterwards.  BLAS makes this 30-60x faster than the int64 loop.
def eval_tree_f(W, matching, k, p, trees):
    legs = {}
    for a, b in matching: legs[a] = b; legs[b] = a
    base = {1 << v: (W, [4*v+j for j in range(4)]) for v in range(k)}
    def go(t):
        if isinstance(t, int): return base[t]
        Ti, li = go(t[0]); Tj, lj = go(t[1])
        sh = [(a, legs[a]) for a in li if legs.get(a) in lj]
        ax0 = [li.index(a) for a, b in sh]; ax1 = [lj.index(b) for a, b in sh]
        Tn = np.mod(np.tensordot(Ti, Tj, axes=(ax0, ax1)), p)
        ln = [l for x, l in enumerate(li) if x not in ax0] + \
             [l for x, l in enumerate(lj) if x not in ax1]
        return Tn, ln
    val = 1.0
    for t in trees:
        T, l = go(t); assert T.ndim == 0
        val = val * float(T) % p
    return int(val) % p

def dimension5(n, k, p=10007, npts=140, seed=1, stall=4000, cap=None, maxrank=6,
               verbose=True, tag="", structured=True):
    rng = np.random.default_rng(seed)
    pts = [random_weyl(n, p, rng).astype(np.float64) for _ in range(npts)]
    R = IncRank(p); since = 0; used = 0; t0 = time.time()
    gen = structured_matching if structured else random_matching
    while True:
        m = gen(k, rng)
        mr, trees = best_tree(k, m)
        if mr > maxrank: continue
        used += 1
        if R.add([eval_tree_f(Wp, m, k, p, trees) for Wp in pts]): since = 0
        else: since += 1
        if verbose and used % 200 == 0:
            print(f"  {tag}n={n} k={k}: {used} diagrams, rank {R.rank()}, stall {since}, {time.time()-t0:.0f}s", flush=True)
        if cap and R.rank() >= cap: break
        if since >= stall: break
    return R.rank(), used

def dimension6(n, k, p=10007, npts=100, seed=1, cap=None, stall4=2500, stall6=120,
               verbose=True, tag="", budget6=None):
    """Two-phase.  Phase 1 uses only diagrams whose optimal contraction tree stays
    at rank 4 (n^4 intermediates, milliseconds).  Phase 2 admits rank-6 trees,
    which cost ~n^8 each and are only needed for the last few dimensions."""
    rng = np.random.default_rng(seed)
    pts = [random_weyl(n, p, rng).astype(np.float64) for _ in range(npts)]
    R = IncRank(p); t0 = time.time()
    for phase, mr, stall in ((1, 4, stall4), (2, 6, stall6)):
        since = 0; used = 0
        while True:
            m = structured_matching(k, rng)
            mrk, trees = best_tree(k, m)
            if mrk > mr or (phase == 2 and mrk <= 4): continue
            used += 1
            if R.add([eval_tree_f(Wp, m, k, p, trees) for Wp in pts]): since = 0
            else: since += 1
            if verbose and used % (200 if phase == 1 else 10) == 0:
                print(f"  {tag}n={n} k={k} phase{phase}: {used} diagrams, rank {R.rank()}, "
                      f"stall {since}, {time.time()-t0:.0f}s", flush=True)
            if cap and R.rank() >= cap: return R.rank(), phase
            if since >= stall: break
            if phase == 2 and budget6 and used >= budget6: break
    return R.rank(), 2
