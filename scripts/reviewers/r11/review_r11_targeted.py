"""
Targeted independent checks on the two gating claims of the 2026-08-20 proof
batch, before any of it is integrated into findings/INDEX.md.

CHECK A -- the sqrt(6/5) discrepancy.
  proof_frontier_bound_report.md lists an "uncatalogued" critical point at
  theta = sqrt(6/5) = 1.095445 with delta^2 = 0.100000 and Lambda^2 spectrum
  (+0.8216 x1, +0.0913 x3, -0.2739 x4).  The catalogued su(3) Ricci-flat
  Kaehler member has the SAME theta = sqrt(6/5) but delta^2 = 5/48 = 0.104167.
  Question: one point with a numerical error, or two genuinely distinct
  critical points sharing a critical value?  Settled by rebuilding the su(3)
  member and comparing spectrum, defect and support dimension.

CHECK B -- the HP^2 local-max discovery.
  proof_defect_instability_report.md claims quaternionic-Kaehler HP^2
  (theta = 1.115547, delta^2 = 0.0317) is a STRICT local maximum with Hessian
  kernel equal to the O(n)-orbit dimension -- new, and consequential because it
  refutes "defective => saddle".  Verified here with the Hessian built through
  rsharp_basis_free.Q_full (Pipeline B), which shares no code with the
  run_defect_instability_* pipeline under review, and with Fox + the balanced
  sphere product as positive/negative controls.

Hessian convention (established and reviewed in findings/INDEX.md):
    Hess(H,H) = 6 T(W,H,H) - 3 theta ||H||^2 ,   ||W|| = 1, H perp W,
with T the full polarization of P, so T(W,E_a,E_b) = <E_a, B(W,E_b)> for
B(X,Y) = 1/2 (Q(X+Y) - Q(X) - Q(Y)).
"""
import numpy as np

from weyl import build_structure_constants, bianchi_constraint_matrix, vec_to_mat, R_val
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, mop_from_4tensor
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from run_defect_max_hunt import su_m_kahler_weyl, su_m_theta, su_m_delta2
from run_hpm_qk import qk_tensor
from run_unconstrained_search import build_weyl_basis
from run_cp2_ricci_flat import cp2_block_st_tensor


def unit(W):
    return W / np.linalg.norm(W)


def theta_of(W, c):
    """Critical eigenvalue and relative idempotency residual."""
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    resid = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
    return th, resid


def spectrum_summary(W, tol=1e-9):
    ev = np.linalg.eigvalsh(W)
    keep = ev[np.abs(ev) > tol]
    out, i = [], 0
    keep = np.sort(keep)[::-1]
    while i < len(keep):
        j = i
        while j < len(keep) and abs(keep[j] - keep[i]) < 1e-7:
            j += 1
        out.append((float(keep[i]), j - i))
        i = j
    return out, len(keep)


def hessian_spectrum(W, c, Eflat, D):
    """Full tangent-space Hessian spectrum at a unit-norm critical point W."""
    th, resid = theta_of(W, c)
    N = W.shape[0]
    QW = Q_full(W, c)
    # L_W(E_b) = B(W, E_b), by polarization
    LW = np.empty((D, N * N))
    for b in range(D):
        Eb = Eflat[b].reshape(N, N)
        QE = Q_full(Eb, c)
        LW[b] = (0.5 * (Q_full(W + Eb, c) - QW - QE)).reshape(-1)
    M = 6.0 * (Eflat @ LW.T)
    M = 0.5 * (M + M.T)
    M -= 3.0 * th * np.eye(D)
    # restrict to the true tangent space w^perp via an explicit orthonormal
    # basis of it (projecting instead would leave a spurious zero eigenvalue
    # buried mid-spectrum, inflating the kernel count by exactly one)
    w = Eflat @ W.reshape(-1)
    w /= np.linalg.norm(w)
    Bc = np.linalg.svd(np.outer(w, w))[0][:, 1:]  # D x (D-1), orthonormal, perp to w
    Mt = Bc.T @ M @ Bc
    ev = np.sort(np.linalg.eigvalsh(Mt))[::-1]
    scale = max(abs(ev[0]), abs(ev[-1]), 1e-300)
    cut = 1e-7 * scale
    return th, resid, ev, int(np.sum(ev > cut)), int(np.sum(np.abs(ev) <= cut)), int(np.sum(ev < -cut))


def orbit_dim(W, n):
    """dim of the O(n)-orbit = rank of A -> [ad(A), W] over so(n)."""
    N = W.shape[0]
    L2 = Lambda2(n)
    cols = []
    for i in range(n):
        for j in range(i + 1, n):
            A = np.zeros((n, n))
            A[i, j], A[j, i] = 1.0, -1.0
            # induced action on Lambda^2: (ad A) acting on bivectors
            adA = np.zeros((N, N))
            for a, (p, q) in enumerate(L2.pairs):
                M = np.zeros((n, n))
                M[p, q], M[q, p] = 1.0, -1.0
                Mm = A @ M - M @ A
                adA[:, a] = L2.matrix_to_vec(Mm)
            cols.append((adA @ W - W @ adA).reshape(-1))
    return int(np.linalg.matrix_rank(np.array(cols), tol=1e-8))


print("=" * 72)
print("CHECK A -- the sqrt(6/5) discrepancy")
print("=" * 72)
n = 6
idx, pos, N, c = build_structure_constants(n)
L2 = Lambda2(n)
alt_idx = build_alt_indices(L2)
W_su3 = unit(su_m_kahler_weyl(L2, 3))
th, resid = theta_of(W_su3, c)
if th < 0:
    W_su3, th = -W_su3, -th
d2 = delta2_and_grad(W_su3, alt_idx)[0]
spec, supp = spectrum_summary(W_su3)
print(f"su(3) Kaehler member (n=6):")
print(f"  theta          = {th:.9f}   (closed form {su_m_theta(3):.9f}, sqrt(6/5)={np.sqrt(6/5):.9f})")
print(f"  idemp. residual= {resid:.2e}")
print(f"  delta^2        = {d2:.9f}   (closed form {su_m_delta2(3):.9f} = 5/48 = {5/48:.9f})")
print(f"  support dim    = {supp}")
print(f"  spectrum       = {[(round(v,6), m) for v, m in spec]}")
print(f"  spectrum*sqrt(120) = {[(round(v*np.sqrt(120),4), m) for v, m in spec]}")
print()
print(f"  frontier report's point: theta=1.095445, delta^2=0.100000,")
print(f"    spectrum (+0.8216 x1, +0.0913 x3, -0.2739 x4), support 8")
print(f"    -> that spectrum * sqrt(120) = (9 x1, 1 x3, -3 x4), trace 0, norm 1")
print(f"  delta^2 differ by {abs(d2 - 0.100000):.6f}; same? {abs(d2-0.1)<1e-6}")

print()
print("=" * 72)
print("CHECK B -- is quaternionic-Kaehler HP^2 a strict local max at n=8?")
print("=" * 72)
n = 8
idx, pos, N, c = build_structure_constants(n)
L2 = Lambda2(n)
alt_idx = build_alt_indices(L2)
Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=True)

# --- HP^2 ---
T = qk_tensor(n, 2, 1.0, 1.0)
Mop = mop_from_4tensor(L2, T)
W_hp = unit(weyl_from_mop(L2, Mop)[0])
th, resid, ev, npos, nzero, nneg = hessian_spectrum(W_hp, c, Eflat, D)
if th < 0:
    W_hp = -W_hp
    th, resid, ev, npos, nzero, nneg = hessian_spectrum(W_hp, c, Eflat, D)
d2 = delta2_and_grad(W_hp, alt_idx)[0]
od = orbit_dim(W_hp, n)
print(f"HP^2  theta={th:.6f} resid={resid:.1e} delta^2={d2:.6f}")
print(f"      Hessian: #pos={npos}  #zero={nzero}  #neg={nneg}   (dim tangent={D-1})")
print(f"      top eigenvalue = {ev[0]:.3e},  orbit dim = {od}")
print(f"      VERDICT: {'STRICT LOCAL MAX' if npos == 0 else 'SADDLE'}"
      f"{' , kernel == orbit dim' if npos == 0 and nzero == od else ''}")

# --- controls: Fox (known local max) and balanced sphere (known local max) ---
W_fox = unit(weyl_from_mop(L2, mop_from_4tensor(L2, cp2_block_st_tensor(n, 1, -1)))[0])
th_f, _ = theta_of(W_fox, c)
if th_f < 0:
    W_fox = -W_fox
th, resid, ev, npos, nzero, nneg = hessian_spectrum(W_fox, c, Eflat, D)
od = orbit_dim(W_fox, n)
print(f"Fox   theta={th:.6f} resid={resid:.1e} "
      f"#pos={npos} #zero={nzero} #neg={nneg} orbitdim={od} "
      f"-> {'LOCAL MAX' if npos == 0 else 'SADDLE'}")
