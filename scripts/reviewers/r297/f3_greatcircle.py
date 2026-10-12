"""F3 triple-check: at the C_5 blow-up (Delta=12), P genuinely RISES along the top
L_e-eigendirection, which has zero component on the orbit tangent."""
import sys; sys.path.insert(0, 'scripts/reviewers/r297')
import numpy as np, core297 as C
n = 10; W, _ = C.c5_blowup(); W /= np.linalg.norm(W); th = C.Pval(n, W)
sp, M, w, U = C.le_spectrum_perp(n, W, th)
B = C.weyl(n); Mp = U.T @ M @ U; Mp = 0.5 * (Mp + Mp.T)
ev, vec = np.linalg.eigh(Mp)
H = np.einsum('k,kij->ij', U @ vec[:, -1], B); H /= np.linalg.norm(H)
print(f"lambda_top = {ev[-1]:.12f}   <H,W> = {float(np.tensordot(H,W)):.1e}"
      f"   ||L_e H - lam H|| = {np.linalg.norm(C.L_W(n,W,H)/th - ev[-1]*H):.1e}")
print(f"theta = {th:.12f};  prediction (P-theta)/t^2 -> 3*theta*(lam-1/2) = {3*th*(ev[-1]-0.5):.6f}")
for t in (0.3, 0.1, 0.03, 0.01, 0.003):
    X = np.cos(t) * W + np.sin(t) * H
    print(f"  t={t:6.3f}  P-theta={C.Pval(n,X)-th:+.3e}  (P-theta)/t^2={(C.Pval(n,X)-th)/t**2:+.6f}")
print(f"||projection of H onto the orbit tangent|| = "
      f"{np.linalg.norm(C.rowspace(C.orbit_tangent(n,W)) @ H.reshape(-1)):.1e}")
