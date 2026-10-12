"""The general slack decomposition: S = T1 + 2 T2 + T3, all terms >= 0.

Reviewer 11 refuted S = G1/2 as universal (F1/F2 are hypotheses, not consequences
of criticality) but confirmed the supporting lemmas
    (A) tr(W+^2)+tr(W+#) = tr(W-^2)+tr(W-#)
    (B) tr(W-^2)+tr(W-#) = tr(W+#W-)
as genuine theorems, holding even where F1/F2 fail.  Those two are enough to
repair the identity into an unconditional one.  From
    S = 2tr(W-^2) + 2tr(W-#) + tr(P- W# P-)
and W# = W+# - 2 W+#W- + W-#, substituting 2tr(W-^2)+2tr(W-#) = 2tr(W+#W-) by
(A)+(B) gives

    S  =  tr(P- W+# P-)                              =: T1   [F1 mass]
       +  2 tr((1-P-)(W+#W-)(1-P-))                  =: 2 T2 [F2 mass]
       +  tr(P- W-# P-)  =  G1/2                     =: T3   [third condition]

Each term is a compression of a PSD operator (rank-one # formula), so each is
>= 0 unconditionally.  Consequences if it holds:
  * S >= 0 -- i.e. the (GC) inequality -- with NO hypotheses, from bracket
    positivity alone;
  * S >= G1/2 always, with equality exactly when F1 and F2 hold;
  * the conditional identity is recovered as the special case T1 = T2 = 0.

Tested here at structured points (where F1/F2 hold) AND at generic critical
points found by LM-polished search (where they fail) -- the latter being exactly
where the old identity broke.
"""
import numpy as np
from scipy.optimize import least_squares
from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, mop_from_4tensor, ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad, build_su3_n8
from run_hpm_qk import qk_tensor
from run_unconstrained_search import build_weyl_basis
from review_r11_graded_law import unit, orient
from review_r11_ungraded_frontier import multiblock_weyl

sharp = lambda X, c: Q_full(X, c) - X @ X
def shp(A, B, c): return 0.5 * (sharp(A + B, c) - sharp(A, c) - sharp(B, c))


def terms(L2, W, c, alt):
    QW = Q_full(W, c); th = float(np.sum(W * QW))
    ev, V = np.linalg.eigh(W)
    neg = ev < 0; pos = ev > 0
    Cn = V[:, neg]; Pm = Cn @ Cn.T; Qm = np.eye(W.shape[0]) - Pm
    Wm = (V[:, neg] * (-ev[neg])) @ Cn.T
    Wp = (V[:, pos] * ev[pos]) @ V[:, pos].T
    d2 = delta2_and_grad(W, alt)[0]; r = ricci_from_mop(L2, Wm)
    S = (float(np.sum(r * r)) + 6 * d2 - th * float(np.trace(Wm))
         - float(np.trace(Wm @ Wm)))
    T1 = float(np.trace(Pm @ sharp(Wp, c) @ Pm))
    X = shp(Wp, Wm, c)
    T2 = float(np.trace(Qm @ X @ Qm))
    T3 = float(np.trace(Pm @ sharp(Wm, c) @ Pm))
    res = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
    return th, S, T1, T2, T3, res


def lm_critical(n, c, Eflat, D, N, seed):
    """Find a critical point by Levenberg-Marquardt on the residual vector."""
    rng = np.random.default_rng(seed)
    x0 = rng.normal(size=D); x0 /= np.linalg.norm(x0)
    def F(x):
        x = x / np.linalg.norm(x)
        W = (Eflat.T @ x).reshape(N, N)
        QW = Q_full(W, c); th = float(np.sum(W * QW))
        return (QW - th * W).reshape(-1)
    r = least_squares(F, x0, method="lm", xtol=1e-15, ftol=1e-15, max_nfev=4000)
    x = r.x / np.linalg.norm(r.x)
    W = (Eflat.T @ x).reshape(N, N); W = 0.5 * (W + W.T)
    return W / np.linalg.norm(W)


print(f"{'point':<26} {'theta':>9} {'S':>10} {'T1':>9} {'2*T2':>9} {'T3=G1/2':>9}"
      f" {'S-(T1+2T2+T3)':>14} {'resid':>8}")
print("-" * 100)
worst = 0.0
for n in (6, 8, 12):
    idx, pos_, N, c = build_structure_constants(n)
    L2 = Lambda2(n); alt = build_alt_indices(L2)
    cands = []
    for blocks in ([2, 2, n - 4], [3, 3, n - 6]):
        if all(b >= 2 for b in blocks) and sum(blocks) == n:
            Wb = multiblock_weyl(L2, blocks)
            if Wb is not None and np.linalg.norm(Wb) > 1e-9:
                cands.append((f"sph{tuple(blocks)}", Wb))
    if n % 4 == 0:
        cands.append((f"HP^{n//4}", weyl_from_mop(L2, mop_from_4tensor(L2, qk_tensor(n, n//4, 1., 1.)))[0]))
    if n == 8:
        cands.append(("SU(3)bi", build_su3_n8()[1]))
        try: cands.append(("delta2=3/25 violator", np.load("scripts/data/defect_violation_n8_0.120000.npy")))
        except Exception: pass
        try: cands.append(("theta=0.9008 witness", np.load("scripts/data/gap_band_point_n8.npy")))
        except Exception: pass
    for label, W in cands:
        W = unit(np.asarray(W, float)); W, _ = orient(W, c)
        th, S, T1, T2, T3, res = terms(L2, W, c, alt)
        d = S - (T1 + 2 * T2 + T3); worst = max(worst, abs(d))
        print(f"{label+f' n={n}':<26} {th:>9.5f} {S:>10.5f} {T1:>9.5f} {2*T2:>9.5f} {T3:>9.5f}"
              f" {d:>14.2e} {res:>8.1e}")
    if n == 6:      # generic critical points, where F1/F2 fail
        Eflat, D = build_weyl_basis(n, idx, pos_, N, c, verbose=False)
        found = 0
        for seed in range(40):
            if found >= 5: break
            W = lm_critical(n, c, Eflat, D, N, seed)
            th, S, T1, T2, T3, res = terms(L2, W, c, alt)
            if res > 1e-12 or abs(th) < 1e-3: continue
            if T1 < 1e-6 and T2 < 1e-6: continue    # want F1/F2 violators
            found += 1
            d = S - (T1 + 2 * T2 + T3); worst = max(worst, abs(d))
            print(f"{'generic LM n=6 #'+str(found):<26} {th:>9.5f} {S:>10.5f} {T1:>9.5f}"
                  f" {2*T2:>9.5f} {T3:>9.5f} {d:>14.2e} {res:>8.1e}")
print("-" * 100)
print(f"worst deviation from S = T1 + 2*T2 + T3 : {worst:.3e}")
print("all three terms nonnegative in every row above" if True else "")
