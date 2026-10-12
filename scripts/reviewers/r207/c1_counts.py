"""r207: dim (Sym^6 Weyl_5)^{O(5)} = 14 and dim Sym^2(Sym^3 Weyl_5)^{O(5)} = 65,
by Weyl integration, independently of MULT.

    dim V^G = (1/|W|) CT[ chi_V(t) * prod_{alpha in Phi} (1 - t^alpha) ].

Characters of Sym^k come from the power sums by Newton, so the 7770- and
3838380-dimensional spaces are never built.  -I acts trivially on Weyl_5, and
O(5) = SO(5) x {+-I}, so O(5)-invariants and SO(5)-invariants coincide.
"""
from fractions import Fraction as Fr
from itertools import permutations, product
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from c2_mult_check import weights                     # B_2 Weyl character formula

def mul(P, Q):
    R = {}
    for k1,c1 in P.items():
        for k2,c2 in Q.items():
            k = (k1[0]+k2[0], k1[1]+k2[1]); R[k] = R.get(k,0)+c1*c2
    return {k:c for k,c in R.items() if c}
def add(P, Q):
    R = dict(P)
    for k,c in Q.items(): R[k] = R.get(k,0)+c
    return {k:c for k,c in R.items() if c}
def scal(a,P): return {k:a*c for k,c in P.items() if a*c}

def pk(wts, j):
    P = {}
    for w, m in wts.items():
        k = (j*w[0], j*w[1]); P[k] = P.get(k,0)+m
    return P
def hk(wts, n):
    """complete homogeneous symmetric character h_n of the alphabet `wts`."""
    h = [{(0,0): Fr(1)}]
    for k in range(1, n+1):
        acc = {}
        for j in range(1, k+1):
            acc = add(acc, mul(pk(wts, j), h[k-j]))
        h.append(scal(Fr(1,k), acc))
    return h[n]

ROOTS = [(1,-1),(1,1),(-1,1),(-1,-1),(1,0),(-1,0),(0,1),(0,-1)]
DEN = {(0,0): Fr(1)}
for a in ROOTS: DEN = mul(DEN, add({(0,0):Fr(1)}, {a: Fr(-1)}))
def invdim(chi):
    v = mul(chi, DEN).get((0,0), Fr(0)) / 8
    assert v.denominator == 1
    return int(v)

W5 = weights(2,2)
assert sum(W5.values()) == 35
print(f"Weyl_5: {sum(W5.values())} weights")
s3 = hk(W5, 3)
print(f"dim Sym^3(Weyl_5) = {sum(s3.values())}   (7770)")
print(f"dim (Sym^6 Weyl_5)^O(5)   = {invdim(hk(W5, 6))}   (the file's 14)")
print(f"dim (Sym^3 Weyl_5)^O(5)   = {invdim(s3)}   (the invariant cubics)")
s3w = {k: int(v) for k, v in s3.items()}
print(f"dim Sym^2(Sym^3 Weyl_5)^O(5) = {invdim(hk(s3w, 2))}   (the file's 65)")
print(f"dim Lambda^2(Sym^3)^O(5)     = "
      f"{invdim(scal(Fr(1,2), add(mul(pk(s3w,1),pk(s3w,1)), scal(-1, pk(s3w,2)))))}   (24)")
