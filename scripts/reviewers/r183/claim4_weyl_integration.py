"""Reviewer 183.  An INDEPENDENT count of the degree-k O(n)-invariants on Weyl_n,
by Weyl integration -- no diagrams, no mod-p rank, no random points.

  char(Weyl_n) = h_2(Lambda^2 V) - h_2(V) - Lambda^4 V,   V = the vector rep,
which is the character form of  Sym^2(Lambda^2) = Weyl + Sym^2_0 + R + Lambda^4.

  dim (Sym^k Weyl_n)^{SO(n)} = (1/|W|) * CT[ h_k(char Weyl_n) * prod_{alpha}(1 - x^alpha) ]

Exact integer Laurent-polynomial arithmetic throughout.  For n odd, O(n) =
SO(n) x {+-I} and -I acts trivially on a rank-4 tensor, so this is also the
O(n) count.

Validation that COULD fail: degree 3 must give 1 at n=5 (the Lovelock collapse
that makes theta = 3 tr(W^3) a single invariant) and 2 at n=6.
"""
from itertools import combinations
from collections import defaultdict
import sys

def mul(a, b):
    r = defaultdict(int)
    for ka, va in a.items():
        for kb, vb in b.items():
            r[tuple(x+y for x, y in zip(ka, kb))] += va*vb
    return {k: v for k, v in r.items() if v}

def add(a, b):
    r = defaultdict(int, a)
    for k, v in b.items(): r[k] += v
    return {k: v for k, v in r.items() if v}

def scal(a, c): return {k: v*c for k, v in a.items() if v*c}
def sub(a, b): return add(a, scal(b, -1))
def subst(a, m):
    """x_i -> x_i^m"""
    r = defaultdict(int)
    for k, v in a.items(): r[tuple(e*m for e in k)] += v
    return {k: v for k, v in r.items() if v}
def dim_of(a): return sum(a.values())

def vector_weights(n):
    r = n // 2
    ws = []
    for i in range(r):
        e = [0]*r; e[i] = 1
        ws.append(tuple(e)); ws.append(tuple(-x for x in e))
    if n % 2: ws.append(tuple([0]*r))
    return ws

def ext_power(weights, k):
    """character of Lambda^k of a rep given by its multiset of weights."""
    r = len(weights[0])
    out = defaultdict(int)
    for c in combinations(range(len(weights)), k):
        key = [0]*r
        for i in c:
            for j in range(r): key[j] += weights[i][j]
        out[tuple(key)] += 1
    return {k_: v for k_, v in out.items() if v}

def weights_of(char):
    ws = []
    for k, v in char.items():
        assert v > 0
        ws += [k]*v
    return ws

def h_list(char, kmax, r):
    """complete homogeneous symmetric functions h_1..h_kmax of a character."""
    p = {i: subst(char, i) for i in range(1, kmax+1)}
    h = {0: {tuple([0]*r): 1}}
    for k in range(1, kmax+1):
        acc = {}
        for i in range(1, k+1):
            acc = add(acc, mul(p[i], h[k-i]))
        assert all(v % k == 0 for v in acc.values()), "Newton division failed"
        h[k] = {kk: v//k for kk, v in acc.items() if v}
    return h

def roots(n):
    r = n // 2
    R = []
    for i in range(r):
        for j in range(i+1, r):
            for s1 in (1, -1):
                for s2 in (1, -1):
                    e = [0]*r; e[i] = s1; e[j] = s2
                    R.append(tuple(e))
    if n % 2:
        for i in range(r):
            for s in (1, -1):
                e = [0]*r; e[i] = s
                R.append(tuple(e))
    return R

def weyl_order(n):
    import math
    r = n // 2
    return (2**r)*math.factorial(r) if n % 2 else (2**(r-1))*math.factorial(r)

def invariant_dim(n, k):
    r = n // 2
    V = defaultdict(int)
    for w in vector_weights(n): V[w] += 1
    V = dict(V)
    L2 = ext_power(vector_weights(n), 2)
    L4 = ext_power(vector_weights(n), 4)
    hL2 = h_list(L2, 2, r); hV = h_list(V, 2, r)
    W = sub(sub(hL2[2], hV[2]), L4)
    assert all(v > 0 for v in W.values()), f"non-character Weyl_{n}: {W}"
    hW = h_list(W, k, r)
    meas = {tuple([0]*r): 1}
    for a in roots(n):
        meas = mul(meas, {tuple([0]*r): 1, a: -1})
    prod = mul(hW[k], meas)
    ct = prod.get(tuple([0]*r), 0)
    assert ct % weyl_order(n) == 0, (ct, weyl_order(n))
    return dim_of(W), ct // weyl_order(n)

if __name__ == "__main__":
    for n in (5, 6):
        for k in (1, 2, 3, 4):
            dW, dI = invariant_dim(n, k)
            print(f"  n={n} dim Weyl_n={dW}  degree {k}: {dI} invariants", flush=True)
    for n in (5,):
        for k in (5, 6):
            dW, dI = invariant_dim(n, k)
            print(f"  n={n} dim Weyl_n={dW}  degree {k}: {dI} invariants", flush=True)
