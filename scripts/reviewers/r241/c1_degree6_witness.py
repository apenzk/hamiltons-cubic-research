"""r241 / claim 1, hardening: the same counterexample at DEGREE SIX exactly.

c1_reducedness.py made the point with a degree-2 covariant.  A2's statement is
about degree-6 diagrams (24 Weyl slots), so the witness is rebuilt there:

    T_ij = (S^3)_ij  with  S_ij = W_iabc W_jabc     -- degree 6 in W, 24 slots,
                                                       f = 2, a_T = 0
    P    = (g_ab g^ab) * T                          -- a_P = 2, still degree 6
    Q    = T                                        -- a_Q = 0

brauer-pairing.md gives <P,Q> = n^L q_D with L <= min(a_P, a_Q) = 0.
"""
from fractions import Fraction as F
import random

def wp(R, n):
    rg = range(n)
    B = [[[[F(1,4)*(R[i][j][k][l]-R[j][i][k][l]-R[i][j][l][k]+R[j][i][l][k])
            for l in rg] for k in rg] for j in rg] for i in rg]
    B = [[[[F(1,2)*(B[i][j][k][l]+B[k][l][i][j]) for l in rg] for k in rg]
          for j in rg] for i in rg]
    B = [[[[B[i][j][k][l]-F(1,3)*(B[i][j][k][l]+B[i][k][l][j]+B[i][l][j][k])
            for l in rg] for k in rg] for j in rg] for i in rg]
    Ric = [[sum(B[i][k][j][k] for k in rg) for j in rg] for i in rg]
    sc = sum(Ric[i][i] for i in rg)
    E = [[Ric[i][j]-F(sc,n)*(i==j) for j in rg] for i in rg]
    g = [[F(1) if a==b else F(0) for b in rg] for a in rg]
    def KN(P,Q,i,j,k,l):
        return P[i][k]*Q[j][l]+P[j][l]*Q[i][k]-P[i][l]*Q[j][k]-P[j][k]*Q[i][l]
    W = [[[[B[i][j][k][l]-F(1,n-2)*KN(E,g,i,j,k,l)
            -F(sc,2*n*(n-1))*KN(g,g,i,j,k,l) for l in rg] for k in rg]
          for j in rg] for i in rg]
    return [[[[F(1,2)*(W[i][j][k][l]+W[k][l][i][j]) for l in rg] for k in rg]
             for j in rg] for i in rg]

rnd = random.Random(241)
N0 = 4
R0 = [[[[F(rnd.randint(-3,3)) for _ in range(N0)] for _ in range(N0)]
       for _ in range(N0)] for _ in range(N0)]
W0 = wp(R0, N0)

def padded(n):
    Wn = [[[[F(0)]*n for _ in range(n)] for _ in range(n)] for _ in range(n)]
    for i in range(N0):
        for j in range(N0):
            for k in range(N0):
                for l in range(N0):
                    Wn[i][j][k][l] = W0[i][j][k][l]
    return Wn

def mm(A, B, m):
    return [[sum(A[i][k]*B[k][j] for k in range(m)) for j in range(m)]
            for i in range(m)]

rows = []
for m in (5, 6, 7, 8, 9, 10):
    W = padded(m); r = range(m)
    S = [[sum(W[i][a][b][c]*W[j][a][b][c] for a in r for b in r for c in r)
          for j in r] for i in r]
    T = mm(mm(S, S, m), S, m)                      # degree 6, f = 2
    pure = sum(T[i][j]*T[i][j] for i in r for j in r)
    cyc = sum(1 for a in r)                        # g_ab g^ab = n
    rows.append((m, pure, cyc*pure))

print("  degree-6 covariant T = S^3, f = 2.  <P,Q> with P = (g_ab g^ab) * T:")
print("     n   <T,T> (reduced)                       <P,T> (unreduced)")
for m, a, b in rows:
    print(f"   {m:>3}   {a!s:>34}   {b!s:>38}")
const = len({a for _, a, _ in rows}) == 1
lin = all(b == m*a for m, a, b in rows)
print(f"\n  reduced entry constant in n            : {const}")
print(f"  unreduced entry equals n * that constant: {lin}")
print( "  min(a_P, a_Q) = 0 -> monomial theorem predicts degree 0; actual degree 1.")
assert const and lin
print("\n  DEGREE-6 WITNESS CONFIRMED.")
