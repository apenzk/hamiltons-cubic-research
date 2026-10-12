"""r68: C5 -- is the requested sharper bound possible at all?

Builds S=0, traceless, unit-norm symmetric operators on so(n) whose theta EXCEEDS
max(sqrt(3/2), theta_0(n)).  Any bound valid on the whole S=0 class must be >= these
values, so no bound of the recorded kind (marginal/cap block estimates, which never
invoke the first Bianchi identity) can be pushed below the target.

Also reports the first-Bianchi residual, which is what separates these operators from
genuine Weyl operators.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from itertools import combinations
import review_r68_core as R
from review_r68_bounds import bounds


def bianchi_residual(n, W):
    """R_{ijkl} = W[(ij),(kl)] in the orthonormal phi basis; return ||b(R)|| / ||R||."""
    P = R.pairs(n)
    idx = {}
    for k, (i, j) in enumerate(P):
        idx[(i, j)] = (k, 1.0); idx[(j, i)] = (k, -1.0)
    def Rt(i, j, k, l):
        if i == j or k == l:
            return 0.0
        a, sa = idx[(i, j)]; b, sb = idx[(k, l)]
        return sa * sb * W[a, b]
    res = 0.0
    for (i, j, k, l) in combinations(range(n), 4):
        for perm in [(i, j, k, l), (i, k, j, l), (i, l, j, k), (j, k, i, l), (j, l, i, k), (k, l, i, j)]:
            pass
    # b(R)_{ijkl} = R_ijkl + R_iklj + R_iljk, only independent for i<j<k<l up to symmetry
    tot = 0.0
    for i in range(n):
        for j in range(n):
            for k in range(n):
                for l in range(n):
                    tot += (Rt(i, j, k, l) + Rt(i, k, l, j) + Rt(i, l, j, k))**2
    return np.sqrt(tot) / np.linalg.norm(W)


def sd_basis(n, quad=(0, 1, 2, 3)):
    P = R.pairs(n); idx = {p: k for k, p in enumerate(P)}; N = len(P)
    q = quad
    out = []
    for (a, b) in [((q[0], q[1]), (q[2], q[3])), ((q[0], q[2]), (q[3], q[1])), ((q[0], q[3]), (q[1], q[2]))]:
        v = np.zeros(N)
        for pr in (a, b):
            i, j = pr; s = 1.0
            if i > j:
                i, j = j, i; s = -1.0
            v[idx[(i, j)]] += s / np.sqrt(2)
        out.append(v)
    return out


def W_sd_split(n, k=4, coefs=(1.0, 1.0, 1.0)):
    """positives: a self-dual combination inside so(k); negatives: all mixed planes."""
    P = R.pairs(n); N = len(P)
    mixed = [t for t, (i, j) in enumerate(P) if (i < k) != (j < k)]
    W = np.zeros((N, N))
    tot = 0.0
    for c, v in zip(coefs, sd_basis(n)):
        W += c * np.outer(v, v); tot += c
    delta = tot / len(mixed)
    for t in mixed:
        W[t, t] -= delta
    return W / np.linalg.norm(W)


def W_subalg_split(n, k, spec_fn):
    """h = so(k) + so(n-k) (a subalgebra, so S_mhh = 0), m = mixed planes (isotropic)."""
    P = R.pairs(n); N = len(P)
    mixed = [t for t, (i, j) in enumerate(P) if (i < k) != (j < k)]
    inner = [t for t in range(N) if t not in set(mixed)]
    diag = np.zeros(N)
    vals = spec_fn(len(inner))
    for t, v in zip(inner, vals):
        diag[t] = v
    delta = diag.sum() / len(mixed)
    for t in mixed:
        diag[t] = -delta
    return np.diag(diag / np.linalg.norm(diag))


if __name__ == '__main__':
    print("=== operators with S_mmm = 0, trace 0, unit norm, and theta above the target ===")
    for n in [6, 8, 10, 12]:
        C = R.struct(n)
        th0 = ((n - 1) / n) * np.sqrt(2 * (n - 2) / (n - 1))
        target = max(np.sqrt(1.5), th0)
        cands = {
            'SD-triple / mixed-negative (k=4)': W_sd_split(n, 4),
            'single so(3) triangle / mixed-neg': W_subalg_split(n, 4, lambda L: np.array([1.0 if t < 3 else 0.0 for t in range(L)])),
            'balanced sphere product': R.sphere_product(n, n // 2),
            'padded CP^2': R.padded_cp2(n),
        }
        for name, W in cands.items():
            an = R.analyse(n, W, C)
            bd = bounds(an['lam'], n)
            print(f" n={n:3d} {name:36s} theta={an['theta']:9.6f} target={target:8.6f} "
                  f"S_mmm={an['S']['mmm']:8.2e} S_mhh={an['S']['mhh']:8.2f} d={an['d']:3d} "
                  f"bounds a/b/c = {bd['a']:9.4f}/{bd['b']:9.4f}/{bd['c']:9.4f} "
                  f"valid: {min(bd['a'],bd['b'],bd['c']) >= an['theta'] - 1e-9}")
    print()
    print("=== first-Bianchi residual (0 <=> genuine algebraic curvature operator) ===")
    for n in [6]:
        for name, W in [('padded CP^2', R.padded_cp2(n)),
                        ('balanced sphere product', R.sphere_product(n, n // 2)),
                        ('SD-triple / mixed-negative', W_sd_split(n, 4))]:
            print(f" n={n} {name:28s} ||b(R)||/||R|| = {bianchi_residual(n, W):.3e}")
