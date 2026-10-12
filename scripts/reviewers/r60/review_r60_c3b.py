"""Reviewer 60, C3 part B: audit the internals of the claimed case analysis --
dim z(c) itself (is it block-diagonal?), the su(k) commutant claim, m=14/16,
and whether nondegeneracy of x is load-bearing."""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from review_r60_core import *
from review_r60_c3 import partitions, block_x, nullspace, centraliser, collapse

rng = np.random.default_rng(6031)

print("=== A. commutant of su(k) on C^k inside so(2k) ===")
def su_k_basis(k):
    """su(k) as real skew matrices on R^{2k} (complex coord j <-> real 2j,2j+1)"""
    m = 2 * k
    def Cmat(Z):
        A, Bm = Z.real, Z.imag
        M = np.zeros((m, m))
        for a in range(k):
            for b in range(k):
                M[2*a, 2*b] = A[a, b];  M[2*a, 2*b+1] = -Bm[a, b]
                M[2*a+1, 2*b] = Bm[a, b]; M[2*a+1, 2*b+1] = A[a, b]
        return M
    out = []
    for a in range(k):
        for b in range(a+1, k):
            Z = np.zeros((k, k), complex); Z[a, b] = 1; Z[b, a] = -1; out.append(Cmat(Z))
            Z = np.zeros((k, k), complex); Z[a, b] = 1j; Z[b, a] = 1j; out.append(Cmat(Z))
    for a in range(k-1):
        Z = np.zeros((k, k), complex); Z[a, a] = 1j; Z[a+1, a+1] = -1j; out.append(Cmat(Z))
    return out

for k in [2, 3, 4, 5]:
    m = 2*k
    V = np.array([mat_to_vec(m, X) for X in su_k_basis(k)]).T
    V = np.linalg.qr(V)[0]
    ZC = centraliser(m, V)
    print(f"  k={k}: dim su(k)={V.shape[1]} (expect {k*k-1});  dim z(su(k)) in so({m}) = {ZC.shape[1]}"
          f"   [claim: 1 for k>=3, 3 for k=2]")

print("\n=== B. is z(c) block-diagonal?  dim z(c) per partition ===")
print("  m  partition        dim c   dim z(c)   dim(z(c) cap c^perp)   blockdiag-predicted dim z(c)")
for m in [6, 8, 10, 12]:
    p = m // 2
    for part in partitions(p):
        al = np.sort(rng.uniform(0.5, 3.0, len(part)))[::-1]
        x = block_x(m, part, al)
        xv = mat_to_vec(m, x); xv /= np.linalg.norm(xv)
        Z = nullspace(np.vstack([ad_of(m, x), xv[None, :]]))
        ZC = centraliser(m, Z)
        d, _ = collapse(m, x)
        # blockwise prediction: per block of complex dim k, commutant of su(k) is 1 (k>=3), 3 (k=2), 1 (k=1... so(2)=R)
        pred = sum({1: 1, 2: 3}.get(k, 1) for k in part)
        print(f"  {m:2d} {str(part):16s} {Z.shape[1]:4d}   {ZC.shape[1]:5d}      {d:5d}"
              f"                  {pred}")

print("\n=== C. m=14, 16 (selected hard patterns) ===")
for m, parts in [(14, [(7,), (2,2,2,1), (1,)*7, (3,2,2), (4,3)]),
                 (16, [(8,), (2,2,2,2), (1,)*8, (3,3,2), (5,3)])]:
    for part in parts:
        al = np.sort(rng.uniform(0.5, 3.0, len(part)))[::-1]
        x = block_x(m, part, al)
        d, U = collapse(m, x)
        xv = mat_to_vec(m, x); xv /= np.linalg.norm(xv)
        ov = float(np.linalg.norm(U.T @ xv)) if d else 0.0
        print(f"  m={m} part={str(part):18s} dim(z(c) cap c^perp) = {d}   |proj of x| = {ov:.6f}")

print("\n=== D. is NONDEGENERACY load-bearing?  x with a zero block ===")
for m in [6, 8, 10]:
    for zeros in [1, 2]:
        p = m // 2
        if zeros >= p: continue
        al = list(np.sort(rng.uniform(0.5, 3.0, p - zeros))[::-1]) + [0.0]*zeros
        x = block_x(m, (1,)*p, al)
        d, U = collapse(m, x)
        print(f"  m={m} rank(x)={np.linalg.matrix_rank(x)}  dim(z(c) cap c^perp) = {d}")
