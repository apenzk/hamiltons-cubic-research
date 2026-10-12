import numpy as np, sympy as sp
exec(open(__file__.rsplit('/', 1)[0] + '/screen_I73c_kyfan_lp.py').read().split("R = sp.Rational\nn, m = 12")[0])
R = sp.Rational
def feas(n, m, th, kyfan, window):
    d = np.array([-1.0, 0.0, 4/3]); d = d / np.sqrt(np.dot(m, d**2)) / th
    return system(n, m, [R(x).limit_denominator(10**10) for x in d], kyfan=kyfan, window=window)
for n, m in ((8, [4, 21, 3]), (10, [4, 38, 3]), (12, [4, 59, 3])):
    for kyfan, window in ((True, False), (True, True)):
        lo, hi = 1.0, 2.3
        if not feas(n, m, lo, kyfan, window):
            print(n, m, kyfan, window, "infeasible already at 1.0"); continue
        for _ in range(22):
            mid = (lo + hi) / 2
            if feas(n, m, mid, kyfan, window): lo = mid
            else: hi = mid
        print(f"n={n} m={tuple(m)} Ky Fan caps, window={window}: largest feasible theta on L173's ray = {lo:.6f}   (sqrt(3/2) = {np.sqrt(1.5):.6f})")
