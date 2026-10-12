"""H2 / H3: the closed form on sphere products, derived and then checked out of sample.

Derivation (see report): with W the two-block Weyl tensor of S^p x S^q, everything is
diagonal in the omega basis and the whole computation is elementary.
  H3 (mixed A = E_uv + E_vu, u in P, v in Q): Pi_Weyl H_A is proportional to the ORBIT
  tangent [D_X, W] for the skew X = E_vu - E_uv, with ratio (q(q-1) - p(p-1)) / (p+q-2).
  Hence L_e = 1/2 automatically for p != q, and Pi_Weyl H_A = 0 for p = q -- while H_A itself
  is NOT zero, it is the pure-Ricci direction (2s/(n-2)) D_A.
"""
import sys, os, time
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from core import Geom
from points import sphere_product
from le import build_weyl, Le_matrix, HA_span, compression, sym0_basis
from run_h1 import log


def orbit_tangent(g, W, B, sv):
    cols = []
    for a in range(g.N):
        v = np.zeros(g.N); v[a] = 1.0
        DX = g.D(g.to_mat(v))
        cols.append(B.T @ sv.vec(DX @ W - W @ DX))
    return np.array(cols).T


def check(p, q):
    n = p + q
    g, W = sphere_product(p, q)
    B, sv = build_weyl(g)
    th = g.P(W)
    Le = Le_matrix(g, W, B, sv, th)
    C, As = HA_span(g, W, B, sv)
    U, M, _ = compression(Le, C)
    ev = np.round(np.linalg.eigvalsh(0.5 * (M + M.T)), 9)
    u, c = np.unique(ev, return_counts=True)
    pred = sorted({(p - 2) / (2.0 * (p - 1)), (q - 2) / (2.0 * (q - 1))} | ({0.5} if p != q else set()))
    # H3 / orbit test on ONE mixed generator
    A = np.zeros((n, n)); A[0, p] = A[p, 0] = 1 / np.sqrt(2.0)
    Hm = g.H(W, A)
    Hw = sv.mat(B @ (B.T @ sv.vec(0.5 * (Hm + Hm.T))))
    X = np.zeros((n, n)); X[0, p] = -1.0; X[p, 0] = 1.0
    DX = g.D(X); O = DX @ W - W @ DX
    nO, nHw, nH = np.linalg.norm(O), np.linalg.norm(Hw), np.linalg.norm(Hm)
    if nHw > 1e-10 and nO > 1e-10:
        cosang = abs(np.sum(Hw * O)) / (nHw * nO)
    else:
        cosang = float('nan')
    ratio_pred = (q * (q - 1) - p * (p - 1)) / float(n - 2)
    # predicted scalar between Pi_Weyl H_A and O, using the derived formulas
    log(f"S{p}xS{q:<2d} n={n:2d} theta={th:.6f} spec=" +
        ", ".join(f"{a:.6f}x{b}" for a, b in zip(u, c)) +
        f" | pred {[round(x,6) for x in pred]}"
        f" | mixed: |H_A|={nH:.4f} |Pi_W H_A|={nHw:.2e} <Pi_W H_A, orbit> cos={cosang:.12f}"
        f" (pred ratio numerator {ratio_pred:+.4f})")


if __name__ == '__main__':
    log("[p3] H2/H3 out-of-sample sweep")
    for (p, q) in [(2, 4), (2, 6), (3, 4), (3, 5), (3, 6), (4, 5), (4, 6), (5, 6), (3, 8),
                   (4, 7), (6, 7), (3, 3), (4, 4), (5, 5), (6, 6), (2, 2), (2, 3), (5, 7)]:
        check(p, q)
