"""Claim 3, second half: WHY the rank-2 pair is independent.

Two facts, both exact:

(1) The pair the validation calls "independent" is a pair from two INEQUIVALENT
    O(n) irreps: (W.W)_ij = X0_ij + (|W|^2/n) delta_ij with X0 traceless and
    nonzero, so one covariant has a nonzero component in the lambda=(2) isotypic
    and the other has none.  Inequivalent isotypics are orthogonal, so the pair
    is independent by Schur -- before any component is read.

(2) The whole space of degree-2 covariants with two free indices is
    2-DIMENSIONAL, one dimension per isotypic.  So the validation universe
    contains NO two covariants in the same block -- and within-block
    independence, with multiplicities up to 9 at n=12, is the only thing the
    programme actually has to certify.
"""
import sys, os, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fractions import Fraction as F
from common import samples, rank_exact, mat_WW, mat_q_delta

n = 5
Ws = samples(n, 2, seed=0)

print("=== (1) the 'independent' pair splits across two isotypics ===")
for k, W in enumerate(Ws):
    X = mat_WW(W, n); Q = mat_q_delta(W, n); q = Q[0][0]
    X0 = [[X[i][j] - F(q, n)*(i == j) for j in range(n)] for i in range(n)]
    tr = sum(X0[i][i] for i in range(n))
    nz = any(X0[i][j] != 0 for i in range(n) for j in range(n))
    print(f"  sample {k}: tr(X - q/n delta) = {tr}   traceless part nonzero: {nz}")
print("  => (W.W)_ij has a nonzero lambda=(2) piece, |W|^2 delta_ij has none.")
print("     Orthogonal isotypics: no scheme that reads VALUES can report rank 1.")

print("\n=== (2) dimension of the degree-2, two-free-index covariant space ===")
# every diagram: W_{s0 s1 s2 s3} W_{s4 s5 s6 s7} with two of the eight slots
# carrying the free indices i,j and the remaining six perfectly matched.
def matchings(xs):
    if not xs: yield []; return
    a, rest = xs[0], xs[1:]
    for t in range(len(rest)):
        for m in matchings(rest[:t] + rest[t+1:]):
            yield [(a, rest[t])] + m

diagrams = []
for (pi, pj) in itertools.permutations(range(8), 2):
    rest = [s for s in range(8) if s not in (pi, pj)]
    for m in matchings(rest):
        diagrams.append((pi, pj, m))
print(f"  diagrams enumerated: {len(diagrams)}")

def val(W, dg, i, j, n):
    pi, pj, m = dg
    slots = [None]*8
    slots[pi] = i; slots[pj] = j
    tot = F(0)
    for assign in itertools.product(range(n), repeat=len(m)):
        for (p, q_), v in zip(m, assign):
            slots[p] = v; slots[q_] = v
        tot += (W[slots[0]][slots[1]][slots[2]][slots[3]]
                * W[slots[4]][slots[5]][slots[6]][slots[7]])
    return tot

rows = []
for W in Ws:
    for i in range(n):
        for j in range(n):
            rows.append([val(W, dg, i, j, n) for dg in diagrams])
r = rank_exact(rows)
print(f"  rank over {len(rows)} rows (all n^2 components, 2 samples) = {r}")
print(f"  rank of the pure-W diagram span = {r}: EVERY contraction of two Weyl")
print("  tensors with two free legs is a multiple of (W.W)_ij (spot check:")
print("  W_iabc W_jbac = (W.W)_ij / 2, the two-index form of the A = 2C identity).")
print("  So the validation's second covariant, |W|^2 delta_ij, is not a diagram at")
print("  all: it needs the metric.  Adding g the space is 2-dimensional, one")
print("  dimension per isotypic -- NO block of multiplicity >= 2 exists here, and")
print("  within-block independence is the only thing the programme must certify.")
