"""
Step 2: the symmetric-pair (graded) critical points, and a closed form for theta.

Track 2 (agent_logs/proof_idempotent_gap_report.md) showed that equality in its
graded compression inequality holds exactly when the eigenspaces of W carry a
Z_2-grading under the so(n) bracket:

    [E+,E+] perp E- ,  [E-,E-] perp E- ,  [E+,E-] subset E- ,

i.e. exactly the symmetric-pair condition h = k + m with [k,k] subset k,
[k,m] subset m, [m,m] subset k, for E+ ~ k and E- ~ m.  Every known critical
point with theta > 1 and delta^2 > 0 is of this type.

This script tests the structural hypothesis that makes that class ENUMERABLE:
that such a W is the two-eigenvalue operator determined by the pair's dimensions
alone,

    W = ( q * Pi_k  -  p * Pi_m ) / sqrt( p q (p+q) ) ,   p = dim k, q = dim m,

(the unique trace-free normalisation supported on h), with critical value

    theta = ( q C - p ) / sqrt( p q (p+q) ) ,

where C is the Casimir eigenvalue of k acting on m in the so(n)-induced
normalisation.  Hand-verified before coding, on three independent cases:
  Fox S^4(alpha):      (p,q)=(1,2),  theta=sqrt(3/2)   => C = 2
  su(3) Kaehler:       (p,q)=(3,5),  theta=sqrt(6/5)   => C = 3
  balanced S^m x S^m:  (p,q)=(m(m-1), m^2)             => C = 2(m-1) for EVERY m,
      since theta_0(2m) = sqrt((2m-1)(m-1))/m solves (qC-p)/sqrt(pq(p+q)) exactly.

Here the two-eigenvalue structure and the (p,q) reading are checked directly
against the repo's constructions, and C is extracted and tested for consistency.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, mop_from_4tensor
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from run_defect_max_hunt import su_m_kahler_weyl
from run_hpm_qk import qk_tensor
from run_cp2_ricci_flat import cp2_block_st_tensor


def weyl_sphere_product_mop(L2, p, q):
    """Weyl operator of S^p x S^q, diagonal in coordinate 2-planes."""
    n = p + q
    alpha = q / ((p - 1) * (n - 1))
    beta = p / ((q - 1) * (n - 1))
    gamma = -1.0 / (n - 1)
    W = np.zeros((L2.N, L2.N))
    for a, (i, j) in enumerate(L2.pairs):
        ip, jp = i < p, j < p
        W[a, a] = alpha if (ip and jp) else (beta if (not ip and not jp) else gamma)
    return W


def unit(W):
    return W / np.linalg.norm(W)


def orient(W, c):
    th = float(np.sum(W * Q_full(W, c)))
    return (-W, -th) if th < 0 else (W, th)


def spec(W, tol=1e-9):
    ev = np.sort(np.linalg.eigvalsh(W))[::-1]
    keep = ev[np.abs(ev) > tol]
    out, i = [], 0
    while i < len(keep):
        j = i
        while j < len(keep) and abs(keep[j] - keep[i]) < 1e-7:
            j += 1
        out.append((float(keep[i]), j - i))
        i = j
    return out


def report(label, W, n, c, alt_idx):
    W = unit(W)
    W, th = orient(W, c)
    resid = np.linalg.norm(Q_full(W, c) - th * W) / max(np.linalg.norm(Q_full(W, c)), 1e-300)
    d2 = delta2_and_grad(W, alt_idx)[0]
    s = spec(W)
    line = f"{label:<26} n={n:<3} theta={th:.9f} d2={d2:.9f} resid={resid:.0e}"
    print(line)
    print(f"{'':28}spectrum = {[(round(v, 6), m) for v, m in s]}")
    if len(s) == 2:
        (a, p), (mb, q) = s[0], s[1]
        b = -mb
        s0 = np.sqrt(p * q * (p + q))
        pred = np.array([q / s0] * 1 + [-p / s0] * 1)
        ok_shape = (abs(a - q / s0) < 1e-9) and (abs(b - p / s0) < 1e-9)
        C = (th * s0 + p) / q
        print(f"{'':28}TWO-EIGENVALUE  (p,q)=({p},{q})  ansatz W=(q*Pi_k - p*Pi_m)/sqrt(pq(p+q)): "
              f"{'MATCH' if ok_shape else 'no'}")
        print(f"{'':28}extracted Casimir C = (theta*sqrt(pq(p+q)) + p)/q = {C:.9f}")
    else:
        print(f"{'':28}{len(s)} distinct eigenvalues -- outside the two-eigenvalue ansatz")
    print()


if __name__ == "__main__":
    for n in (6, 8, 12):
        idx, pos, N, c = build_structure_constants(n)
        L2 = Lambda2(n)
        alt_idx = build_alt_indices(L2)
        print("=" * 78)
        print(f"n = {n}")
        print("=" * 78)
        if n % 2 == 0:
            m = n // 2
            Wsp = weyl_sphere_product_mop(L2, m, n - m)
            report(f"balanced sphere S^{m}xS^{m}", Wsp, n, c, alt_idx)
        report("Fox S^4(alpha)",
               weyl_from_mop(L2, mop_from_4tensor(L2, cp2_block_st_tensor(n, 1, -1)))[0],
               n, c, alt_idx)
        if n % 2 == 0:
            report(f"su({n//2}) Ricci-flat Kaehler", su_m_kahler_weyl(L2, n // 2), n, c, alt_idx)
        if n % 4 == 0:
            report(f"quaternionic-Kaehler HP^{n//4}",
                   weyl_from_mop(L2, mop_from_4tensor(L2, qk_tensor(n, n // 4, 1.0, 1.0)))[0],
                   n, c, alt_idx)
