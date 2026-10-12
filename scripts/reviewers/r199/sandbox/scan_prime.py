"""Reviewer 199: re-scan the cached basis for coefficients that die mod the NEW prime.

The operative failure is not "p divides a numerator" but to_p(a+bi) == 0 for a
nonzero Gaussian rational, i.e. a + b*IMOD = 0 mod p.  Both are counted, and so
are denominators divisible by p, which trip the assert in to_p.
"""
import pickle, os
from fractions import Fraction as Fr
d = os.path.dirname(os.path.abspath(__file__))
raw = pickle.load(open(os.path.join(d, "n5_adapted.pkl"), "rb"))
for P in (1000033, 65537):
    I = next(x for x in range(2, P) if pow(x, 2, P) == P-1)
    n = falsezero = numzero = denbad = 0
    ex = []
    for lam, cs in raw.items():
        for i, c in enumerate(cs):
            for t, v in enumerate(c):
                for k, (a, b) in v.items():
                    n += 1
                    if a.denominator % P == 0 or b.denominator % P == 0: denbad += 1
                    if (a.numerator and a.numerator % P == 0) or \
                       (b.numerator and b.numerator % P == 0): numzero += 1
                    if (a, b) == (Fr(0), Fr(0)): continue
                    va = a.numerator * pow(a.denominator % P, P-2, P) % P
                    vb = b.numerator * pow(b.denominator % P, P-2, P) % P
                    if (va + vb*I) % P == 0:
                        falsezero += 1
                        if len(ex) < 3: ex.append((lam, i, t, k, a, b))
    print(f"P = {P}  (i = {I}): {n:,} stored coefficients")
    print(f"   denominators divisible by p : {denbad}")
    print(f"   a numerator divisible by p  : {numzero}")
    print(f"   FALSE ZEROS to_p(c) == 0    : {falsezero}")
    for e in ex: print(f"      witness {e}")
