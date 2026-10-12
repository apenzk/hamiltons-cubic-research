"""H5, made reading-independent: at the n=12 break points, the edge average for EVERY choice
of which block-value class counts as an edge."""
import sys, os, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from core import Geom
from le import build_weyl
from defect import Delta
from run_h5 import lam_matrix, blocks_of, edge_pairs, family_average
from run_h5b import block_symmetric_solutions
from run_h1 import log

if __name__ == '__main__':
    g, sols = block_symmetric_solutions([2] * 6, seed=99, tries=60)
    B, sv = build_weyl(g)
    log("[p5d] every reading of 'block graph' at the three n=12 break points")
    for t in [3, 7, 10]:
        th, lam = sols[t]
        W = np.diag(lam)
        L = lam_matrix(g, W); lab, nb = blocks_of(L)
        val, _, _ = edge_pairs(L, lab, nb)
        off = sorted({round(val[a, b], 7) for a in range(nb) for b in range(nb) if a != b})
        log(f"  point #{t}: theta={g.P(W):.6f} Delta={Delta(g,W):.4f} blocks={nb} "
            f"off-block values {off}")
        # every non-empty subset of off-block value classes
        for r in range(1, len(off) + 1):
            for sub in itertools.combinations(off, r):
                prs = []
                for a in range(nb):
                    for b in range(a + 1, nb):
                        if any(abs(val[a, b] - v) < 1e-6 for v in sub):
                            ia = [i for i in range(g.n) if lab[i] == a]
                            ib = [i for i in range(g.n) if lab[i] == b]
                            prs += [(i, j) for i in ia for j in ib]
                if not prs:
                    continue
                ea, de, evs, _ = family_average(g, W, B, sv, prs)
                tag = "neg only" if all(v < 0 for v in sub) and len(sub) == sum(1 for v in off if v < 0) else ""
                flag = "  <= 1/2" if ea is not None and ea <= 0.5 + 1e-9 else "  > 1/2"
                log(f"      edges = {list(sub)}{' ' + tag if tag else ''}: avg={ea:.9f} dim={de}{flag}")
