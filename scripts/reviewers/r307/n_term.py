"""Coordinator's Q2, settled: is N := Q(W) - theta W nonzero off Weyl_n at a critical point?
Test (a) Q(Weyl_n) subset Weyl_n, split into the two constraints separately.
Test (b) the FULL (unprojected) residual at the solved critical points."""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r307')
from core307 import *
import itertools

def bianchi_ricci_defect(n, X):
    P = pairs_of(n); idx = {p: a for a, p in enumerate(P)}
    def G(i, j, k, l):
        if i == j or k == l: return 0.0
        s = 1.0
        if i > j: i, j, s = j, i, -s
        if k > l: k, l, s = l, k, -s
        return s*X[idx[(i, j)], idx[(k, l)]]
    b = max(abs(G(i,j,k,l)+G(i,k,l,j)+G(i,l,j,k))
            for (i,j,k,l) in itertools.combinations(range(n), 4))
    r = max(abs(sum(G(i,j,k,j) for j in range(n)))
            for i in range(n) for k in range(n))
    return b, r

for n in (6, 7, 8):
    B = weyl_basis(n); rng = np.random.default_rng(n)
    W = np.einsum('a,aij->ij', rng.normal(size=B.shape[0]), B); W /= np.linalg.norm(W)
    print(f'n={n}  W: Bianchi {bianchi_ricci_defect(n,W)[0]:.1e} Ricci {bianchi_ricci_defect(n,W)[1]:.1e}'
          f'   |W|={np.linalg.norm(W):.3f}')
    QW = Q(n, W)
    b, r = bianchi_ricci_defect(n, QW)
    print(f'      Q(W): Bianchi {b:.1e} Ricci {r:.1e}  |Q(W)|={np.linalg.norm(QW):.3f}'
          f'  -> non-Weyl mass {np.linalg.norm(QW-project_weyl(n,QW)):.1e}')

print()
n = 8
for nm, W in (('S^3xS^5', sphere_product_W(8,3)),
              ('witness', np.load('scripts/data/w_n8_nondiagonal_witness.npy'))):
    W = W/np.linalg.norm(W)
    th = float(np.tensordot(Q(n,W), W))
    N = Q(n,W) - th*W
    lam, V = np.linalg.eigh(W); U = V[:, lam > 1e-9]; A = U@U.T@W@U@U.T
    print(f'{nm}: |N|_F (FULL, unprojected) = {np.linalg.norm(N):.2e}; '
          f'non-Weyl mass of A = {np.linalg.norm(A-project_weyl(n,A)):.4f} '
          f'(|A|={np.linalg.norm(A):.4f});  <A,N> = {np.tensordot(A,N):.2e}')
