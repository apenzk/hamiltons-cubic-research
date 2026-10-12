"""r241 / claim 1: is A2's two-line discharge of reducedness EXHAUSTIVE?

A2's discharge, verbatim:
  "A self-loop on a WEYL factor is a trace of W on two of its own indices,
   which VANISHES: on the first pair or second pair by antisymmetry, across
   pairs by Ricci-flatness.  A self-loop on a bare metric is delta^a_a = n,
   which is the L-count already in the monomial theorem.  So every unreduced
   diagram is either zero or n times a smaller diagram."

This script (1) confirms both cases hold, exactly; (2) exhibits the
configurations the two cases do NOT reach; (3) shows one of those breaks the
very bound the reducedness precondition exists to protect,
L <= min(a_P, a_Q) (brauer-pairing.md); and (4) confirms the brief's other
question -- that a contraction component touching two DIFFERENT Weyl factors
carries no n, and why.

Everything is exact over Q.  The Weyl tensor is built at n0 = 4 and PADDED, so
any n-dependence seen is the diagram's, never the tensor's.
"""
from fractions import Fraction as F
import random

# ---- exact Weyl projector, same construction as the file under review -------
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

n = 7
W = padded(n)
rg = range(n)

print("=" * 74)
print("(1)  CASE (i): a self-loop inside ONE Weyl factor, all six slot pairs.")
print("=" * 74)
pairs = [(0,1),(2,3),(0,2),(0,3),(1,2),(1,3)]
why = {(0,1):"antisymmetry, first pair", (2,3):"antisymmetry, second pair",
       (0,2):"Ricci-flatness", (0,3):"Ricci-flatness",
       (1,2):"Ricci-flatness", (1,3):"Ricci-flatness"}
def selftrace(W, p, q, n):
    """trace W over slots p<q, returning the residual 2-tensor."""
    out = [[F(0)]*n for _ in range(n)]
    free = [i for i in range(4) if i not in (p, q)]
    for x in range(n):
        for y in range(n):
            s = F(0)
            for a in range(n):
                idx = [0]*4
                idx[p] = a; idx[q] = a; idx[free[0]] = x; idx[free[1]] = y
                s += W[idx[0]][idx[1]][idx[2]][idx[3]]
            out[x][y] = s
    return out
allzero = True
for p, q in pairs:
    T = selftrace(W, p, q, n)
    z = all(T[x][y] == 0 for x in rg for y in rg)
    allzero &= z
    print(f"   trace on slots {p},{q}: identically zero = {z}   ({why[(p,q)]})")
assert allzero
print("   -> six slot pairs, six vanishings.  CASE (i) IS EXHAUSTIVE PER FACTOR.")

print()
print("=" * 74)
print("(2)  CASE (ii): a self-loop on ONE bare metric.")
print("=" * 74)
g = [[F(1) if a == b else F(0) for b in rg] for a in rg]
print(f"   sum_a g_aa = {sum(g[a][a] for a in rg)}   (= n = {n})")
assert sum(g[a][a] for a in rg) == n

print()
print("=" * 74)
print("(3)  WHAT THE TWO CASES DO NOT REACH.")
print("=" * 74)
# (3a) a CYCLE of two DISTINCT bare metrics.  No factor carries a self-loop.
val = sum(g[a][b]*g[a][b] for a in rg for b in rg)
print(f"   (3a) g_ab g^ab  = {val}  = n.   Two DISTINCT metric factors; neither")
print( "        carries an edge with both ends on itself, so this is NOT a")
print( "        self-loop under A2's dichotomy -- yet it is an unreduced diagram")
print( "        and it produces an n.")
assert val == n
# and length-3, to show the family is infinite
val3 = sum(g[a][b]*g[b][c]*g[c][a] for a in rg for b in rg for c in rg)
print(f"   (3b) g_ab g^bc g_ca = {val3} = n.  Metric cycles of every length >= 2")
print( "        are missing from the case list, not just length 2.")
assert val3 == n
# (3c) a Weyl self-trace routed THROUGH a metric.  Also no single-factor loop.
T = [[sum(W[a][b][x][y]*g[a][b] for a in rg for b in rg) for y in rg] for x in rg]
print(f"   (3c) W_abxy g^ab : identically zero = "
      f"{all(T[x][y]==0 for x in rg for y in rg)}.  Two factors, no self-loop,")
print( "        yet unreduced: the metric chain returns to the SAME Weyl factor.")
assert all(T[x][y] == 0 for x in rg for y in rg)

print()
print("=" * 74)
print("(4)  THE GAP BITES: an internal metric cycle breaks L <= min(a_P, a_Q).")
print("=" * 74)
# P carries a metric 2-cycle (a_P = 2 metrics) and a pure-Weyl part with two
# free indices.  Q is pure Weyl with two free indices, a_Q = 0.
# brauer-pairing.md: <P,Q> = n^L q_D with L <= min(a_P, a_Q) = 0, so DEGREE 0.
def S_of(Wn, m):
    return [[sum(Wn[i][a][b][c]*Wn[j][a][b][c] for a in range(m)
                 for b in range(m) for c in range(m)) for j in range(m)]
            for i in range(m)]
rows = []
for m in (5, 6, 7, 8, 9):
    Wm = padded(m); gm = [[F(int(a==b)) for b in range(m)] for a in range(m)]
    S = S_of(Wm, m)
    pure = sum(S[i][j]*S[i][j] for i in range(m) for j in range(m))   # <P0,Q>
    cyc  = sum(gm[a][b]*gm[a][b] for a in range(m) for b in range(m)) # the 2-cycle
    rows.append((m, pure, cyc*pure))
print("     n   <P0,Q> (reduced)      <P,Q> with the metric 2-cycle")
for m, a, b in rows:
    print(f"   {m:>3}   {a!s:>18}   {b!s:>22}")
d0 = len({a for _, a, _ in rows})
lin = all(rows[i][2] == rows[i][0]*rows[i][1] for i in range(len(rows)))
print(f"   reduced entry is constant in n: {d0 == 1}")
print(f"   unreduced entry is exactly n * (that constant): {lin}")
print( "   min(a_P, a_Q) = min(2, 0) = 0, so the monomial theorem predicts")
print( "   DEGREE 0 and the true degree is 1.  The precondition is load-bearing,")
print( "   and A2's two cases do not remove this diagram from the spanning set.")
assert d0 == 1 and lin

print()
print("=" * 74)
print("(5)  A COMPONENT TOUCHING TWO DIFFERENT WEYL FACTORS CARRIES NO n.")
print("=" * 74)
# W1_abcd W2_cdef W3_efab -- a closed contraction cycle through three DISTINCT
# Weyl factors.  A Weyl factor does not transmit a chain (only a delta does),
# so this is a union of PATHS between Weyl slots, never a delta cycle.
vals = []
for m in (5, 6, 7, 8, 9):
    Wm = padded(m); r = range(m)
    v = sum(Wm[a][b][c][d]*Wm[c][d][e][f]*Wm[e][f][a][b]
            for a in r for b in r for c in r for d in r for e in r for f in r)
    vals.append((m, v))
for m, v in vals:
    print(f"   n={m}: W1_abcd W2_cdef W3_efab = {v}")
same = len({v for _, v in vals}) == 1
print(f"   constant in n: {same}   -- no factor of n, as the path/cycle")
print( "   decomposition predicts.  The REASON, which neither file states: a")
print( "   bare metric is the only factor that COMPOSES (g_ab x^b = x_a), so a")
print( "   Weyl slot is a degree-1 terminal and no cycle can pass through it.")
assert same
print()
print("ALL CHECKS PASSED.")
