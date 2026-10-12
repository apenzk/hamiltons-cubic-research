"""Claim 5.  What changes when the covariants are degree 3 with |lambda| <= 12.

The structure that appears there and is ABSENT from the validation is the
projector onto V_lambda.  In the validation the two free indices carry no
target: every covariant is a raw contraction, P is the identity, and the
identity <F, e_I> = <F, P e_I> is never used.  At degree 3 with |lambda| = 12
the target is a Young-symmetrised traceless subspace of (R^12)^{x12}, P has a
large kernel, and independence is NOT preserved by a map with a kernel.

Witness, inside the file's own carrier: two covariants that a component read
calls independent and that are EQUAL in the target.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fractions import Fraction as F
from common import samples, rank_exact, mat_WW

COMPS = [(0, 0), (0, 1), (1, 2)]

print("=== the projector has a kernel, and a component read cannot see it ===")
for n in (5, 6, 7):
    Ws = samples(n, 4, seed=0)
    raw, proj = [], []
    tr_ok = True
    for W in Ws:
        X = mat_WW(W, n)
        q = sum(W[a][b][c][d]**2 for a in range(n) for b in range(n)
                for c in range(n) for d in range(n))
        tr_ok &= (sum(X[i][i] for i in range(n)) == q)
        A = X                                                    # covariant 1
        B = [[X[i][j] - F(q, n)*(i == j) for j in range(n)] for i in range(n)]
        # P = traceless part, the projector onto the lambda=(2) target
        def P(M):
            t = sum(M[i][i] for i in range(n))
            return [[M[i][j] - F(t, n)*(i == j) for j in range(n)]
                    for i in range(n)]
        PA, PB = P(A), P(B)
        for (i, j) in COMPS:
            raw.append([A[i][j], B[i][j]])
            proj.append([PA[i][j], PB[i][j]])
    print(f"  n={n}:  tr(W.W) = |W|^2 exactly: {tr_ok}   "
          f"rank of RAW component reads = {rank_exact(raw)}   "
          f"rank in the TARGET = {rank_exact(proj)}")
print("  A = (W.W)_ij and B = A - (|W|^2/n) delta_ij are independent as raw")
print("  covariants and are the SAME element of V_(2).  A component test run on")
print("  unprojected objects returns 2 where the truth in the target is 1 --")
print("  r254's failure mode (a dependence read as independence), reappearing at")
print("  the one place degree 3 differs from the validation.")

print("\n=== cost of one component read at degree 3, n = 12 ===")
n = 12
print("  a degree-3 diagram has 12 index slots; |lambda| of them are free and")
print("  the rest are contracted in pairs, so one component costs n^((12-|l|)/2):")
print("   |lambda| :  " + "  ".join(f"{L:>9d}" for L in range(0, 13, 2)))
print("   ops      :  " + "  ".join(f"{n**((12-L)//2):>9d}" for L in range(0, 13, 2)))
print("  the read itself is cheap at every |lambda| -- the file's cost claim")
print("  survives the move to degree 3.  What does not survive is the premise")
print("  that the object being read is already in V_lambda.")
