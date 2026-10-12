"""R52 M1: is sphere_product_W Ricci-flat only for two blocks?
Runs BOTH the repository helper and an independent reimplementation."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import review_r52_core as K
from review_r30_core import sphere_product_W as repo_spw, Q as repoQ, weyl_basis as repo_wb

LOG = _os.path.join(_ROOT, 'agent_logs/review_r52_multiblock.log')
def log(m):
    line = f"[{time.strftime('%H:%M:%S')}] {m}"
    print(line, flush=True)
    open(LOG, 'a').write(line + '\n')


def mine_spw(blocks):
    n = sum(blocks)
    prs, idx = K.pairs_of(n)
    lab = []
    for bi, b in enumerate(blocks):
        lab += [bi] * b
    W = np.zeros((len(prs), len(prs)))
    for a, (i, j) in enumerate(prs):
        if lab[i] == lab[j]:
            p = blocks[lab[i]]
            W[a, a] = 1.0 / (p * (p - 1))
        else:
            p, q = blocks[lab[i]], blocks[lab[j]]
            W[a, a] = -1.0 / (p * q)
    return W


def report(blocks):
    n = sum(blocks)
    Wr, _ = repo_spw(blocks)
    Wm = mine_spw(blocks)
    agree = np.abs(Wr - Wm).max()
    for tag, W0 in (("repo", Wr), ("mine", Wm)):
        W = W0 / np.linalg.norm(W0)
        Ric = K.ricci(n, W)
        th = K.P_val(n, W)
        res = np.linalg.norm(K.Q(n, W) - th * W)
        # repo Q as well, for the repo copy
        if tag == "repo":
            resrepo = np.linalg.norm(repoQ(n, W) - th * W)
        else:
            resrepo = float('nan')
        # analytic row sum prediction
        p = blocks[0]
        pred = (2 - len(blocks)) / p
        log(f"  {blocks} n={n} [{tag}] |Ric|_F={np.linalg.norm(Ric):.6f} "
            f"Ric_00={Ric[0,0]:.6f} pred_rowsum(unnorm,blk0)={pred:+.6f} "
            f"theta={th:.6f} resid(mine Q)={res:.4f} resid(repo Q)={resrepo:.4f} "
            f"|Alt|={np.abs(K.alt(n,W)).max():.1e}")
    log(f"    repo vs mine construction agreement: {agree:.1e}")


if __name__ == '__main__':
    log("PHASE 2 M1: sphere_product_W Ricci audit")
    for blocks in [(3, 3), (4, 4), (3, 5), (4, 6), (4, 4, 4), (3, 3, 6), (4, 4, 6),
                   (3, 3, 3), (2, 2, 2, 6), (3, 3, 3, 3)]:
        report(blocks)
    # exact rational check of the two-block row sum
    log("  exact two-block row sums (Fraction arithmetic):")
    from fractions import Fraction as F
    for (p, q) in [(3, 3), (4, 4), (3, 5), (2, 6), (5, 9)]:
        rs_p = F(p - 1, 1) * F(1, p * (p - 1)) + F(q, 1) * F(-1, p * q)
        rs_q = F(q - 1, 1) * F(1, q * (q - 1)) + F(p, 1) * F(-1, p * q)
        log(f"    ({p},{q}): row sum in block p = {rs_p}, in block q = {rs_q}")
    for bl in [(4, 4, 4), (3, 3, 6), (4, 4, 6)]:
        n = sum(bl)
        for a, pa in enumerate(bl):
            rs = F(pa - 1, 1) * F(1, pa * (pa - 1)) + sum(
                F(bl[b], 1) * F(-1, pa * bl[b]) for b in range(len(bl)) if b != a)
            log(f"    {bl}: exact row sum in block {a} (dim {pa}) = {rs}")
    log("PHASE 2 M1 done")
