import sys, time
sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r29_core import Alg, weyl_basis, ip, L_matrix, theta0
from review_r29_points import invariant_subspace, from_coords
from review_r29_catalogue import block_gens, u_m_gens, sp_gens
from review_r29_spec import orbit_tangent

def run(n, label, gens, a, B):
    D = B.shape[0]
    V = invariant_subspace(a, B, gens)
    if V.shape[0] != 1:
        print(f"{label}: invdim={V.shape[0]}, skip", flush=True); return
    W = from_coords(B, V[0]); QW = a.Q(W); th = ip(W, QW)
    if th < 0:
        W = -W; QW = a.Q(W); th = ip(W, QW)
    res = np.linalg.norm(QW - th * W)
    e = W / th; Le = L_matrix(a, B, e); Le = 0.5 * (Le + Le.T)
    lam = np.sort(np.linalg.eigvalsh(Le))[::-1]
    orb, _, _ = orbit_tangent(a, B, W, 1e-8)
    kap = (2*n-1)*(n-1)/4
    m1 = int((abs(lam-1) < 1e-8).sum()); mh = int((abs(lam-.5) < 1e-8).sum()); m0 = int((abs(lam) < 1e-8).sum())
    S2 = (lam**2).sum()
    print(f"{label:<10} n={n} D={D} th={th:.7f} th0={theta0(n):.7f} res={res:.0e} orb={orb} m(1)={m1} "
          f"m(1/2)={mh} m(0)={m0} th^2S2={th*th*S2:.9f} kappa={kap} l2={lam[1]:+.6f} lmin={lam[-1]:+.6f} "
          f"th^2S3={th*th*(lam**3).sum():+.6f}", flush=True)

jobs = {9: [('S4xS5', lambda: block_gens(9,[4,5])), ('S3xS6', lambda: block_gens(9,[3,6])), ('S2xS7', lambda: block_gens(9,[2,7]))],
        10: [('S5xS5', lambda: block_gens(10,[5,5])), ('S4xS6', lambda: block_gens(10,[4,6])),
             ('S2xS8', lambda: block_gens(10,[2,8])), ('CP5', lambda: u_m_gens(5))],
        12: [('S6xS6', lambda: block_gens(12,[6,6])), ('S5xS7', lambda: block_gens(12,[5,7])),
             ('CP6', lambda: u_m_gens(6)), ('HP3', lambda: sp_gens(3))]}
for n in [int(x) for x in sys.argv[1:]]:
    t = time.time(); a = Alg(n); B, _, _ = weyl_basis(a)
    print(f"--- n={n} D={B.shape[0]} basis built in {time.time()-t:.0f}s", flush=True)
    for lab, g in jobs[n]:
        t = time.time(); run(n, lab, g(), a, B); print(f"   ({time.time()-t:.0f}s)", flush=True)
