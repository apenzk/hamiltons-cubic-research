"""
Step 1 of the graded enumeration: the second (isotropy-block) criticality
equation, and theta expressed without the mixed Casimir.

The k-block of Q(W) = theta*W gives a relation the dimension-only law did not
use.  Writing p = dim k, q = dim m, C for the Casimir of k on m and c_k for the
adjoint Casimir of k on itself (both in the so(n)-induced normalisation, where
coordinate 2-planes are orthonormal):

    A_mm = q C / p          (total antisymmetry of the structure constants:
                             both sides count the same index set -- one k index
                             and two m indices)

    c_k = [ C (2q - p) - 2 (p + q) ] / q          (the k-block equation)

Eliminating C between that and theta = (qC - p)/sqrt(pq(p+q)) gives theta in
terms of the pair's dimensions and the isotropy algebra's own Casimir alone:

    theta = ( c_k q^2 + 2 q^2 + p^2 ) / [ (2q - p) sqrt(pq(p+q)) ] .

Hand-checked on three families before coding -- Fox (p,q,c_k)=(1,2,0),
su(3) (3,5,1), and balanced S^m x S^m (m(m-1), m^2, 2(m-2)) for every m.
This script checks both relations against the catalogue with c_k computed
directly from the so(n) bracket rather than back-solved from theta.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, mop_from_4tensor
from run_defect_max_hunt import su_m_kahler_weyl
from run_cp2_ricci_flat import cp2_block_st_tensor
from review_r11_graded_law import weyl_sphere_product_mop, unit, orient, spec


def bracket_casimir(L2, Pi, dim_sub, tol=1e-9):
    """c_sub = (1/dim) * sum_{i,j in onb(sub)} ||Pi [u_i, u_j]||^2, brackets in so(n)."""
    n = L2.n
    ev, V = np.linalg.eigh(Pi)
    cols = V[:, ev > 0.5]                      # orthonormal basis of the subspace
    assert cols.shape[1] == dim_sub, (cols.shape[1], dim_sub)
    mats = [L2.vec_to_matrix(cols[:, i]) for i in range(dim_sub)]
    total = 0.0
    for i in range(dim_sub):
        for j in range(dim_sub):
            Bij = mats[i] @ mats[j] - mats[j] @ mats[i]
            v = L2.matrix_to_vec(Bij)
            total += float(np.dot(v, Pi @ v))
    return total / dim_sub


def analyse(label, W, n, c, L2):
    W = unit(W)
    W, th = orient(W, c)
    s = spec(W)
    if len(s) != 2:
        print(f"{label:<24} {len(s)} eigenvalues -- skipped (needs the ideal-wise form)")
        return
    (a, p), (mb, q) = s[0], s[1]
    b = -mb
    ev, V = np.linalg.eigh(W)
    Pk = V[:, ev > 0.5 * a] @ V[:, ev > 0.5 * a].T
    Pm = V[:, ev < 0.5 * mb] @ V[:, ev < 0.5 * mb].T
    s0 = np.sqrt(p * q * (p + q))
    C = (th * s0 + p) / q
    ck_pred = (C * (2 * q - p) - 2 * (p + q)) / q
    ck_meas = bracket_casimir(L2, Pk, p)
    th_pred = (ck_meas * q * q + 2 * q * q + p * p) / ((2 * q - p) * s0)
    print(f"{label:<24} (p,q)=({p:>3},{q:>3})  C={C:6.3f}  "
          f"c_k: pred={ck_pred:7.3f} measured={ck_meas:7.3f}  "
          f"|d|={abs(ck_pred-ck_meas):.1e}   theta={th:.9f} "
          f"from(p,q,c_k)={th_pred:.9f}  |d|={abs(th-th_pred):.1e}")


for n in (6, 8, 12):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    print(f"--- n={n} " + "-" * 60)
    m = n // 2
    analyse(f"balanced S^{m}xS^{m}", weyl_sphere_product_mop(L2, m, n - m), n, c, L2)
    analyse("Fox S^4(alpha)",
            weyl_from_mop(L2, mop_from_4tensor(L2, cp2_block_st_tensor(n, 1, -1)))[0], n, c, L2)
    analyse(f"su({m}) Kaehler", su_m_kahler_weyl(L2, m), n, c, L2)
