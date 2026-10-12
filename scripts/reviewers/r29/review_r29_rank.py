"""R29 attack 8: rank / kernel of L_e at random critical points; is any extra eigenvalue forced?"""
import sys
sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r29_core import Alg, weyl_basis, ip, L_matrix, theta0
from review_r29_points import newton_critical, from_coords
from review_r29_spec import orbit_tangent

n = int(sys.argv[1]); ntry = int(sys.argv[2])
a = Alg(n); B, _, _ = weyl_basis(a); D = B.shape[0]
rng = np.random.default_rng(99)
kap = (2*n-1)*(n-1)/4.0
seen = []
print(f"n={n} D={D} kappa={kap} theta0={theta0(n):.6f}")
best = None
for t in range(ntry):
    v, th, res = newton_critical(a, B, rng.standard_normal(D), iters=400)
    if res > 1e-9 or th <= 1e-6: continue
    if any(abs(abs(v @ w) - 1) < 1e-6 for w in seen): continue
    seen.append(v)
    W = from_coords(B, v); e = W / th
    Le = L_matrix(a, B, e); Le = 0.5*(Le+Le.T)
    lam = np.sort(np.linalg.eigvalsh(Le))[::-1]
    orb, T, s = orbit_tangent(a, B, W, 1e-6)
    sc = max(abs(lam).max(), 1.0)
    m0 = int((np.abs(lam) < 1e-7*sc).sum())
    mh = int((np.abs(lam-0.5) < 1e-7*sc).sum())
    m1 = int((np.abs(lam-1.0) < 1e-7*sc).sum())
    S2 = (lam**2).sum()
    if best is None or S2 < best[0]: best = (S2, th, len(seen)-1)
    print(f"  #{len(seen)-1:<3} th={th:.6f} orb={orb} m(1)={m1} m(1/2)={mh} m(0)={m0} rank={D-m0} "
          f"S2={S2:.3f} th^2S2={th*th*S2:.9f} lmax={lam[0]:.4f} l2={lam[1]:.4f} lmin={lam[-1]:.4f} "
          f"th2S3={th*th*(lam**3).sum():+.4f}", flush=True)
print("min S2 found:", best, " forced bound:", 1 + a.N/4 + (1+a.N/2)**2/(D-1-a.N),
      " needed for theta<=theta0:", kap/theta0(n)**2)
