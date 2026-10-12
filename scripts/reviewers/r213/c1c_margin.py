"""r213: a certified rational lower bound on the certificate's least eigenvalue.

M - c I positive definite (exact LDL^H over Q(i), reconstructed and compared)
proves lambda_min(M) > c for every block.  Reported as a rational, so the margin
is a theorem rather than a float.
"""
import json, os, functools
from fractions import Fraction as F
import importlib.util, sys
HERE = os.path.dirname(os.path.abspath(__file__))
sp = importlib.util.spec_from_file_location("c1", os.path.join(HERE, "c1_pd_third_route.py"))
m = importlib.util.module_from_spec(sp)
_o = sys.stdout; sys.stdout = open(os.devnull, "w")
try: sp.loader.exec_module(m)
finally: sys.stdout = _o

def shift(M, c):
    return [[(M[i][j][0] - (c if i == j else 0), M[i][j][1])
             for j in range(len(M))] for i in range(len(M))]

for c in (F(1, 50), F(1, 48), F(21, 1000), F(213, 10000)):
    ok = True
    for M in m.BL:
        r = m.ldl(shift(M, c))
        if r is None or not all(d > 0 for d in r[1]): ok = False; break
        assert m.reconstruct(*r) == shift(M, c)
    print(f"  every block minus {str(c):>10} I is positive definite: {ok}")
    if not ok:
        break
