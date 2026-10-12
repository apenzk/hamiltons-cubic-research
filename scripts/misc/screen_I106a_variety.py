"""I106a: the 3x3 orthostochastic variety's defining equation, and whether it is exact.

THE SOURCE.  Bengtsson, Ericsson, Kus, Tadej and Zyczkowski, section 3, carrying
Au-Yeung and Poon 1979.  For a bistochastic matrix laid out as

        x y *
        z w *
        a b *

it is orthostochastic if and only if (sqrt x, sqrt z, sqrt a) and
(sqrt y, +-sqrt w, +-sqrt b) are orthogonal for some choice of signs, that is
sqrt(xy) + e1 sqrt(zw) + e2 sqrt(ab) = 0.

THE BRIDGE TO THE POLYNOMIAL FORM is this project's own step, so it is checked here
rather than taken on trust.  With a = 1-x-z and b = 1-y-w from the column sums,

        ab - xy - zw = 1 - x - y - z - w + xw + yz,

so squaring the radical condition twice gives

        (1 - x - y - z - w + xw + yz)^2 = 4 x y z w.

WHY THE THIRD CHECK IS THE ONE THAT MATTERS.  R28 maximises a linear functional over
this variety.  If the equation cut out a set LARGER than the orthostochastic matrices,
the maximum would be an upper bound and possibly lossy, which is exactly how the
three-alignment relaxation to Birkhoff's polytope overshot by 3.82.  So the screen
samples points ON the variety and asks whether each is actually realisable as Q^o2.

A screen of a derived formula and of a route's hypothesis, never evidence for a claim.
"""

import numpy as np
import sympy as sp


def bridge():
    x, y, z, w = sp.symbols("x y z w")
    a, b = 1 - x - z, 1 - y - w
    r = sp.simplify(sp.expand(a * b - x * y - z * w - (1 - x - y - z - w + x * w + y * z)))
    print(f"1. bridge, ab - xy - zw - (1-x-y-z-w+xw+yz) = {r}   <- must be 0")


def forward(trials=20000, seed=0):
    """every Q^o2 for Q in O(3) satisfies the equation"""
    rng = np.random.default_rng(seed)
    worst = 0.0
    for _ in range(trials):
        Q, _ = np.linalg.qr(rng.normal(size=(3, 3)))
        B = Q ** 2
        X, Y, Z, W = B[0, 0], B[0, 1], B[1, 0], B[1, 1]
        worst = max(worst, abs((1 - X - Y - Z - W + X * W + Y * Z) ** 2 - 4 * X * Y * Z * W))
    print(f"2. max |lhs - rhs| over {trials} random Q in O(3): {worst:.2e}")


def bistoch(X, Y, Z, W):
    B = np.zeros((3, 3))
    B[0, 0], B[0, 1], B[1, 0], B[1, 1] = X, Y, Z, W
    B[0, 2], B[1, 2] = 1 - X - Y, 1 - Z - W
    B[2, 0], B[2, 1] = 1 - X - Z, 1 - Y - W
    B[2, 2] = 1 - B[0, 2] - B[1, 2]
    return B


def realisable(B):
    """is some sign pattern of the entrywise square root orthogonal?"""
    S = np.sqrt(np.clip(B, 0, None))
    for m in range(2 ** 9):
        E = np.array([[1 if (m >> (3 * i + j)) & 1 else -1 for j in range(3)] for i in range(3)], float)
        M = S * E
        if np.allclose(M @ M.T, np.eye(3), atol=1e-9):
            return True
    return False


def converse(target=60, seed=0):
    """points ON the variety that are bistochastic: are they all orthostochastic?"""
    rng = np.random.default_rng(seed)
    Wv = sp.Symbol("Wv")
    found = bad = 0
    while found < target:
        X, Y, Z = rng.uniform(0, 1, 3)
        for s in sp.solve(sp.Eq((1 - X - Y - Z - Wv + X * Wv + Y * Z) ** 2, 4 * X * Y * Z * Wv), Wv):
            if not s.is_real:
                continue
            B = bistoch(X, Y, Z, float(s))
            if B.min() < -1e-12 or B.max() > 1 + 1e-12:
                continue
            found += 1
            if not realisable(B):
                bad += 1
    print(f"3. bistochastic points on the variety: {found}, NOT orthostochastic: {bad}")
    print("   bad = 0 means the equation is EXACT on the bistochastic slice, so R28's")
    print("   constraint is the true set rather than a relaxation of it.")


if __name__ == "__main__":
    bridge()
    forward()
    converse()
