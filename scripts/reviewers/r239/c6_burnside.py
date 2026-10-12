"""r239, claim 6.  dim (Sym^d W_n^*)^{B_n} by Burnside over the conjugacy classes of the
hyperoctahedral group, reusing the chi_W polynomial validated in c1_guards.py against an
explicit Weyl projector.

Classes of B_n = signed permutations are pairs of partitions (lam, mu) with |lam|+|mu| = n
-- positive and negative cycles.  A positive cycle of length L has eigenvalues the L-th
roots of 1; a negative cycle of length L the L-th roots of -1.  Hence

    p_m(g) = sum_{L in lam, L | m} L  +  sum_{L in mu, L | m} L * (-1)^{m/L},

and the centralizer order is  z = 2^{l(lam)+l(mu)} z_lam z_mu.

    dim (Sym^d W_n)^{B_n} = sum_classes  chi_{Sym^d W}(class) / z .
"""
from fractions import Fraction
from collections import Counter
from itertools import product as iproduct
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from c1_haar_moments import CHI_W, CHI_V, partitions, zrho, sym_power_char

MAXM = 24

def part_list(k):
    return list(partitions(k)) if k > 0 else [()]

def classes_B(n):
    """yield (lam, mu, centralizer_order)"""
    for k in range(n + 1):
        for lam in part_list(k):
            zl = zrho(lam) * 2 ** len(lam)
            for mu in part_list(n - k):
                yield lam, mu, zl * zrho(mu) * 2 ** len(mu)

def pvals(lam, mu, maxm=MAXM):
    p = [0] * (maxm + 1)
    for m in range(1, maxm + 1):
        s = 0
        for L in lam:
            if m % L == 0:
                s += L
        for L in mu:
            if m % L == 0:
                s += L * (-1) ** (m // L)
        p[m] = s
    return p

def ev(poly, p):
    tot = Fraction(0)
    for e, c in poly.items():
        v = c
        for i, a in enumerate(e):
            if a:
                v *= Fraction(p[i + 1]) ** a
        tot += v
    return tot

CHARS = {}
def sym_char(chi, d, tag):
    key = (tag, d)
    if key not in CHARS:
        CHARS[key] = sym_power_char(chi, d)
    return CHARS[key]

def dim_inv(chi, tag, n, d):
    ch = sym_char(chi, d, tag)
    tot = Fraction(0)
    for lam, mu, z in classes_B(n):
        tot += ev(ch, pvals(lam, mu)) / z
    return tot

def check_class_sum(n):
    return sum(Fraction(1, z) for _, _, z in classes_B(n))

if __name__ == "__main__":
    print("class bookkeeping: sum over classes of 1/|centralizer| must be 1")
    for n in range(1, 13):
        s = check_class_sum(n)
        assert s == 1, (n, s)
    print("  n=1..12: OK")
    print()

    print("control: dim (Sym^d R^n)^{B_n} = #partitions of d/2 into parts <= n")
    def pcount(k, maxpart):
        memo = {}
        def go(k, m):
            if k == 0: return 1
            if (k, m) in memo: return memo[(k, m)]
            t = sum(go(k - p, p) for p in range(1, min(k, m) + 1))
            memo[(k, m)] = t
            return t
        return go(k, maxpart)
    for n in range(2, 8):
        got = [int(dim_inv(CHI_V, "V", n, d)) for d in range(1, 9)]
        want = [0 if d % 2 else pcount(d // 2, n) for d in range(1, 9)]
        print(f"  n={n}: {got}  expected {want}  {'OK' if got == want else '*** MISMATCH ***'}")
        assert got == want
    print()

    print("dim (Sym^d W_n^*)^{B_n}")
    hdr = "   n  " + "".join(f"{'d='+str(d):>10}" for d in range(1, 7))
    print(hdr)
    rows = {}
    for n in range(4, 17):
        row = []
        for d in range(1, 7):
            v = dim_inv(CHI_W, "W", n, d)
            assert v.denominator == 1, (n, d, v)
            row.append(int(v))
        rows[n] = row
        print(f"  {n:2d}  " + "".join(f"{x:>10}" for x in row))
    print()
    print("STATIONARITY of each column (first n at which the column stops changing):")
    for d in range(1, 7):
        col = {n: rows[n][d - 1] for n in rows}
        final = col[16]
        first = min(n for n in sorted(col) if all(col[m] == final for m in sorted(col) if m >= n))
        print(f"  d={d}: value {final}, stationary from n = {first}   (2d = {2*d})")
    print()
    print(f"d=6 value at n>=12: {rows[12][5]}   claim: 339423   "
          f"{'MATCH' if rows[12][5] == 339423 else '*** MISMATCH ***'}")
