import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib317 as L, points317 as PT

n = 4
c = L.structure_constants(n)
ns, coords, N = L.weyl_basis(n)
print('dim Weyl_4 =', ns.shape[0])
mats = [L.coords_to_M(ns[d], coords, N) for d in range(ns.shape[0])]
J = np.array([[0,1,0,0],[-1,0,0,0],[0,0,0,1],[0,0,-1,0]], dtype=float)
AdJ = L.Lambda2(J, n)
ev, V = np.linalg.eigh(AdJ)
pb = V[:, ev > 0.5]
print('dim u(2) =', pb.shape[1])
# symmetric-pair check for p = u(2) in so(4)
mb = V[:, ev < -0.5]
def blk(X, Y, Z):
    return float(np.linalg.norm(np.einsum('abc,ax,by,cz->xyz', c, X, Y, Z)))
print('bracket defects: [p,p]->m %.2e  [p,m]->p %.2e  [m,m]->m %.2e'
      % (blk(pb, pb, mb), blk(pb, mb, pb), blk(mb, mb, mb)))
# ad(p)-invariant Weyl operators
rows = []
for k in range(pb.shape[1]):
    adx = L.ad_on_lambda2(pb[:, k], c)
    rows.append(np.array([(adx @ M - M @ adx).ravel() for M in mats]))
A = np.concatenate(rows, axis=1)     # (dimWeyl, dimp*N^2)
u_, s_, vt_ = np.linalg.svd(A.T)
rank = int((s_ > 1e-9 * s_[0]).sum())
inv = np.linalg.svd(A, full_matrices=True)[2] if False else None
# nullspace of A^T acting on coefficient vectors: solve A^T x = 0 with x in R^{dimWeyl}
uu, ss, vv = np.linalg.svd(A, full_matrices=True)
r = int((ss > 1e-9 * ss[0]).sum())
kerc = uu[:, r:].T
print('dim {W in Weyl_4 : ad(u(2))-invariant} =', kerc.shape[0])
Wcp, _ = PT.cpm(2); Wcp /= np.linalg.norm(Wcp)
for row in kerc:
    M = sum(row[d] * mats[d] for d in range(len(mats)))
    M /= np.linalg.norm(M)
    ov = abs(float(np.sum(M * Wcp)))
    ee = np.linalg.eigvalsh(M)
    print('   invariant W: |<W,W_CP2>| = %.12f  spectrum %s' % (ov, np.round(ee, 8)))
