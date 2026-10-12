"""J3: is the diagonal reduction the whole second-order condition?
Compare lambda_max(L_e) on Weyl_n ^ W-perp against the diagonal restriction."""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np
from core303 import Alg, diag_op, sphere_product_M
from diagcore import V_basis, theta_of, L_matrix
from census2 import census

n = int(sys.argv[1])
alg = Alg(n)
WB = alg.weyl_basis()
print(f"n={n} dim Weyl_n = {len(WB)}  (formula {n*(n+1)*(n+2)*(n-3)//12})")
B = V_basis(n)
_, tab = census(n, int(sys.argv[2]) if len(sys.argv) > 2 else 60)


def full_spectrum(M):
    W = diag_op(alg, M)
    th = float(np.sum(W * alg.Q(W)))
    # L_W as a matrix in the Weyl basis
    LW = np.array([np.einsum('kij,ij->k', WB, alg.L(W, Bk)) for Bk in WB]).T
    assert np.abs(LW - LW.T).max() < 1e-9, np.abs(LW - LW.T).max()
    wv = np.einsum('kij,ij->k', WB, W); wv /= np.linalg.norm(wv)
    Qb, _ = np.linalg.qr(np.hstack([wv[:, None], np.eye(len(WB))]))
    U = Qb[:, 1:len(WB)]
    lam = np.linalg.eigvalsh(U.T @ LW @ U)
    return th, lam.max(), lam.min(), float(wv @ LW @ wv)


print(f"{'theta':>10} {'diag lmax/th':>13} {'FULL lmax/th':>13} {'full lmin/th':>13} {'radial/th':>10}")
for key, (M, a, st) in sorted(tab.items(), key=lambda kv: -kv[1][1]['theta']):
    th, lmax, lmin, rad = full_spectrum(M)
    print(f"{th:10.6f} {a['ratio']:13.6f} {lmax/th:13.6f} {lmin/th:13.6f} {rad/th:10.6f}"
          + ("   FULL>diag" if lmax/th > a['ratio'] + 1e-8 else "   equal"))
