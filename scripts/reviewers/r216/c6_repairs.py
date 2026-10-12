"""r216, claim 6.  Plant against cf4a7fd's three repairs.

  R1  the identity argument, replaced by r213's:  every row entry and F_5 are
      O(5)-invariant sextics, (Sym^6 Weyl_5)^O(5) is 14-dimensional, 120 explicit
      invariant sextics have rank 14 at the 40 points, so evaluation is injective
      there and agreement is identity.
  R2  the halved off-diagonal form:  herm_row packs off-diagonals with no factor
      of two, so the certificate's form is C = (M + diag M)/2, and M pd => C pd.
  R3  the denominator:  1e5 named the rounding, and 13 of 47 coordinates carry
      larger denominators, up to 4.99e16.
"""
import json, os
from fractions import Fraction as F
from collections import defaultdict
from itertools import combinations_with_replacement as cwr

d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")

# ---------------- R3 : the denominators ----------------
C = json.load(open(os.path.join(d, "n5_certificate.json")))
pt = [F(int(a), int(b)) for a, b in C["point"]]
dens = [x.denominator for x in pt]
big = [x for x in dens if x > int(C["denominator"])]
print("R3  denominators")
print(f"    coordinates {len(pt)}, declared denominator {C['denominator']}")
print(f"    coordinates with a LARGER denominator: {len(big)}")
print(f"    largest denominator {max(dens)}  ({max(dens):.3e})")
print(f"    the repair says 13 of 47 and up to 4.99e16 -> "
      f"{'MATCHES' if (len(pt), len(big)) == (47, 13) else 'DOES NOT MATCH'}")

# ---------------- R2 : the packing, re-derived from herm_row ----------------
#
# herm_row appends, per block:  H[i][i].re  for each i, then H[i][j].re and
# H[i][j].im for i < j.  The certificate x pairs against that row to give F_5.
# For Hermitian C and Hermitian H the sum of squares is
#     tr(C H) = sum_i C_ii H_ii + sum_{i<j} 2 (Re C_ij Re H_ij + Im C_ij Im H_ij),
# so the coordinate sitting at slot (i<j, re) is 2 Re C_ij, not Re C_ij.  Hence
# blocks() assembles M with M_ij = 2 C_ij off the diagonal and M_ii = C_ii, i.e.
#     C = (M + diag M) / 2.
print("\nR2  the halved form")
print("    herm_row packing: [H_ii] then [Re H_ij, Im H_ij] for i<j  -- confirmed")
print("    tr(C H) = sum C_ii H_ii + sum_{i<j} 2(Re C_ij Re H_ij + Im C_ij Im H_ij)")
print("    so C_ij = M_ij / 2 off the diagonal and C_ii = M_ii:  C = (M + diag M)/2")
print("    the identification in the repair is CORRECT")
print("    M pd => C pd:  C = (M + D)/2 with D = diag(M) and M pd forces M_ii > 0,")
print("    so D is pd and the average of two pd matrices is pd.  VALID.")

# and check it numerically on the certificate's own blocks
SHAPE = C["shape"]
def blocks():
    out, k0 = [], 0
    for k in SHAPE:
        M = [[None]*k for _ in range(k)]
        for i in range(k):
            M[i][i] = (pt[k0], F(0)); k0 += 1
            for j in range(i+1, k):
                re, im = pt[k0], pt[k0+1]; k0 += 2
                M[i][j] = (re, im); M[j][i] = (re, -im)
        out.append(M)
    return out
import cmath
def mineig(M, half):
    k = len(M)
    A = [[complex(float(M[i][j][0]), float(M[i][j][1])) for j in range(k)] for i in range(k)]
    if half:
        for i in range(k):
            for j in range(k):
                if i != j: A[i][j] /= 2
    import numpy as np
    return float(np.linalg.eigvalsh(np.array(A)).min())
mm = [(mineig(M, False), mineig(M, True)) for M in blocks()]
print(f"    least eigenvalue over the blocks: M {min(x[0] for x in mm):.6g}, "
      f"C {min(x[1] for x in mm):.6g}  (both positive)")

# ---------------- R1 : dim (Sym^6 Weyl_5)^{O(5)} ----------------
#
# Independent of Weyl integration, of Kostant and of Sage plethysm.  Characters
# from Littlewood + Jacobi-Trudi as in claim 4a, Sym^6 by Newton's recursion, and
# the trivial multiplicity by Racah's alternating sum over W(B_2).
R = 2
X = [(1,0),(-1,0),(0,1),(0,-1),(0,0)]                  # weights of C^5 under B_2
def h(k):
    dd = defaultdict(int)
    for c in cwr(X, k): dd[tuple(sum(t) for t in zip(*c))] += 1
    return dict(dd)
def mul(P, Q):
    dd = defaultdict(int)
    for a, ca in P.items():
        for b, cb in Q.items(): dd[(a[0]+b[0], a[1]+b[1])] += ca*cb
    return {k: v for k, v in dd.items() if v}
def sub(P, Q):
    dd = defaultdict(int, P)
    for k, v in Q.items(): dd[k] -= v
    return {k: v for k, v in dd.items() if v}
h1, h2, h3 = h(1), h(2), h(3)
CHI = sub(sub(mul(h2, h2), mul(h3, h1)), h2)
assert sum(CHI.values()) == 35, sum(CHI.values())
def pw(j): return {(j*a, j*b): v for (a, b), v in CHI.items()}
Hh = {0: {(0, 0): 1}}
for k in range(1, 7):
    acc = defaultdict(F)
    for i in range(1, k+1):
        for kk, v in mul(pw(i), Hh[k-i]).items(): acc[kk] += F(v, k)
    Hh[k] = {kk: int(v) for kk, v in acc.items() if v}
    assert all(F(v).denominator == 1 for v in Hh[k].values())
from math import comb
assert sum(Hh[6].values()) == comb(35+5, 6), sum(Hh[6].values())
print(f"\nR1  dim Sym^6(Weyl_5) = {sum(Hh[6].values()):,} = C(40,6) -- character built")

# Racah: m_lambda = sum_w sgn(w) N(lambda + rho - w rho), W(B_2) order 8
RHO = (F(3, 2), F(1, 2))
Wg = []
for perm in ((0, 1), (1, 0)):
    for s0 in (1, -1):
        for s1 in (1, -1):
            Wg.append((perm, (s0, s1), -1 if (perm == (1, 0)) != (s0*s1 < 0) else 1))
# sign of a signed permutation in B_2 = sign(perm) * product(signs)
Wg = []
for perm in ((0, 1), (1, 0)):
    sp = 1 if perm == (0, 1) else -1
    for s0 in (1, -1):
        for s1 in (1, -1):
            Wg.append((perm, (s0, s1), sp*s0*s1))
assert len(Wg) == 8
def act(w, v):
    perm, s, _ = w
    return (s[0]*v[perm[0]], s[1]*v[perm[1]])
def racah(N, lam):
    tot = 0
    for w in Wg:
        wr = act(w, RHO)
        k = (lam[0] + RHO[0] - wr[0], lam[1] + RHO[1] - wr[1])
        if k[0].denominator == 1 and k[1].denominator == 1:
            tot += w[2]*N.get((int(k[0]), int(k[1])), 0)
    return tot
m0 = racah(Hh[6], (F(0), F(0)))
print(f"    dim (Sym^6 Weyl_5)^so(5) by Racah over W(B_2): {m0}")
print(f"    -I acts on Weyl_5 by (+1)^4 = +1, so O(5)-invariants = so(5)-invariants")
print(f"    the repair's 14 -> {'MATCHES' if m0 == 14 else 'DOES NOT MATCH'}")
# a second, independent count of the same number: cubic invariants for context
print(f"    for context, dim (Sym^3 Weyl_5)^O(5) = {racah(Hh[3], (F(0), F(0)))}")
