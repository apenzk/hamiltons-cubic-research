"""Coordinator's Q2: is criticality Q(W)=theta W exactly, or only Pi(Q(W))=theta W?
Equivalently: does Q map Weyl_n into Weyl_n?  And is <A, Q(W)-theta W> zero for the
block A = W|_p when W is critical?"""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r307')
from core307 import *

for n in (5, 6, 7, 8):
    B = weyl_basis(n)
    rng = np.random.default_rng(n)
    worst_p, worst_l = 0.0, 0.0
    for t in range(3):
        W = np.einsum('a,aij->ij', rng.normal(size=B.shape[0]), B)
        W /= np.linalg.norm(W)
        QW = Q(n, W)
        worst_p = max(worst_p, np.abs(QW - project_weyl(n, QW)).max()/np.abs(QW).max())
        # is the BLOCK A itself Weyl?  (take the spectral p)
        lam, V = np.linalg.eigh(W); U = V[:, lam > 0]
        A = U @ U.T @ W @ U @ U.T
        worst_l = max(worst_l, np.abs(A - project_weyl(n, A)).max()/max(np.abs(A).max(), 1e-30))
    print(f'n={n}: rel. non-Weyl part of Q(W) for random Weyl W: {worst_p:.2e};'
          f'  rel. non-Weyl part of the block A = W|_p: {worst_l:.2e}')
