"""Claims 1 and 2: the min-entry lemma and the alleged extremiser.

Reduction. For K hollow symmetric with K1=0 and ||K||_F^2 = t, the quantity
|min K| scales linearly with K while t scales quadratically, so
    min { |min K| : ||K||_F^2 = t } = sqrt(t / N*(n)),
    N*(n) := max { ||K||_F^2 : K hollow symmetric, K1 = 0, K_ab >= -1 }.
The feasible set is a compact polytope and ||.||_F^2 is convex, so N* is
attained at a vertex.  Claim 1's proof gives N* <= n(n-1)(n-2).
"""
import numpy as np
from scipy.optimize import linprog
import itertools


def pairs(n):
    return [(a, b) for a in range(n) for b in range(a + 1, n)]


def polytope(n):
    """Variables x = (K_ab)_{a<b}.  Constraints: row sums zero, x >= -1."""
    P = pairs(n)
    A = np.zeros((n, len(P)))
    for idx, (a, b) in enumerate(P):
        A[a, idx] = 1.0
        A[b, idx] = 1.0
    return P, A


def frank_wolfe_max_norm(n, rng, iters=400):
    """Maximise the convex ||K||^2 over the polytope by repeated linearisation
    (each LP step lands on a vertex); many random starts."""
    P, A = polytope(n)
    m = len(P)
    bounds = [(-1.0, None)] * m
    x = rng.standard_normal(m)
    best = None
    for _ in range(iters):
        r = linprog(-2 * x, A_eq=A, b_eq=np.zeros(n), bounds=bounds,
                    method='highs')
        if not r.success:
            return None
        y = r.x
        if best is not None and np.allclose(y, x, atol=1e-9):
            break
        x = y
    return x


def norm2(n, x):
    return 2.0 * float(np.sum(np.asarray(x) ** 2))


def matching_K(n):
    """Perfect matching witness: K_ab = n-2 on a perfect matching, -1 else."""
    assert n % 2 == 0
    K = -np.ones((n, n)) + np.eye(n)
    for a in range(0, n, 2):
        K[a, a + 1] = K[a + 1, a] = n - 2.0
    np.fill_diagonal(K, 0.0)
    return K


def two_block_K(p, q):
    """Complete-bipartite-shaped K with cross entries -1."""
    n = p + q
    K = np.zeros((n, n))
    a1 = q / (p - 1.0) if p > 1 else 0.0
    a2 = p / (q - 1.0) if q > 1 else 0.0
    for a in range(n):
        for b in range(n):
            if a == b:
                continue
            if a < p and b < p:
                K[a, b] = a1
            elif a >= p and b >= p:
                K[a, b] = a2
            else:
                K[a, b] = -1.0
    return K


def report_K(n, K, name):
    off = K[~np.eye(n, dtype=bool)]
    t = float(np.sum(K ** 2))
    rs = np.abs(K.sum(axis=1)).max()
    m = abs(off.min()) * np.sqrt(2.0 / t)      # rescaled to t = 2
    print(f"  {name:28s} ||K||^2={t:10.4f} rowsum={rs:.1e} |minK| at t=2 : {m:.6f}")
    return m, t


if __name__ == '__main__':
    rng = np.random.default_rng(1051)
    print("Claim 1 bound at t=2 : sqrt(2/(n(n-1)(n-2)))")
    for n in (6, 7, 8, 9, 10, 12):
        cl1 = np.sqrt(2.0 / (n * (n - 1) * (n - 2)))
        print(f"\nn={n}   Claim-1 lower bound = {cl1:.6f}   "
              f"(N <= n(n-1)(n-2) = {n*(n-1)*(n-2)})")
        # sphere product (even n only)
        if n % 2 == 0:
            report_K(n, two_block_K(n // 2, n // 2), "balanced two-block (sphere)")
            report_K(n, matching_K(n), "perfect matching")
        for p in range(2, n // 2 + 1):
            if n - p > 1:
                report_K(n, two_block_K(p, n - p), f"two-block ({p},{n-p})")
        # numerical vertex search
        bestN, bestx = 0.0, None
        for _ in range(60):
            x = frank_wolfe_max_norm(n, rng)
            if x is None:
                continue
            v = norm2(n, x)
            if v > bestN:
                bestN, bestx = v, x
        print(f"  Frank-Wolfe vertex search: max ||K||^2 = {bestN:.4f}"
              f"   -> |minK| at t=2 = {np.sqrt(2.0/bestN):.6f}")
