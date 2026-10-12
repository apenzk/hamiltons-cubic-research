"""Reviewer 62: independent implementation of LP(lam) and G(lam), and adversarial maximisation of G.

G(lam) = sum lam^3 + max{ 3 sum_{a<b<g} T_abg lam_a lam_b lam_g : T >= 0, sum_g T_abg <= 2 }
over the support (2 negatives + k positives).  LP(lam) adds the row marginals
sum_{b<g} T_abg = m-2 over the FULL index set of size N = C(m,2).
"""
import numpy as np, itertools
from scipy.optimize import linprog


def G_lp(lam):
    """G by a direct LP over all triples of the given (support) spectrum."""
    n = len(lam)
    tri = list(itertools.combinations(range(n), 3))
    c = np.array([-3.0 * lam[a] * lam[b] * lam[g] for (a, b, g) in tri])
    pairs = list(itertools.combinations(range(n), 2))
    pidx = {p: t for t, p in enumerate(pairs)}
    A = np.zeros((len(pairs), len(tri)))
    for t, (a, b, g) in enumerate(tri):
        for p in ((a, b), (a, g), (b, g)):
            A[pidx[p], t] = 1.0
    res = linprog(c, A_ub=A, b_ub=2.0 * np.ones(len(pairs)),
                  bounds=[(0, None)] * len(tri), method='highs')
    assert res.status == 0, res.message
    return float(np.sum(lam ** 3) - res.fun), res


def FTP(x):
    """max fractional triangle packing sum T_abg x_a x_b x_g, edge caps 2, on k positives."""
    k = len(x)
    if k < 3:
        return 0.0
    tri = list(itertools.combinations(range(k), 3))
    c = np.array([-x[a] * x[b] * x[g] for (a, b, g) in tri])
    pairs = list(itertools.combinations(range(k), 2))
    pidx = {p: t for t, p in enumerate(pairs)}
    A = np.zeros((len(pairs), len(tri)))
    for t, (a, b, g) in enumerate(tri):
        for p in ((a, b), (a, g), (b, g)):
            A[pidx[p], t] = 1.0
    res = linprog(c, A_ub=A, b_ub=2.0 * np.ones(len(pairs)),
                  bounds=[(0, None)] * len(tri), method='highs')
    assert res.status == 0
    return -float(res.fun)


def G_closed(x):
    """Closed form after decoupling: x = positive part (any order), b,c implied.
    Returns -inf if (b,c) are not real and positive."""
    x = np.asarray(x, float)
    s = x.sum(); u = (x ** 2).sum()
    bc = 0.5 * (s * s + u - 1.0)
    disc = 2.0 * (1.0 - u) - s * s
    if bc < -1e-14 or disc < -1e-14 or u >= 1.0:
        return -np.inf
    bc = max(bc, 0.0)
    return float((x ** 3).sum() + 3.0 * FTP(x) - s ** 3 + 3.0 * bc * (s + 2.0 * x.max()))


def spectrum_from_x(x):
    x = np.asarray(x, float)
    s = x.sum(); u = (x ** 2).sum()
    disc = 2.0 * (1.0 - u) - s * s
    b = 0.5 * (s + np.sqrt(max(disc, 0.0)))
    c = 0.5 * (s - np.sqrt(max(disc, 0.0)))
    return np.concatenate([x, [-b, -c]]), b, c


def LP_full(lam_support, m):
    """The full transportation LP with row marginals = m-2 on N=C(m,2) indices,
    the support padded with zeros."""
    N = m * (m - 1) // 2
    lam = np.zeros(N)
    lam[:len(lam_support)] = lam_support
    tri = list(itertools.combinations(range(N), 3))
    c = np.array([-3.0 * lam[a] * lam[b] * lam[g] for (a, b, g) in tri])
    pairs = list(itertools.combinations(range(N), 2))
    pidx = {p: t for t, p in enumerate(pairs)}
    A_ub = np.zeros((len(pairs), len(tri)))
    for t, (a, b, g) in enumerate(tri):
        for p in ((a, b), (a, g), (b, g)):
            A_ub[pidx[p], t] = 1.0
    A_eq = np.zeros((N, len(tri)))
    for t, (a, b, g) in enumerate(tri):
        A_eq[a, t] = A_eq[b, t] = A_eq[g, t] = 1.0
    res = linprog(c, A_ub=A_ub, b_ub=2.0 * np.ones(len(pairs)),
                  A_eq=A_eq, b_eq=(m - 2) * np.ones(N),
                  bounds=[(0, None)] * len(tri), method='highs')
    if res.status != 0:
        return None
    return float(np.sum(lam ** 3) - res.fun)
