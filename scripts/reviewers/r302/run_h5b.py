"""H5, targeted: (a) balanced emptiness with the rank floor fixed, (b) Delta>0 points whose
edge average is <= 1/2, (c) is 2/3 at C_5 forced by symmetry rather than by criticality?"""
import sys, os, time
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from core import Geom
from points import sphere_product, c5_blowup, cpm, witness
from le import build_weyl, Le_matrix, HA_span, compression
from defect import Delta
from run_h5 import report, lam_matrix, blocks_of, edge_pairs, family_average
from run_h1 import log
from sweep import diag_weyl_basis, diag_Q


def block_symmetric_solutions(sizes, seed=0, tries=120):
    k = len(sizes); n = sum(sizes)
    g = Geom(n)
    lab = []
    for bi, s in enumerate(sizes):
        lab += [bi] * s
    keys = [(a, b) for a in range(k) for b in range(a, k)]
    ki = {kk: t for t, kk in enumerate(keys)}
    idxmap = np.array([ki[(min(lab[i], lab[j]), max(lab[i], lab[j]))] for (i, j) in g.pairs])
    rng = np.random.default_rng(seed)
    out = {}
    for t in range(tries):
        p0 = rng.normal(size=len(keys))

        def F(p):
            lam = p[idxmap]
            q = diag_Q(g, lam)
            nrm = float(lam @ lam)
            th = float(q @ lam) / nrm
            L = np.zeros((n, n))
            for a, (i, j) in enumerate(g.pairs):
                L[i, j] = L[j, i] = lam[a]
            return np.concatenate([q - th * lam, L.sum(axis=1), [nrm - 1.0]])
        r = least_squares(F, p0, xtol=3e-16, ftol=3e-16, gtol=3e-16, max_nfev=4000)
        if np.linalg.norm(r.fun) > 1e-11:
            continue
        lam = r.x[idxmap]
        th = float(diag_Q(g, lam) @ lam)
        if th < 0:
            lam, th = -lam, -th
        if th < 1e-6:
            continue
        out[tuple(np.sort(np.round(lam, 6)))] = (th, lam)
    return g, sorted(out.values(), key=lambda x: -x[0])


if __name__ == '__main__':
    log("[p5b] H5 targeted")
    log("  (a) balanced products: is the mixed family really empty after the rank floor fix?")
    for p in [3, 4, 5]:
        g, W = sphere_product(p, p)
        report(f"S{p}xS{p}", g, W)
    log("  (b) six-block n=12 critical points with Delta > 0")
    g, sols = block_symmetric_solutions([2] * 6, seed=99, tries=60)
    B, sv = build_weyl(g)
    hits = []
    for t, (th, lam) in enumerate(sols[:12]):
        W = np.diag(lam)
        r = report(f"6blk_n12#{t}", g, W, B, sv)
        if r['D'] > 1e-7 and r['edge'] is not None and r['edge'] <= 0.5 + 1e-9:
            hits.append(r)
    for r in hits:
        log(f"  *** H5 BREAK: {r['name']} Delta={r['D']:.4f} lam_max={r['full']:.6f} "
            f"EDGE avg={r['edge']:.9f} <= 1/2 on dim {r['dim']}")
    log("  (c) is 2/3 at the C_5 blow-up forced by the D_5 symmetry alone?")
    g5, W5 = c5_blowup()
    B5, sv5 = build_weyl(g5)
    for (d, a, b) in [(4, -2, 1), (4, -2.5, 1.5), (4, -1.5, 0.5), (4, -3, 2), (8, -2, -1)]:
        if abs(d + 4 * a + 4 * b) > 1e-12:
            log(f"      (d,a,b)=({d},{a},{b}) is not Ricci-free, skipped")
            continue
        gg, WW = c5_blowup(diag=float(d), adjv=float(a), nonadj=float(b))
        th = gg.P(WW)
        res = np.linalg.norm(gg.Q(WW) - th * WW)
        L = lam_matrix(gg, WW); lab, nb = blocks_of(L); val, ep, allp = edge_pairs(L, lab, nb)
        ea, de, evs, _ = family_average(gg, WW, B5, sv5, ep)
        log(f"      (d,a,b)=({d},{a},{b}) theta={th:.6f} crit_res={res:.2e} "
            f"EDGE avg={ea:.9f} dim={de} spec={np.round(np.unique(np.round(evs,7)),7).tolist()}")
