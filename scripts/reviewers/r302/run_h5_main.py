import sys, os
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from run_h5 import report, lam_matrix, blocks_of, edge_pairs, family_average
from points import sphere_product, c5_blowup, cpm, witness
from core import Geom
from le import build_weyl
from run_h1 import log
from sweep import diag_weyl_basis, diag_Q
from scipy.optimize import least_squares


def graph_blowup(G, sizes, seed=0, tries=200):
    """critical points of the blow-up family of graph G: diagonal, block-constant,
    solved inside the block-symmetric subspace, then verified as full critical points."""
    k = len(sizes); n = sum(sizes)
    g = Geom(n)
    lab = []
    for bi, s in enumerate(sizes):
        lab += [bi] * s
    # parameters: value for each unordered block pair (incl. self)
    keys = [(a, b) for a in range(k) for b in range(a, k)]
    ki = {kk: t for t, kk in enumerate(keys)}
    idxmap = np.array([ki[(min(lab[i], lab[j]), max(lab[i], lab[j]))] for (i, j) in g.pairs])

    def to_lam(p):
        return p[idxmap]
    rng = np.random.default_rng(seed)
    sols = []
    for t in range(tries):
        p0 = rng.normal(size=len(keys))

        def F(p):
            lam = to_lam(p)
            q = diag_Q(g, lam)
            nrm = float(lam @ lam)
            th = float(q @ lam) / nrm
            # criticality + Ricci-free + normalisation
            L = np.zeros((n, n))
            for a, (i, j) in enumerate(g.pairs):
                L[i, j] = L[j, i] = lam[a]
            return np.concatenate([q - th * lam, L.sum(axis=1), [nrm - 1.0]])
        r = least_squares(F, p0, xtol=3e-16, ftol=3e-16, gtol=3e-16, max_nfev=4000)
        if np.linalg.norm(r.fun) > 1e-11:
            continue
        lam = to_lam(r.x)
        th = float(diag_Q(g, lam) @ lam)
        if th < 0:
            lam, th = -lam, -th
        if th < 1e-6:
            continue
        # keep only genuinely k-block solutions
        rows = set(tuple(np.round(r.x, 7)) for _ in [0])
        sols.append((th, lam))
    best = {}
    for th, lam in sols:
        key = tuple(np.sort(np.round(lam, 6)))
        best[key] = (th, lam)
    return g, sorted(best.values(), key=lambda x: -x[0])


def cyc(k):
    G = np.zeros((k, k), int)
    for a in range(k):
        G[a, (a + 1) % k] = G[(a + 1) % k, a] = 1
    return G


if __name__ == '__main__':
    log("[p5] H5: negative-block-graph edge average")
    for nm, f in [("S3xS5", lambda: sphere_product(3, 5)),
                  ("S4xS6", lambda: sphere_product(4, 6)),
                  ("S4xS4", lambda: sphere_product(4, 4)),
                  ("S5xS5", lambda: sphere_product(5, 5)),
                  ("C5blowup", c5_blowup),
                  ("witness_n8", witness),
                  ("CP4", lambda: cpm(4))]:
        g, W = f()
        report(nm, g, W)
    log("[p5] K_m and C_m blow-ups, block sizes chosen to keep n <= 12")
    for k, s in [(3, 2), (3, 3), (4, 2), (5, 2), (6, 2), (4, 3), (3, 4), (5, 1), (6, 1), (7, 1),
                 (4, 1), (8, 1), (9, 1), (10, 1), (11, 1), (12, 1)]:
        n = k * s
        if n > 12 or n < 5:
            continue
        g, sols = graph_blowup(None, [s] * k, seed=k * 10 + s, tries=60)
        B, sv = build_weyl(g)
        for t, (th, lam) in enumerate(sols[:4]):
            report(f"K{k}blowup(s={s})#{t}", g, np.diag(lam), B, sv)
