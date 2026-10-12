"""Reviewer 53: the exact relation between the two slack functions.

Claim to test: at a TWO-EIGENVALUE critical point (unit norm), with v < 0 the
negative eigenvalue,
        S_theta-formula  =  v^2 * S_structural,
so the two agree about vanishing there and differ only by the scale v^2.  Off the
two-eigenvalue class the relation -- and the shared zero set -- both fail.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import time

import numpy as np

sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r53_core import Npairs, Pval, Qop, slack_struct, slack_theta, theta0
from review_r53_m2m3 import embed, solve_vertex
from review_r53_c5 import build_c5
from review_r53_closedform import product_W

LOG = _os.path.join(_ROOT, 'agent_logs/review_r53_multiblock.log')


def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open(LOG, 'a') as f:
        f.write(line + '\n')


def row(name, n, W):
    W = W / np.linalg.norm(W)
    th = Pval(n, W)
    res = float(np.linalg.norm(Qop(n, W) - th * W))
    ev = np.round(np.linalg.eigvalsh(W), 10)
    distinct = sorted(set(ev))
    v = float(min(distinct))
    sn = slack_struct(n, W)
    st = slack_theta(n, W, th)
    pred = v * v * sn
    log(f"  {name:>26} n={n:2d} #eig={len(distinct)} theta={th:.6f} res={res:.1e} "
        f"v={v:+.6f} S_str={sn:10.4f} S_theta={st:+.6f} v^2*S_str={pred:+.6f} "
        f"diff={abs(st-pred):.2e}")
    return len(distinct), abs(st - pred)


def main():
    log("Slack relation: S_theta = v^2 * S_structural on two-eigenvalue points")
    two, many = [], []
    from p5_casimir_family import (projector, casimir_operator, h_adjoint,
                                   h_so3_in_so5, su3_structure_constants,
                                   so_k_structure_constants, h_so_p_so_q)
    for nm, n, gens in [("su(3) bi-invariant", 8, h_adjoint(su3_structure_constants())),
                        ("so(5) adjoint", 10, h_adjoint(so_k_structure_constants(5))),
                        ("so(3) irred in so(5)", 5, h_so3_in_so5()),
                        ("so(4)+so(4)", 8, h_so_p_so_q(8, 4)),
                        ("so(5)+so(5)", 10, h_so_p_so_q(10, 5))]:
        Pi, r = projector(gens, n)
        W = casimir_operator(Pi, r, Npairs(n))
        k, d = row(nm, n, W)
        (two if k == 2 else many).append(d)
    for bl in [(3, 3, 3), (4, 4, 4), (2, 2, 2), (5, 5, 5), (3, 3, 3, 3), (2, 2, 2, 2)]:
        n = sum(bl)
        k, d = row(f"balanced {bl}", n, embed(bl, product_W(bl)))
        (two if k == 2 else many).append(d)
    for bl in [(3, 3, 6), (2, 5, 5), (3, 4, 5), (2, 3, 4)]:
        n = sum(bl)
        k, d = row(f"unbalanced {bl}", n, embed(bl, product_W(bl)))
        (two if k == 2 else many).append(d)
    k, d = row("C_5 blow-up (2,2,2,2,2)", 10, embed((2,) * 5, build_c5(2)))
    (two if k == 2 else many).append(d)
    log(f"  two-eigenvalue points: {len(two)}, max |S_theta - v^2 S_struct| = "
        f"{max(two) if two else 0:.2e}")
    log(f"  three-or-more-eigenvalue points: {len(many)}, max deviation = "
        f"{max(many) if many else 0:.4f}")
    log("slack relation done")


if __name__ == '__main__':
    main()
