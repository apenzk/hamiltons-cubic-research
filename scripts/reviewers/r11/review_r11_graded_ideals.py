"""
Step 2 of the graded enumeration: the ideal-wise criticality system, covering
the graded critical points whose isotropy algebra is not simple.

When k splits into ideals k_1 + ... + k_r (which happens exactly when W carries
more than one positive eigenvalue), W is a_i on k_i and -b on m, and the two
block equations become, with p_i = dim k_i, q = dim m, C_i the Casimir of k_i
on m, c_i the adjoint Casimir of k_i on itself, and A^i_mm = q C_i / p_i:

    m-block :   b - sum_i a_i C_i = -theta
    k_i-block:  a_i^2 + (1/2)[ c_i a_i^2 + (q C_i / p_i) b^2 ] = theta a_i
    trace    :  sum_i p_i a_i = q b
    norm     :  sum_i p_i a_i^2 + q b^2 = 1

r = 1 recovers the two-eigenvalue law of review_r11_graded_law.py, and the two
equal ideals of a balanced sphere product recover it as well.  This script reads
(p_i, a_i, q, b) off each catalogued operator, computes C_i, c_i and A^i_mm
directly from the so(n) bracket, and checks every equation, so nothing is
back-solved from theta.

Structural point confirmed here: the graded critical points correspond to
symmetric pairs (h, k) with h a subalgebra of so(n) -- Fox is (su(2), u(1)),
the Ricci-flat Kaehler family is (su(m), so(m)), the balanced sphere product is
(so(2m), so(m)+so(m)), and HP^2 at n=8 is (so(8), so(3)+so(5)) via the
exceptional isomorphisms sp(2) = so(5), sp(1) = so(3).
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, mop_from_4tensor
from run_defect_max_hunt import su_m_kahler_weyl
from run_cp2_ricci_flat import cp2_block_st_tensor
from run_hpm_qk import qk_tensor
from review_r11_graded_law import weyl_sphere_product_mop, unit, orient, spec


def onb(L2, W, lo, hi):
    """Orthonormal basis (as so(n) matrices) of the eigenspace of W in (lo, hi)."""
    ev, V = np.linalg.eigh(W)
    cols = V[:, (ev > lo) & (ev < hi)]
    return [L2.vec_to_matrix(cols[:, i]) for i in range(cols.shape[1])], cols


def proj(cols):
    return cols @ cols.T


def bracket_sum(L2, basis_a, basis_b, Ptarget):
    """sum over the two bases of ||Ptarget [u, v]||^2."""
    tot = 0.0
    for A in basis_a:
        for B in basis_b:
            v = L2.matrix_to_vec(A @ B - B @ A)
            tot += float(np.dot(v, Ptarget @ v))
    return tot


def analyse(label, W, n, c, L2):
    W = unit(W)
    W, th = orient(W, c)
    s = spec(W)
    pos = [(v, m) for v, m in s if v > 0]
    neg = [(v, m) for v, m in s if v < 0]
    if len(neg) != 1:
        print(f"{label:<22} {len(neg)} negative eigenvalues -- outside this ansatz")
        return
    mb, q = neg[0]
    b = -mb
    mbasis, mcols = onb(L2, W, mb - 1e-6, mb + 1e-6)
    Pm = proj(mcols)
    # gradedness test: [m, m] must land in k, i.e. have no m-component
    mm_in_m = bracket_sum(L2, mbasis, mbasis, Pm)
    mm_tot = sum(np.dot(L2.matrix_to_vec(A @ B - B @ A), L2.matrix_to_vec(A @ B - B @ A))
                 for A in mbasis for B in mbasis)
    graded = mm_in_m / max(mm_tot, 1e-300)
    print(f"{label:<22} theta={th:.9f}  q={q:<3} b={b:.6f}  r={len(pos)} ideal(s)  "
          f"[m,m] m-fraction = {graded:.3e} -> {'GRADED' if graded < 1e-12 else 'NOT graded'}")
    worst_k, sum_aC, tr_chk = 0.0, 0.0, 0.0
    for a, p in pos:
        kbasis, kcols = onb(L2, W, a - 1e-6, a + 1e-6)
        Pk = proj(kcols)
        C = bracket_sum(L2, kbasis, mbasis, Pm) / q
        ci = bracket_sum(L2, kbasis, kbasis, Pk) / p
        Amm = bracket_sum(L2, mbasis, mbasis, Pk) / p
        lhs = a * a + 0.5 * (ci * a * a + (q * C / p) * b * b)
        worst_k = max(worst_k, abs(lhs - th * a))
        sum_aC += a * C
        tr_chk += p * a
        print(f"{'':22}  ideal p={p:<3} a={a:.6f}  C={C:8.4f}  c_i={ci:8.4f}  "
              f"A_mm={Amm:8.4f} (q*C/p={q*C/p:8.4f}, |d|={abs(Amm-q*C/p):.1e})  "
              f"k-eqn |d|={abs(lhs - th*a):.1e}")
    print(f"{'':22}  m-eqn: b - sum a_i C_i = {b - sum_aC:+.9f}  vs -theta = {-th:+.9f}"
          f"   |d|={abs(b - sum_aC + th):.1e}")
    print(f"{'':22}  trace: sum p_i a_i = {tr_chk:.6f}  vs q*b = {q*b:.6f}"
          f"   |d|={abs(tr_chk - q*b):.1e}\n")


for n in (8, 12):
    idx, pos_, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    print("=" * 76)
    print(f"n = {n}")
    print("=" * 76)
    m = n // 2
    analyse(f"balanced S^{m}xS^{m}", weyl_sphere_product_mop(L2, m, n - m), n, c, L2)
    analyse("Fox S^4(alpha)",
            weyl_from_mop(L2, mop_from_4tensor(L2, cp2_block_st_tensor(n, 1, -1)))[0], n, c, L2)
    analyse(f"su({m}) Kaehler", su_m_kahler_weyl(L2, m), n, c, L2)
    analyse(f"QK HP^{n//4}",
            weyl_from_mop(L2, mop_from_4tensor(L2, qk_tensor(n, n // 4, 1.0, 1.0)))[0], n, c, L2)
