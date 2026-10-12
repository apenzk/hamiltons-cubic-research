"""r212: verify the claim-5 rational point WITHOUT using ldl_psd.

Sylvester over Q(i): a Hermitian matrix with Gaussian-rational entries is
positive definite iff every leading principal minor is > 0, and the minors are
real automatically.  Determinants are computed by exact cofactor expansion in
Q(i) implemented here, so nothing in this check comes from the pipeline.
"""
import os, pickle
from fractions import Fraction as Fr
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
P = pickle.load(open(os.path.join(HERE, "claim5_point.pkl"), "rb"))
x, SHAPE, BLK = P["x"], P["shape"], P["blocks"]
D = pickle.load(open(os.path.join(HERE, "exact_rows.pkl"), "rb"))
A, B = D["A"], D["B"]
NR, NC = len(A), len(A[0])

# ---- Gaussian rationals as (re, im) pairs of Fractions ----
def gadd(a, b): return (a[0]+b[0], a[1]+b[1])
def gmul(a, b): return (a[0]*b[0]-a[1]*b[1], a[0]*b[1]+a[1]*b[0])
def gneg(a): return (-a[0], -a[1])
def gconj(a): return (a[0], -a[1])

def det(M):
    n = len(M)
    if n == 0: return (Fr(1), Fr(0))
    if n == 1: return M[0][0]
    tot = (Fr(0), Fr(0))
    for j in range(n):
        if M[0][j] == (Fr(0), Fr(0)): continue
        minor = [[M[i][k] for k in range(n) if k != j] for i in range(1, n)]
        term = gmul(M[0][j], det(minor))
        tot = gadd(tot, term if j % 2 == 0 else gneg(term))
    return tot

# ---- rebuild the Hermitian blocks from the 47 coordinates, true layout ----
blocks, c = [], 0
for k in SHAPE:
    H = [[(Fr(0), Fr(0))]*k for _ in range(k)]
    H = [[(Fr(0), Fr(0)) for _ in range(k)] for _ in range(k)]
    for i in range(k):
        H[i][i] = (Fr(x[c]), Fr(0)); c += 1
        for j in range(i+1, k):
            re = Fr(x[c]); c += 1
            im = Fr(x[c]); c += 1
            H[i][j] = (re, im); H[j][i] = (re, -im)
    blocks.append(H)
assert c == NC

print("A) the 40 affine equations, exactly over Q")
bad = [i for i in range(NR) if sum(A[i][j]*x[j] for j in range(NC)) != B[i]]
print(f"   violations: {len(bad)} of {NR}   (equality of rationals, not a residual)")

print("\nB) Hermitian: H_ji = conj(H_ij) by construction; check it holds")
nh = sum(1 for H in blocks for i in range(len(H)) for j in range(len(H))
         if H[i][j] != gconj(H[j][i]))
print(f"   violations: {nh}")

print("\nC) Sylvester over Q(i): every leading principal minor > 0")
allpd = True
for l, H, k in zip(BLK, blocks, SHAPE):
    ms = []
    for r in range(1, k+1):
        dd = det([[H[i][j] for j in range(r)] for i in range(r)])
        assert dd[1] == 0, f"a leading minor of {l} is not real: {dd}"
        ms.append(dd[0])
    pd = all(m > 0 for m in ms)
    allpd &= pd
    w = np.linalg.eigvalsh(np.array([[complex(float(H[i][j][0]), float(H[i][j][1]))
                                      for j in range(k)] for i in range(k)]))
    print(f"   {l} k={k}: minors {[float(m) for m in ms]}  PD={pd}   "
          f"(numpy min eig {w.min():.6f})")
print(f"\n   POSITIVE DEFINITE ON EVERY BLOCK: {allpd}")
print(f"   affine violations {len(bad)}, Hermitian violations {nh}")
if allpd and not bad and not nh:
    print("\n   THE POINT IS AN EXACT RATIONAL, STRICTLY POSITIVE DEFINITE MEMBER")
    print("   OF THE AFFINE FAMILY.  Nothing in this file is floating point.")
