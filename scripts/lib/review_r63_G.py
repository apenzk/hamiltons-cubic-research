"""Reviewer 63 -- independent implementation of C4's G(lambda) and the full LP(lambda).

G(lam) = sum lam^3 + max{ 3 sum_{a<b<g} T_abg lam_a lam_b lam_g :
                          T >= 0, pair caps sum_g T_abg <= 2 }   (support indices only)
LP(lam) additionally imposes the row marginals sum_{b<g} T_abg = m-2.
"""
import itertools, numpy as np
from scipy.optimize import linprog


def _tables(n):
    tri = list(itertools.combinations(range(n), 3))
    prs = list(itertools.combinations(range(n), 2))
    pidx = {p: i for i, p in enumerate(prs)}
    A = np.zeros((len(prs), len(tri)))
    for t, (a, b, g) in enumerate(tri):
        for p in ((a, b), (a, g), (b, g)):
            A[pidx[p], t] = 1.0
    Arow = np.zeros((n, len(tri)))
    for t, (a, b, g) in enumerate(tri):
        Arow[a, t] = Arow[b, t] = Arow[g, t] = 1.0
    return tri, prs, A, Arow


_CACHE = {}
def tables(n):
    if n not in _CACHE:
        _CACHE[n] = _tables(n)
    return _CACHE[n]


def G(lam, return_T=False):
    """lam: 1-d array of the NONZERO eigenvalues (any order)."""
    lam = np.asarray(lam, float)
    n = len(lam)
    if n < 3:
        return (float(np.sum(lam**3)), None) if return_T else float(np.sum(lam**3))
    tri, prs, A, _ = tables(n)
    w = np.array([3*lam[a]*lam[b]*lam[g] for (a, b, g) in tri])
    res = linprog(-w, A_ub=A, b_ub=2*np.ones(len(prs)),
                  bounds=[(0, None)]*len(tri), method='highs')
    val = float(np.sum(lam**3) - res.fun)
    if return_T:
        return val, (tri, res.x)
    return val


def G_grad(lam):
    """Value and an envelope-theorem gradient (valid a.e.)."""
    lam = np.asarray(lam, float); n = len(lam)
    val, TT = G(lam, return_T=True)
    g = 3*lam**2
    if TT is not None:
        tri, x = TT
        for t, (a, b, gg) in enumerate(tri):
            if x[t] != 0.0:
                g[a] += 3*x[t]*lam[b]*lam[gg]
                g[b] += 3*x[t]*lam[a]*lam[gg]
                g[gg] += 3*x[t]*lam[a]*lam[b]
    return val, g


def LP_full(lam, m, N=None):
    """The full transportation LP on N = C(m,2) indices: lam padded with zeros."""
    if N is None:
        N = m*(m-1)//2
    v = np.zeros(N); v[:len(lam)] = lam
    tri, prs, A, Arow = tables(N)
    w = np.array([3*v[a]*v[b]*v[g] for (a, b, g) in tri])
    res = linprog(-w, A_ub=A, b_ub=2*np.ones(len(prs)),
                  A_eq=Arow, b_eq=(m-2)*np.ones(N),
                  bounds=[(0, None)]*len(tri), method='highs')
    if res.status != 0:
        return None
    return float(np.sum(v**3) - res.fun)


def G_closed(lam_pos, b, c):
    """Closed form implied by the (+++)/(+--) decoupling:
       G = sum_P lam^3 - b^3 - c^3 + 6 lam_1 b c + 3 M(lam_P)."""
    lam_pos = np.asarray(lam_pos, float)
    lam1 = lam_pos.max() if len(lam_pos) else 0.0
    base = float(np.sum(lam_pos**3)) - b**3 - c**3 + 6*lam1*b*c
    k = len(lam_pos)
    if k < 3:
        return base
    tri, prs, A, _ = tables(k)
    w = np.array([3*lam_pos[a]*lam_pos[bb]*lam_pos[g] for (a, bb, g) in tri])
    res = linprog(-w, A_ub=A, b_ub=2*np.ones(len(prs)),
                  bounds=[(0, None)]*len(tri), method='highs')
    return base - res.fun
