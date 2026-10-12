"""Reviewer 24 phase 3: the corrected J_5 sweep, the definitional J_5 check,
and where the multi-block family sits relative to the lifted chain's own
applicability floor."""
import numpy as np
from itertools import combinations_with_replacement

from review_r24_core import (struct_c, rsharp_full, pairs_of, ric_op, ric_diag,
                             vertex_closed, theta2_closed, lam_from_blocks,
                             rhs_from_definition, slack_from_definition,
                             rhs_closed_r24, j5_over_r2_closed)

SQ32 = np.sqrt(1.5)


def partitions(n, k, lo=2):
    """all n_1 <= ... <= n_k with n_a >= lo summing to n, generated directly."""
    if k == 1:
        if n >= lo:
            yield (n,)
        return
    hi = n // k
    for first in range(lo, hi + 1):
        for rest in partitions(n - first, k - 1, first):
            yield (first,) + rest


print("=" * 78)
print("PART D: J_5 from its own definition, J5 = <Ric(X_inv), Ric(|W|)>,")
print("        X_inv = |W|^# + (W - theta)|W|;  is J5/r^2 = RHS - theta?")
print("=" * 78)
print(f"{'blocks':>16} {'theta':>11} {'J5':>13} {'r^2':>11} {'J5/r^2':>12} "
      f"{'RHS-theta':>12} {'diff':>9} {'delta^2':>9}")
for blocks in [(2, 2, 2), (2, 3, 3), (3, 3, 3), (2, 2, 4), (4, 4, 4), (2, 2, 2, 2),
               (2, 2, 2, 2, 2), (2, 2, 8), (3, 4, 5), (5, 5), (6, 6), (2, 10),
               (4, 8), (2, 2, 2, 2, 2, 2)]:
    n = sum(blocks)
    prs, pos, N, c = struct_c(n)
    w, th = vertex_closed(blocks)
    lam = lam_from_blocks(blocks, w, prs)
    W = np.diag(lam)
    aW = np.diag(np.abs(lam))
    Xinv = rsharp_full(aW, c) + (W - th * np.eye(N)) @ aW
    Ric = ric_op(aW, prs, n)
    r2 = float(np.sum(Ric * Ric))
    J5 = float(np.sum(ric_op(Xinv, prs, n) * Ric))
    rhs, _ = rhs_from_definition(lam, prs, n)
    # delta^2 = ||Alt W_-||^2, Alt of an operator diagonal in coordinate 2-planes
    print(f"{str(blocks):>16} {th:>11.7f} {J5:>13.7f} {r2:>11.7f} {J5/r2:>12.8f} "
          f"{rhs-th:>12.8f} {abs(J5/r2-(rhs-th)):>9.1e} {0.0:>9.1e}")

print()
print("=" * 78)
print("PART E: corrected sweep -- min of J_5/r^2 = mu (A1^2 - 2 C2)/A2")
print("=" * 78)
worst = None
count = 0
by_k = {}
for n in range(6, 61):
    for k in range(3, 7):
        for b in partitions(n, k):
            j5 = j5_over_r2_closed(b)
            count += 1
            if worst is None or j5 < worst[0]:
                worst = (j5, n, b)
            by_k.setdefault(k, []).append((j5, n, b))
print(f"  {count} ungraded partitions (k=3..6, n<=60), all from the closed form")
print(f"  minimum J_5/r^2 = {worst[0]:.9f} at n={worst[1]}, blocks={worst[2]}")
for k in sorted(by_k):
    mk = min(by_k[k])
    print(f"    k={k}: min {mk[0]:.9f} at n={mk[1]} {mk[2]}   ({len(by_k[k])} partitions)")
print(f"  FINDINGS reports 0.154185 at (2,2,2,2,2,50); correct value there = "
      f"{j5_over_r2_closed((2,2,2,2,2,50)):.9f}")
print(f"  sign: {'ALL POSITIVE' if worst[0] > 0 else '*** NEGATIVE FOUND ***'}")

print()
print("  identity F = A1^2 - 2 C2 = 4 e_2^2 - 2 sum_a x_a^2, x_a = n_a(n-n_a):")
mx = 0.0
for n in range(4, 41):
    for k in range(2, 8):
        for b in partitions(n, k):
            bb = np.array(b, float)
            x = bb * (n - bb)
            e2 = 0.5 * (n * n - float(np.sum(bb ** 2)))
            F = 4 * e2 ** 2 - 2 * float(np.sum(x ** 2))
            A1 = float(np.sum(bb * (n - bb)))
            C2 = float(np.sum(bb ** 2 * (n - bb) ** 2))
            mx = max(mx, abs(F - (A1 ** 2 - 2 * C2)))
print(f"    max |F - (A1^2-2C2)| over all partitions k=2..7, n<=40 = {mx:.2e}")

print()
print("=" * 78)
print("PART F: where the family sits vs the lifted chain's own theta floor")
print("=" * 78)
print(f"{'n':>4} {'tilde_theta_0':>14} {'theta_min_331':>14} {'sup theta k>=3':>16} "
      f"{'ratio to floor':>15} {'in chain region?':>17}")
for n in (6, 8, 12, 15, 18, 24, 36, 60, 120, 1200):
    t0 = np.sqrt(2.0 * (n - 1) * (n - 3) / ((n + 1.0) * (n - 2)))
    tmin331 = (n - 3.0) * np.sqrt(2.0 / ((n - 1.0) * (n - 2.0)))
    # theta is globally maximised at balanced blocks and decreasing in k, so the
    # supremum over k>=3 partitions of n is the balanced 3-block value
    sup3 = np.sqrt((n - 1.0) * (n - 3.0)) / n
    floor = min(t0, tmin331)
    print(f"{n:>4} {t0:>14.6f} {tmin331:>14.6f} {sup3:>16.6f} "
          f"{sup3/floor:>15.6f} {'YES' if sup3 >= floor else 'no':>17}")
print("  (theta^2 < 2/(k-1) <= 1 for every k>=3 partition, so the ungraded")
print("   multi-block family never reaches either floor)")

print()
print("=" * 78)
print("PART G: RHS >= sqrt(3/2) triggers under the CORRECT RHS")
print("=" * 78)
cases = [(12, (4, 4, 4)), (12, (3, 3, 3, 3)), (12, (2, 5, 5)), (12, (3, 4, 5)),
         (15, (5, 5, 5)), (16, (4, 6, 6)), (18, (6, 6, 6)), (20, (4, 8, 8)),
         (21, (7, 7, 7)), (24, (8, 8, 8)), (24, (6, 6, 6, 6))]
trig = 0
for n, b in cases:
    prs = pairs_of(n)
    w, th = vertex_closed(b)
    lam = lam_from_blocks(b, w, prs)
    rhs, _ = rhs_from_definition(lam, prs, n)
    S = slack_from_definition(lam, prs, n, th)
    hit = rhs >= SQ32
    trig += hit
    print(f"  n={n:>3} {str(b):>14} theta={th:.6f} RHS={rhs:.6f} S={S:.4f}"
          f"{'   <- trigger' if hit else ''}")
print(f"  triggers among p5_multiblock_regularity's own case list: {trig}"
      f"   (that script prints 14)")

hi = []
for n in range(6, 61):
    for k in range(3, 7):
        for b in partitions(n, k):
            prs = None
            rc = rhs_closed_r24(b)
            if rc >= SQ32:
                hi.append((np.sqrt(theta2_closed(b)), rc, n, b))
print(f"  over all k=3..6 partitions to n=60: {len(hi)} have RHS >= sqrt(3/2)")
if hi:
    mx = max(hi)
    print(f"    max theta among them = {mx[0]:.6f} at n={mx[2]} {mx[3]}, RHS={mx[1]:.6f}")
    print(f"    regularity 'RHS>=sqrt(3/2) => theta<=0.916': "
          f"{'holds' if mx[0] <= 0.916 else '*** VIOLATED ***'}")
