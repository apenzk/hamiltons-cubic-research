"""Reviewer 24 phase 1: does the hand-derived vertex point solve Q(W) = theta W,
and does RHS match the balanced-family identity and my general closed form?"""
import numpy as np
from itertools import combinations_with_replacement

from review_r24_core import (struct_c, Q_full, rsharp_diag, pairs_of, ric_op,
                             ric_diag, vertex_closed, theta2_closed,
                             lam_from_blocks, rhs_from_definition,
                             slack_from_definition, rhs_closed_r24,
                             j5_over_r2_closed)


def alt_norm2_diag(lam, prs, n):
    """||Alt(W)||^2 for a diagonal operator: the Lambda^4 part."""
    pos = {p: t for t, p in enumerate(prs)}
    tot = 0.0
    for (i, j, k, l) in combinations_with_replacement(range(n), 4):
        pass
    from itertools import combinations
    for (i, j, k, l) in combinations(range(n), 4):
        # R_{ijkl} vanishes unless {i,j}={k,l}; all three cyclic terms vanish
        v = 0.0
        tot += v * v
    return tot


print("=" * 78)
print("PART A: is the hand-derived vertex point an exact critical point?")
print("=" * 78)
print(f"{'blocks':>18} {'n':>3} {'th^2 closed':>13} {'||Q(W)-thW||':>13} "
      f"{'|W|-1':>10} {'||Ric(W)||':>11}")
cases = [(2, 2, 2), (2, 3, 3), (3, 3, 3), (2, 2, 4), (4, 4, 4), (2, 2, 2, 2),
         (2, 3, 4, 3), (2, 2, 2, 2, 2), (2, 2, 2, 2, 2, 2), (2, 2, 8),
         (2, 2, 2, 6), (3, 4, 5), (5, 5), (2, 10), (6, 6)]
for blocks in cases:
    n = sum(blocks)
    if n > 12:
        continue
    prs, pos, N, c = struct_c(n)
    w, th = vertex_closed(blocks)
    lam = lam_from_blocks(blocks, w, prs)
    W = np.diag(lam)
    QW = Q_full(W, c)
    res = np.linalg.norm(QW - th * W)
    Ric = ric_op(W, prs, n)
    print(f"{str(blocks):>18} {n:>3} {theta2_closed(blocks):>13.9f} "
          f"{res:>13.2e} {abs(np.linalg.norm(W)-1):>10.1e} "
          f"{np.linalg.norm(Ric):>11.2e}")

print()
print("  (diagonal R^# formula vs full structure-constant R^#, n = 6..10)")
for n in (6, 8, 10):
    prs, pos, N, c = struct_c(n)
    rng = np.random.default_rng(n)
    lam = rng.normal(size=N)
    full = Q_full(np.diag(lam), c)
    dg = lam ** 2 + rsharp_diag(lam, prs, pos, n)
    off = np.max(np.abs(full - np.diag(np.diag(full))))
    print(f"    n={n}: max|diag - hand formula| = "
          f"{np.max(np.abs(np.diag(full)-dg)):.2e}   max off-diagonal |Q| = {off:.2e}")

print()
print("=" * 78)
print("PART B: CLAIM 3 -- RHS = theta(4m-1)/(3m-1) on balanced (S^m)^3 ?")
print("=" * 78)
print(f"{'m':>4} {'n':>4} {'theta':>12} {'RHS (definition)':>18} "
      f"{'theta(4m-1)/(3m-1)':>20} {'diff':>10} {'S':>10}")
for m in (2, 3, 4, 5, 6, 8, 12, 20, 50):
    blocks = (m, m, m)
    n = 3 * m
    prs = pairs_of(n)
    w, th = vertex_closed(blocks)
    lam = lam_from_blocks(blocks, w, prs)
    rhs, info = rhs_from_definition(lam, prs, n, delta2=0.0)
    pred = th * (4 * m - 1) / (3 * m - 1)
    S = slack_from_definition(lam, prs, n, th)
    print(f"{m:>4} {n:>4} {th:>12.9f} {rhs:>18.12f} {pred:>20.12f} "
          f"{abs(rhs-pred):>10.1e} {S:>10.6f}")

print()
print("  theta^2 vs (3m-1)(m-1)/(3m^2), and sqrt(1-e^2) vs 2 sqrt(2m(m-1))/(3m-1):")
for m in (2, 3, 8, 20):
    blocks = (m, m, m)
    n = 3 * m
    prs = pairs_of(n)
    w, th = vertex_closed(blocks)
    lam = lam_from_blocks(blocks, w, prs)
    _, info = rhs_from_definition(lam, prs, n)
    t2 = (3 * m - 1) * (m - 1) / (3.0 * m * m)
    e = 2 * np.sqrt(2 * m * (m - 1)) / (3 * m - 1)
    print(f"    m={m:>3}: theta^2 {th**2:.12f} vs {t2:.12f} (d={abs(th**2-t2):.1e})   "
          f"sq(1-e^2) {info['sq1me2']:.12f} vs {e:.12f} (d={abs(info['sq1me2']-e):.1e})   "
          f"trSh4 {info['trSh4']:.9f} vs 1/n {1/n:.9f}")

print()
print("=" * 78)
print("PART C: my general closed form for RHS vs RHS from the definition")
print("=" * 78)


def partitions(n, k, lo=2):
    for cmb in combinations_with_replacement(range(lo, n + 1), k):
        if sum(cmb) == n:
            yield tuple(sorted(cmb))


worst, cnt = 0.0, 0
worst_at = None
rows = []
for n in range(4, 25):
    for k in range(2, 7):
        for b in partitions(n, k):
            prs = pairs_of(n)
            w, th = vertex_closed(b)
            lam = lam_from_blocks(b, w, prs)
            rhs, _ = rhs_from_definition(lam, prs, n)
            rc = rhs_closed_r24(b)
            d = abs(rhs - rc)
            if d > worst:
                worst, worst_at = d, (n, b)
            cnt += 1
            rows.append((n, b, th, rhs, rhs - th, j5_over_r2_closed(b),
                         slack_from_definition(lam, prs, n, th)))
print(f"  {cnt} partitions (k=2..6, n=4..24), max |closed - definition| = {worst:.3e}"
      f"   at {worst_at}")
wj = max(abs(r[4] - r[5]) for r in rows)
print(f"  max |(RHS-theta) - mu(A1^2-2C2)/A2| = {wj:.3e}")
ws = max(abs(r[6] - 3 * r[2] ** 2 * (lambda bb: sum(bb[i] * bb[j] * bb[l]
        for i in range(len(bb)) for j in range(i + 1, len(bb))
        for l in range(j + 1, len(bb))))(r[1]) / (r[0] - 1) ** 2) for r in rows)
print(f"  max |S - 3 theta^2 e_3/(n-1)^2| = {ws:.3e}")
mn = min(rows, key=lambda r: r[4])
print(f"  min RHS-theta over these = {mn[4]:.9f} at n={mn[0]} blocks={mn[1]} "
      f"(k={len(mn[1])})")
k2 = [r for r in rows if len(r[1]) == 2]
print(f"  two-block points: max |RHS-theta| = {max(abs(r[4]) for r in k2):.3e}  "
      f"max |S| = {max(abs(r[6]) for r in k2):.3e}   ({len(k2)} of them)")
