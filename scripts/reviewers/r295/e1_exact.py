"""E1: is the 5e-16 residual real, or float64 cancellation?  Recompute Q(W) at the
saved float64 W in 60-digit arithmetic, then bound the distance to an exact solution.
"""
import sys, numpy as np, mpmath as mp
sys.path.insert(0, 'scripts/reviewers/r295'); sys.path.insert(0, 'scripts/runs'); sys.path.insert(0, 'scripts/lib')
from r295_core import pairs_of, cst
mp.mp.dps = 60

n = 8
W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
N = 28
c = cst(n).astype(int)                       # structure constants are integers here
print('structure constants integral: %.1e' % np.abs(cst(n) - c).max())
A = [mp.matrix(c[a].tolist()) for a in range(N)]
Wm = mp.matrix([[mp.mpf(float(W[i, j])) for j in range(N)] for i in range(N)])
nrm2 = sum(Wm[i, j]**2 for i in range(N) for j in range(N))
print('||W||^2 - 1 in 60 digits: %s' % mp.nstr(nrm2 - 1, 8))
M = [A[a] * Wm for a in range(N)]
sh = mp.matrix(N, N)
for a in range(N):
    for b in range(a, N):
        t = sum(M[a][i, j] * M[b][j, i] for i in range(N) for j in range(N))
        sh[a, b] = sh[b, a] = -t / 2
QW = Wm * Wm + sh
th = sum(QW[i, j] * Wm[i, j] for i in range(N) for j in range(N))
print('theta (60 digits) = %s' % mp.nstr(th, 20))
res = max(abs(QW[i, j] - th * Wm[i, j]) for i in range(N) for j in range(N))
fro = mp.sqrt(sum((QW[i, j] - th * Wm[i, j])**2 for i in range(N) for j in range(N)))
print('exact-arithmetic criticality residual at the SAVED float64 W:')
print('   max |Q(W) - theta W| = %s' % mp.nstr(res, 8))
print('   ||Q(W) - theta W||_F = %s' % mp.nstr(fro, 8))
