"""Reviewer 46, T3 continued: a census of coordinate-diagonal critical points
by negative-support graph, and the full triangle-free strongly-regular list.

For a coordinate-diagonal Weyl operator the whole problem lives on the n x n
vertex matrix Lambda (hollow, symmetric, zero row sums), and criticality is
    lambda_ij^2 + (Lambda^2)_ij = theta lambda_ij   for all i != j.
S = 0 iff the negative-support graph is triangle free; graded iff it is a cut.
"""
import itertools
import numpy as np
from scipy.optimize import least_squares
from review_r46_t3_hunt import triangle_free, is_cut


def residual(n, x):
    lam = np.zeros((n, n))
    k = 0
    for i in range(n):
        for j in range(i + 1, n):
            lam[i, j] = lam[j, i] = x[k]
            k += 1
    L2 = lam @ lam
    num = den = 0.0
    for i in range(n):
        for j in range(n):
            if i != j:
                num += (lam[i, j] ** 2 + L2[i, j]) * lam[i, j]
                den += lam[i, j] ** 2
    th = num / max(den, 1e-300)
    r = []
    for i in range(n):
        for j in range(i + 1, n):
            r.append(lam[i, j] ** 2 + L2[i, j] - th * lam[i, j])
    r += list(lam.sum(axis=1))
    r.append(0.5 * den - 1.0)
    return np.array(r), lam, th


def hunt(n, tries, seed=0):
    rng = np.random.default_rng(seed)
    m = n * (n - 1) // 2
    found = []
    for t in range(tries):
        x0 = rng.normal(size=m)
        x0 /= np.linalg.norm(x0)
        sol = least_squares(lambda x: residual(n, x)[0], x0, xtol=1e-14,
                            ftol=1e-14, gtol=1e-14, max_nfev=4000)
        r, lam, th = residual(n, sol.x)
        if np.abs(r).max() > 1e-10:
            continue
        # normalise the operator: ||W||^2 = sum_{i<j} lambda_ij^2 = 1 by the last residual
        E = {(i, j) for i in range(n) for j in range(i + 1, n) if lam[i, j] < -1e-9}
        nz = sum(1 for i in range(n) for j in range(i + 1, n) if abs(lam[i, j]) <= 1e-9)
        if th < 0:
            lam, th = -lam, -th
            E = {(i, j) for i in range(n) for j in range(i + 1, n) if lam[i, j] < -1e-9}
        found.append(dict(theta=th, E=E, dm=len(E), tf=triangle_free(n, E),
                          cut=is_cut(n, E), zeros=nz, lam=lam))
    return found


def summarize(n, found):
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    buckets = {}
    for f in found:
        key = (round(f['theta'], 9), f['dm'], f['tf'], f['cut'])
        buckets.setdefault(key, 0)
        buckets[key] += 1
    print(f"n={n}: {len(found)} converged diagonal critical points, "
          f"{len(buckets)} distinct (theta, dim m, trianglefree, cut) classes; theta_0={th0:.6f}")
    rows = sorted(buckets.items(), key=lambda kv: -kv[0][0])
    print(f"   {'theta':>13} {'dim m':>6} {'S=0':>5} {'graded':>7} {'count':>6}")
    for (th, dm, tf, cut), cnt in rows[:24]:
        print(f"   {th:13.9f} {dm:6d} {str(tf):>5} {str(cut):>7} {cnt:6d}")
    ung = [k for k in buckets if k[2] and not k[3]]
    if ung:
        best = max(ung, key=lambda k: k[0])
        print(f"   -> best UNGRADED-with-S=0 diagonal point: theta={best[0]:.9f} "
              f"(theta/theta_0={best[0]/th0:.4f}), dim m={best[1]}")
    else:
        print("   -> no ungraded S=0 diagonal point in this sample")
    print()


TF_SRG = [  # (n, k, lambda, mu) triangle-free strongly regular graphs
    ("C_5",              5,  2, 0, 1),
    ("Petersen",        10,  3, 0, 1),
    ("Clebsch",         16,  5, 0, 2),
    ("Hoffman-Singleton", 50, 7, 0, 1),
    ("Gewirtz",         56, 10, 0, 2),
    ("M22 graph",       77, 16, 0, 4),
    ("Higman-Sims",    100, 22, 0, 6),
]


def srg_theta(n, d, lam_p, mu):
    """Closed form for the two-value diagonal point on an SRG, at the
    vertex-matrix level only (no Lambda^2 needed)."""
    beta = 1.0
    alpha = -(n - 1 - d) * beta / d
    g = alpha - beta
    edge = alpha ** 2 + g * g * lam_p + g * beta * (2 * d - 2) + beta ** 2 * (n - 2)
    nonedge = beta ** 2 + g * g * mu + 2 * g * beta * d + beta ** 2 * (n - 2)
    th_e, th_n = edge / alpha, nonedge / beta
    E = n * d // 2
    nrm = np.sqrt(E * alpha ** 2 + (n * (n - 1) // 2 - E) * beta ** 2)
    return alpha, th_e, th_n, E, th_e / nrm


if __name__ == "__main__":
    print("=== triangle-free strongly regular graphs: the full known list ===")
    print("(all are non-bipartite, hence not cuts, hence UNGRADED, while")
    print(" triangle-freeness makes S = 0 exactly)")
    print(f"{'graph':20s} {'n':>4} {'k':>3} {'mu':>3} {'dim m':>6} {'C(dim m,3)':>11} "
          f"{'theta':>10} {'theta_0':>9} {'ratio':>7} {'consistent':>10}")
    for (name, n, d, lp, mu) in TF_SRG:
        alpha, th_e, th_n, E, th = srg_theta(n, d, lp, mu)
        th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
        print(f"{name:20s} {n:4d} {d:3d} {mu:3d} {E:6d} {E*(E-1)*(E-2)//6:11d} "
              f"{th:10.6f} {th0:9.6f} {th/th0:7.4f} {str(abs(th_e-th_n)<1e-12):>10}")
    print()

    print("=== census of coordinate-diagonal critical points by graph type ===")
    for n, tries, seed in ((8, 300, 1), (10, 250, 2), (12, 200, 3)):
        summarize(n, hunt(n, tries, seed))
