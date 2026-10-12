"""D4: does pinning Q_gamma by criticality escape the 67/68 LP class?

Class list (reviews/REVIEW_r67.md, scripts/reviewers/r67/review_r67_lp.py):
    T >= 0, totally symmetric, zero on repeated indices
    row marginal   sum_{b<g} t_abg = n-2         (every a)
    pair cap       sum_g t_abg <= 2              (every a<b)
    isotropy       t = 0 on triples inside m     (S_mmm = 0)
Objective theta(lam,T) = sum lam^3 + 3 sum_{a<b<g} lam_a lam_b lam_g t_abg.

ADDED HERE, and neither is in that list:
    (C) per-row criticality   sum_{ab} lam_a lam_b T_gab = 2 theta lam_g - 2 lam_g^2
    (I) per-row identity      sum_b lam_b R_gb = -2 lam_g
"""
import numpy as np, sys, functools
from itertools import combinations
from scipy.optimize import linprog


@functools.lru_cache(None)
def skeleton(N):
    tris = list(combinations(range(N), 3))
    prs = list(combinations(range(N), 2))
    pidx = {p: i for i, p in enumerate(prs)}
    Arow = np.zeros((N, len(tris)))
    Apair = np.zeros((len(prs), len(tris)))
    for i, (a, b, g) in enumerate(tris):
        Arow[a, i] = Arow[b, i] = Arow[g, i] = 1.0
        Apair[pidx[(a, b)], i] = Apair[pidx[(a, g)], i] = Apair[pidx[(b, g)], i] = 1.0
    return tris, prs, Arow, Apair


def lp(lam, n, d, crit=True, ident=True, smmm=True, ret_T=False):
    N = len(lam)
    tris, prs, Arow, Apair = skeleton(N)
    nv = len(tris)
    ub = np.array([0.0 if (smmm and max(a, b, g) < d) else 2.0 for (a, b, g) in tris])
    obj = np.zeros(nv + 1)                       # variables: t, then theta
    Aeq = [np.hstack([Arow, np.zeros((N, 1))])]
    beq = [np.full(N, float(n - 2))]
    if crit:
        # Q_g = 2 sum_{a<b in triple with g} lam_a lam_b t  = 2 theta lam_g - 2 lam_g^2
        M = np.zeros((N, nv + 1))
        for i, (a, b, g) in enumerate(tris):
            M[a, i] = 2 * lam[b] * lam[g]; M[b, i] = 2 * lam[a] * lam[g]
            M[g, i] = 2 * lam[a] * lam[b]
        M[:, nv] = -2 * lam
        Aeq.append(M); beq.append(-2 * lam ** 2)
    if ident:
        M = np.zeros((N, nv + 1))
        for i, (a, b, g) in enumerate(tris):
            M[a, i] = lam[b] + lam[g]; M[b, i] = lam[a] + lam[g]; M[g, i] = lam[a] + lam[b]
        Aeq.append(M); beq.append(-2 * lam)
    # theta = sum lam^3 + 3 sum lam_a lam_b lam_g t
    M = np.zeros((1, nv + 1)); M[0, nv] = -1.0
    for i, (a, b, g) in enumerate(tris):
        M[0, i] = 3 * lam[a] * lam[b] * lam[g]
    Aeq.append(M); beq.append(np.array([-np.sum(lam ** 3)]))
    obj[nv] = -1.0
    bounds = [(0.0, u) for u in ub] + [(None, None)]
    r = linprog(obj, A_ub=np.hstack([Apair, np.zeros((len(prs), 1))]),
                b_ub=np.full(len(prs), 2.0),
                A_eq=np.vstack(Aeq), b_eq=np.concatenate(beq), bounds=bounds, method='highs')
    if not r.success:
        return None if not ret_T else (None, None)
    return (float(-r.fun), r.x) if ret_T else float(-r.fun)
