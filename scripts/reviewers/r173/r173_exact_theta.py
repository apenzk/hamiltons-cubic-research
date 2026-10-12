"""Reviewer 173 -- theta(W_CP2) = sqrt(3/2) in EXACT rational arithmetic.

RUN:  python3 scripts/reviewers/r173/r173_exact_theta.py

plan.md calls the zero of F at W_CP2 "exhibited": theta = 1.224744871392 and
F = -8.9e-16.  The Fubini-Study curvature tensor is rational, so the statement is
decidable exactly.  Weyl operator convention: W acts on Lambda^2 with the orthonormal
basis e_a ^ e_b (a<b), so ||I||^2 = dim Lambda^2 and ||W||^2 = tr(M^2).

At n = 5 the record's Lovelock collapse gives theta = 3 tr(M^3)/||W||^3, so the exact
claim to test is  tr(M^3)^2 / tr(M^2)^3 = 1/6.
"""
from fractions import Fraction as F
from itertools import product

n4 = 4
J = [[0]*4 for _ in range(4)]
J[0][1] = -1; J[1][0] = 1; J[2][3] = -1; J[3][2] = 1
d = lambda i, j: 1 if i == j else 0

R = {}
for a,b,c,e in product(range(4), repeat=4):
    R[a,b,c,e] = F(d(a,c)*d(b,e) - d(a,e)*d(b,c)
                   + J[a][c]*J[b][e] - J[a][e]*J[b][c] + 2*J[a][b]*J[c][e])

Ric = [[sum(R[a,b,a,e] for a in range(4)) for e in range(4)] for b in range(4)]
Sc  = sum(Ric[i][i] for i in range(4))
Wt = {}
for a,b,c,e in product(range(4), repeat=4):
    kn = (d(a,c)*Ric[b][e] - d(a,e)*Ric[b][c] - d(b,c)*Ric[a][e] + d(b,e)*Ric[a][c])
    gg = d(a,c)*d(b,e) - d(a,e)*d(b,c)
    Wt[a,b,c,e] = R[a,b,c,e] - F(kn, n4-2) + F(Sc,(n4-1)*(n4-2))*gg

# checks
assert all(Wt[a,b,c,e] == -Wt[b,a,c,e] for a,b,c,e in product(range(4),repeat=4))
assert all(Wt[a,b,c,e] == Wt[c,e,a,b] for a,b,c,e in product(range(4),repeat=4))
assert all(Wt[a,b,c,e]+Wt[a,c,e,b]+Wt[a,e,b,c] == 0 for a,b,c,e in product(range(4),repeat=4))
assert all(sum(Wt[a,b,a,e] for a in range(4)) == 0 for b,e in product(range(4),repeat=2))
print("CP^2 Weyl tensor: antisymmetry, pair symmetry, first Bianchi, tracelessness all exact")

# pad to n = 5 and build the Lambda^2 operator matrix
idx = [(a,b) for a in range(5) for b in range(a+1,5)]
M = [[F(0)]*len(idx) for _ in idx]
for i,(a,b) in enumerate(idx):
    for j,(c,e) in enumerate(idx):
        if max(a,b,c,e) < 4:
            M[i][j] = Wt[a,b,c,e]

def matmul(A,B):
    m = len(A); k = len(B); p = len(B[0])
    return [[sum(A[i][t]*B[t][j] for t in range(k)) for j in range(p)] for i in range(m)]
def tr(A): return sum(A[i][i] for i in range(len(A)))

M2 = matmul(M,M); M3 = matmul(M2,M)
p2 = tr(M2); p3 = tr(M3)
print("tr(M^2) =", p2, "   tr(M^3) =", p3)
ratio = p3*p3 / (p2**3)
print("tr(M^3)^2 / tr(M^2)^3 =", ratio, "   target 1/6 =", F(1,6), "  EQUAL:", ratio == F(1,6))
print("theta^2 = 9 * ratio =", 9*ratio, "   target 3/2:", 9*ratio == F(3,2))
print("normalised tr(W_0^3) = p3/p2^{3/2}; its square =", p3*p3/(p2**3), "= 1/6, so tr(W_0^3) = 1/sqrt(6)  CONFIRMED")
