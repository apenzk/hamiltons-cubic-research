"""r244 / claim 5.  What does the n=5 certificate tell us about A2's open case?

A2' concedes: "if no constant t gives a PSD member, t must be taken polynomial
in n" -- a fit INSIDE the family.  The brief asks whether n=5 is evidence.

n=5 is a SINGLE dimension, so it cannot exhibit n-dependence of t directly.
What it CAN answer is the structural question that decides whether the open
case is the actual case:

  * If the n=5 certificate is in the INTERIOR of the psd cone, its free
    coefficients live in an OPEN set.  Then a rounded / arbitrary choice works,
    and a constant t has a genuine chance of surviving a whole interval of n,
    because the psd condition is an open condition with slack to spend.
  * If it is on the BOUNDARY, the free coefficients are pinned to a measure-zero
    set and no arbitrary choice survives.

Blocks are HERMITIAN over Q(i) (coordinate order from r213's herm_row: per
block, for i ascending, the real diagonal then (re, im) for each j > i).
Exact rational LDL^H, no floats, no square roots.
"""
import json, os
from fractions import Fraction as F

RUNS = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
C = json.load(open(os.path.join(RUNS, "n5_certificate.json")))
pt = [F(int(a), int(b)) for a, b in C["point"]]
SHAPE, LAB = C["shape"], C["blocks"]
assert sum(k*k for k in SHAPE) == len(pt)

def add(a,b): return (a[0]+b[0], a[1]+b[1])
def sub(a,b): return (a[0]-b[0], a[1]-b[1])
def mul(a,b): return (a[0]*b[0]-a[1]*b[1], a[0]*b[1]+a[1]*b[0])
def cj(a):    return (a[0], -a[1])
def dv(a,b):
    d = b[0]*b[0]+b[1]*b[1]
    return ((a[0]*b[0]+a[1]*b[1])/d, (a[1]*b[0]-a[0]*b[1])/d)
Z = (F(0), F(0))

def blocks(vec):
    out, k0 = [], 0
    for k in SHAPE:
        M = [[Z]*k for _ in range(k)]
        for i in range(k):
            M[i][i] = (vec[k0], F(0)); k0 += 1
            for j in range(i+1, k):
                M[i][j] = (vec[k0], vec[k0+1]); M[j][i] = (vec[k0], -vec[k0+1]); k0 += 2
        out.append(M)
    assert k0 == len(vec)
    return out

def ldl(M):
    k = len(M)
    L = [[(F(1),F(0)) if i==j else Z for j in range(k)] for i in range(k)]
    D = [F(0)]*k
    for j in range(k):
        s = M[j][j]
        for r in range(j): s = sub(s, mul(mul(L[j][r], (D[r],F(0))), cj(L[j][r])))
        assert s[1] == 0
        D[j] = s[0]
        if D[j] == 0: return L, D, False
        for i in range(j+1, k):
            t = M[i][j]
            for r in range(j): t = sub(t, mul(mul(L[i][r], (D[r],F(0))), cj(L[j][r])))
            L[i][j] = dv(t, (D[j], F(0)))
    return L, D, True

BL = blocks(pt)
for M in BL:
    for i in range(len(M)):
        assert M[i][i][1] == 0
        for j in range(len(M)): assert M[i][j] == cj(M[j][i])
print("every block is Hermitian with real diagonal")

sing = 0; slack = None
print(f"\n{'blk':>3} {'label':>8} {'k':>2} {'pivots all > 0':>15}   smallest pivot")
for i, M in enumerate(BL):
    L, D, full = ldl(M)
    pos = full and all(d > 0 for d in D)
    if not pos: sing += 1
    m = min(D)
    slack = m if slack is None else min(slack, m)
    print(f"{i:>3} {str(LAB[i]):>8} {SHAPE[i]:>2} {str(pos):>15}   {m}  ~ {float(m):.3e}")

print(f"\nblocks that are NOT strictly positive definite: {sing}")
print(f"smallest pivot over all blocks: {slack} ~ {float(slack):.4e}")
print("\nVERDICT: " + ("BOUNDARY -- some block is singular, the free coefficients are pinned"
                       if sing else
                       "INTERIOR -- every block is strictly positive definite, so the free\n"
                       "         coefficients were chosen from an OPEN set with slack "
                       f"{float(slack):.2e}.\n"
                       "         n=5 is a NON-SHARP certificate: it has no forced kernel."))

# How much of the point is free?  The docstring of run_n5_sdp says 36 unknowns
# against 14 constraints -> a 22-dimensional family; run_n5_verify records "the
# 34 kernel coefficients".  Either way the point is a CHOICE inside a family.
print(f"\nrecorded rounding denominator for the free coefficients: {C['denominator']}")
big = [(a,b) for a,b in C['point'] if int(b) > C['denominator']]
print(f"coordinates whose denominator exceeds it: {len(big)} of {len(pt)} "
      "-- the rounding was imposed on the FREE coefficients only, the rest\n"
      "inherited from the exact particular solution and kernel basis.")
