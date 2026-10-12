"""Reviewer 65 / C6(a): is S = 0 invisible to the bracket-transportation LP?

The relaxation (findings/INDEX.md, "the bracket-transportation relaxation"): with lambda the
Weyl eigenvalues, treat T_{abc} = c'^2_{abc} as a free nonnegative totally symmetric
tensor obeying only
    row marginal   sum_{b<c} T_{abc} = n-2       (i.e. sum_{b,c} T_{abc} = 2(n-2))
    pair cap       sum_c T_{abc} <= 2
and maximise  theta(T) = sum_a lam_a^3 + 3 sum_{a<b<c} T_{abc} lam_a lam_b lam_c.

Claim under test: every optimum puts zero mass on triples of NEGATIVE indices, so
adding the constraint S = 0 (T = 0 there) does not move the optimum.
Test: solve the LP with and without that constraint for many spectra and compare.
"""
import sys, itertools
import numpy as np
from scipy.optimize import linprog


def build(N, n, lam, kill_neg=False):
    tri = list(itertools.combinations(range(N), 3))
    pos = {t: i for i, t in enumerate(tri)}
    c = np.array([-3.0 * lam[a] * lam[b] * lam[g] for (a, b, g) in tri])  # minimise -theta
    Aeq = np.zeros((N, len(tri)))
    for t, (a, b, g) in enumerate(tri):
        Aeq[a, t] = Aeq[b, t] = Aeq[g, t] = 1.0
    beq = np.full(N, float(n - 2))
    pairs = list(itertools.combinations(range(N), 2))
    Aub = np.zeros((len(pairs), len(tri)))
    for r, (a, b) in enumerate(pairs):
        for g in range(N):
            if g != a and g != b:
                Aub[r, pos[tuple(sorted((a, b, g)))]] = 1.0
    bub = np.full(len(pairs), 2.0)
    ub = np.full(len(tri), None, dtype=object)
    bounds = []
    for t, (a, b, g) in enumerate(tri):
        if kill_neg and lam[a] < 0 and lam[b] < 0 and lam[g] < 0:
            bounds.append((0.0, 0.0))
        else:
            bounds.append((0.0, None))
    return tri, c, Aeq, beq, Aub, bub, bounds


def solve(N, n, lam, kill_neg=False):
    tri, c, Aeq, beq, Aub, bub, bounds = build(N, n, lam, kill_neg)
    r = linprog(c, A_ub=Aub, b_ub=bub, A_eq=Aeq, b_eq=beq, bounds=bounds, method="highs")
    if not r.success:
        return None, None, None
    theta = float((lam ** 3).sum() - r.fun)
    negmass = sum(r.x[t] for t, (a, b, g) in enumerate(tri)
                  if lam[a] < 0 and lam[b] < 0 and lam[g] < 0)
    return theta, negmass, r.x


if __name__ == "__main__":
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 6
    N = n * (n - 1) // 2
    rng = np.random.default_rng(6506)
    print(f"n={n}  N={N}   LP with / without the S=0 constraint\n")
    print(f"{'#neg':>4} {'theta_free':>12} {'(---) mass':>11} {'theta_S=0':>12} {'gap':>10}")
    for trial in range(20):
        k = 3 + trial % 6
        neg = -np.abs(rng.standard_normal(k)) - 0.2
        pos = np.abs(rng.standard_normal(N - k)) + 0.2
        pos *= (-neg.sum()) / pos.sum()
        lam = np.concatenate([neg, pos])
        lam /= np.linalg.norm(lam)
        assert (lam < 0).sum() == k and abs(lam.sum()) < 1e-12
        t0, nm, _ = solve(N, n, lam, False)
        t1, _, _ = solve(N, n, lam, True)
        if t0 is None or t1 is None:
            print("   LP failed")
            continue
        print(f"{k:>4} {t0:>12.6f} {nm:>11.3e} {t1:>12.6f} {t0-t1:>10.2e}")
