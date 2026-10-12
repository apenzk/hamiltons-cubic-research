import numpy as np, sympy as sp, itertools
from scipy.optimize import linprog
src = open(__file__.rsplit('/', 1)[0] + '/screen_I73c_kyfan_lp.py').read().split("R = sp.Rational\nn, m = 12")[0]
src = src.replace("def system(n, m, eps, kyfan=True, window=True):", "def system(n, m, eps, kyfan=True, window=True, T7=None):")
src = src.replace("    if window:\n", "    if T7 is not None:\n        R0 = 3*P(0,0) + 3*P(0,2); R2 = 4*P(0,2) + 2*P(2,2)\n        ineq.append(4*R0 + 3*R2 - T7)\n    if window:\n")
exec(src.replace("__file__.rsplit('/', 1)[0] + '/screen_I73c_I1_rowspan.py'", "'" + __file__.rsplit('/', 1)[0] + "/screen_I73c_I1_rowspan.py'"))
R = sp.Rational
def ceiling(n, m, T7):
    def feas(th):
        d = np.array([-1.0, 0.0, 4/3]); d = d / np.sqrt(np.dot(m, d**2)) / th
        return system(n, m, [R(x).limit_denominator(10**10) for x in d], kyfan=True, window=False, T7=T7)
    lo, hi = 1.0, 2.3
    if not feas(lo): return None
    for _ in range(20):
        mid = (lo + hi) / 2
        lo, hi = (mid, hi) if feas(mid) else (lo, mid)
    return lo
n, m = 8, [4, 21, 3]
for T7 in (56, 48, 44, 42, 40, 36):
    print(f"T7 = {T7}: ray ceiling = {ceiling(n, m, T7)}   (sqrt(3/2) = {np.sqrt(1.5):.5f})")
lo, hi = 48.0, 56.0
th0 = np.sqrt(1.5)
for n, m in ((8, [4, 21, 3]), (12, [4, 59, 3])):
    lo, hi = 48.0, 56.0
    for _ in range(14):
        mid = (lo + hi) / 2
        c = ceiling(n, m, mid)
        if c is None or c < th0: lo = mid
        else: hi = mid
    print(f"n={n}: the ray closes at sqrt(3/2) once T7 <= {lo:.3f}")
