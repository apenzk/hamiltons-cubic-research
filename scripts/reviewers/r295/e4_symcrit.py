"""E4: symmetric criticality, proved and then measured."""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r295'); sys.path.insert(0, 'scripts/runs'); sys.path.insert(0, 'scripts/lib')
from r295_core import *
from run_f4b_graded_multi import block_diagonal_weyl_basis, graded_split

n, p = 8, 3
basis, Pi, Mi = block_diagonal_weyl_basis(n, p)
s = np.diag([1.0]*p + [-1.0]*(n-p))
prs = pairs_of(n)
L = np.array([[s[i, k]*s[j, l] - s[i, l]*s[j, k] for (k, l) in prs] for (i, j) in prs])
sig = np.diag([1.0 if (i < p) == (j < p) else -1.0 for (i, j) in prs])
print('A. Lambda^2(s) equals the +-1 sign matrix sigma on p/m:  %.2e' % np.abs(L - sig).max())
print('   sigma^2 = I: %.2e' % np.abs(sig@sig - np.eye(28)).max())
print('B. basis is Ad(s)-invariant: max |sigma B sigma - B| over 155 elements = %.2e'
      % max(np.abs(sig @ B @ sig - B).max() for B in basis))
print('   dim V = %d, and V = {W in Weyl_8 : sigma W sigma = W}?' % basis.shape[0])
from review_r30_core import weyl_basis
BW = weyl_basis(n).reshape(300, -1)
S = np.array([(sig @ B.reshape(28,28) @ sig).reshape(-1) for B in BW])
Mrep = BW @ S.T                        # sigma acts on Weyl_8 in this basis
ev = np.linalg.eigvalsh(0.5*(Mrep+Mrep.T))
print('   sigma restricted to Weyl_8: eigenvalues +1 x %d, -1 x %d  (fixed space dim %d)'
      % (int((ev > 0.5).sum()), int((ev < -0.5).sum()), int((ev > 0.5).sum())))

print('\nC. equivariance of Q under conjugation by sigma = Lambda^2(s), s in O(8):')
rng = np.random.default_rng(0)
worst = 0.0
for _ in range(5):
    X = rng.normal(size=(28,28)); X = X + X.T
    worst = max(worst, np.abs(Qmap(n, sig@X@sig) - sig@Qmap(n, X)@sig).max())
print('   |Q(sigma X sigma) - sigma Q(X) sigma| at random SYMMETRIC X: %.2e' % worst)
print('   => at any W in V, Q(W) = Q(sigma W sigma) = sigma Q(W) sigma, so Q(W) in V.')

print('\nD. measured: gradient mass off V at random points of V')
flat = basis.reshape(155, -1)
for t in range(6):
    c = rng.normal(size=155); c /= np.linalg.norm(c)
    W = np.einsum('a,aij->ij', c, basis)
    G = Qmap(n, W)                              # gradient of P is 3 Q(W)
    Gm = G.reshape(-1)
    inV = flat.T @ (flat @ Gm)
    offV = Gm - inV
    offW = np.abs(sig @ G @ sig - G).max()
    print('   point %d: ||Q(W)|| = %.4f, mass off V = %.2e, |sigma Q sigma - Q| = %.2e'
          % (t, np.linalg.norm(Gm), np.linalg.norm(offV), offW))
print('   (mass off V here is off the BLOCK-DIAGONAL pattern; the residual Weyl'
      ' projection is a separate question)')
print('\nE. is Q(W) inside Weyl_8 for W in V?  max off-Weyl mass:')
for t in range(3):
    c = rng.normal(size=155); c /= np.linalg.norm(c)
    W = np.einsum('a,aij->ij', c, basis); G = Qmap(n, W).reshape(-1)
    print('   %.3e  (of ||Q|| = %.3f)' % (np.linalg.norm(G - BW.T @ (BW @ G)), np.linalg.norm(G)))
