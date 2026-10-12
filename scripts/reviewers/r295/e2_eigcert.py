"""Decomposability of EVERY eigenvector / eigenspace of the witness."""
import sys, itertools
sys.path.insert(0, 'scripts/reviewers/r295'); sys.path.insert(0, 'scripts/lib')
import numpy as np
from r295_core import *
from review_r56_core import plucker_min as repo_plucker_min

n = 8
W = np.load(sys.argv[1] if len(sys.argv) > 1 else 'scripts/data/w_n8_nondiagonal_witness.npy')
lam, V = np.linalg.eigh(W)
pl = pairs_of(n)
groups, i = [], 0
while i < len(lam):
    j = i
    while j + 1 < len(lam) and lam[j + 1] - lam[i] < 1e-8: j += 1
    groups.append((i, j + 1)); i = j + 1
print(' lambda            mult   rank(A) of a generic elt   min||pl|| over eigenspace')
for (i, j) in groups:
    m = j - i
    E = V[:, i:j]
    rng = np.random.default_rng(3)
    y = rng.normal(size=m); w = E @ y; w /= np.linalg.norm(w)
    rk = int((np.linalg.svd(skew(n, w), compute_uv=False) > 1e-9).sum())
    if m == 1:
        val = np.linalg.norm(plucker_vec(n, E[:, 0]))
        tag = 'exact (simple eigenvalue)'
    else:
        val = repo_plucker_min(E, pl, n, tries=60, seed=1)
        tag = 'Nelder-Mead search'
    print('  %+.9f   %d      %d                      %.9f   [%s]'
          % (lam[i], m, rk, val, tag))
