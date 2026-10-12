"""Claim 4 controls: (i) the solver DOES recover the known graded points when
started near them (so 'none found' above is a basin fact, not a solver fault);
(ii) the sign condition that defines gradedness inside a fixed grading is OPEN,
so the graded set with a fixed grading is not closed for a structural reason."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r112'))
import r112_core as K
from r112_claim4 import sigma_basis, cubic_tensor, newton

rng = np.random.default_rng(555)

n = 6
eps = np.diag([1.0] * 3 + [-1.0] * 3)
B = sigma_basis(n, eps); Phi = cubic_tensor(n, B); Bc = B.reshape(B.shape[0], -1)
W0 = K.sphere_product(6, 3)
print("control: S^3xS^3 lies in W^sigma?  residual =",
      float(np.linalg.norm(W0 - np.einsum('d,dij->ij', Bc @ W0.ravel(), B))))
x0 = Bc @ W0.ravel()
for d in (1e-4, 1e-2, 5e-2):
    ok = 0; ths = []
    for _ in range(20):
        x = x0 + d * rng.standard_normal(len(x0)); x /= np.linalg.norm(x)
        x, r = newton(Phi, x)
        if r < 1e-11:
            M = np.einsum('d,dij->ij', x, B)
            th = abs(K.theta(n, M))
            ths.append((th, K.slack_mmm(n, M), K.slack_hhm(n, M)))
            ok += 1
    g = [t for t in ths if t[1] < 1e-8 and t[2] < 1e-8]
    print(f"  start dist {d:.0e}: {ok}/20 converged, {len(g)} graded, "
          f"theta values {sorted(set(round(t[0],9) for t in ths))[:6]}")

# CP^3 at n=6 via the u(3) grading, from the projector ansatz
J = np.zeros((6, 6))
for i in range(3):
    J[2*i, 2*i+1] = 1; J[2*i+1, 2*i] = -1
L = K.lam2(J); w, V = np.linalg.eigh(L)
Ph = V[:, w > 0]; Pm = V[:, w < 0]
Bu = sigma_basis(6, J); Phiu = cubic_tensor(6, Bu); Buc = Bu.reshape(Bu.shape[0], -1)
q, p = Ph.shape[1], Pm.shape[1]
Wg = (q * (Ph @ Ph.T) - p * (Pm @ Pm.T)) / np.sqrt(p * q * (p + q))
Wg = K.proj_weyl(6, Wg); Wg /= np.linalg.norm(Wg)
x = Buc @ Wg.ravel(); x /= np.linalg.norm(x)
x, r = newton(Phiu, x)
M = np.einsum('d,dij->ij', x, Bu); th = abs(K.theta(6, M))
print(f"u(3) two-eigenvalue ansatz -> Newton: res={r:.1e} theta={th:.9f} "
      f"th0={K.theta0(6):.9f} S_mmm={K.slack_mmm(6,M):.2e} S_hhm={K.slack_hhm(6,M):.2e}")

print("\n-- the sign condition is open: eigenvalues of W at the known graded points --")
for tag, nn, M in [('S^3xS^3', 6, K.sphere_product(6, 3)), ('S^4xS^4', 8, K.sphere_product(8, 4)),
                   ('CP2 pad n=8', 8, K.cp2(8))]:
    ev = np.linalg.eigvalsh(M)
    print(f"  {tag:12s} min|lam| over nonzero = {min(abs(e) for e in ev if abs(e)>1e-9):.6f}, "
          f"#zero eigenvalues = {int((abs(ev)<1e-9).sum())}, dim m = {int((ev<-1e-9).sum())}")
