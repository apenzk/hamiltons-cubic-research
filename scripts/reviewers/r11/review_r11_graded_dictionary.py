"""
Step 3 of the graded enumeration: closing the dictionary, so theta is computable
from tabulated Lie data alone.

Step 1 gave theta from (p, q, c_k) but left c_k to be measured per embedding.
A second, purely Lie-theoretic identity removes that.  Counting the structure
sum sum_{a,g,d in h} c_{agd}^2 two ways -- once by the grading (only "all three
in k" and "one k, two m" triples survive, since c is totally antisymmetric and
[k,k] in k, [k,m] in m, [m,m] in k), once as the adjoint Casimir of h -- gives

    (R2)    sum_i c_i p_i  +  3 q sum_i C_i  =  c_h^ad (p + q)

(ideals i of k; a single term when k is simple).  Combined with the criticality
relation of step 1,

    (R1)    c_k = [ C (2q - p) - 2 (p + q) ] / q ,

this determines both C and c_k from (p, q, c_h^ad):

    C = (p + q) [ q c_h^ad + 2 p ] / [ 2 p q - p^2 + 3 q^2 ] .

And c_h^ad itself is tabulated data, because the so(n)-induced normalisation is
pinned by a trace: sum_{a in h} tr_{R^n}(e_a^2) = -2 dim h gives the Casimir of h
on R^n as c_V = 2 dim h / n, and the ratio c_h^ad / c_V = C2(adj)/C2(V) is an
intrinsic invariant of the pair (h, V).  Hence

    c_h^ad = (2 (p + q) / n) * C2(adj)/C2(V) .

So for a symmetric pair (h, k) with h acting irreducibly on R^n, theta follows
from p, q, n and one tabulated Casimir ratio -- no curvature computation at all.
This script checks the whole chain against the operators actually built.
"""
import numpy as np

RAT = {  # C2(adjoint) / C2(V), intrinsic, normalisation-independent
    "su(2) on R^4 (=H)": 8 / 3,          # C2(adj)=2, C2(fund)=3/4
    "su(3) on C^3": 9 / 4,               # 3 / (4/3)
    "su(4) on C^4": 32 / 15,             # 4 / (15/8)
    "su(6) on C^6": 72 / 35,             # 6 / (35/12)
    "so(6) on R^6": 8 / 5,               # (2N-4)/(N-1), N=6
    "so(8) on R^8": 12 / 7,              # N=8
    "so(12) on R^12": 20 / 11,           # N=12
}


def chain(p, q, n, ratio):
    """(p, q, n, C2 ratio) -> c_h^ad, C, c_k, theta."""
    ch_ad = (2.0 * (p + q) / n) * ratio
    C = (p + q) * (q * ch_ad + 2 * p) / (2 * p * q - p * p + 3 * q * q)
    ck = (C * (2 * q - p) - 2 * (p + q)) / q
    theta = (ck * q * q + 2 * q * q + p * p) / ((2 * q - p) * np.sqrt(p * q * (p + q)))
    return ch_ad, C, ck, theta


def su_m(m):
    """(su(m), so(m)) acting on C^m = R^{2m}."""
    p = m * (m - 1) // 2
    q = (m - 1) * (m + 2) // 2
    return p, q, 2 * m, 2 * m * m / (m * m - 1)


def sphere(m):
    """(so(2m), so(m)+so(m)) acting on R^{2m} -- the balanced sphere product."""
    return m * (m - 1), m * m, 2 * m, (4 * m - 4) / (2 * m - 1)


CASES = [
    ("Fox S^4(alpha)          (su(2), u(1))", 1, 2, 4, RAT["su(2) on R^4 (=H)"], np.sqrt(1.5)),
    ("su(3) Kaehler           (su(3), so(3))", *su_m(3), 1.095445115),
    ("su(4) Kaehler           (su(4), so(4))", *su_m(4), 1.054092553),
    ("su(6) Kaehler           (su(6), so(6))", *su_m(6), 1.024695077),
    ("balanced S^3xS^3        (so(6), so(3)^2)", *sphere(3), 1.054092553),
    ("balanced S^4xS^4        (so(8), so(4)^2)", *sphere(4), 1.145643924),
    ("balanced S^6xS^6        (so(12), so(6)^2)", *sphere(6), 1.236033081),
]

print(f"{'symmetric pair':<40} {'p':>4} {'q':>4} {'n':>3} "
      f"{'c_h^ad':>8} {'C':>8} {'c_k':>8} {'theta(pred)':>12} {'theta(true)':>12} {'|d|':>9}")
print("-" * 118)
worst = 0.0
for label, p, q, n, ratio, true_th in CASES:
    ch, C, ck, th = chain(p, q, n, ratio)
    d = abs(th - true_th)
    worst = max(worst, d)
    print(f"{label:<40} {p:>4} {q:>4} {n:>3} {ch:>8.4f} {C:>8.4f} {ck:>8.4f} "
          f"{th:>12.9f} {true_th:>12.9f} {d:>9.1e}")
print("-" * 118)
print(f"worst deviation over the catalogue: {worst:.2e}")

# The ideal-wise form of (R2), checked on HP^2 = (so(8), so(3)+so(5)) at n=8,
# where k is not simple: ideals of dim 3 and 10 carry (C_i, c_i) = (2,2), (4,6)
# as measured from the bracket in review_r11_graded_ideals.py.
p_i, C_i, c_i, q, n = [3, 10], [2.0, 4.0], [2.0, 6.0], 15, 8
lhs = sum(c * p for c, p in zip(c_i, p_i)) + 3 * q * sum(C_i)
ch_ad = (2.0 * (sum(p_i) + q) / n) * RAT["so(8) on R^8"]
rhs = ch_ad * (sum(p_i) + q)
print(f"\nideal-wise (R2) at HP^2:  lhs = {lhs:.6f}   rhs = c_h^ad*(p+q) = {rhs:.6f}"
      f"   |d| = {abs(lhs - rhs):.1e}   (c_h^ad = {ch_ad:.4f})")

print("\nExtrapolation the dictionary now permits (no curvature operator built):")
for m in (8, 10, 20, 50):
    _, _, _, th_s = chain(*sphere(m))
    _, _, _, th_k = chain(*su_m(m))
    print(f"  m={m:<3}  balanced S^m x S^m: theta={th_s:.9f}    "
          f"su({m}) Kaehler: theta={th_k:.9f}")
print(f"  limits: sphere -> sqrt(2) = {np.sqrt(2):.9f},  su(m) -> 1")
