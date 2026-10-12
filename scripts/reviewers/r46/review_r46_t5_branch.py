"""Reviewer 46, T5 continued: does a genuine branch of critical points leave a
degenerate critical point, and does the slack change along it?

Slice corrector.  Unknowns are the Weyl coordinates of W.  Residuals:
    Q(W) - P(W) W                       (criticality, projected to Weyl)
    |W|^2 - 1                           (unit norm)
    <W - W0, t_j> = 0 for every orbit tangent t_j   (gauge fixing: stay in a
                                                     slice transverse to the orbit)
    |W - W0|^2 - eps^2                  (arc length: forbid falling back to W0)
A converged solve with tiny criticality residual is a critical point at
distance eps from W0 in the slice; S is then read off there.
"""
import numpy as np
from scipy.optimize import least_squares
from review_r46_core import (structure_constants, weyl_basis, Q_of, P_of,
                             slack_weighted, slack_structural, slack_hhm)
from review_r46_t4_nondeg import orbit_tangent
from review_r46_t5_localconst import survey


def corrector(n, c, B, flat, W0, v, eps, Ovt):
    K = B.shape[0]
    y0 = flat @ (W0 + eps * v).ravel()

    from review_r46_t4_nondeg import make_Le
    yb = flat @ W0.ravel()
    Ocoord = Ovt @ flat.T

    def res(y):
        W = np.einsum('k,kij->ij', y, B)
        th = P_of(c, W)
        G = Q_of(c, W) - th * W
        r = [flat @ G.ravel()]
        r.append([float(np.sum(W * W)) - 1.0])
        dW = (W - W0).ravel()
        r.append(Ovt @ dW)
        r.append([float(dW @ dW) - eps ** 2])
        return np.concatenate([np.asarray(x, dtype=float).ravel() for x in r])

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
        return np.vstack([J1, 2.0 * y[None, :], Ocoord, 2.0 * (y - yb)[None, :]])

    sol = least_squares(res, y0, jac=jac, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=600)
    W = np.einsum('k,kij->ij', sol.x, B)
    th = P_of(c, W)
    crit = np.abs(Q_of(c, W) - th * W).max()
    dist = np.linalg.norm(W - W0)
    return W, th, crit, dist, np.abs(res(sol.x)).max()


if __name__ == "__main__":
    n = 8
    results = survey(n)
    c = structure_constants(n)
    B = weyl_basis(n)
    flat = B.reshape(B.shape[0], -1)
    print()
    print("=== slice corrector: is there a branch of Crit off the orbit? ===")
    print(f"{'point':20s} {'eps':>6} {'dir':>4} {'crit.res':>10} {'dist':>8} "
          f"{'theta':>13} {'S_w':>12} {'S_mmm':>11}")
    rng = np.random.default_rng(0)
    for name, (W0, d) in results.items():
        ex = d['extra']
        if ex.shape[0] == 0:
            continue
        Ovt, orb = orbit_tangent(n, W0)
        S0 = slack_weighted(c, W0)
        if 'plateau' not in name:
            continue
        picks = list(range(min(3, ex.shape[0])))
        # also a random combination of the extra directions
        for eps in (0.05, 0.10):
            for pi in picks + ['rand']:
                if pi == 'rand':
                    coef = rng.normal(size=ex.shape[0])
                    v = np.einsum('k,kc->c', coef, ex).reshape(W0.shape)
                else:
                    v = ex[pi].reshape(W0.shape)
                v = 0.5 * (v + v.T)
                v /= np.linalg.norm(v)
                W, th, crit, dist, rmax = corrector(n, c, B, flat, W0, v, eps, Ovt)
                tag = 'rand' if pi == 'rand' else str(pi)
                flag = "  <== BRANCH" if (crit < 1e-11 and rmax < 1e-9 and dist > 0.5 * eps) else ""
                print(f"{name:20s} {eps:6.3f} {tag:>4} {crit:10.2e} {dist:8.4f} "
                      f"{th:13.9f} {slack_weighted(c, W):12.6e} "
                      f"{slack_structural(c, W):11.3e}{flag}")
        print(f"{name:20s}  (base point: theta={d['theta']:.9f}, S_w={S0:.6e})")
