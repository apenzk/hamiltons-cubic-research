"""Reviewer 53: the C_5-blow-up multi-block critical point at n=10, blocks (2,2,2,2,2).

Found by the M4 scan.  It is an indecomposable 5-block critical point whose
negative graph is the blow-up of a 5-cycle -- triangle-free -- so the STRUCTURAL
slack vanishes exactly, while the THETA-FORMULA slack does not.  This is a direct
counterexample to "the two slacks agree".
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys
import time

import numpy as np

sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r53_core import (Le_matrix, Npairs, Pval, Qop, alt, leaks, onb_rows,
                             orbit_tangent, pairs_of, ricci, slack_struct,
                             slack_theta, theta0, weyl_basis)
from review_r53_m2m3 import embed, vertex_residual
from review_r53_m4 import genuine, neg_graph_slack

LOG = _os.path.join(_ROOT, 'agent_logs/review_r53_multiblock.log')


def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open(LOG, 'a') as f:
        f.write(line + '\n')


def build_c5(b=2):
    """w_aa = 2c, w_ab = -c for the 5-cycle edges, +c/2 otherwise, then normalised.
    The exact ratios found by the solver were 0.298142397 : -0.149071198 : 0.074535599,
    i.e. 4 : -2 : 1."""
    k = 5
    w = np.zeros((k, k))
    cyc = [(0, 1), (1, 4), (4, 2), (2, 3), (3, 0)]
    E = set(cyc) | set((j, i) for (i, j) in cyc)
    for a in range(k):
        w[a, a] = 4.0
        for bq in range(k):
            if bq == a:
                continue
            w[a, bq] = -2.0 if (a, bq) in E else 1.0
    return w


def main():
    log("C_5 blow-up point: an indecomposable multi-block critical point with S_struct = 0")
    b = 2
    blocks = (b,) * 5
    n = 5 * b
    w = build_c5(b)
    W = embed(blocks, w)
    W = W / np.linalg.norm(W)
    th = Pval(n, W)
    res = float(np.linalg.norm(Qop(n, W) - th * W))
    log(f"  blocks={blocks} n={n}")
    log(f"  vertex matrix (ratios 4 : -2 : +1):\n{np.array2string(w, precision=0)}")
    log(f"  theta = {th:.12f}   theta_0({n}) = {theta0(n):.9f}   "
        f"ratio = {th/theta0(n):.6f}")
    log(f"  criticality residual = {res:.3e}   |Ric| = {np.linalg.norm(ricci(n,W)):.2e}"
        f"   |Alt| = {np.linalg.norm(alt(n,W)):.2e}")
    vr = np.linalg.norm(vertex_residual(blocks, w / np.linalg.norm(embed(blocks, w)),
                                        th))
    log(f"  vertex-system residual = {vr:.2e}")
    g, why = genuine(blocks, w)
    log(f"  indecomposable / genuine? {g} ({why})")
    tri, ne = neg_graph_slack(n, W)
    log(f"  negative graph: {ne} edges, {tri} triangles")
    ev = np.linalg.eigvalsh(W)
    log(f"  W spectrum: {sorted(set(np.round(ev,9)))}  dim m = {int((ev<-1e-9).sum())}"
        f"  (n^2/4 = {n*n/4})")
    sn = slack_struct(n, W)
    st = slack_theta(n, W, th)
    lk = leaks(n, W)
    log(f"  S_structural = {sn:.3e}   S_theta-formula = {st:.9f}")
    log(f"  leaks (mm->m, hm->h, hh->m) = ({lk[0]:.6f}, {lk[1]:.6f}, {lk[2]:.6f})")

    # repository implementations
    import b_padded_s3s3 as bp
    from review_r30_core import adj as r30_adj
    log(f"  repository b_padded_s3s3.slack   = "
        f"{bp.slack(n, W, r30_adj(n), Npairs(n)):.3e}")
    import g1_second_order as g1
    N_, c_, L2_, alt_idx_, B_ = g1.setup(n)
    log(f"  repository g1_second_order.slack = {g1.slack(L2_, W, c_, alt_idx_, th):.9f}")

    # is it graded?  the three conditions
    log("  gradedness: [m,m]->m = %.2e, [h,m]->h = %.2e, [h,h]->m = %.2e"
        % lk)

    # second-order data
    B = weyl_basis(n)
    M = Le_matrix(n, W / th, B)
    evl = np.linalg.eigvalsh(M)
    dimE = int((np.abs(evl - 0.5) < 1e-8).sum())
    orb = onb_rows(orbit_tangent(n, W)).shape[0]
    log(f"  L_e: lam_max on W^perp = {sorted(evl)[-2]:.6f}  dim E(1/2) = {dimE}  "
        f"orbit = {orb}  {'nondegenerate' if dimE == orb else 'DEGENERATE'}")
    cnt = {}
    for v in np.round(evl, 9):
        cnt[v] = cnt.get(v, 0) + 1
    log(f"  L_e spectrum: {sorted(cnt.items(), key=lambda t: -t[0])}")

    # larger blow-ups
    for bb in (3, 4):
        bl = (bb,) * 5
        nn = 5 * bb
        w2 = build_c5(bb)
        W2 = embed(bl, w2)
        W2 = W2 / np.linalg.norm(W2)
        th2 = Pval(nn, W2)
        r2 = float(np.linalg.norm(Qop(nn, W2) - th2 * W2))
        log(f"  blow-up b={bb}, n={nn}: theta={th2:.9f} resid={r2:.2e} "
            f"|Ric|={np.linalg.norm(ricci(nn,W2)):.2e} "
            f"S_struct={slack_struct(nn,W2):.2e} S_theta={slack_theta(nn,W2,th2):.6f} "
            f"th/th0={th2/theta0(nn):.4f}")
    log("C_5 point done")


if __name__ == '__main__':
    main()
