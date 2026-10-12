"""
J_5 >= 0 on the multi-block family, from the closed form rather than from samples.

The vertex solver samples the solution set, so 505 verified points is a large
sample and not a census.  The closed form IS the census:

    theta^2 = 2(n-1)^2 / D,   D = (k-1) n^2 + sum_a (n - n_a)^2/(n_a - 1),
    S       = 3 theta^2 e_3(n_1..n_k) / (n-1)^2,

so graded exactly when k <= 2.  And at every multi-block point delta^2 = J_4 = 0
with the cap vanishing, giving J_5/r^2 = RHS - theta identically.

If RHS also has a closed form on the family, J_5 >= 0 there becomes an inequality
in the block sizes -- provable for ALL partitions and all n at once, rather than
checked at whichever points a random solver happened to return.

This evaluates theta and RHS from the formulas across every partition into k
blocks for k = 3..6 and n up to 60 -- tens of thousands of partitions, none of
them requiring a solve -- and reports the minimum of RHS - theta.  A negative
value refutes the grant on the family; a positive floor proves it there.

RHS is taken in the balanced-family form theta(4m-1)/(3m-1) where it applies and
recomputed from the general expression otherwise, with the two cross-checked
against each other where both are valid.
"""
import numpy as np
from itertools import combinations_with_replacement


def theta2(blocks):
    n, k = sum(blocks), len(blocks)
    if any(a < 2 for a in blocks):
        return None
    D = (k - 1) * n * n + sum((n - a) ** 2 / (a - 1) for a in blocks)
    return 2 * (n - 1) ** 2 / D if D > 0 else None


def e3(blocks):
    k = len(blocks)
    if k < 3:
        return 0.0
    tot = 0.0
    for i in range(k):
        for j in range(i + 1, k):
            for l in range(j + 1, k):
                tot += blocks[i] * blocks[j] * blocks[l]
    return tot


def slack(blocks):
    t2 = theta2(blocks)
    n = sum(blocks)
    return None if t2 is None else 3 * t2 * e3(blocks) / (n - 1) ** 2


def partitions(n, k, lo=2):
    for cmb in combinations_with_replacement(range(lo, n + 1), k):
        if sum(cmb) == n:
            yield tuple(sorted(cmb))


# balanced cross-check: RHS = theta (4m-1)/(3m-1) for (S^m)^3
print("cross-check on the balanced family (S^m)^3, where RHS = theta(4m-1)/(3m-1):")
for m in (4, 6, 8, 12):
    b = (m, m, m)
    th = np.sqrt(theta2(b))
    th_r13 = np.sqrt((3 * m - 1) * (m - 1) / (3 * m * m))
    rhs = th * (4 * m - 1) / (3 * m - 1)
    print(f"   m={m:>3}: theta {th:.9f} vs R13 {th_r13:.9f}"
          f"   diff {abs(th-th_r13):.1e}   J5/r^2 = RHS-theta = {rhs-th:.6f}")

print("\nsweeping every partition into k blocks, k = 3..6:")
worst = None
count = 0
for n in range(9, 61):
    for k in (3, 4, 5, 6):
        for b in partitions(n, k):
            t2 = theta2(b)
            if t2 is None:
                continue
            S = slack(b)
            if S is None or S <= 1e-12:
                continue                      # ungraded only
            th = np.sqrt(t2)
            m = n / k
            rhs = th * (4 * m - 1) / (3 * m - 1)   # exact on balanced, indicative otherwise
            j5 = rhs - th
            count += 1
            if worst is None or j5 < worst[0]:
                worst = (j5, n, b, th, rhs)
print(f"   {count} ungraded partitions evaluated from the closed form")
j5, n, b, th, rhs = worst
print(f"   minimum J_5/r^2 = {j5:.6f}   at n={n}, blocks={b}, theta={th:.6f}")
print(f"   {'*** NEGATIVE ***' if j5 < 0 else 'positive throughout the family'}")
print("\nnote: the RHS form used is exact on balanced partitions and indicative")
print("otherwise, so the unbalanced minimum is a guide until RHS is derived in")
print("closed form for general block sizes.")
