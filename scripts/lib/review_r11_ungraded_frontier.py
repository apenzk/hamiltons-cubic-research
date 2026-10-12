"""
C11 step (i): measure (S, theta) over the whole known ungraded population.

S is the slack of the graded compression inequality (review_r11_grading_slack.py),
zero exactly on the graded class.  The graded half of the core is settled across
the classical families; the ungraded half, S > 0, is the crux, and the candidate
closing statement is theta <= Theta(S) with Theta decreasing.

This gathers every ungraded critical point the repo knows how to produce --
the SU(3) bi-invariant and its padding, multi-block sphere products, the
theta = sqrt(3/20) defect violator, the theta = 0 stratum point, quaternionic
HP^m, and generic symmetry-free saddles found by ascent -- and tabulates
(S, theta, delta^2) so the frontier can be read off.

Everything is screened before it counts: Ricci-flat, unit norm, and a genuine
criticality residual.  Graded points are carried along as controls, since they
must return S = 0.
"""
import numpy as np

from weyl import (build_structure_constants, bianchi_constraint_matrix,
                  vec_to_mat, R_val)
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, mop_from_4tensor, ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad, build_su3_n8, pad_weyl_to_n
from run_defect_max_hunt import su_m_kahler_weyl
from run_cp2_ricci_flat import cp2_block_st_tensor
from run_hpm_qk import qk_tensor
from run_unconstrained_search import build_weyl_basis
from review_r11_graded_law import weyl_sphere_product_mop, unit, orient

SQ32 = np.sqrt(1.5)


def multiblock_weyl(L2, blocks):
    """Weyl part of the Einstein product of round spheres S^{n_1} x ... x S^{n_k}.

    The product metric with Ric = id has sectional curvature 1/(n_a - 1) inside
    block a and 0 between blocks, so the curvature operator is diagonal in
    coordinate 2-planes with those entries; the Weyl projection of that is the
    critical point.  (An earlier version of this routine solved only for
    Ricci-flatness on a block-constant ansatz and never imposed criticality,
    which is why every multi-block point was silently filtered out.)
    """
    n = L2.n
    if sum(blocks) != n or any(b < 2 for b in blocks):
        return None
    owner = []
    for bi, b in enumerate(blocks):
        owner += [bi] * b
    d = np.zeros(L2.N)
    for a, (i, j) in enumerate(L2.pairs):
        if owner[i] == owner[j]:
            nb = blocks[owner[i]]
            d[a] = 1.0 / (nb - 1)
    return weyl_from_mop(L2, np.diag(d))[0]


def analyse(L2, W, c, alt_idx):
    W = unit(W)
    W, th = orient(W, c)
    QW = Q_full(W, c)
    res = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
    ric = np.max(np.abs(ricci_from_mop(L2, W)))
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    d2 = delta2_and_grad(W, alt_idx)[0]
    r = ricci_from_mop(L2, Wm)
    scale = float(np.sum(r * r)) + 6 * d2
    S = scale - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))
    return th, d2, S, res, ric, S / max(scale, 1e-300)


def ascend(n, c, Eflat, D, seed, iters=600):
    """Riemannian gradient ascent on P over the Weyl subspace, from a random start."""
    rng = np.random.default_rng(seed)
    x = rng.normal(size=D)
    x /= np.linalg.norm(x)
    N = int(round(np.sqrt(Eflat.shape[1])))
    step = 0.1
    for _ in range(iters):
        W = (Eflat.T @ x).reshape(N, N)
        g = Eflat @ (3.0 * Q_full(W, c)).reshape(-1)
        g -= (g @ x) * x
        ng = np.linalg.norm(g)
        if ng < 1e-13:
            break
        y = x + step * g / ng
        y /= np.linalg.norm(y)
        Wy = (Eflat.T @ y).reshape(N, N)
        if float(np.sum(Wy * Q_full(Wy, c))) > float(np.sum(W * Q_full(W, c))):
            x = y
        else:
            step *= 0.6
            if step < 1e-10:
                break
    return (Eflat.T @ x).reshape(N, N)


rows = []
for n in (6, 8, 12):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt_idx = build_alt_indices(L2)
    m = n // 2
    cands = [(f"balanced S^{m}xS^{m}", weyl_sphere_product_mop(L2, m, n - m), "control"),
             ("Fox S^4(alpha)",
              weyl_from_mop(L2, mop_from_4tensor(L2, cp2_block_st_tensor(n, 1, -1)))[0], "control"),
             (f"su({m}) Kaehler", su_m_kahler_weyl(L2, m), "control")]
    if n % 4 == 0:
        cands.append((f"QK HP^{n//4}",
                      weyl_from_mop(L2, mop_from_4tensor(L2, qk_tensor(n, n // 4, 1.0, 1.0)))[0],
                      "cand"))
    # multi-block sphere products (3 and 4 factors)
    for blocks in ([2, 2, n - 4], [3, 3, n - 6], [2, 2, 2, n - 6]):
        if all(b >= 2 for b in blocks) and sum(blocks) == n:
            Wb = multiblock_weyl(L2, blocks)
            if Wb is not None and np.linalg.norm(Wb) > 1e-9:
                cands.append((f"sphere {tuple(blocks)}", Wb, "cand"))
    if n == 8:
        cands.append(("SU(3) bi-invariant", build_su3_n8()[1], "cand"))
        for f in ("scripts/data/defect_violation_n8_0.120000.npy", "scripts/data/defect_theta0_n8_0.125000.npy"):
            try:
                cands.append((f.replace(".npy", ""), np.load(f), "cand"))
            except Exception:
                pass
    if n == 12:
        try:
            L8, W8 = build_su3_n8()
            cands.append(("SU(3) padded to n=12", pad_weyl_to_n(L8, W8, 12), "cand"))
        except Exception:
            pass
    for label, W, kind in cands:
        if W is None:
            continue
        try:
            th, d2, S, res, ric, Srel = analyse(L2, np.asarray(W, dtype=float), c, alt_idx)
        except Exception:
            continue
        if res > 1e-6 or ric > 1e-8:
            continue
        rows.append((n, label, th, d2, S, Srel))
    # generic saddles by ascent (n = 6 only: cheap, and where the thicket lives)
    if n == 6:
        Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
        for seed in range(12):
            W = ascend(n, c, Eflat, D, seed)
            th, d2, S, res, ric, Srel = analyse(L2, W, c, alt_idx)
            if res < 1e-6 and ric < 1e-8:
                rows.append((n, f"ascent seed {seed}", th, d2, S, Srel))

print(f"{'n':>3} {'point':<26} {'theta':>10} {'delta^2':>10} {'slack S':>11}  class")
print("-" * 78)
for n, label, th, d2, S, Srel in sorted(rows, key=lambda r: (-r[2],)):
    cls = "graded" if abs(Srel) < 1e-6 else "UNGRADED"
    print(f"{n:>3} {label:<26} {th:>10.6f} {d2:>10.6f} {S:>11.6f}  {cls}")

g = [r for r in rows if abs(r[5]) < 1e-6]
u = [r for r in rows if abs(r[5]) >= 1e-6]
print("-" * 78)
print(f"graded  : {len(g):>3} points, max theta = {max((r[2] for r in g), default=0):.6f}")
print(f"UNGRADED: {len(u):>3} points, max theta = {max((r[2] for r in u), default=0):.6f}"
      f"   (sqrt(3/2) = {SQ32:.6f})")
if u:
    u_sorted = sorted(u, key=lambda r: r[4])
    print("\nungraded frontier (sorted by slack):")
    for n, label, th, d2, S, _ in u_sorted:
        print(f"   S={S:>10.6f}   theta={th:.6f}   {label} (n={n})")
