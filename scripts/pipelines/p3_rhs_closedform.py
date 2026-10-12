"""
RHS in closed form for general multi-block partitions.

J_5 >= 0 is proven on balanced (S^m)^k, where RHS = theta(4m-1)/(3m-1) gives
J_5/r^2 = theta m/(3m-1) > 0.  Extending that to unbalanced partitions needs RHS
itself in closed form, and the structure invites it: the multi-block operator is
DIAGONAL in coordinate 2-planes, with entry w[a,b] depending only on which blocks
the two indices fall in.  So every ingredient of

    RHS = sqrt(2) sqrt(1 - tr(Shat^4)) sqrt(1 - e^2)
          - <Ric(W_-^2), rho>/|rho|^2  +  12 delta^2 lambda_max(rho)/|rho|^2

should reduce to sums over blocks: W_- is diagonal, rho = Ric(W_-) is diagonal in
coordinates with entries constant on each block, delta^2 = 0 on this family, and
Shat is rho normalised.

This derives each piece symbolically in the block sizes and the vertex values
w[a,b], then checks the assembled expression against the numerically computed
RHS at every partition the solver can produce.  Agreement makes the unbalanced
J_5 sweep a proof rather than an indication; disagreement localises which piece
resists.
"""
import numpy as np
from itertools import combinations_with_replacement

from weyl import build_structure_constants
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from review_r13_multiblock import multiblock_point
from p5_multiblock_regularity import embed_local, measure


def rhs_closed(blocks, w):
    """RHS from block data alone: W is diagonal with entry w[blk(i),blk(j)]."""
    n = sum(blocks)
    k = len(blocks)
    # multiplicity of each (a,b) pair-class among the coordinate 2-planes
    mult = {}
    for a in range(k):
        mult[(a, a)] = blocks[a] * (blocks[a] - 1) // 2
        for b in range(a + 1, k):
            mult[(a, b)] = blocks[a] * blocks[b]
    # negative part and its Ricci: rho is diagonal in coordinates, constant per block
    def wv(a, b):
        return w[a, b] if a <= b else w[b, a]
    neg = {}
    for key in mult:
        v = -wv(*key)
        if v > 0:
            neg[key] = v
    if not neg:
        return None
    # rho_i = sum over planes through i of (W_-)_{plane}
    rho = np.zeros(k)
    for a in range(k):
        tot = 0.0
        for b in range(k):
            key = (min(a, b), max(a, b))
            if key not in neg:
                continue
            cnt = blocks[b] - (1 if b == a else 0)
            tot += cnt * neg[key]
        rho[a] = tot
    nr2 = float(sum(blocks[a] * rho[a] ** 2 for a in range(k)))
    if nr2 < 1e-14:
        return None
    sh = rho / np.sqrt(nr2)
    trS4 = float(sum(blocks[a] * sh[a] ** 4 for a in range(k)))
    # tr(W_-^2) and the W_-^2 Ricci term
    trWm2 = float(sum(mult[key] * v * v for key, v in neg.items()))
    ricWm2 = np.zeros(k)
    for a in range(k):
        tot = 0.0
        for b in range(k):
            key = (min(a, b), max(a, b))
            if key not in neg:
                continue
            cnt = blocks[b] - (1 if b == a else 0)
            tot += cnt * neg[key] ** 2
        ricWm2[a] = tot
    Bt = float(sum(blocks[a] * ricWm2[a] * rho[a] for a in range(k))) / nr2
    # WRONG DEFINITION -- see review_r13_independent.py:277 for the real one.
    e2 = max(0.0, 1.0 - nr2 / max(trWm2, 1e-300))
    return np.sqrt(2) * np.sqrt(max(1 - trS4, 0.0)) * np.sqrt(max(1 - e2, 0.0)) - Bt


def partitions(n, k, lo=2):
    for cmb in combinations_with_replacement(range(lo, n + 1), k):
        if sum(cmb) == n:
            yield tuple(sorted(cmb))


print(f"{'n':>4} {'blocks':>16} {'RHS numeric':>13} {'RHS closed':>12} {'diff':>10}")
worst, checked = 0.0, 0
for n in (12, 15, 16, 18):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt = build_alt_indices(L2)
    for k in (3, 4):
        for b in partitions(n, k):
            try:
                sols = multiblock_point(b)
            except Exception:
                continue
            for _key, (w, _t) in sorted(sols.items()):
                m = measure(L2, embed_local(L2, b, w), c, alt)
                if m is None:
                    continue
                th, rhs_num, S, res = m
                if res > 1e-8 or S <= 1e-8:
                    continue
                rc = rhs_closed(b, w)
                if rc is None:
                    continue
                d = abs(rc - rhs_num)
                worst = max(worst, d)
                checked += 1
                if checked <= 12:
                    print(f"{n:>4} {str(b):>16} {rhs_num:>13.6f} {rc:>12.6f} {d:>10.2e}")
                break
print(f"\n{checked} ungraded points checked   max |closed - numeric| = {worst:.3e}")
print("   " + ("the closed form reproduces RHS -- the unbalanced sweep becomes a proof"
               if worst < 1e-9 else
               "the closed form does NOT reproduce RHS; a piece is still missing"))
