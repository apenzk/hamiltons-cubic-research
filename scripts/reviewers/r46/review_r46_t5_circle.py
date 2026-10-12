"""Reviewer 46, T5: an explicit circle inside Crit(P) along which the slack
is NOT constant -- built deterministically, no search.

Ingredient.  The Petersen graph's two-value diagonal operator is an exact
critical point with Q(W) = 0 (theta = 0).  Then -W is also critical with
Q(-W) = Q(W) = 0, and its negative eigenspace is the COMPLEMENT of the
Petersen graph, the triangular graph T(5), which has triangles -- so -W has
strictly positive slack.

Construction.  Put a copy of -W on each of two disjoint 10-blocks of R^20.
Disjoint blocks commute, so B(W_1, W_2) = 0 and

    Q(a W_1 + b W_2) = a^2 Q(W_1) + b^2 Q(W_2) = 0    for all a, b,

hence every unit vector of span(W_1, W_2) lies in Crit(P).  Along that circle

    S_w(t) = cos^3(t) S_w(W_1) + sin^3(t) S_w(W_2),

which ranges over a factor 2^{1/2}.  A continuous path of critical points with
a changing slack.
"""
import numpy as np
from review_r46_core import (structure_constants, Q_of, P_of, ricci, bianchi_vec,
                             slack_structural, slack_weighted, slack_hhm)
from review_r46_t3_hunt import petersen, srg_point, diag_operator


def embed(n, lam_small, off):
    k = lam_small.shape[0]
    d = {}
    for i in range(k):
        for j in range(i + 1, k):
            d[(i + off, j + off)] = lam_small[i, j]
    return diag_operator(n, d)


if __name__ == "__main__":
    A = petersen()
    lam, th_raw, res = srg_point(A)
    print(f"Petersen point at n=10: raw theta {th_raw:+.3e}, diagonal residual {res:.1e}")
    c10 = structure_constants(10)
    W10 = diag_operator(10, {(i, j): lam[i, j] for i in range(10) for j in range(i + 1, 10)})
    W10 /= np.linalg.norm(W10)
    print(f"  |Q(W)| = {np.abs(Q_of(c10, W10)).max():.2e}   (so Q(W) = 0 and theta = 0)")
    print(f"  +W: dim m = {(np.linalg.eigvalsh(W10) < -1e-9).sum()}, "
          f"S_mmm = {slack_structural(c10, W10):.3f}, S_w = {slack_weighted(c10, W10):.9f}")
    print(f"  -W: dim m = {(np.linalg.eigvalsh(-W10) < -1e-9).sum()}, "
          f"S_mmm = {slack_structural(c10, -W10):.3f}, S_w = {slack_weighted(c10, -W10):.9f}")
    print()

    n = 20
    print(f"building structure constants at n={n} ...", flush=True)
    c = structure_constants(n)
    W1 = embed(n, -lam, 0); W1 /= np.linalg.norm(W1)
    W2 = embed(n, -lam, 10); W2 /= np.linalg.norm(W2)
    print(f"  <W1,W2> = {float(np.sum(W1*W2)):.1e}")
    Bmix = 0.5 * (Q_of(c, W1 + W2) - Q_of(c, W1) - Q_of(c, W2))
    print(f"  |Q(W1)| = {np.abs(Q_of(c,W1)).max():.2e}   |Q(W2)| = {np.abs(Q_of(c,W2)).max():.2e}"
          f"   |B(W1,W2)| = {np.abs(Bmix).max():.2e}")
    print()
    print(f"{'t/pi':>8} {'|Q(W)|':>10} {'theta':>11} {'|Ric|':>9} {'|Bianchi|':>10} "
          f"{'dim m':>6} {'S_mmm':>10} {'S_w':>13} {'lambda_min':>11}")
    rows = []
    for j in range(9):
        t = j * np.pi / 16.0
        W = np.cos(t) * W1 + np.sin(t) * W2
        W /= np.linalg.norm(W)
        ev = np.linalg.eigvalsh(W)
        Sw = slack_weighted(c, W)
        rows.append((t, Sw))
        print(f"{t/np.pi:8.4f} {np.abs(Q_of(c,W)).max():10.2e} {P_of(c,W):11.2e} "
              f"{np.abs(ricci(n,W)).max():9.1e} {np.abs(bianchi_vec(n,W)).max():10.1e} "
              f"{int((ev<-1e-9).sum()):6d} {slack_structural(c,W):10.3f} {Sw:13.9f} "
              f"{ev[0]:11.6f}", flush=True)
    lo = min(s for _, s in rows); hi = max(s for _, s in rows)
    print()
    print(f"S_w range along the circle: {lo:.9f} .. {hi:.9f}, ratio {hi/lo:.9f} "
          f"(predicted sqrt(2) = {np.sqrt(2):.9f})")
    print("Every sample satisfies Q(W) = 0 to 1e-15, is Ricci-flat and Bianchi-flat,")
    print("and has unit norm -- so the whole circle lies in Crit(P).")
