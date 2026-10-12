"""Reviewer 21 (c)-(e): coverage of the frontier branch, vectorised, plus the
c0 = 1 / s = s_max structure across the whole interval."""
import sys
import numpy as np
from review_r21_bound import (R23, A_SUP, B_SUP, B_NEG, TSTAR, theta0, c_n,
                              requirement, nienhaus_gamma)


def Vv(t, mode):
    t = np.asarray(t, dtype=float)
    if mode == "corner":
        return A_SUP + B_SUP * t
    if mode == "claim":
        return np.where(t <= 0.65, A_SUP, A_SUP + B_SUP * t)
    if mode == "closed":
        with np.errstate(divide='ignore'):
            v = 5.0 / (16.0 * np.maximum(t, 1e-300)) + 2.0 * t / 3.0
        return np.where(t <= TSTAR, A_SUP, v)
    if mode == "zero":                    # B dropped everywhere (for contrast)
        return np.full_like(t, A_SUP)
    raise ValueError(mode)


def coupled(alpha, n, mode, nc0=801, ns=801):
    eps = 1.0 / 3.0 - alpha
    if eps <= 0:
        return 0.0, 1.0, 0.0
    th0 = theta0(n)
    c0 = np.linspace(0.0, 1.0, nc0)[:, None]
    smax = np.sqrt(np.minimum(1.0, 6.0 * eps / (3.0 - c0 ** 2)))
    s = smax * np.linspace(0.0, 1.0, ns)[None, :]
    cb = np.sqrt(np.maximum(1e-300, 1.0 - s ** 2))
    t = s * c0 / cb
    val = R23 * (3 * cb ** 2 * s * c0 * Vv(t, mode)
                 + 3 * cb * s ** 2 * (1 - c0 ** 2) * B_NEG
                 + s ** 3 * th0)
    i = np.unravel_index(np.argmax(val), val.shape)
    return float(val[i]), float(c0[i[0], 0]), float(s[i])


def coverage_low(n, mode, lo=0.0, hi=1.0 / 3.0):
    """smallest alpha0 such that the branch bound < requirement on [alpha0, 1/3]."""
    f = lambda a: coupled(a, n, mode)[0] - requirement(a)
    for _ in range(60):
        mid = 0.5 * (lo + hi)
        if f(mid) < 0:
            hi = mid
        else:
            lo = mid
    return hi


if __name__ == "__main__":
    ns = [int(x) for x in sys.argv[1:]] or [12, 14, 16, 20, 24, 40, 100, 120, 200, 1000]
    print("--- Nienhaus reach in the large-n limit ---")
    cinf = 2.0 / np.sqrt(3.0)
    lo, hi = 0.0, 1.0 / 3.0
    for _ in range(200):
        mid = 0.5 * (lo + hi)
        if nienhaus_gamma(mid, cinf) < requirement(mid):
            lo = mid
        else:
            hi = mid
    print(f"  c_inf = 2/sqrt(3) = {cinf:.12f}   a_N(inf) = {0.5*(lo+hi):.12f}")
    print(f"  alpha* = 32/141 = {32/141:.12f}   -> {'COVERED for every n' if 0.5*(lo+hi) > 32/141 else 'gap opens at finite n'}")
    print("\n--- coverage of the coupled branch, three versions of the frontier ---")
    print(f"  {'n':>5} {'a_N':>12} {'corner':>12} {'claim(0.65)':>12} {'closed':>12} "
          f"{'gap:claim':>11} {'gap:closed':>11}")
    for n in ns:
        c = c_n(n)
        lo, hi = 0.0, 1.0 / 3.0
        for _ in range(200):
            mid = 0.5 * (lo + hi)
            if nienhaus_gamma(mid, c) < requirement(mid):
                lo = mid
            else:
                hi = mid
        aN = 0.5 * (lo + hi)
        r = {m: coverage_low(n, m) for m in ("corner", "claim", "closed")}
        print(f"  {n:>5d} {aN:>12.9f} {r['corner']:>12.9f} {r['claim']:>12.9f} {r['closed']:>12.9f} "
              f"{aN-r['claim']:>+11.6f} {aN-r['closed']:>+11.6f}", flush=True)
