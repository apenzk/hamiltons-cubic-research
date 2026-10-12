"""Reviewer 53, M4 part 2: wide hunt for multi-block critical points with S = 0.

Scans k = 3,4,5 partitions at n = 9..16, solves the block-symmetric vertex system,
and reports every solution with its two slacks, whether it is a genuine k-block
point, and the negative-graph triangle count (the exact criterion for S = 0 at a
coordinate-diagonal point).
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import itertools
import sys
import time

import numpy as np

sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r53_core import Pval, Qop, alt, pairs_of, ricci, slack_struct, slack_theta, theta0
from review_r53_m2m3 import embed, solve_vertex
from review_r53_m4 import genuine, neg_graph_slack

LOG = _os.path.join(_ROOT, 'agent_logs/review_r53_multiblock.log')


def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open(LOG, 'a') as f:
        f.write(line + '\n')


def partitions(n, k, minpart=2):
    if k == 1:
        if n >= minpart:
            yield (n,)
        return
    for first in range(minpart, n - minpart * (k - 1) + 1):
        for rest in partitions(n - first, k - 1, first):
            yield (first,) + rest


def main():
    log("M4 part 2: wide scan for multi-block critical points with S = 0")
    hits = []
    allrows = []
    t0 = time.time()
    cases = []
    for n in range(9, 17):
        for k in (3, 4, 5):
            for bl in partitions(n, k):
                cases.append((n, bl))
    log(f"  {len(cases)} partitions to solve (n=9..16, k=3,4,5)")
    for ci, (n, bl) in enumerate(cases):
        if ci % 10 == 0:
            log(f"  ... {ci}/{len(cases)} partitions, {time.time()-t0:.0f}s elapsed, "
                f"{len(hits)} genuine S=0 hits so far")
        try:
            sols = solve_vertex(bl, nstart=250, seed=1000 + ci)
        except Exception as exc:
            log(f"  {bl}: solver failed {exc}")
            continue
        for w, th in sols:
            W = embed(bl, w)
            nrm = np.linalg.norm(W)
            if nrm < 1e-9:
                continue
            W = W / nrm
            thf = Pval(n, W)
            res = float(np.linalg.norm(Qop(n, W) - thf * W))
            if res > 1e-9:
                continue
            g, why = genuine(bl, w)
            sn = slack_struct(n, W)
            st = slack_theta(n, W, thf)
            tri, ne = neg_graph_slack(n, W)
            row = (n, bl, thf, thf / theta0(n), sn, st, tri, g, why, w)
            allrows.append(row)
            if g and sn < 1e-9:
                hits.append(row)
                log(f"  *** GENUINE k={len(bl)} S=0 HIT: n={n} blocks={bl} "
                    f"theta={thf:.9f} ({thf/theta0(n):.4f} theta_0) "
                    f"S_struct={sn:.2e} S_theta={st:.2e} tri={tri}")
                log(f"      vertex matrix w =\n{np.array2string(w, precision=9)}")
    log(f"  scan complete in {time.time()-t0:.0f}s: {len(allrows)} critical points, "
        f"{len(hits)} genuine multi-block points with S = 0")

    # explicit sign-pattern census: which genuine points have a POSITIVE cross entry?
    pos_cross = [r for r in allrows if r[7] and any(
        r[9][a, b] > 1e-9 for a in range(len(r[1])) for b in range(a + 1, len(r[1])))]
    log(f"  genuine k>=3 points with at least one POSITIVE cross-block entry: {len(pos_cross)}")
    for r in pos_cross[:40]:
        log(f"    n={r[0]} blocks={r[1]} theta={r[2]:.6f} ({r[3]:.4f} th0) "
            f"S_struct={r[4]:.4f} tri={r[6]}")

    log("  --- all GENUINE k>=3 points, sorted by theta/theta_0 ---")
    log(f"  {'n':>3} {'blocks':>16} {'theta':>10} {'th/th0':>8} {'S_struct':>11} "
        f"{'S_theta':>11} {'tri':>5}")
    seen = set()
    for (n, bl, thf, r, sn, st, tri, g, why, w) in sorted(
            [r for r in allrows if r[7]], key=lambda r: -r[3]):
        key = (n, bl, round(thf, 9))
        if key in seen:
            continue
        seen.add(key)
        log(f"  {n:3d} {str(bl):>16} {thf:10.6f} {r:8.4f} {sn:11.4f} {st:11.6f} {tri:5d}")

    # the disagreement question: do the two slacks have the same zero set here?
    dis = [r for r in allrows if (r[4] < 1e-9) != (abs(r[5]) < 1e-9)]
    log(f"  points where the two slacks disagree about vanishing: {len(dis)}")
    for r in dis[:20]:
        log(f"    n={r[0]} blocks={r[1]} theta={r[2]:.6f} S_struct={r[4]:.3e} S_theta={r[5]:.3e}")
    import pickle
    with open(_os.path.join(_ROOT, 'agent_logs/review_r53_scan.pkl'), 'wb') as f:
        pickle.dump(allrows, f)
    log("M4 part 2 done")


if __name__ == '__main__':
    main()
