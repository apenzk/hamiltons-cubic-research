"""
Why the closed form deviates from the measured theta at some partitions.

Evaluating J_5 across the multi-block family threw a maximum deviation of
1.5e-1 between the measured theta and

    theta^2 = 2(n-1)^2 / [ (k-1) n^2 + sum_a (n - n_a)^2/(n_a - 1) ],

while every printed row agreed exactly.  Two explanations fit: the vertex solver
returns SEVERAL critical points per partition and the comparison took the first,
which need not be the one the formula describes; or the formula is wrong for
some partitions.  They are distinguished by checking whether the formula matches
SOME solution of each partition rather than a particular one.

Reported per partition: every solution's theta, which of them the formula
matches, and whether any partition has no matching solution at all.  A partition
with none would mean the closed form is wrong there, which matters because the
family's census -- and the theta^2 < 2/(k-1) bound drawn from it -- rests on it.
"""
import numpy as np
from itertools import combinations_with_replacement

from weyl import build_structure_constants
from curvature_operator import Lambda2
from run_bianchi_defect import build_alt_indices
from review_r13_multiblock import multiblock_point
from p5_multiblock_regularity import embed_local, measure


def theta_closed(blocks):
    n, k = sum(blocks), len(blocks)
    if any(a < 2 for a in blocks):
        return None
    den = (k - 1) * n * n + sum((n - a) ** 2 / (a - 1) for a in blocks)
    return np.sqrt(2 * (n - 1) ** 2 / den) if den > 0 else None


def partitions(n, k, lo=2):
    for cmb in combinations_with_replacement(range(lo, n - lo * (k - 1) + 1), k):
        if sum(cmb) == n:
            yield tuple(sorted(cmb))


bad = []
tot = 0
for n in (12, 15, 16, 18):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt = build_alt_indices(L2)
    for k in (3, 4):
        for b in partitions(n, k):
            tc = theta_closed(b)
            if tc is None:
                continue
            try:
                sols = multiblock_point(b)
            except Exception:
                continue
            ths = []
            for _key, (w, _t) in sorted(sols.items()):
                m = measure(L2, embed_local(L2, b, w), c, alt)
                if m is None:
                    continue
                th, rhs, S, res = m
                if res < 1e-8 and th > 1e-6:
                    ths.append((th, S))
            if not ths:
                continue
            tot += 1
            hit = [t for t, _ in ths if abs(t - tc) < 1e-7]
            if not hit:
                bad.append((n, b, tc, sorted(t for t, _ in ths)))

print(f"{tot} partitions with at least one verified critical point")
print(f"{len(bad)} where the closed form matches NO solution\n")
for n, b, tc, ths in bad[:10]:
    print(f"  n={n} {b}: closed form {tc:.6f}   solutions {[round(t,6) for t in ths]}")
if not bad:
    print("  the closed form matches some solution of every partition --")
    print("  the deviation was a matching artefact, not an error in the formula")
