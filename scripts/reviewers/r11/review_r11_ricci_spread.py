"""Is lambda_max(Ric(W-)) <= C t/n dimension-uniform?

The n eigenvalues of Ric(W-) are nonnegative and sum to 2t (t = tr W-), so their
mean is 2t/n and

    K := lambda_max * n / (2t)  >=  1   always,

with K = 1 exactly when Ric(W-) is scalar.  The proven bound lambda_max <= t is
K <= n/2, far too weak for the theta chain.  The question is whether K is
bounded uniformly in n, or grows.  This measures K across every critical point
constructible at n = 6..16, plus generic Levenberg-Marquardt points at n = 6, 8.
"""
import numpy as np
from weyl import build_structure_constants
from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, mop_from_4tensor, ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import build_su3_n8
from run_hpm_qk import qk_tensor
from run_unconstrained_search import build_weyl_basis
from review_r11_graded_law import unit, orient
from review_r11_ungraded_frontier import multiblock_weyl
from review_r11_slack_decomp import terms, lm_critical


def sphere_pair(L2, p):
    n = L2.n
    d = np.zeros(L2.N)
    for k, (i, j) in enumerate(L2.pairs):
        if i < p and j < p:   d[k] = 1.0 / (p - 1)
        elif i >= p and j >= p: d[k] = 1.0 / (n - p - 1)
    return weyl_from_mop(L2, np.diag(d))[0]


def K_of(L2, W, c):
    W = unit(np.asarray(W, float)); W, th = orient(W, c)
    ev, V = np.linalg.eigh(W); neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    t = float(np.trace(Wm)); R = ricci_from_mop(L2, Wm)
    rho = np.linalg.eigvalsh(R)
    return th, t, float(rho.max()) * L2.n / (2 * t), float(rho.min()) * L2.n / (2 * t)


print(f"{'n':>3} {'point':<22} {'theta':>9} {'K=lmax*n/2t':>12} {'kmin':>7}")
print("-" * 60)
best = {}
for n in (6, 8, 10, 12, 14, 16):
    idx, pos_, N, c = build_structure_constants(n)
    L2 = Lambda2(n); alt = build_alt_indices(L2)
    cands = []
    for p in range(2, n // 2 + 1):
        if n - p >= 2:
            cands.append((f"S^{p}xS^{n-p}", sphere_pair(L2, p)))
    for blocks in ([2, 2, n - 4], [3, 3, n - 6], [2, 2, 2, n - 6]):
        if all(b >= 2 for b in blocks) and sum(blocks) == n:
            Wb = multiblock_weyl(L2, blocks)
            if Wb is not None and np.linalg.norm(Wb) > 1e-9:
                cands.append((f"sph{tuple(blocks)}", Wb))
    if n % 4 == 0:
        cands.append((f"HP^{n//4}", weyl_from_mop(L2, mop_from_4tensor(L2, qk_tensor(n, n//4, 1., 1.)))[0]))
    if n == 8:
        cands.append(("SU(3)bi", build_su3_n8()[1]))
        for f, lab in (("scripts/data/defect_violation_n8_0.120000.npy", "3/25 violator"),
                       ("scripts/data/gap_band_point_n8.npy", "0.9008 witness")):
            try: cands.append((lab, np.load(f)))
            except Exception: pass
    if n in (6, 8):
        Eflat, D = build_weyl_basis(n, idx, pos_, N, c, verbose=False)
        got = 0
        for seed in range(30):
            if got >= 4: break
            W = lm_critical(n, c, Eflat, D, N, seed)
            th, S, T1, T2, T3, res = terms(L2, W, c, alt)
            if res > 1e-11 or abs(th) < 1e-3: continue
            got += 1; cands.append((f"generic LM #{got}", W))
    for label, W in cands:
        try: th, t, K, kmin = K_of(L2, W, c)
        except Exception: continue
        if t < 1e-9: continue
        best[n] = max(best.get(n, 0.0), K)
        print(f"{n:>3} {label:<22} {th:>9.5f} {K:>12.4f} {kmin:>7.4f}")
print("-" * 60)
print("max K by dimension:", {k: round(v, 4) for k, v in sorted(best.items())})
print("proven ceiling K <= n/2:", {k: k // 2 for k in sorted(best)})
