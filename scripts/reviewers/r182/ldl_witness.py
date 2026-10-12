"""Claim 4: find a rational symmetric matrix that run_n5_sdp.ldl_psd misclassifies."""
import importlib.util, os, sys, random
from fractions import Fraction as F
d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
spec = importlib.util.spec_from_file_location("sdp", os.path.join(d, "run_n5_sdp.py"))
sdp = importlib.util.module_from_spec(spec); spec.loader.exec_module(sdp)
ldl = sdp.ldl_psd

def psd_truth(M):
    """ground truth by exact leading-principal-minor / characteristic polynomial
    sign rule: M is PSD iff every principal minor (all subsets) is >= 0."""
    from itertools import combinations
    n = len(M)
    for k in range(1, n+1):
        for S in combinations(range(n), k):
            sub = [[F(M[i][j]) for j in S] for i in S]
            if det(sub) < 0: return False
    return True

def det(A):
    A = [row[:] for row in A]; n = len(A); s = F(1)
    for k in range(n):
        p = next((i for i in range(k, n) if A[i][k]), None)
        if p is None: return F(0)
        if p != k: A[k], A[p] = A[p], A[k]; s = -s
        for i in range(k+1, n):
            f = A[i][k]/A[k][k]
            for j in range(k, n): A[i][j] -= f*A[k][j]
        s *= A[k][k]
    return s

WITNESSES = [
    ([[-1, 0], [0, 0]], "diag(-1,0): negative definite direction, zero row of larger diagonal"),
    ([[-3, 0, 0], [0, 0, 0], [0, 0, 5]], "diag(-3,0,5)"),
    ([[0, 0], [0, 0]], "zero matrix (control, genuinely psd)"),
]
print("=== hand witnesses ===")
for M, why in WITNESSES:
    got, D = ldl(M)
    want = psd_truth(M)
    print(f"  {'MISCLASSIFIED' if got != want else 'ok           '}  {M}  ldl={got} truth={want}  D={D}   ({why})")

print("\n=== random search, n=2..4, entries in {-2..2} ===")
random.seed(182); bad = 0
for trial in range(20000):
    n = random.choice([2, 3, 4])
    M = [[0]*n for _ in range(n)]
    for i in range(n):
        for j in range(i, n):
            M[i][j] = M[j][i] = random.randint(-2, 2)
    got, _ = ldl(M)
    want = psd_truth(M)
    if got != want:
        bad += 1
        if bad <= 3: print(f"  witness {M}: ldl={got} truth={want}")
print(f"  misclassified {bad} of 20000")
