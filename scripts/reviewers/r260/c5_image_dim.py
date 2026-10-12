"""CLAIM 5 -- dim nu(B_f(n)) against sum_{lambda O(n)-admissible} (dim Delta_lambda)^2,
EXACTLY and far past f = 4.

The primary run builds n^f x n^f dense float matrices, which caps it at f = 4.
Here the same number is computed exactly and cheaply.

  nu(D) is the 0/1 tensor on [n]^{2f} whose entry at an index tuple t is 1 iff
  t is constant on every pair of the matching D.  Two tuples with the same
  KERNEL PARTITION give the same column, so

      dim nu(B_f(n)) = rank of  A[D][pi] = [ D refines pi ]

  with pi ranging over the set partitions of [2f] realisable by a tuple in
  [n]^{2f} -- i.e. at most n blocks -- and only those all of whose blocks have
  EVEN size can dominate a perfect matching at all.  That is a matrix of size
  (2f-1)!! x (a few thousand) instead of n^{2f}.

Rank is taken as rank(A A^T) over F_p for three primes (rank(A A^T) = rank(A)
over Q since A is rational).
"""
import sys, numpy as np
from math import comb
from itertools import combinations

def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

def even_partitions(pts):
    """set partitions of pts all of whose blocks have even size."""
    if not pts:
        yield []
        return
    a, rest = pts[0], list(pts[1:])
    m = len(rest)
    for k in range(1, m+1, 2):                     # block size k+1 is even
        for comb_idx in _combs(range(m), k):
            block = [a] + [rest[i] for i in comb_idx]
            left = tuple(rest[i] for i in range(m) if i not in set(comb_idx))
            for tail in even_partitions(left):
                yield [block] + tail

def _combs(it, k):
    from itertools import combinations
    return combinations(it, k)

def updown_counts(m):
    cur = {(): 1}
    for _ in range(m):
        nxt = {}
        for lam, c in cur.items():
            for k in range(len(lam) + 1):
                new = list(lam) + [0]
                new[k] += 1
                if all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    nxt[key] = nxt.get(key, 0) + c
            for k in range(len(lam)):
                new = list(lam)
                new[k] -= 1
                if new[k] >= 0 and all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    nxt[key] = nxt.get(key, 0) + c
        cur = nxt
    return cur

def conj(lam):
    return tuple(sum(1 for p in lam if p > k) for k in range(lam[0])) if lam else ()

def admissible(lam, n):
    c = conj(lam)
    return (c[0] if len(c) > 0 else 0) + (c[1] if len(c) > 1 else 0) <= n

def rank_mod(A, p):
    A = (A % p).astype(np.int64)
    rows, cols = A.shape
    r = 0
    for c in range(cols):
        nz = np.nonzero(A[r:, c])[0]
        if nz.size == 0:
            continue
        piv = r + nz[0]
        if piv != r:
            A[[r, piv]] = A[[piv, r]]
        A[r] = (A[r] * pow(int(A[r, c]), p-2, p)) % p
        col = A[r+1:, c]
        nz2 = np.nonzero(col)[0]
        if nz2.size:
            A[r+1:][nz2] = (A[r+1:][nz2] - col[nz2][:, None] * A[r][None, :]) % p
        r += 1
        if r == rows:
            break
    return r

PRIMES = [1000003, 999983, 999979]

def pairmask(f):
    """bit index for each unordered pair of [2f]."""
    idx = {}
    k = 0
    for a in range(2*f):
        for b in range(a+1, 2*f):
            idx[(a, b)] = k
            k += 1
    return idx

def image_dim(f, n, dmask, pmask, npart):
    cols = [j for j in range(len(pmask)) if npart[j] <= n]
    A = np.zeros((len(dmask), len(cols)), dtype=np.int8)
    for cj, ci in enumerate(cols):
        pm = pmask[ci]
        col = A[:, cj]
        for di, dm in enumerate(dmask):
            if dm & ~pm == 0:
                col[di] = 1
    G = (A.astype(np.int64)) @ (A.astype(np.int64).T)
    return max(rank_mod(G, p) for p in PRIMES), len(cols)

fmax = int(sys.argv[1]) if len(sys.argv) > 1 else 5
nmax = int(sys.argv[2]) if len(sys.argv) > 2 else 7
print("dim nu(B_f(n))  vs  sum over O(n)-admissible lambda of (dim Delta_lambda)^2")
print("Rui: B_f(n) semisimple over a char-0 field iff n >= f-1.\n")
for f in range(2, fmax+1):
    mats = [tuple(D) for D in matchings(tuple(range(2*f)))]
    parts = list(even_partitions(tuple(range(2*f))))
    pidx = pairmask(f)
    dmask = []
    for D in mats:
        m = 0
        for a, b in D:
            m |= 1 << pidx[(min(a,b), max(a,b))]
        dmask.append(m)
    pmask, npart = [], []
    for P in parts:
        m = 0
        for B in P:
            for a, b in combinations(sorted(B), 2):
                m |= 1 << pidx[(a, b)]
        pmask.append(m)
        npart.append(len(P))
    ud = updown_counts(f)
    tot = sum(d*d for d in ud.values())
    dbl = 1
    for k in range(1, 2*f, 2):
        dbl *= k
    print(f"  f={f}: {len(mats)} diagrams, {len(parts)} even-block partitions; "
          f"sum over ALL lambda of (dim Delta)^2 = {tot} vs (2f-1)!! = {dbl}  "
          f"{'OK' if tot == dbl else 'MISMATCH'}")
    for n in range(2, nmax+1):
        pred = sum(d*d for lam, d in ud.items() if admissible(lam, n))
        got, ncols = image_dim(f, n, dmask, pmask, npart)
        ss = n >= f - 1
        inj = n >= f
        print(f"    n={n}  cols={ncols:>5}  dim nu = {got:>6}   sum (dim Delta)^2 = {pred:>6}   "
              f"{'MATCH' if got == pred else 'DIFFERS'}   ss(n>=f-1)={ss}  inj(n>=f)={inj}")
    sys.stdout.flush()
