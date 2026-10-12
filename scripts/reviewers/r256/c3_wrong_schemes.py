"""Claim 3.  A WRONG scheme that passes both asserts of the validation.

The file under review reads, for each covariant F and each (i,j) in COMPS, the
number F_ij, and asserts

    rank[(W.W)_ij , |W|^2 delta_ij] == 2      (independence must be SEEN)
    rank[W_iabc W_jabc , W_aibc W_ajbc] == 1  (dependence must COLLAPSE)

A "scheme" is any rule S that turns the covariant's VALUE at W into the number
placed in the matrix.  The honest scheme is S(F)(i,j) = F_ij, which is LINEAR in
F -- and linearity is the whole of the soundness argument ("a relation among the
covariants forces the same relation among their components").

Below: three schemes.  All three pass both asserts at n = 5, 6, 7.  Two of them
are not linear, and the last two report rank 3 for a triple whose members
satisfy the exact identity C = A + B.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fractions import Fraction as F
from common import samples, rank_exact, mat_WW, mat_swapped, mat_q_delta, mat_sum

COMPS = [(0, 0), (0, 1), (1, 2)]          # the file's constant
NS = (5, 6, 7)

def s_honest(M, i, j, n):     return M[i][j]
def s_indicator(M, i, j, n):  return F(1) if M[i][j] != 0 else F(0)
def s_square(M, i, j, n):     return M[i][j]**2
def s_matsq(M, i, j, n):      return sum(M[i][a]*M[a][j] for a in range(n))

SCHEMES = [("honest   F_ij", s_honest),
           ("indicator [F_ij != 0]", s_indicator),
           ("entrywise square F_ij^2", s_square),
           ("one contraction too many (F.F)_ij", s_matsq)]

def component_rank(mats, n, comps, scheme):
    rows = []
    for Ms in mats:
        for (i, j) in comps:
            rows.append([scheme(M, i, j, n) for M in Ms])
    return rank_exact(rows)

print("=== the file's two asserts, under four schemes ===")
print(f"{'scheme':38s} " + "  ".join(f"n={n}: ind/dep" for n in NS))
cache = {}
for n in NS:
    Ws = samples(n, 4, seed=0)
    cache[n] = [(mat_WW(W, n), mat_q_delta(W, n), mat_swapped(W, n)) for W in Ws]
for name, sc in SCHEMES:
    out = []
    for n in NS:
        ind = component_rank([(A, B) for (A, B, S) in cache[n]], n, COMPS, sc)
        dep = component_rank([(A, S) for (A, B, S) in cache[n]], n, COMPS, sc)
        out.append(f"     {ind}/{dep}    ")
    both = all(True for _ in NS)
    print(f"{name:38s} " + "  ".join(out))

print("\n=== but the last two are NOT linear reads, and they fabricate rank ===")
print("A = (W.W)_ij,  B = |W|^2 delta_ij,  C = A + B  --  exact identity C-A-B=0,")
print("so the true rank of {A,B,C} is 2 for every W.  What each scheme reports:")
for n in NS:
    trip = [(A, B, mat_sum(A, B)) for (A, B, S) in cache[n]]
    line = []
    for name, sc in SCHEMES:
        line.append(f"{name.split()[0]}={component_rank(trip, n, COMPS, sc)}")
    print(f"  n={n}:  true rank 2   reported: " + "  ".join(line))

print("\n=== why the rank-2 assert has no arithmetic content ===")
print("the two columns at the three chosen components, one sample, n=5:")
A, B, S = cache[5][0]
for (i, j) in COMPS:
    print(f"   ({i},{j}):  (W.W)_ij = {A[i][j]}   |W|^2 delta_ij = {B[i][j]}")
print("  |W|^2 delta_ij is IDENTICALLY ZERO at both off-diagonal components, and")
print("  nonzero at (0,0).  Rank 2 follows from the zero PATTERN alone -- which is")
print("  why the indicator scheme, which discards every value, still reports 2.")

print("\n=== why the rank-1 assert has no content either ===")
eq = all(cache[n][s][0] == cache[n][s][2] for n in NS for s in range(4))
print(f"  W_aibc W_ajbc == W_iabc W_jabc as MATRICES on every sample: {eq}")
print("  (W_aibc = -W_iabc, so the two functions are equal, not merely dependent.)")
print("  Any scheme that reads the covariant's VALUE returns two identical columns.")
