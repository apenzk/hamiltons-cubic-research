"""Reviewer 53: is the (S^3)^3 degeneracy a three-block phenomenon, or the known
(3,3) anomaly counted once per pair of blocks?

Prediction to test: the recorded exception to two-block nondegeneracy is (3,3) alone,
with excess 9 = dim E(1/2) - orbit at n = 6.  If the multi-block excess is just that
anomaly appearing once per unordered PAIR of 3-blocks, then
    excess((S^3)^k) = C(k,2) * 18   (each pair contributing its own 18-dim E(1/2)
                                     minus nothing, since the pair's own orbit is
                                     already inside the ambient orbit)
and any product whose blocks are all of size != 3 should be NONDEGENERATE.

Test cases: (S^3)^3 at n=9 (excess 54 = 3 * 18), (S^4)^3 at n=12, (S^3)^2 x S^4 at
n=10, S^3 x S^4 x S^5 at n=12, (S^2)^3 at n=6.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import time

import numpy as np

sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r53_core import (Le_matrix, Pval, Qop, onb_rows, orbit_tangent,
                             slack_struct, theta0, weyl_basis)
from review_r53_m2m3 import embed
from review_r53_closedform import product_W

LOG = _os.path.join(_ROOT, 'agent_logs/review_r53_multiblock.log')


def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open(LOG, 'a') as f:
        f.write(line + '\n')


def analyse(blocks):
    n = sum(blocks)
    t0 = time.time()
    W = embed(blocks, product_W(blocks))
    W = W / np.linalg.norm(W)
    th = Pval(n, W)
    res = float(np.linalg.norm(Qop(n, W) - th * W))
    B = weyl_basis(n)
    M = Le_matrix(n, W / th, B)
    ev = np.linalg.eigvalsh(M)
    dimE = int((np.abs(ev - 0.5) < 1e-8).sum())
    orb = onb_rows(orbit_tangent(n, W)).shape[0]
    lam2 = float(np.sort(ev)[-2])
    log(f"  {str(blocks):>16} n={n:2d} dimWeyl={B.shape[0]:5d} theta={th:.9f} "
        f"({th/theta0(n):.4f} th0) res={res:.1e} orbit={orb:3d} dimE(1/2)={dimE:4d} "
        f"excess={dimE-orb:4d} lam_max(W^perp)={lam2:.6f} S={slack_struct(n,W):.1f} "
        f"[{time.time()-t0:.0f}s]")
    return dimE - orb


def main():
    log("Three-block degeneracy: is the excess the (3,3) anomaly, once per pair?")
    for bl in [(3, 3), (4, 4), (3, 4), (2, 2), (2, 3)]:
        analyse(bl)
    for bl in [(2, 2, 2), (3, 3, 3), (3, 3, 4), (2, 3, 4), (3, 4, 5), (4, 4, 4),
               (3, 3, 3, 3)]:
        analyse(bl)
    log("degeneracy scan done")


if __name__ == '__main__':
    main()
