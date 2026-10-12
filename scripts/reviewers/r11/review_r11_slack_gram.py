"""P1 step (ii), first move: does the (GC) slack have a closed Gram form?

The proof route for the crux is: expand

    S = ||Ric(W-)||^2 + 6 delta^2 - theta tr(W-) - tr(W-^2)  >= 0

as the sum of bracket terms that the (GC) derivation throws away, then feed that
back in to get theta <= (trace data) - c S.  That route lives or dies on S having
such a form.  This tests it directly, by regressing S against candidate Gram sums
built from the eigen-decomposition of W.

With W v_i = -mu_i v_i on E- (mu_i > 0) and W u_a = nu_a u_a on E+, the natural
candidates from the #-positivity step ((uu^T)#(vv^T) = 1/2 [u,v][u,v]^T) are

    G1 = sum_{i,j} mu_i mu_j ||P_{E-}[v_i,v_j]||^2      (weighted, E- only)
    G2 = sum_{i,j}          ||P_{E-}[v_i,v_j]||^2       (unweighted)
    G3 = sum_{i,j} mu_i mu_j ||[v_i,v_j]||^2            (no projection)
    G4 = sum_{a,i} nu_a mu_i ||P_{E-}[u_a,v_i]||^2      (cross term)

A clean identity S = c*Gk (or a fixed combination) opens the route; no relation
means the slack is not bracket-local and the route needs rethinking.

Only points with a spectral gap at zero are used: the n=12 episode showed that a
merely-numerical kernel gets split arbitrarily between E+ and E-, which corrupts
every bracket quantity here.
"""
import numpy as np
from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, mop_from_4tensor, ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad, build_su3_n8
from run_hpm_qk import qk_tensor
from review_r11_graded_law import unit, orient
from review_r11_ungraded_frontier import multiblock_weyl

TOL_GAP = 1e-3          # spectral-gap screen at zero


def parts(L2, W, c, alt):
    QW = Q_full(W, c); th = float(np.sum(W * QW))
    ev, V = np.linalg.eigh(W)
    small = np.abs(ev) < TOL_GAP
    gap_ok = not small.any() or np.abs(ev[small]).max() < 1e-11
    neg = ev < -TOL_GAP; pos = ev > TOL_GAP
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    d2 = delta2_and_grad(W, alt)[0]
    r = ricci_from_mop(L2, Wm)
    S = (float(np.sum(r * r)) + 6 * d2 - th * float(np.trace(Wm))
         - float(np.trace(Wm @ Wm)))
    return th, S, ev, V, neg, pos, gap_ok


def grams(L2, ev, V, neg, pos):
    vs = [L2.vec_to_matrix(V[:, i]) for i in np.where(neg)[0]]
    us = [L2.vec_to_matrix(V[:, i]) for i in np.where(pos)[0]]
    mu = -ev[neg]; nu = ev[pos]
    Cn = V[:, neg]; Pm = Cn @ Cn.T
    G1 = G2 = G3 = G4 = 0.0
    for i, X in enumerate(vs):
        for j, Y in enumerate(vs):
            v = L2.matrix_to_vec(X @ Y - Y @ X)
            pn = float(v @ (Pm @ v)); full = float(v @ v)
            G1 += mu[i] * mu[j] * pn
            G2 += pn
            G3 += mu[i] * mu[j] * full
    for a, U in enumerate(us):
        for i, X in enumerate(vs):
            v = L2.matrix_to_vec(U @ X - X @ U)
            G4 += nu[a] * mu[i] * float(v @ (Pm @ v))
    return G1, G2, G3, G4


rows = []
for n in (6, 8, 12):
    idx, pos_, N, c = build_structure_constants(n)
    L2 = Lambda2(n); alt = build_alt_indices(L2)
    cands = []
    for blocks in ([2, 2, n - 4], [3, 3, n - 6], [2, 2, 2, n - 6]):
        if all(b >= 2 for b in blocks) and sum(blocks) == n:
            Wb = multiblock_weyl(L2, blocks)
            if Wb is not None and np.linalg.norm(Wb) > 1e-9:
                cands.append((f"sphere {tuple(blocks)}", Wb))
    if n % 4 == 0:
        cands.append((f"HP^{n//4}", weyl_from_mop(L2, mop_from_4tensor(L2, qk_tensor(n, n // 4, 1.0, 1.0)))[0]))
    if n == 8:
        cands.append(("SU(3) bi-invariant", build_su3_n8()[1]))
        try:
            cands.append(("gap point n=8", np.load("scripts/data/gap_band_point_n8.npy")))
        except Exception:
            pass
    for label, W in cands:
        W = unit(np.asarray(W, dtype=float)); W, th0 = orient(W, c)
        th, S, ev, V, neg, pos, gap_ok = parts(L2, W, c, alt)
        if not gap_ok or S < 1e-8:
            continue
        G = grams(L2, ev, V, neg, pos)
        rows.append((n, label, th, S, *G))

print(f"{'n':>3} {'point':<22} {'theta':>9} {'S':>10} {'G1':>10} {'G2':>10} {'G3':>10} {'G4':>10}"
      f" {'S/G1':>8}")
print("-" * 100)
for n, label, th, S, G1, G2, G3, G4 in rows:
    print(f"{n:>3} {label:<22} {th:>9.5f} {S:>10.5f} {G1:>10.5f} {G2:>10.5f} {G3:>10.5f} {G4:>10.5f}"
          f" {S/G1 if G1 else float('nan'):>8.4f}")

if len(rows) >= 4:
    A = np.array([[r[4], r[5], r[6], r[7]] for r in rows])
    b = np.array([r[3] for r in rows])
    for name, cols in (("G1", [0]), ("G1,G4", [0, 3]), ("G1,G2,G3,G4", [0, 1, 2, 3])):
        M = A[:, cols]
        coef, *_ = np.linalg.lstsq(M, b, rcond=None)
        resid = np.linalg.norm(M @ coef - b) / max(np.linalg.norm(b), 1e-300)
        print(f"\nfit S ~ {name}: coefficients {np.round(coef, 6)}  relative residual {resid:.3e}"
              f"   {'<-- CLEAN' if resid < 1e-8 else ''}")
