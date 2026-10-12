"""Reviewer 19: COMPLETE basis-level test of the two claimed exact zeros.

For every basis vector W1_i of V_{1/3} build the FULL matrix of the linear map
F_{W1_i}(h) = 1/2(W1_i h + h W1_i) + W1_i # h on the whole Weyl space, then read
off the blocks between F_u-eigenspaces.  Since T(W1,X,Y) = <F_{W1}(X), Y>, the
blocks ARE the trilinear form; nothing is sampled.

Reported per block (row eigenspace, column eigenspace), max |entry|:
   [13, neg]  -> T(W1, W1', N)   must be 0 for the c_0 factor in the leading term
   [ker,neg]  -> T(W1, K, N)     must be 0 for the B(c_0) interpolation
"""
import sys, time
import numpy as np
from review_r19_struct import Ctx, log

NAMES = ('u', 'half', '13', 'ker', 'm16', 'm12', 'm1')


def run(n, nb=None):
    ctx = Ctx(n)
    E = ctx.Eflat
    D = E.shape[0]
    B13 = ctx.sub['13']
    k13 = B13.shape[1] if nb is None else min(nb, B13.shape[1])
    blocks = {k: ctx.sub[k] for k in NAMES}
    worst = {}
    t0 = time.time()
    for i in range(k13):
        W1 = ctx.mat(B13[:, i], np.eye(D))
        W1 = W1/np.linalg.norm(W1)
        M = np.empty((D, D))
        for b in range(D):
            h = E[b].reshape(ctx.Nl, ctx.Nl)
            M[:, b] = ctx.coords(ctx.F(W1, h))
        M = 0.5*(M + M.T)
        for a in NAMES:
            for c in NAMES:
                Ba, Bc = blocks[a], blocks[c]
                if Ba.shape[1] == 0 or Bc.shape[1] == 0:
                    continue
                v = float(np.max(np.abs(Ba.T @ M @ Bc)))
                key = (a, c)
                worst[key] = max(worst.get(key, 0.0), v)
        if i % 10 == 0:
            log(f"  n={n} tensor scan {i+1}/{k13} ({time.time()-t0:.0f}s)")
    log(f"n={n} FULL F_(W1) block maxima over ALL {k13} basis vectors of V_13:")
    for a in NAMES:
        row = "  ".join(f"{c}:{worst.get((a,c),0.0):.2e}" for c in NAMES if (a, c) in worst)
        log(f"   n={n}  row {a:5s} | {row}")


if __name__ == "__main__":
    n = int(sys.argv[1])
    nb = int(sys.argv[2]) if len(sys.argv) > 2 else None
    run(n, nb)
