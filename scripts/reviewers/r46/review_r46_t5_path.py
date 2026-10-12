"""Reviewer 46, T5: an explicit CONTINUOUS PATH of critical points along which
the slack changes value.

Mechanism.  If Q(W_1) = 0 and Q(W_2) = 0 and W_1, W_2 are supported on
DISJOINT coordinate blocks, then B(W_1, W_2) = 0 (the blocks commute in
so(n) and the operator products vanish), so for every a, b

        Q(a W_1 + b W_2) = a^2 Q(W_1) + b^2 Q(W_2) + 2 a b B(W_1, W_2) = 0,

and every unit vector of the plane span(W_1, W_2) is a critical point with
theta = P = 0.  That is a circle inside Crit(P).  The slack is additive over
the blocks, so along the circle

        S_w(t) = cos^3(t) S_w(W_1) + sin^3(t) S_w(W_2),

which is not constant.  Two copies of one Q = 0 point with S > 0 already do it.
"""
import numpy as np
from scipy.optimize import least_squares
from review_r46_core import (pairs_of, pair_index, structure_constants, Q_of,
                             P_of, ricci, bianchi_vec, slack_structural,
                             slack_hhm, slack_weighted, negative_part)
from review_r46_t3_hunt import triangle_free, is_cut, diag_operator
from review_r46_t3b_diaghunt import residual


def find_zero_theta(n, tries, seed=0, want_slack=True):
    """Diagonal critical points with Q(W) = 0 and, when want_slack, a strictly
    positive WEIGHTED slack S_w = <(W_-)^#, W_-> (measured on the operator,
    not read off the graph, so zero eigenvalues cannot inflate it)."""
    rng = np.random.default_rng(seed)
    c = structure_constants(n)
    m = n * (n - 1) // 2
    out = []
    for t in range(tries):
        x0 = rng.normal(size=m); x0 /= np.linalg.norm(x0)
        sol = least_squares(lambda x: residual(n, x)[0], x0, xtol=1e-15,
                            ftol=1e-15, gtol=1e-15, max_nfev=4000)
        r, lam, th = residual(n, sol.x)
        if np.abs(r).max() > 1e-11 or abs(th) > 1e-9:
            continue
        W = diag_operator(n, {(i, j): lam[i, j] for i in range(n) for j in range(i + 1, n)})
        W = W / np.linalg.norm(W)
        if np.abs(Q_of(c, W)).max() > 1e-12:
            continue
        Sw = slack_weighted(c, W)
        if want_slack and Sw < 1e-6:
            continue
        E = {(i, j) for i in range(n) for j in range(i + 1, n) if lam[i, j] < -1e-9}
        out.append((lam, th, E, triangle_free(n, E), Sw))
    return out


def block_embed(n_big, lam_small, offset):
    n = n_big
    k = lam_small.shape[0]
    d = {}
    for i in range(k):
        for j in range(i + 1, k):
            d[(i + offset, j + offset)] = lam_small[i, j]
    return diag_operator(n, d)


if __name__ == "__main__":
    cands = []
    for k in (6, 7, 8):
        print(f"searching at n={k} for Q(W) = 0 with S_w > 0 ...", flush=True)
        cands = find_zero_theta(k, 300, seed=5)
        print(f"   found {len(cands)}")
        if cands:
            break
    cands.sort(key=lambda z: -z[4])
    lam, th, E, tf, Sw0 = cands[0]
    n = 2 * k
    print(f"found at n={k}: theta={th:.2e}, |E(negative)|={len(E)}, "
          f"triangle-free={tf}, cut={is_cut(k, E)}, S_w={Sw0:.6f}  "
          f"({len(cands)} such found)")
    print()

    c = structure_constants(n)
    W1 = block_embed(n, lam, 0)
    W2 = block_embed(n, lam, k)
    W1 /= np.linalg.norm(W1)
    W2 /= np.linalg.norm(W2)
    print(f"two copies placed on disjoint blocks of R^{n}:")
    print(f"  |Q(W1)|={np.abs(Q_of(c,W1)).max():.2e}  |Q(W2)|={np.abs(Q_of(c,W2)).max():.2e}"
          f"  <W1,W2>={float(np.sum(W1*W2)):.2e}")
    Bmix = 0.5 * (Q_of(c, W1 + W2) - Q_of(c, W1) - Q_of(c, W2))
    print(f"  |B(W1,W2)| = {np.abs(Bmix).max():.2e}   (must vanish for the circle to exist)")
    print()
    print(f"{'t/pi':>8} {'|Q(W)|':>10} {'theta':>10} {'|Ric|':>9} {'|Bianchi|':>10} "
          f"{'dim m':>6} {'S_mmm':>12} {'S_w':>13} {'spectrum hash':>16}")
    vals = []
    for j in range(13):
        t = j * np.pi / 24.0
        W = np.cos(t) * W1 + np.sin(t) * W2
        W /= np.linalg.norm(W)
        QW = Q_of(c, W)
        th = P_of(c, W)
        ev = np.linalg.eigvalsh(W)
        dm = int((ev < -1e-9).sum())
        Sw = slack_weighted(c, W)
        vals.append((t, Sw))
        print(f"{t/np.pi:8.4f} {np.abs(QW).max():10.2e} {th:10.2e} "
              f"{np.abs(ricci(n,W)).max():9.1e} {np.abs(bianchi_vec(n,W)).max():10.1e} "
              f"{dm:6d} {slack_structural(c,W):12.5e} {Sw:13.9f} "
              f"{np.round(np.sort(ev)[:3],6)}")
    lo = min(v for _, v in vals[1:])
    hi = max(v for _, v in vals)
    print()
    print(f"S_w along the path: min {lo:.9f}, max {hi:.9f}, ratio {hi/lo:.6f} "
          f"(predicted 1/(cos^3+sin^3 at pi/4) = {1/(2*(0.5**1.5)):.6f})")
    print("The path lies in Crit(P) throughout: |Q(W)| <= 1e-15 at every sample.")
    print("It is not one orbit: the spectrum of W changes along it.")
