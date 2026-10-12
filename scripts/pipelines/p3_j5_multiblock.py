"""
J_5 >= 0 in closed form on the multi-block family.

J_5 >= 0 is the older of the two grants in the lifted chain: proven on the
commuting class, zero violations at 20 points off it, but unproven in general.
Reviewer 23 showed it is also the whole content of the surviving branch of the
sharp (II)-side bound -- at every multi-block witness delta^2 = J_4 = 0 and the
cap vanishes, so

    RHS - theta = J_5 / r^2   identically.

That makes J_5 computable wherever RHS and theta are, and both now have closed
forms on this family:

    theta^2 = 2(n-1)^2 / [ (k-1) n^2 + sum_a (n - n_a)^2/(n_a - 1) ]

so J_5 >= 0 there reduces to an inequality in the block sizes alone.  For the
balanced case it is immediate -- RHS = theta (4m-1)/(3m-1) gives
J_5/r^2 = theta * m/(3m-1) > 0 -- and the question is whether that survives
arbitrary partitions.

This computes J_5/r^2 = RHS - theta directly across many partitions, checks it
against the closed forms, and reports the minimum.  A negative value would
refute the grant on the one family where the bound's margin consists entirely of
it; a positive floor proves the grant there.
"""
import numpy as np
from itertools import combinations_with_replacement

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from review_r13_multiblock import multiblock_point
from p5_multiblock_regularity import embed_local, measure

SQ32 = np.sqrt(1.5)


def theta_closed(blocks):
    n = sum(blocks)
    k = len(blocks)
    den = (k - 1) * n * n + sum((n - a) ** 2 / (a - 1) for a in blocks if a > 1)
    if den <= 0 or any(a < 2 for a in blocks):
        return None
    return np.sqrt(2 * (n - 1) ** 2 / den)


def partitions(n, k, lo=2):
    for c in combinations_with_replacement(range(lo, n - lo * (k - 1) + 1), k):
        if sum(c) == n:
            yield tuple(sorted(c))


rows = []
print(f"{'n':>4} {'blocks':>18} {'theta':>10} {'closed':>10} {'RHS':>10} {'J5/r^2':>10} {'S':>8}")
for n in (12, 15, 16, 18, 20, 21, 24):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt = build_alt_indices(L2)
    seen = set()
    for k in (3, 4, 5):
        for b in partitions(n, k):
            if b in seen:
                continue
            seen.add(b)
            try:
                sols = multiblock_point(b)
            except Exception:
                continue
            for _key, (w, _t) in sorted(sols.items()):
                m = measure(L2, embed_local(L2, b, w), c, alt)
                if m is None:
                    continue
                th, rhs, S, res = m
                if res > 1e-8 or th < 1e-6 or S <= 1e-8:
                    continue          # ungraded points only
                tc = theta_closed(b)
                j5 = rhs - th
                rows.append((n, b, th, tc, rhs, j5, S))
                if len(rows) <= 24:
                    print(f"{n:>4} {str(b):>18} {th:>10.6f}"
                          f" {tc if tc else float('nan'):>10.6f} {rhs:>10.6f}"
                          f" {j5:>10.6f} {S:>8.3f}", flush=True)
                break

if rows:
    j5s = [r[5] for r in rows]
    dev = max(abs(r[2] - r[3]) for r in rows if r[3])
    print(f"\n{len(rows)} ungraded multi-block points")
    print(f"   closed form vs measured theta: max deviation {dev:.2e}")
    print(f"   J_5/r^2 range [{min(j5s):.6f}, {max(j5s):.6f}]")
    print(f"   {'*** J_5 NEGATIVE SOMEWHERE ***' if min(j5s) < -1e-9 else 'J_5 >= 0 throughout this family'}")
