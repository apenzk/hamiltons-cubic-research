"""r229 claim 5a: the file's relaxed two-atom minimum against the EXACT minimum of
the same moment problem with the integrality it dropped.

Minimise p_3 = sum x_i^3 over x in R^N with sum x = 0, sum x^2 = S, x_i >= -m.
KKT: 3x^2 - 2 b x - a >= 0 with equality off the active set, so an extremal point
has at most TWO free values (the roots of one quadratic) plus a block at -m.
That is a THREE-value structure, which is exactly the shape of the true spectrum
at the balanced sphere product -- the two-atom relaxation is not the right shape.
"""
import numpy as np, itertools
from scipy.optimize import minimize

def exact_min(N, m, S):
    best = (np.inf, None)
    for a in range(0, 6):                       # entries pinned at -m
        rem = N - a
        if rem < 2: continue
        s1 = a * m                              # free entries must sum to +a*m
        s2 = S - a * m * m                      # ... and square-sum to this
        if s2 <= 0: continue
        for b in range(1, rem):
            c = rem - b
            # b r1 + c r2 = s1 ; b r1^2 + c r2^2 = s2
            # r2 = (s1 - b r1)/c  ->  quadratic in r1
            A = b + b * b / c
            B = -2 * b * s1 / c
            C = s1 * s1 / c - s2
            disc = B * B - 4 * A * C
            if disc < 0: continue
            for sg in (+1, -1):
                r1 = (-B + sg * np.sqrt(disc)) / (2 * A)
                r2 = (s1 - b * r1) / c
                if r1 < -m - 1e-12 or r2 < -m - 1e-12: continue
                v = -a * m ** 3 + b * r1 ** 3 + c * r2 ** 3
                if v < best[0]: best = (v, (a, b, c, r1, r2))
    return best

def relaxed(N, m, S): return S * S / (N * m) - m * S

print("exact vs relaxed minimum of the SAME moment problem  (S = 3, |M|_F = 1)\n")
print(f"{'n':>4} {'N':>6} {'m=cap':>9} {'relaxed':>10} {'EXACT':>10} {'true p3':>10} "
      f"{'exact/true':>10} {'structure (a,b,c)':>20}")
for n in (12, 14, 16, 24, 40, 100):
    mm = n // 2; N = n * (n + 1) // 2 - 1
    A = 1.0 / (mm * np.sqrt((mm - 1) * (2 * mm - 1)))
    om = np.array([mm * A] * ((mm - 1) * (mm + 2)) + [-(mm - 1) * A] * (mm * mm)
                  + [-2 * mm * (mm - 1) * A])
    m = -om.min(); S = 3.0
    v, st = exact_min(N, m, S); r = relaxed(N, m, S); t = float(np.sum(om ** 3))
    print(f"{n:>4} {N:>6} {m:>9.6f} {r:>10.6f} {v:>10.6f} {t:>10.6f} {v/t:>10.4f} "
          f"{str(st[:3]):>20}")

print("\nsanity: the EXACT value must never exceed the true spectrum's p_3 (which is")
print("feasible for the problem), and must never fall below the relaxed bound.")
for n in (12, 24, 100):
    mm = n // 2; N = n * (n + 1) // 2 - 1
    A = 1.0 / (mm * np.sqrt((mm - 1) * (2 * mm - 1)))
    om = np.array([mm * A] * ((mm - 1) * (mm + 2)) + [-(mm - 1) * A] * (mm * mm)
                  + [-2 * mm * (mm - 1) * A])
    m = -om.min(); v, st = exact_min(N, m, 3.0); t = float(np.sum(om ** 3))
    r = relaxed(N, m, 3.0)
    print(f"   n={n}: relaxed {r:.6f} <= exact {v:.6f} <= true {t:.6f}  "
          f"{'OK' if r <= v + 1e-9 <= t + 1e-9 else 'ORDER VIOLATED'}")

print("\nplanted violation: a direct SLSQP descent on the same constraints must not")
print("beat the exact value.")
n = 12; mm = 6; N = n * (n + 1) // 2 - 1
A = 1.0 / (mm * np.sqrt((mm - 1) * (2 * mm - 1))); m = 2 * mm * (mm - 1) * A
v, st = exact_min(N, m, 3.0)
rng = np.random.default_rng(1); best = np.inf
for _ in range(40):
    x0 = rng.standard_normal(N); x0 -= x0.mean(); x0 *= np.sqrt(3 / np.sum(x0 ** 2))
    x0 = np.maximum(x0, -m + 1e-6)
    res = minimize(lambda x: np.sum(x ** 3), x0, jac=lambda x: 3 * x ** 2,
                   bounds=[(-m, None)] * N, method='SLSQP',
                   constraints=[{'type': 'eq', 'fun': lambda x: x.sum()},
                                {'type': 'eq', 'fun': lambda x: np.sum(x ** 2) - 3.0}],
                   options={'maxiter': 400, 'ftol': 1e-12})
    if res.success: best = min(best, res.fun)
print(f"   exact {v:.6f}   best of 40 SLSQP starts {best:.6f}   "
      f"{'no violation' if best >= v - 1e-6 else 'VIOLATION -- exact enumeration is wrong'}")
