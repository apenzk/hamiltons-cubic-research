"""Reviewer 53, M4: the slack at (S^3)^3, and a hunt for a multi-block product with S = 0.

Three things:
  1. Compute BOTH slacks at (S^3)^3 -- the structural bracket leakage (in two
     normalisations) and the theta-formula ||Ric(W_-)||^2 + 6 d^2 - th tr(W_-) - tr(W_-^2)
     -- plus the repository's own two implementations, and compare.
  2. Prove/record the combinatorial criterion for S = 0 at a coordinate-diagonal
     point: S = 0  <=>  the graph G = {(i,j) : w_ij < 0} is triangle-free.
  3. Scan multi-block critical points (k = 3,4,5; many partitions; n up to 16)
     for any with S = 0, and separate the genuine k-block points from coarsenings.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import itertools
import sys
import time

import numpy as np

sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r53_core import (Npairs, Pval, Qop, alt, leaks, pairs_of, ricci,
                             slack_struct, slack_theta, theta0)
from review_r53_m2m3 import embed, solve_vertex, vertex_residual

LOG = _os.path.join(_ROOT, 'agent_logs/review_r53_multiblock.log')


def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open(LOG, 'a') as f:
        f.write(line + '\n')


def neg_graph_slack(n, W, tol=1e-9):
    """Combinatorial slack for a coordinate-diagonal W: count of paths i-j-k whose
    closing edge ik is also negative.  Returns (#triangles*, edges)."""
    prs, idx = pairs_of(n)
    d = np.diag(W)
    E = set()
    for a, (i, j) in enumerate(prs):
        if d[a] < -tol:
            E.add((i, j))
    tri = 0
    for (i, j, k) in itertools.combinations(range(n), 3):
        e = [(i, j) in E, (i, k) in E, (j, k) in E]
        if all(e):
            tri += 1
    return tri, len(E)


def is_diag(W):
    return np.max(np.abs(W - np.diag(np.diag(W)))) < 1e-12


def genuine(blocks, w, tol=1e-7):
    """Is the vertex matrix a genuine, indecomposable |blocks|-block point?

    Rejected: a zero block (the point is a padding of a smaller one); two blocks
    that merge (the point is really a coarser product); a disconnected pattern of
    nonzero cross entries (the point is an orthogonal block SUM of smaller
    critical points, which the harmonic-square law already covers).
    """
    k = len(blocks)
    for a in range(k):
        if np.max(np.abs(w[a, :])) < tol:
            return False, f"block {a} is zero (padding)"
    for a in range(k):
        for b in range(a + 1, k):
            same = abs(w[a, a] - w[b, b]) < tol and abs(w[a, a] - w[a, b]) < tol
            if same:
                rest = [c for c in range(k) if c not in (a, b)]
                if all(abs(w[a, c] - w[b, c]) < tol for c in rest):
                    return False, f"blocks {a},{b} merge"
    # connectivity of the block graph via nonzero cross entries
    seen = {0}
    stack = [0]
    while stack:
        a = stack.pop()
        for b in range(k):
            if b not in seen and abs(w[a, b]) > tol:
                seen.add(b)
                stack.append(b)
    if len(seen) < k:
        return False, "decomposable (orthogonal block sum)"
    return True, "genuine"


def main():
    log("M4: slack at (S^3)^3 and the hunt for a multi-block product with S = 0")

    # ---------------------------------------------------------------- (S^3)^3
    blocks = (3, 3, 3)
    n = 9
    w = np.full((3, 3), -0.0962250448649377)
    np.fill_diagonal(w, 0.2886751345948129)
    W = embed(blocks, w)
    W = W / np.linalg.norm(W)
    th = Pval(n, W)
    log(f"  (S^3)^3 n=9: theta={th:.12f}, resid={np.linalg.norm(Qop(n,W)-th*W):.2e}")
    s_nat = slack_struct(n, W, scaled=False)
    s_scaled = slack_struct(n, W, scaled=True)
    s_theta = slack_theta(n, W, th)
    log(f"    structural slack, natural coordinates : {s_nat:.9f}")
    log(f"    structural slack, x (n-2)^2 = x{(n-2)**2}  : {s_scaled:.6f}")
    log(f"    theta-formula slack                   : {s_theta:.9f}")
    lk = leaks(n, W)
    log(f"    leaks (mm->m, hm->h, hh->m)           : {lk[0]:.6f} {lk[1]:.6f} {lk[2]:.6f}")
    tri, ne = neg_graph_slack(n, W)
    log(f"    negative graph: {ne} edges, {tri} triangles (S=0 iff triangle-free)")

    # repository implementations, run as-is
    try:
        import b_padded_s3s3 as bp
        from review_r30_core import adj as r30_adj
        A = r30_adj(n)
        s_repo = bp.slack(n, W, A, Npairs(n))
        log(f"    repository b_padded_s3s3.slack(...)   : {s_repo:.6f}")
        log(f"      ratio repo / natural = {s_repo/s_nat:.9f}   (n-2)^2 = {(n-2)**2}")
    except Exception as exc:
        log(f"    repository b_padded_s3s3.slack failed: {exc}")
    try:
        import g1_second_order as g1
        N_, c_, L2_, alt_idx_, B_ = g1.setup(n)
        s_repo2 = g1.slack(L2_, W, c_, alt_idx_, th)
        log(f"    repository g1_second_order.slack(...) : {s_repo2:.9f}")
        log(f"      difference from my theta-formula     : {abs(s_repo2-s_theta):.2e}")
    except Exception as exc:
        log(f"    repository g1_second_order.slack failed: {exc}")

    # ------------------------------------------- do the two slacks agree elsewhere?
    log("  do the two slack functions agree?  (subalgebra family + sphere products)")
    rows = []
    from review_r53_m2m3 import solve_vertex as sv
    for bl in [(3, 3), (4, 4), (5, 5), (3, 5), (2, 6), (3, 3, 3), (4, 4, 4),
               (3, 3, 6), (2, 5, 5), (3, 4, 5), (3, 3, 3, 3)]:
        nn = sum(bl)
        for wv, thv in sv(bl, nstart=200):
            Wv = embed(bl, wv)
            Wv = Wv / np.linalg.norm(Wv)
            thf = Pval(nn, Wv)
            g, why = genuine(bl, wv)
            rows.append((bl, nn, thf, slack_struct(nn, Wv), slack_struct(nn, Wv, scaled=True),
                         slack_theta(nn, Wv, thf), neg_graph_slack(nn, Wv), g, why))
    log(f"  {'blocks':>14} {'n':>3} {'theta':>10} {'th/th0':>8} {'S_nat':>12} "
        f"{'S_(n-2)^2':>12} {'S_theta':>12} {'tri':>5} {'genuine':>8}")
    for (bl, nn, thf, sn, ss, st, (tri, ne), g, why) in sorted(rows, key=lambda r: (r[1], -r[2])):
        log(f"  {str(bl):>14} {nn:3d} {thf:10.6f} {thf/theta0(nn):8.4f} {sn:12.6f} "
            f"{ss:12.4f} {st:12.6f} {tri:5d} {str(g):>8} {'' if g else why}")

    log("M4 part 1 done")


if __name__ == '__main__':
    main()
