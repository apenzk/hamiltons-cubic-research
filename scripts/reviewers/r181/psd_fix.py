"""Reviewer 181, claim 4b: the mechanism, the minimal fix, and its validation."""
from fractions import Fraction as F
import random
from psd_witness import ldl_psd, psd_oracle

def ldl_psd_fixed(M):
    """Same algorithm; the two lines that were wrong are marked FIX."""
    n = len(M)
    A = [[F(M[i][j]) for j in range(n)] for i in range(n)]
    D = []
    for k in range(n):
        p = max(range(k, n), key=lambda i: A[i][i])
        if A[p][p] < 0: return False, D
        if A[p][p] == 0:
            # FIX 1: max diagonal is 0 => EVERY remaining diagonal is <= 0, and a
            # PSD form has no negative diagonal, so they must all be 0.
            if any(A[i][i] < 0 for i in range(k, n)): return False, D
            # FIX 2: with the whole remaining diagonal zero, PSD forces the whole
            # remaining block to vanish, not just row p.
            if any(A[i][j] for i in range(k, n) for j in range(k, n)): return False, D
            D.extend([F(0)]*(n-k)); return True, D
        A[k], A[p] = A[p], A[k]
        for r in range(n): A[r][k], A[r][p] = A[r][p], A[r][k]
        d = A[k][k]; D.append(d)
        for i in range(k+1, n):
            f = A[i][k]/d
            for j in range(k+1, n): A[i][j] -= f*A[k][j]
            A[i][k] = F(0)
    return all(x >= 0 for x in D), D

if __name__ == '__main__':
    print('trace of the failure on M = [[-1,0],[0,0]]')
    print('  k=0: diagonals (-1, 0); argmax = index 1 (Python max returns the FIRST')
    print('       maximiser, and 0 > -1), so p=1 != k=0.  A[1][1]==0 and row 1 is')
    print('       zero, so the branch does D.append(0); continue -- WITHOUT swapping')
    print('       p into slot k.  The next iteration scans range(1, n), so index 0,')
    print('       carrying the negative diagonal, is dropped and never examined.')
    print()
    random.seed(1811)
    bad_old = bad_new = 0; onesided = True
    N = 300000
    for _ in range(N):
        n = random.choice([2,3,3,4,5])
        M = [[0]*n for _ in range(n)]
        for i in range(n):
            for j in range(i, n):
                v = random.choice([-2,-1,-1,0,0,0,1,1,2])
                M[i][j] = M[j][i] = v
        t = psd_oracle(M)
        o = ldl_psd(M)[0]; f = ldl_psd_fixed(M)[0]
        if o != t:
            bad_old += 1
            if not o and t: onesided = False       # a false NEGATIVE would be worse
        if f != t:
            bad_new += 1
            print('  FIX STILL WRONG on', M)
    print('random census over %d matrices:' % N)
    print('  original ldl_psd  misclassifications : %d  (%.2f%%)' % (bad_old, 100.0*bad_old/N))
    print('  every error is a FALSE POSITIVE (non-PSD reported PSD): %s' % onesided)
    print('  patched  ldl_psd  misclassifications : %d' % bad_new)
    # also re-run the file's own self-test through the fix
    tests = [([[2,1],[1,2]], True), ([[1,1],[1,1]], True), ([[1,2],[2,1]], False),
             ([[0,1],[1,0]], False), ([[0,0],[0,3]], True),
             ([[1,0,0],[0,0,1],[0,1,0]], False)]
    ok = all(ldl_psd_fixed(M)[0] == w for M, w in tests)
    print('  patched version still passes the original self-test: %s' % ok)
