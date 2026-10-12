"""The witness's hidden 4+4 structure: a W-invariant Lambda^2(U), dim U = 4."""
import sys, numpy as np, itertools
sys.path.insert(0, 'scripts/reviewers/r295'); sys.path.insert(0, 'scripts/lib')
from r295_core import *
n = 8
W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
lam, V = np.linalg.eigh(W)
As = [skew(n, V[:, k]) for k in (0, 1)]
Uo, s, _ = np.linalg.svd(np.hstack(As))
U = Uo[:, :4]; Up = Uo[:, 4:]
R = np.hstack([U, Up])                      # orthonormal frame of R^8, U first
if np.linalg.det(R) < 0: R[:, 7] *= -1
prs = pairs_of(n)
I = np.array([p[0] for p in prs]); Jd = np.array([p[1] for p in prs])
L = R[np.ix_(I, I)] * R[np.ix_(Jd, Jd)] - R[np.ix_(I, Jd)] * R[np.ix_(Jd, I)]
Wr = L.T @ W @ L                            # W in the frame R (U = e0..e3)
a = [k for k, (i, j) in enumerate(prs) if j < 4]
b = [k for k, (i, j) in enumerate(prs) if i >= 4]
c = [k for k, (i, j) in enumerate(prs) if i < 4 <= j]
print('block sizes: Lambda^2 U = %d, Lambda^2 U^perp = %d, U ^ U^perp = %d' % (len(a), len(b), len(c)))
for (nm, x, y) in (('U-Uperp', a, b), ('U-mixed', a, c), ('Uperp-mixed', b, c)):
    print('  off-block mass %-12s %.3e' % (nm, np.linalg.norm(Wr[np.ix_(x, y)])))
print('so W IS block-diagonal for the so(4)+so(4) split U + U^perp, as well as for so(3)+so(5).')
sd = np.array([[1,0,0,0,0,1],[0,1,0,0,-1,0],[0,0,1,1,0,0]])/np.sqrt(2)   # e01+e23, e02-e13, e03+e12
asd = np.array([[1,0,0,0,0,-1],[0,1,0,0,1,0],[0,0,1,-1,0,0]])/np.sqrt(2)
sub = Wr[np.ix_(a, a)]
print('\nW on Lambda^2 U, in the (self-dual | anti-self-dual) basis:')
Bas = np.vstack([sd, asd])
print(np.round(Bas @ sub @ Bas.T, 9))
print('eigenvalues on Lambda^2 U :', np.round(np.linalg.eigvalsh(sub), 9))
print('eigenvalues on Lambda^2 U^perp :', np.round(np.linalg.eigvalsh(Wr[np.ix_(b, b)]), 9))
print('eigenvalues on U ^ U^perp :', np.round(np.linalg.eigvalsh(Wr[np.ix_(c, c)]), 9))
print('\nfull Wr, rounded to 6 dp, |entries| > 1e-9 pattern per block:')
print('  Lambda^2 U block:'); print(np.round(sub, 6))
