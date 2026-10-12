"""Reviewer 53, M1: is sphere_product_W's coefficient set Ricci-flat only for two blocks?

Runs BOTH the repository's own constructor (review_r30_core.sphere_product_W) and an
independent reimplementation, and compares them entry-for-entry.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import time

import numpy as np

sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r53_core import (Npairs, Pval, Qop, alt, pairs_of, ricci, theta0)
from review_r30_core import sphere_product_W as repo_spW

LOG = _os.path.join(_ROOT, 'agent_logs/review_r53_multiblock.log')


def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open(LOG, 'a') as f:
        f.write(line + '\n')


def mine_spW(blocks):
    """1/(p(p-1)) inside a block of size p, -1/(pq) across blocks p,q."""
    n = sum(blocks)
    prs, _ = pairs_of(n)
    lab = []
    for bi, b in enumerate(blocks):
        lab += [bi] * b
    lam = np.zeros(len(prs))
    for a, (i, j) in enumerate(prs):
        if lab[i] == lab[j]:
            p = blocks[lab[i]]
            lam[a] = 1.0 / (p * (p - 1))
        else:
            p, q = blocks[lab[i]], blocks[lab[j]]
            lam[a] = -1.0 / (p * q)
    return np.diag(lam)


def report(blocks):
    n = sum(blocks)
    Wrepo, _ = repo_spW(tuple(blocks))
    Wmine = mine_spW(blocks)
    agree = float(np.max(np.abs(Wrepo - Wmine)))
    W = Wmine
    ric_raw = ricci(n, W)
    nrm = np.linalg.norm(W)
    Wn = W / nrm
    ric_n = ricci(n, Wn)
    th = Pval(n, Wn)
    res = np.linalg.norm(Qop(n, Wn) - th * Wn)
    # predicted Ricci diagonal value (2-k)/p at an index of block p
    k = len(blocks)
    pred = [(2 - k) / p for p in blocks]
    diag_seen = sorted(set(np.round(np.diag(ric_raw), 12)))
    log(f"  blocks={blocks} n={n}: repo-vs-mine max|dW|={agree:.1e}  "
        f"|W|={nrm:.6f}")
    log(f"     |Ric| raw={np.linalg.norm(ric_raw):.6f}  normalised={np.linalg.norm(ric_n):.6f}"
        f"  |Alt|={np.linalg.norm(alt(n, Wn)):.2e}")
    log(f"     Ric diagonal values seen={diag_seen}  predicted (2-k)/p={sorted(set(np.round(pred,12)))}")
    log(f"     theta={th:.9f}  criticality residual (normalised) = {res:.6f}")
    return res


def main():
    log("M1: sphere_product_W coefficient set -- Ricci-flatness by block count")
    log(" two blocks:")
    for b in [(3, 3), (4, 4), (5, 5), (3, 5), (2, 6), (6, 6), (4, 8), (7, 7)]:
        report(b)
    log(" three blocks:")
    for b in [(4, 4, 4), (3, 3, 6), (4, 4, 6), (3, 3, 3), (2, 3, 4), (5, 5, 5)]:
        report(b)
    log(" four blocks:")
    for b in [(3, 3, 3, 3), (2, 2, 2, 2)]:
        report(b)
    log("M1 done")


if __name__ == '__main__':
    main()
