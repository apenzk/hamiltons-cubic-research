"""Native (unpadded) degeneracy of the seeds, so 'nondegenerate at n_0' is checked
rather than assumed -- the J4 counterexample clause needs it."""
import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r50_core as C
from review_r50_spec import le_matrix, orbit_dim

print(f"{'seed':>10} {'n0':>3} {'theta':>13} {'th/th0(n0)':>11} {'orbit':>6} {'dimE':>5} {'verdict':>9}")
for (p, q) in [(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(3,3),(3,4),(3,5),(3,6),
               (4,4),(4,5),(4,6),(5,5),(5,6),(6,6),(6,7)]:
    n0 = p + q
    W = C.sphere_product_W((p, q)); W = W / np.linalg.norm(W)
    th = C.P(n0, W)
    U, _ = orbit_dim(n0, W); orb = U.shape[0]
    M, B, _ = le_matrix(n0, W, th)
    w = np.linalg.eigvalsh(M)
    dimE = int((np.abs(w - 0.5) < 1e-8).sum())
    print(f"{'S^%dxS^%d'%(p,q):>10} {n0:3d} {th:13.9f} {th/C.theta0(n0):11.6f} {orb:6d} {dimE:5d} "
          f"{'NONDEG' if dimE==orb else 'DEG+%d'%(dimE-orb):>9}", flush=True)
