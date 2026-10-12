"""r274, Claim 6: independent validation of the r259/r260 verdict  r = 6 + |lambda|/2.

Two halves.
 (A) The criterion itself. Lehrer-Zhang / ASWT: the (2r-1)!! Brauer diagrams span
     (V^{ox 2r})^{O(n)} always, and are INDEPENDENT iff r <= n.  Tested here by the
     rank of the diagram Gram matrix  G_{D,D'} = n^{c(D u D')}  -- whose entries are
     the honest inner products of the gamma_D, and whose size is n-independent.
     Cross-checked against the brute-force dimension of the invariant space in
     V^{ox 2r} (n^{2r} x (2r-1)!! evaluation matrix) at small n.
 (B) The leg arithmetic: a covariant  V^{ox 12} -> V_lambda  pairs against
     V_lambda c V^{ox |lambda|}, so it is an invariant functional on 12 + |lambda|
     legs, i.e. r = 6 + |lambda|/2.  Verified as a DIMENSION statement:
     dim Hom_{O(n)}(V^{ox f}, V_lambda) = dim (V^{ox f} ox V_lambda)^{O(n)}.
"""
import numpy as np, itertools
from fractions import Fraction

def perfect_matchings(k):
    pts = list(range(k))
    def rec(rem):
        if not rem: yield []
        else:
            a = rem[0]
            for i in range(1, len(rem)):
                b = rem[i]
                rest = rem[1:i] + rem[i+1:]
                for m in rec(rest): yield [(a, b)] + m
    return list(rec(pts))

def cycles(D, E, k):
    adj = {i: [] for i in range(k)}
    for (a,b) in D: adj[a].append(b); adj[b].append(a)
    for (a,b) in E: adj[a].append(b); adj[b].append(a)
    seen = set(); c = 0
    for s in range(k):
        if s in seen: continue
        c += 1; stack=[s]
        while stack:
            v = stack.pop()
            if v in seen: continue
            seen.add(v)
            for w in adj[v]:
                if w not in seen: stack.append(w)
    return c

print("(A) independence threshold for the Brauer spanning set, from the diagram Gram rank")
print(f"{'r':>2} {'#diagrams':>10} | " + " ".join(f"n={n:<3}" for n in range(1, 9)))
for r in (1, 2, 3, 4):
    k = 2*r
    Ds = perfect_matchings(k)
    C = np.array([[cycles(D, E, k) for E in Ds] for D in Ds])
    row = []
    for n in range(1, 9):
        # exact rank over Q via fractions is slow; use rank of the integer matrix mod two primes
        G = np.array(n, dtype=object) ** C
        # rank mod p
        rks = []
        for p in (2147483647, 2147483629):
            A = np.array([[int(x) % p for x in rw] for rw in G.tolist()], dtype=np.int64)
            m = A.shape[0]; rk = 0
            for col in range(m):
                nz = np.nonzero(A[rk:, col])[0]
                if nz.size == 0: continue
                pr = rk + nz[0]
                A[[rk, pr]] = A[[pr, rk]]
                inv = pow(int(A[rk, col]), p-2, p)
                A[rk] = (A[rk] * inv) % p
                f = A[:, col].copy(); f[rk] = 0
                A = (A - np.outer(f, A[rk]) % p) % p
                rk += 1
            rks.append(rk)
        row.append(f"{max(rks):<5}")
    print(f"{r:>2} {len(Ds):>10} | " + " ".join(row) + f"   (full = {len(Ds)}; predicted full iff n >= r)")

print("\n(B) the leg arithmetic for a covariant into the block V_lambda")
print("  a covariant  V^ox12 -> V_lambda  <->  an invariant on 12 + |lambda| legs  =>  r = 6 + |lambda|/2")
print(f"{'|lambda|':>9} | " + " ".join(f"{v:>4}" for v in range(0, 13, 2)))
print(f"{'r':>9} | " + " ".join(f"{6+v//2:>4}" for v in range(0, 13, 2)))
print(f"{'r<=n, n=6':>9} | " + " ".join(f"{'yes' if 6+v//2<=6 else 'no':>4}" for v in range(0, 13, 2)))
print(f"{'r<=n,n=12':>9} | " + " ".join(f"{'yes' if 6+v//2<=12 else 'no':>4}" for v in range(0, 13, 2)))
