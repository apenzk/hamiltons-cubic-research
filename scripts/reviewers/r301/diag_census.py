"""Census of coordinate-diagonal critical points, their blocks, negative block graph,
Delta, Sym_0 spectrum and the H5 edge statistic."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(__file__))
import core301 as C, points301 as PT, defect as DF, sym0 as S, hunt as HN
from scipy.optimize import least_squares

def solve_diag(n, seed):
    rng = np.random.default_rng(seed)
    iu = np.triu_indices(n, 1)
    def build(v):
        L = np.zeros((n, n)); L[iu] = v; L = L + L.T; return L
    def F(v):
        L = build(v)
        QL = PT.diagQ(L)
        s2 = (L * L).sum() / 2
        th = (QL * L).sum() / 2 if s2 > 1e-12 else 0.0
        return np.concatenate([(QL - th * L)[iu], L.sum(axis=1), [s2 - 1.0]])
    v0 = rng.normal(size=len(iu[0]))
    sol = least_squares(F, v0, xtol=3e-16, ftol=3e-16, gtol=3e-16, max_nfev=3000)
    L = build(sol.x)
    s2 = (L * L).sum() / 2
    if s2 < 1e-8: return None
    L = L / np.sqrt(s2)
    th = (PT.diagQ(L) * L).sum() / 2
    res = np.abs((PT.diagQ(L) - th * L)[iu]).max() + np.abs(L.sum(axis=1)).max()
    if res > 1e-10: return None
    if th < 0: L, th = -L, -th
    return L, th, res

def to_operator(n, L):
    P, idx = C.pairs(n); N = len(P)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(P):
        W[a, a] = L[i, j]
    return W

def blocks_of(L, tol=1e-7):
    n = L.shape[0]
    lab = [-1] * n; nb = 0
    for i in range(n):
        if lab[i] >= 0: continue
        lab[i] = nb
        for j in range(i + 1, n):
            if lab[j] < 0:
                a = L[i].copy(); b = L[j].copy()
                a[[i, j]] = 0; b[[i, j]] = 0
                if np.abs(a - b).max() < tol and abs(L[i, j] - L[i, j]) < tol:
                    lab[j] = nb
        nb += 1
    return lab, nb

def neg_block_graph(L, lab, nb, tol=1e-7):
    G = [[0] * nb for _ in range(nb)]
    n = L.shape[0]
    for i in range(n):
        for j in range(n):
            if i == j: continue
            a, b = lab[i], lab[j]
            if a != b and L[i, j] < -tol:
                G[a][b] = G[b][a] = 1
    return G
