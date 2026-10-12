"""Reviewer 46, T3 continued: an unbiased hunt for critical points in the FULL
Weyl space (not only the coordinate-diagonal locus), classifying each by
dim m, the structural slack S_mmm, and the grading leak S_hhm.

Also a control for the T5 derivative test: dS_w is measured along random Weyl
directions, to show that its vanishing on E(1/2) is not vacuous.
"""
import sys
import numpy as np
from scipy.optimize import least_squares
from review_r46_core import (structure_constants, weyl_basis, Q_of, P_of,
                             slack_structural, slack_hhm, slack_weighted)
from review_r46_t5_localconst import dSw


def hunt(n, tries, seed=0):
    c = structure_constants(n)
    B = weyl_basis(n)
    K = B.shape[0]
    flat = B.reshape(K, -1)
    rng = np.random.default_rng(seed)

    from review_r46_t4_nondeg import make_Le

    def res(y):
        W = np.einsum('k,kij->ij', y, B)
        th = P_of(c, W)
        G = Q_of(c, W) - th * W
        return np.concatenate([flat @ G.ravel(), [float(np.sum(W * W)) - 1.0]])

    def jac(y):
        W = np.einsum('k,kij->ij', y, B)
        QW = Q_of(c, W)
        th = float(np.sum(W * QW))
        q = flat @ QW.ravel()
        LW = make_Le(c, W)
        M = np.empty((K, K))
        for k in range(K):
            M[:, k] = flat @ LW(B[k]).ravel()
        J1 = 2.0 * M - 3.0 * np.outer(y, q) - th * np.eye(K)
        return np.vstack([J1, 2.0 * y[None, :]])

    out = []
    for t in range(tries):
        y0 = rng.normal(size=K)
        y0 /= np.linalg.norm(y0)
        sol = least_squares(res, y0, jac=jac, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=400)
        W = np.einsum('k,kij->ij', sol.x, B)
        th = P_of(c, W)
        crit = np.abs(Q_of(c, W) - th * W).max()
        if (t + 1) % 10 == 0:
            print(f"    ... {t+1}/{tries} starts, {len(out)} converged", flush=True)
        if crit > 1e-10 or abs(np.linalg.norm(W) - 1) > 1e-9:
            continue
        if th < 0:
            W, th = -W, -th
        ev = np.linalg.eigvalsh(W)
        out.append(dict(theta=th, dm=int((ev < -1e-9).sum()),
                        Smmm=slack_structural(c, W), Shhm=slack_hhm(c, W),
                        Sw=slack_weighted(c, W), W=W))
    return c, B, flat, out


if __name__ == "__main__":
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 8
    tries = int(sys.argv[2]) if len(sys.argv) > 2 else 120
    print(f"=== unbiased critical-point hunt in the full Weyl_{n} ===")
    c, B, flat, out = hunt(n, tries, seed=17)
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    print(f"{len(out)} converged critical points; theta_0({n}) = {th0:.6f}")
    zero = [o for o in out if o['Smmm'] < 1e-14]
    ung = [o for o in zero if o['Shhm'] > 1e-10]
    print(f"  with S_mmm = 0 : {len(zero)}     of those UNGRADED (S_hhm > 0): {len(ung)}")
    if zero:
        print(f"  {'theta':>13} {'th/th0':>7} {'dim m':>6} {'S_mmm':>11} {'S_hhm':>11} {'S_w':>11}")
        for o in sorted(zero, key=lambda o: -o['theta'])[:15]:
            print(f"  {o['theta']:13.9f} {o['theta']/th0:7.4f} {o['dm']:6d} "
                  f"{o['Smmm']:11.3e} {o['Shhm']:11.3e} {o['Sw']:11.3e}")
    print()
    top = sorted(out, key=lambda o: -o['theta'])[:12]
    print("  highest-theta points found (any slack):")
    print(f"  {'theta':>13} {'th/th0':>7} {'dim m':>6} {'S_mmm':>11} {'S_hhm':>11}")
    for o in top:
        print(f"  {o['theta']:13.9f} {o['theta']/th0:7.4f} {o['dm']:6d} "
              f"{o['Smmm']:11.3e} {o['Shhm']:11.3e}")
    print()
    print("  control: dS_w along RANDOM Weyl directions at three of these points")
    rng = np.random.default_rng(4)
    for o in out[:3]:
        vals = []
        for _ in range(8):
            v = np.einsum('k,kij->ij', rng.normal(size=B.shape[0]), B)
            vals.append(abs(dSw(n, c, o['W'], v.ravel())[0]))
        print(f"    theta={o['theta']:.6f}  S_w={o['Sw']:.4e}  "
              f"max|dS_w| over 8 random directions = {max(vals):.4e}")
