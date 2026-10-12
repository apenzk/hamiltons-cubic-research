import sys, numpy as np
sys.path.insert(0,'scripts/reviewers/r313')
import r313_lib as R
from r313_m1b import ad_matrix, gens_u, gens_so_kl

def inv_dim_T(n, gens):
    """nullspace of T = sum_X C_X^T C_X on Weyl_n, computed in one shot."""
    B = R.weyl_basis(n); dim = B.shape[0]
    T = np.zeros((dim, dim))
    for X in gens:
        a = ad_matrix(n, X)
        img = a @ B - np.einsum('sij,jk->sik', B, a)
        C = np.einsum('sab,tab->ts', img, B)
        T += C.T @ C
    ev, evec = np.linalg.eigh(0.5*(T+T.T))
    return ev, evec

n=12
for name, g in (("u(6)", gens_u(6)), ("so(5)+so(7)", gens_so_kl(12,5))):
    ev, evec = inv_dim_T(n, g)
    print(name, "smallest 6 eigenvalues of T:", np.array2string(ev[:6], precision=3))
    print("   largest:", ev[-1])
    for j in range(3):
        W = R.from_coords(n, evec[:, j]); W /= np.sqrt(np.tensordot(W,W,axes=2))
        res, th = R.crit_residual(n, W)
        print(f"   vec{j}: ev={ev[j]:.3e} theta={th:.9f} crit_res={res:.1e}")
