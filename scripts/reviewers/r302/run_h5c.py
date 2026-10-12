"""Verify the three n=12 Delta>0 points that break H5, from scratch and in full Weyl_12."""
import sys, os
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from core import Geom
from le import build_weyl, Le_matrix, compression
from defect import Delta
from run_h5 import lam_matrix, blocks_of, edge_pairs, family_average
from run_h5b import block_symmetric_solutions
from run_h1 import log

if __name__ == '__main__':
    g, sols = block_symmetric_solutions([2] * 6, seed=99, tries=60)
    B, sv = build_weyl(g)
    log(f"[p5c] dim Weyl_12 = {B.shape[1]}")
    for t in [3, 7, 10]:
        th0, lam = sols[t]
        W = np.diag(lam)
        # full, unreduced checks
        QW = g.Q(W); th = g.P(W)
        crit = np.linalg.norm(QW - th * W)
        ric = np.max(np.abs(g.ric(W)))
        bia = np.max(np.abs(g.bianchi_vec(W)))
        inW = np.linalg.norm(sv.vec(W) - B @ (B.T @ sv.vec(W)))
        L = lam_matrix(g, W); lab, nb = blocks_of(L); val, ep, allp = edge_pairs(L, lab, nb)
        D = Delta(g, W)
        Le = Le_matrix(g, W, B, sv, th)
        e = B.T @ sv.vec(W)
        Pe = np.eye(B.shape[1]) - np.outer(e, e)
        full = np.linalg.eigvalsh(Pe @ Le @ Pe).max()
        ea, de, evs, _ = family_average(g, W, B, sv, ep)
        log(f"  #{t}: theta={th:.9f} crit_res={crit:.2e} |Ric|={ric:.2e} |Bianchi|={bia:.2e} "
            f"dist_to_Weyl={inW:.2e} Delta={D:.6f} blocks={nb}")
        log(f"       block value matrix (rounded 6):")
        for row in np.round(val, 6):
            log("        " + "  ".join(f"{x:+.6f}" for x in row))
        log(f"       negative-block-graph edges: {sorted(set((lab[a],lab[b]) for a,b in ep))}")
        log(f"       lam_max(L_e|e-perp) = {full:.9f}   EDGE avg = {ea:.9f} on dim {de}"
            f"   -> H5 predicts >1/2, measured {'FAILS' if ea<=0.5 else 'ok'}")
