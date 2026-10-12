import sys, time
sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r29_core import Alg, weyl_basis, ip, L_matrix, project, theta0
from review_r29_spec import orbit_tangent

n = 12
t = time.time(); a = Alg(n); B, _, _ = weyl_basis(a); D = B.shape[0]
print(f"n={n} D={D} basis {time.time()-t:.0f}s", flush=True)
for p in [6, 5, 4, 2]:
    lam = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            if i != j and (i < p) == (j < p):
                lam[i, j] = 1.0
    W = np.zeros((a.N, a.N))
    for k, (i, j) in enumerate(a.P):
        W[k, k] = lam[i, j]
    W = project(B, W); W /= np.linalg.norm(W)
    QW = a.Q(W); th = ip(W, QW)
    e = W / th; t = time.time()
    Le = L_matrix(a, B, e); Le = 0.5 * (Le + Le.T)
    ev = np.sort(np.linalg.eigvalsh(Le))[::-1]
    orb, _, _ = orbit_tangent(a, B, W, 1e-8)
    kap = (2*n-1)*(n-1)/4
    m1 = int((abs(ev-1) < 1e-8).sum()); mh = int((abs(ev-.5) < 1e-8).sum()); m0 = int((abs(ev) < 1e-8).sum())
    S2 = (ev**2).sum()
    print(f"S{p}xS{n-p}: th={th:.7f} th0={theta0(n):.7f} res={np.linalg.norm(QW-th*W):.0e} orb={orb} "
          f"m(1)={m1} m(1/2)={mh} m(0)={m0} th^2S2={th*th*S2:.9f} kappa={kap} S2={S2:.4f} "
          f"l2={ev[1]:+.6f} lmin={ev[-1]:+.6f} th^2S3={th*th*(ev**3).sum():+.6f}  [{time.time()-t:.0f}s]", flush=True)
