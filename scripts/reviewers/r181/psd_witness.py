"""Reviewer 181, claim 4: hunt for a rational symmetric matrix that
run_n5_sdp.ldl_psd misclassifies.  The zero-pivot branch is the suspect.

Ground truth is the exact sign of the characteristic polynomial's coefficients
(Descartes / Sylvester): a rational symmetric M is PSD iff every coefficient of
char(M) alternates in the standard way, equivalently iff all coefficients of
det(x*I + M) are >= 0.  That test uses no floating point and no square roots
and shares no code with LDL.
"""
from fractions import Fraction as F
from itertools import product
import random, sys

# ---------------------------------------------------------------- the verifier under test
def ldl_psd(M):
    n = len(M)
    A = [[F(M[i][j]) for j in range(n)] for i in range(n)]
    D, perm = [], list(range(n))
    for k in range(n):
        p = max(range(k, n), key=lambda i: A[i][i])
        if A[p][p] < 0: return False, D
        if A[p][p] == 0:
            if any(A[p][j] for j in range(k, n)): return False, D
            D.append(F(0)); continue
        A[k], A[p] = A[p], A[k]
        for r in range(n): A[r][k], A[r][p] = A[r][p], A[r][k]
        perm[k], perm[p] = perm[p], perm[k]
        d = A[k][k]; D.append(d)
        for i in range(k+1, n):
            f = A[i][k]/d
            for j in range(k+1, n): A[i][j] -= f*A[k][j]
            A[i][k] = F(0)
    return all(x >= 0 for x in D), D

# ---------------------------------------------------------------- independent oracle
def charpoly_shift(M):
    """coefficients of det(x*I + M) in Q[x], by exact Faddeev-LeVerrier-free
    fraction-free expansion: we just build det(x I + M) with x symbolic via
    the Leibniz-free Berkowitz-style recursion on Fractions."""
    n = len(M)
    # Berkowitz / Samuelson: use the simple O(n^4) Faddeev-LeVerrier over Q.
    A = [[F(M[i][j]) for j in range(n)] for i in range(n)]
    # p(x) = det(xI - A) = x^n + c1 x^{n-1} + ... ; then det(xI + A) = (-1)^n p(-x)
    Mk = [[F(0)]*n for _ in range(n)]
    c = [F(1)]
    Ak = [row[:] for row in A]
    Mk = [row[:] for row in A]
    for k in range(1, n+1):
        if k > 1:
            # M_k = A (M_{k-1} + c_{k-1} I)
            T = [[Mk[i][j] + (c[k-1] if i == j else F(0)) for j in range(n)] for i in range(n)]
            Mk = [[sum(A[i][l]*T[l][j] for l in range(n)) for j in range(n)] for i in range(n)]
        tr = sum(Mk[i][i] for i in range(n))
        c.append(-tr/F(k))
    # p(x) = sum_{k} c[k] x^{n-k}
    # det(xI + A) = (-1)^n p(-x) = sum_k c[k] (-1)^n (-1)^{n-k} x^{n-k} = sum_k c[k] (-1)^k x^{n-k}
    return [c[k]*(-1)**k for k in range(n+1)]

def psd_oracle(M):
    """M symmetric is PSD  <=>  all coefficients of det(xI+M) are >= 0.
    (roots of det(xI+M) are -eigenvalues; all eigenvalues >=0 <=> all roots <=0
     <=> the monic real-rooted polynomial has all non-negative coefficients.)"""
    return all(x >= 0 for x in charpoly_shift(M))

def sym(M):
    return all(M[i][j] == M[j][i] for i in range(len(M)) for j in range(len(M)))

# ---------------------------------------------------------------- hand witnesses
NAMED = [
    ("diag(-1,0)",            [[-1,0],[0,0]]),
    ("indefinite + zero row", [[-1,2,0],[2,-1,0],[0,0,0]]),
    ("neg-definite + zero",   [[-3,1,0],[1,-3,0],[0,0,0]]),
    ("bug created by elim",   [[1,1,0],[1,0,0],[0,0,0]]),
    ("2x2 [[1,1],[1,0]] pad", [[1,1,0,0],[1,0,0,0],[0,0,0,0],[0,0,0,1]]),
]

def report(tag, M):
    got, D = ldl_psd(M)
    want = psd_oracle(M)
    flag = 'MISCLASSIFIED' if got != want else 'ok'
    print('  %-24s ldl=%-5s truth=%-5s  %s   D=%s' % (tag, got, want, flag,
          [str(x) for x in D]))
    return got != want

if __name__ == '__main__':
    print('sanity: oracle against the verifier self-test cases')
    for M, want, why in [([[2,1],[1,2]], True, 'pd'), ([[1,1],[1,1]], True, 'psd rk1'),
                         ([[1,2],[2,1]], False, 'indef'), ([[0,1],[1,0]], False, 'zero pivot'),
                         ([[0,0],[0,3]], True, 'zero row'),
                         ([[1,0,0],[0,0,1],[0,1,0]], False, 'lower block')]:
        o = psd_oracle(M)
        print('   oracle %-32s -> %-5s expected %-5s %s' % (str(M), o, want, 'OK' if o == want else 'ORACLE BROKEN'))

    print('\nhand-built candidates')
    bad = 0
    for tag, M in NAMED:
        bad += report(tag, M)

    print('\nrandom search over small rational symmetric matrices')
    random.seed(181)
    found = []
    for trial in range(200000):
        n = random.choice([2,3,3,4])
        M = [[0]*n for _ in range(n)]
        for i in range(n):
            for j in range(i, n):
                v = random.choice([-2,-1,-1,0,0,0,1,1,2])
                M[i][j] = M[j][i] = v
        if ldl_psd(M)[0] != psd_oracle(M):
            found.append(M)
            if len(found) <= 5:
                report('random#%d' % trial, M)
    print('  random misclassifications: %d / 200000' % len(found))
    print('\ntotal hand witnesses that misclassify: %d' % bad)
