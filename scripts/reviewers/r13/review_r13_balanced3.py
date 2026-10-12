#!/usr/bin/env python3
"""Reviewer 13: the balanced k-block sphere-product family (S^m)^k as an attack
on the sharp (II)-side bound's separation claim. These are zero-defect UNGRADED
critical points with J5 > 0; their RHS was measured rising with n
(1.1307 at (4,4,4), 1.1656 at (4,6,6)). Chase the trend to n=24."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import importlib.util

import numpy as np

spec = importlib.util.spec_from_file_location(
    "r13", _os.path.join(_ROOT, "scripts/review_r13_independent.py"))
r13 = importlib.util.module_from_spec(spec)
spec.loader.exec_module(r13)
mb = importlib.util.spec_from_file_location(
    "r13mb", _os.path.join(_ROOT, "scripts/review_r13_multiblock.py"))
# reuse multiblock_point/embed without running its __main__
import itertools
from scipy.optimize import least_squares


def solve_balanced(k, m):
    """balanced k-block: within value a, cross value b; row sums + criticality."""
    # row sum: (m-1)a + (k-1)m b = 0  ->  b = -(m-1)a/((k-1)m)
    # criticality within-pair: a^2 + [(m-2)a^2 + (k-1)m b^2] = th a
    # criticality cross-pair:  b^2 + [2(m-1)ab + (k-2)m b^2] = th b
    # solve consistency for a, then norm.
    from sympy import symbols, solve, Rational, sqrt, nsimplify
    a, b, th = symbols('a b th', positive=None)
    bb = -(m - 1) * a / ((k - 1) * m)
    e1 = a ** 2 + (m - 2) * a ** 2 + (k - 1) * m * bb ** 2 - th * a
    e2 = bb ** 2 + 2 * (m - 1) * a * bb + (k - 2) * m * bb ** 2 - th * bb
    sols = solve([e1, e2], [a, th], dict=True)
    out = []
    for s in sols:
        av = complex(s[a].evalf() if hasattr(s[a], 'evalf') else s[a])
        if abs(av.imag) > 1e-12 or abs(av.real) < 1e-12:
            continue
        out.append(float(s[a]))
    return out


def build(core, k, m, a):
    n = k * m
    b = -(m - 1) * a / ((k - 1) * m)
    blk = np.repeat(np.arange(k), m)
    Wd = np.array([a if blk[i] == blk[j] else b for (i, j) in core.pairs])
    W = np.diag(Wd)
    W /= np.linalg.norm(W)
    return W


if __name__ == "__main__":
    r13.log("BALANCED3 start: (S^m)^k family, chasing the RHS trend")
    for (k, m) in ((3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (3, 8),
                   (4, 4), (4, 5)):
        n = k * m
        if n > 24:
            continue
        core = r13.Core(n)
        # permutation-symmetric invariant space is 1-dim: criticality automatic
        W = build(core, k, m, 1.0)
        th = float(np.sum(W * core.Q(W)))
        if th < 0:
            W, th = -W, -th
        res = np.linalg.norm(core.Q(W) - th * W)
        if res > 1e-10:
            r13.log(f"  (S^{m})^{k} n={n}: residual {res:.1e} NOT critical, skip")
            continue
        ev = r13.evaluate_point(core, W, th, want_masses=(n <= 18))
        r13.log("  " + r13.fmt_point(f"(S^{m})^{k} n={n}", ev))
    r13.log("BALANCED3 done")
