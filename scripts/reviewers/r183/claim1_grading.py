"""Reviewer 183.  The flat/Lambda^2 discrepancy is a GRADING, not a coincidence.

PROPOSITION.  Let A be the Lambda^2 operator of W in the orthonormal PAIRS basis,
A_{(ij),(kl)} = W_ijkl (i<j, k<l), and M the 25x25 flat reshape M_{(ab),(cd)} =
W_abcd over ALL ordered pairs.  Then for every k >= 2

        tr(M^k) = 2^k tr(A^k).

Proof.  tr(M^k) = sum over all ordered (a_1 b_1) ... (a_k b_k) of the product
W_{a_1 b_1 a_2 b_2} ... W_{a_k b_k a_1 b_1}.  Terms with a_i = b_i vanish by
antisymmetry.  Swapping a_i <-> b_i flips the sign of the two factors carrying
that pair, so the product is unchanged; each of the k unordered pairs is
therefore counted twice.  QED.

COROLLARY.  Every degree-d invariant that is a product of traces of words in A,
of total length d, is scaled by exactly 2^d when computed from M instead of A.
So F_5 built from M is 2^6 = 64 times F_5 built from A -- a uniform positive
scalar, for the whole subalgebra of operator-trace invariants, not just for
this one target.
"""
from fractions import Fraction as F
import importlib.util, sys, os, random

d_ = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
spec = importlib.util.spec_from_file_location("wm", os.path.join(d_, "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(spec)
o = sys.stdout; sys.stdout = open(os.devnull, "w"); spec.loader.exec_module(wm); sys.stdout = o
N, NP, PAIRS, SPAIRS, BASIS = wm.N, wm.NP, wm.PAIRS, wm.SPAIRS, wm.BASIS
TEN = [wm.sym2_to_R({SPAIRS[k]: c for k, c in enumerate(b) if c}) for b in BASIS]

def matmul(X, Y, n):
    return [[sum(X[i][k]*Y[k][j] for k in range(n) if X[i][k]) for j in range(n)]
            for i in range(n)]
def trace(X, n): return sum(X[i][i] for i in range(n))

rnd = random.Random(1831)
print("  k :  tr(M^k)            2^k tr(A^k)         equal")
for t in range(3):
    cs = [rnd.randint(-3, 3) for _ in range(35)]
    R = [[[[sum(c*T[i][j][k][l] for c, T in zip(cs, TEN) if c)
            for l in range(N)] for k in range(N)] for j in range(N)] for i in range(N)]
    A = [[R[i][j][k][l] for (k, l) in PAIRS] for (i, j) in PAIRS]
    M = [[R[a//N][a%N][b//N][b%N] for b in range(N*N)] for a in range(N*N)]
    Ap, Mp = A, M
    for k in range(2, 7):
        Ap = matmul(A, Ap, NP) if k > 2 else matmul(A, A, NP)
        Mp = matmul(M, Mp, N*N) if k > 2 else matmul(M, M, N*N)
        tA, tM = trace(Ap, NP), trace(Mp, N*N)
        print(f"  {k} : {tM!s:<20}{2**k*tA!s:<20}{tM == 2**k*tA}")
    print()
