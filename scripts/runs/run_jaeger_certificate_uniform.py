"""
I64: a CHECKABLE interval certificate for Jaeger's Lemma 3.5.6, at n = 12 and n = 14.

WHAT WAS WRONG WITH THE OLD DISCHARGE.  run_jaeger_e5a_interval.py subdivides
ADAPTIVELY, so the subdivision exists only during the run and its box count is
printed rather than recorded.  The record's "ten subintervals" was an artefact of
one run, not an object a reader can check.  And it runs at n = 12 only, against a
claim that both dimensions are machine-checked.

WHAT THIS PRODUCES INSTEAD.  A UNIFORM subdivision of [VLO, VHI] into K equal
parts, so every endpoint is v_k = VLO + k*(VHI - VLO)/K and a reader reconstructs
the whole list from three rationals and an integer.  For each box the script
prints a rational upper bound U_k, rounded UP, with RHS <= U_k < 0 proved by
validated interval arithmetic.  Checking the certificate needs the table and an
interval evaluator -- not this script, and not its search.

THE CONSTANTS, and which are n-free.  The supporting line comes from E5's
Lagrangian certificate (alpha, beta, gamma) = (7/10, 1/152, 613/2000), whose
quartic nonnegativity is n-free; only the -n*beta term moves, giving
phi(v) = (7/10) v + gamma - n*beta.  The range ends are VLO = (n-2)/(n-3)^2 and
VHI = E(n) = (8n^2 - 41n + 49)/(4(n+1)(n-2)(n-3)).  The 263/144 in the lift is
n-free -- see scripts/lib/run_jaeger_threshold.py line 13.
"""
import math
from fractions import Fraction as F
from mpmath import iv, mp

iv.dps = 50
mp.dps = 50

ALPHA, BETA, GAMMA = F(7, 10), F(1, 152), F(613, 2000)

def constants(n):
    t0sq = F(2 * (n - 1) * (n - 3), (n + 1) * (n - 2))
    vlo = F(n - 2, (n - 3) ** 2)
    vhi = F(8 * n * n - 41 * n + 49, 4 * (n + 1) * (n - 2) * (n - 3))
    return t0sq, vlo, vhi, GAMMA - n * BETA

def rhs_upper(n, lo, hi):
    """Validated upper bound for max-over-cases RHS on the box [lo, hi]."""
    t0sq, _, _, const = constants(n)
    T0 = iv.sqrt(iv.mpf(t0sq.numerator) / iv.mpf(t0sq.denominator))
    TH0 = (iv.mpf(n - 2) / iv.mpf(n - 3)) * T0
    T_HI = iv.mpf(n - 3) * T0
    v = iv.mpf([iv.mpf(lo.numerator) / iv.mpf(lo.denominator),
                iv.mpf(hi.numerator) / iv.mpf(hi.denominator)])
    phi = (iv.mpf(ALPHA.numerator) / iv.mpf(ALPHA.denominator)) * v \
        + iv.mpf(const.numerator) / iv.mpf(const.denominator)
    y = phi ** 2
    x = iv.mpf(n) * v - 1
    pos = (2 * iv.sqrt(2) / TH0) * iv.sqrt(1 - v) * (v + iv.sqrt((v ** 2 - y ** 2) / (1 - y)))
    best = None
    for t in (TH0 / v, T_HI):
        e = (-(iv.mpf(263) / 144) * (iv.mpf(n - 3) / (n ** 2 * (n - 2)))
             * (t ** 2 - t ** 3 / (iv.mpf(n) * TH0))
             - 2 * T0 * (iv.mpf(2 * n - 9) / (4 * n ** 3)
                         + (iv.mpf(3) / (8 * n ** 2)) * x) * t + pos)
        eb = float(e.b)
        best = eb if best is None else max(best, eb)
    return best

def certificate(n, K):
    t0sq, vlo, vhi, const = constants(n)
    width = (vhi - vlo) / K
    rows, worst = [], None
    for k in range(K):
        lo, hi = vlo + k * width, vlo + (k + 1) * width
        u = rhs_upper(n, lo, hi)
        if not (u < 0):
            return None, None
        rows.append((k, F(int(math.floor(u * 10 ** 6)) + 1, 10 ** 6)))
        worst = u if worst is None else max(worst, u)
    return rows, worst

for n in (12, 14):
    t0sq, vlo, vhi, const = constants(n)
    K = 1
    while K <= 4096:
        rows, worst = certificate(n, K)
        if rows:
            break
        K *= 2
    print(f"n = {n}")
    print(f"  phi(v) = (7/10) v + {const}")
    print(f"  v in [{vlo}, {vhi}],  K = {K} equal parts,  width = {(vhi-vlo)/K}")
    print(f"  worst upper bound over all boxes: {float(worst):+.8f}")
    print("  k : rational upper bound U_k  (RHS <= U_k < 0 on box k)")
    for k, u in rows:
        print(f"   {k:2d} : {u}")
    print()
