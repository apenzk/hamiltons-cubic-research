"""Reviewer 53: closed forms for the multi-block sphere products.

  S_structural = 3 * (number of triangles in the negative graph)
               = 3 * sum_{a<b<c} n_a n_b n_c        for a k-block sphere product,
since the negative graph of S^{n_1} x ... x S^{n_k} is the complete k-partite graph
K_{n_1,...,n_k} and each triangle {i,j,k} contributes exactly 1 for each of its three
unordered edge pairs ([phi_ij, phi_jk] = phi_ik, coefficient 1).

Hence S = 0 is impossible for any sphere product with k >= 3, and the theta ceiling
over the whole k >= 3 family is what actually keeps them away from theta_0.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import itertools
import sys
import time

import numpy as np

sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r53_core import Pval, Qop, pairs_of, ricci, slack_struct, slack_theta, theta0
from review_r53_m2m3 import embed
from review_r53_m4 import neg_graph_slack

LOG = _os.path.join(_ROOT, 'agent_logs/review_r53_multiblock.log')


def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open(LOG, 'a') as f:
        f.write(line + '\n')


def product_W(blocks):
    """Weyl operator of S^{n_1} x ... x S^{n_k}: w_aa = (n-n_a)/((n-1)(n_a-1)),
    w_ab = -1/(n-1)."""
    k = len(blocks)
    n = sum(blocks)
    w = np.zeros((k, k))
    for a in range(k):
        w[a, a] = (n - blocks[a]) / ((n - 1) * (blocks[a] - 1))
        for b in range(k):
            if b != a:
                w[a, b] = -1.0 / (n - 1)
    return w


def main():
    log("Closed forms: S = 3 * #triangles, and the theta ceiling of k >= 3 products")
    log(f"  {'blocks':>18} {'n':>3} {'theta':>10} {'th/th0':>8} {'S_struct':>10} "
        f"{'3*sum n_a n_b n_c':>18} {'resid':>9}")
    worst = 0.0
    best_ratio = 0.0
    best_case = None
    cases = []
    for k in (3, 4, 5, 6):
        for n in range(3 * k, 25):
            for bl in itertools.combinations_with_replacement(range(2, n), k):
                if sum(bl) != n:
                    continue
                cases.append(bl)
    for bl in cases:
        n = sum(bl)
        if n > 20:
            continue
        w = product_W(bl)
        W = embed(bl, w)
        W = W / np.linalg.norm(W)
        th = Pval(n, W)
        res = float(np.linalg.norm(Qop(n, W) - th * W))
        if res > 1e-9:
            log(f"  {str(bl):>18} {n:3d}   NOT CRITICAL (res {res:.1e})")
            continue
        S = slack_struct(n, W)
        pred = 3.0 * sum(bl[a] * bl[b] * bl[c]
                         for a, b, c in itertools.combinations(range(len(bl)), 3))
        worst = max(worst, abs(S - pred))
        r = th / theta0(n)
        if r > best_ratio:
            best_ratio, best_case = r, (bl, n, th)
        if len(bl) == 3 and bl[0] == bl[1] == bl[2] or n <= 14:
            log(f"  {str(bl):>18} {n:3d} {th:10.6f} {r:8.4f} {S:10.1f} {pred:18.1f} "
                f"{res:9.1e}")
    log(f"  max |S - 3*sum n_a n_b n_c| over {len(cases)} products: {worst:.2e}")
    log(f"  highest theta/theta_0 over all k>=3 products with n<=20: {best_ratio:.6f} "
        f"at blocks={best_case[0]} n={best_case[1]} theta={best_case[2]:.6f}")

    log("  balanced k-block products, theta/theta_0 as m grows:")
    for k in (2, 3, 4, 5):
        row = []
        for m in (2, 3, 4, 5, 6):
            n = k * m
            if n > 20 or m < 2:
                continue
            w = product_W((m,) * k)
            W = embed((m,) * k, w)
            W = W / np.linalg.norm(W)
            th = Pval(n, W)
            row.append((n, round(th / theta0(n), 6)))
        log(f"    k={k}: {row}")
    log("closed forms done")


if __name__ == '__main__':
    main()
