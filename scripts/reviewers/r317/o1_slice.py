"""Builds V = {W in Weyl_8 : [W, Ad(J)] = 0}, the u(4) graded slice at n=8.
Writes kerJ_n8.npy (coefficients in the Weyl basis) for o1_AtoB.py and
o1_crit_search.py.  Run this first."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib317 as L

n = 8; m = 4
ns, coords, N = L.weyl_basis(n)
print('dim Weyl_%d = %d' % (n, ns.shape[0]))
J = np.zeros((n, n))
for a in range(m):
    J[2*a, 2*a+1] = 1.0; J[2*a+1, 2*a] = -1.0
AdJ = L.Lambda2(J, n)
print('AdJ^2 = I ?', np.abs(AdJ @ AdJ - np.eye(N)).max())
evJ, VJ = np.linalg.eigh(AdJ)
print('dim p = u(4) =', int((evJ > 0.5).sum()), ' dim m =', int((evJ < -0.5).sum()))
mats = [L.coords_to_M(ns[d], coords, N) for d in range(ns.shape[0])]
A = np.array([(AdJ @ M - M @ AdJ).ravel() for M in mats]).T
u2, s2, vt2 = np.linalg.svd(A)
rank = int((s2 > 1e-8 * s2[0]).sum())
ker = vt2[rank:]
print('dim {W in Weyl_8 : [W,AdJ]=0} =', ker.shape[0])
np.save(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'kerJ_n8.npy'), ker)
