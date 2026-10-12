"""
Testing the two-sided regularity where it can actually be tested.

Random-start search reaches only theta <= 0.512, while both triggers of the
regularity -- RHS >= sqrt(3/2) and theta > 0.916 -- live above that.  Everything
on file in that region came from a structured construction, so the regularity
must be tested on the structured population or not at all.

The regularity, and why it would be the repair:

    every critical point with RHS >= sqrt(3/2) has theta <= 0.916.

The sharp (II)-side bound gives theta <= RHS, which separates wherever
RHS < sqrt(3/2); the regularity covers exactly the complement.  Together they
would give theta < sqrt(3/2) at every ungraded critical point, which is what the
ungraded half needs.

Population enumerated here, at every n where each exists:
  * all two-block sphere products S^k x S^l, k + l = n
  * the multi-block products (S^m)^k, which supplied the counterexample that
    refuted the separation
  * the CP^m / su(m) Kaehler family
  * W_CP2 and its paddings
Each is screened for criticality and unit norm before its (theta, RHS, S) is
recorded, and the two directions of the regularity are reported separately.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from review_r11_graded_law import weyl_sphere_product_mop
from run_defect_max_hunt import su_m_kahler_weyl

SQ32 = np.sqrt(1.5)


def measure(L2, W, c, alt):
    nrm = np.linalg.norm(W)
    if nrm < 1e-12:
        return None
    W = W / nrm
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    if th < 0:
        W, th = -W, -th
        QW = Q_full(W, c)
    res = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    d2 = float(delta2_and_grad(W, alt)[0])
    rho = ricci_from_mop(L2, Wm)
    nr2 = float(np.sum(rho * rho))
    if nr2 < 1e-14:
        return None
    Sh = rho / np.sqrt(nr2)
    trSh4 = float(np.trace(np.linalg.matrix_power(Sh, 4)))
    RicWm2 = ricci_from_mop(L2, Wm @ Wm)
    rhs = (np.sqrt(2) * np.sqrt(max(1 - trSh4, 0.0))
           - float(np.sum(RicWm2 * rho)) / nr2
           + 12.0 * d2 * float(np.linalg.eigvalsh(rho)[-1]) / nr2)
    S = float(np.sum(rho * rho)) + 6 * d2 - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))
    return th, rhs, S, res


def multiblock(L2, n, k):
    """(S^m)^k with m = n/k: block-diagonal Weyl operator over k equal blocks."""
    m = n // k
    if m * k != n or m < 2:
        return None
    W = np.zeros((L2.N, L2.N))
    for a, (i, j) in enumerate(L2.pairs):
        bi, bj = i // m, j // m
        W[a, a] = 1.0 if bi == bj else -1.0 / (k - 1) if k > 1 else 0.0
    return W


rows = []
for n in (8, 10, 12, 14, 16, 18, 20, 24):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt = build_alt_indices(L2)
    cands = []
    for k in range(2, n // 2 + 1):
        cands.append((f"S^{k}xS^{n-k}", weyl_sphere_product_mop(L2, k, n - k)))
    for k in (3, 4):
        Wb = multiblock(L2, n, k)
        if Wb is not None:
            cands.append((f"(S^{n//k})^{k}", Wb))
    if n % 2 == 0:
        try:
            cands.append((f"CP^{n//2}", su_m_kahler_weyl(L2, n // 2)))
        except Exception:
            pass
    for name, W in cands:
        m = measure(L2, W, c, alt)
        if m is None:
            continue
        th, rhs, S, res = m
        if res < 1e-8:
            rows.append((n, name, th, rhs, S))

print(f"{'n':>4} {'family':>14} {'theta':>10} {'RHS':>10} {'S':>9}  flags")
for n, name, th, rhs, S in rows:
    f = []
    if rhs >= SQ32: f.append("RHS>=sqrt(3/2)")
    if th > 0.916: f.append("theta>0.916")
    if th > SQ32: f.append("*** theta>sqrt(3/2) ***")
    print(f"{n:>4} {name:>14} {th:>10.6f} {rhs:>10.6f} {S:>9.4f}  {' '.join(f)}")

hi = [r for r in rows if r[3] >= SQ32]
big = [r for r in rows if r[2] > 0.916]
print(f"\n{len(rows)} structured critical points")
print(f"   with RHS >= sqrt(3/2): {len(hi)}"
      + (f"   max theta among them = {max(r[2] for r in hi):.6f}"
         f"   {'*** REGULARITY BREACHED ***' if max(r[2] for r in hi) > 0.916 else 'consistent'}" if hi else ""))
print(f"   with theta > 0.916: {len(big)}"
      + (f"   min RHS among them = {min(r[3] for r in big):.6f}"
         f"   {'*** REGULARITY BREACHED ***' if min(r[3] for r in big) >= SQ32 else 'consistent'}" if big else ""))
