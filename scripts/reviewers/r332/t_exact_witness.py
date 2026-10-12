"""Exact rational witness for Q4: two T >= 0 satisfying every row of (A),(B),(C)
at the same (lambda, theta), with different S22.

Spectrum (integer-scaled; unit-normalising divides lambda and theta by sqrt(32)):
  lambda = (2,2,2, 1,1,1,1, 0, -1,-1,-1,-1, -2,-2,-2), N=15 (n=6, so 2(n-2)=8), theta rational.
Method: float LP finds the two optimal vertices; the vertex supports are re-solved exactly
over the rationals; nonnegativity and every row are then verified exactly.
"""
import numpy as np
from fractions import Fraction
from itertools import combinations
from scipy.optimize import linprog
import json

n = 6
lam_int = [2, 2, 2, 1, 1, 1, 1, 0, -1, -1, -1, -1, -2, -2, -2]
N = len(lam_int)
trips = list(combinations(range(N), 3))
M = len(trips)


def build(theta):
    lam = np.array(lam_int, dtype=float)
    Aeq = np.zeros((3 * N, M))
    beq = np.zeros(3 * N)
    for k in range(N):
        for i, t in enumerate(trips):
            if k in t:
                b, c = [x for x in t if x != k]
                Aeq[3 * k, i] = 2.0
                Aeq[3 * k + 1, i] = lam[b] + lam[c]
                Aeq[3 * k + 2, i] = 2.0 * lam[b] * lam[c]
        beq[3 * k] = 2.0 * (n - 2)
        beq[3 * k + 1] = -2.0 * lam[k]
        beq[3 * k + 2] = 2.0 * lam[k] * (theta - lam[k])
    obj = np.zeros(M)
    for i, (a, b, c) in enumerate(trips):
        la, lb, lc = lam[a], lam[b], lam[c]
        obj[i] = 2.0 * (la ** 2 * lb ** 2 + la ** 2 * lc ** 2 + lb ** 2 * lc ** 2)
    return Aeq, beq, obj


# find a feasible rational theta
theta = None
for th_try in [Fraction(p, q) for (p, q) in [(2, 1), (3, 2), (5, 2), (1, 1), (3, 1), (7, 4), (9, 4)]]:
    Aeq, beq, obj = build(float(th_try))
    r = linprog(np.zeros(M), A_eq=Aeq, b_eq=beq, bounds=(0, None), method='highs')
    if r.success:
        theta = th_try
        print(f"feasible at theta = {th_try}")
        break
assert theta is not None, "no feasible theta found in scan"

Aeq, beq, obj = build(float(theta))
lo = linprog(obj, A_eq=Aeq, b_eq=beq, bounds=(0, None), method='highs')
hi = linprog(-obj, A_eq=Aeq, b_eq=beq, bounds=(0, None), method='highs')
print(f"float S22 interval: [{lo.fun:.6f}, {-hi.fun:.6f}]")

# exact re-solve on each vertex support
lamF = [Fraction(v) for v in lam_int]


def exact_rows():
    rows, rhs = [], []
    for k in range(N):
        r1 = [Fraction(0)] * M
        r2 = [Fraction(0)] * M
        r3 = [Fraction(0)] * M
        for i, t in enumerate(trips):
            if k in t:
                b, c = [x for x in t if x != k]
                r1[i] = Fraction(2)
                r2[i] = lamF[b] + lamF[c]
                r3[i] = 2 * lamF[b] * lamF[c]
        rows += [r1, r2, r3]
        rhs += [Fraction(2 * (n - 2)), -2 * lamF[k], 2 * lamF[k] * (theta - lamF[k])]
    return rows, rhs


rowsF, rhsF = exact_rows()


def exact_solve(support):
    """Solve the equality system restricted to the support columns, exactly."""
    import sympy as sp
    cols = sorted(support)
    A = sp.Matrix([[sp.Rational(rowsF[r][c]) for c in cols] for r in range(3 * N)])
    b = sp.Matrix([sp.Rational(v) for v in rhsF])
    sol = A.solve_least_squares(b) if A.rank() == len(cols) else None
    if sol is None:
        # underdetermined on support: take particular solution via gauss
        aug = A.row_join(b)
        sol_set = sp.linsolve((A, b))
        if not sol_set:
            return None
        sol = sp.Matrix(list(sol_set)[0])
        # free params -> set to 0 already by linsolve? substitute zeros for symbols
        free = sol.free_symbols
        sol = sol.subs({s: 0 for s in free})
    # residual check
    res = A * sol - b
    if any(x != 0 for x in res):
        return None
    T = {c: sol[i] for i, c in enumerate(cols)}
    if any(v < 0 for v in T.values()):
        return None
    return T


def s22_exact(T):
    tot = Fraction(0)
    for c, v in T.items():
        a, b, cc = trips[c]
        la, lb, lc = lamF[a], lamF[b], lamF[cc]
        tot += Fraction(str(v)) * 2 * (la ** 2 * lb ** 2 + la ** 2 * lc ** 2 + lb ** 2 * lc ** 2)
    return tot


out = {}
for name, r in [("min", lo), ("max", hi)]:
    supp = [i for i in range(M) if r.x[i] > 1e-9]
    T = exact_solve(supp)
    if T is None:
        print(f"{name}: exact repair failed on support size {len(supp)}")
        continue
    val = s22_exact(T)
    print(f"{name}: support {len(supp)} entries, exact S22 = {val} = {float(val):.6f}")
    out[name] = {"theta": str(theta), "S22": str(val),
                 "T": {str(trips[c]): str(v) for c, v in T.items()}}

with open('witness.json', 'w') as f:
    json.dump(out, f, indent=1)
print("witness.json written")
