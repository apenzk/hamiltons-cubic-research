"""r246 claim 4 -- probing the rewritten run_a2prime_point_formula.py.

Two suspicions from running the file (both checks below are exact except the
final numeric magnitude, which is mpmath at 50 digits and labelled).

(A) The file prints its held-out relative miss as 'QUIET, and it would pass a
    1e-6 test'.  Recompute the miss exactly and test it against 1e-6.

(B) The file's POSITIVE instance of the (b) check calls
    residual_on_full(Aug, bug, [0, 1, 2]) with Aug square 3x3 -- every row is
    a pivot row.  r243 refuted the previous screen precisely because a square
    solve-then-substitute cannot fail (200 corrupt systems, zero failures).
    Repeat that experiment against the NEW checker in the file's own
    configuration: random corrupt square systems, pivot_rows = all rows.
    Then show the same checker DOES discriminate the moment pivot_rows is a
    proper subset -- so the checker is sound and the positive instantiation
    is what carries no content.
"""
import random
import sympy as sp

n = sp.symbols('n')

# ---- residual_on_full, copied VERBATIM from the file under review ----
def residual_on_full(full_A, full_b, pivot_rows):
    P = full_A[pivot_rows, :]
    xp, params = P.gauss_jordan_solve(full_b[pivot_rows, :])
    r = sp.simplify(full_A * xp - full_b)
    if params:
        for t in params:
            assert sp.simplify(sp.diff(r, t)) == sp.zeros(*r.shape), "t-dependent"
        r = sp.simplify(r.subs({t: 0 for t in params}))
    return r

# ---- (A) the 1e-6 claim, recomputed ----
A = sp.Matrix([[1, n, 2], [0, n - 2, 1]])
b = sp.Matrix([n + 3, 1])
v = sp.Matrix([1, 1, -1])
Aug = A.col_join(v.T); bug = b.col_join(sp.Matrix([0]))
x = sp.simplify(Aug.solve(bug))
ker2 = A.nullspace()[0]
c0, c1, c2, d0 = sp.symbols('c0 c1 c2 d0')
def centre_like(ni):
    t = sp.sqrt(ni + 1) / (ni + 1)
    return (x + t * ker2).subs(n, ni)
pts = {ni: centre_like(ni)[0] for ni in (12, 14, 16, 18)}
f = (c0 + c1*n + c2*n**2) / (n + d0)
sol = sp.solve([sp.Eq(f.subs(n, ni), pts[ni]) for ni in pts], [c0, c1, c2, d0], dict=True)
ffit = f.subs(sol[0])
rel = sp.N(sp.Abs((ffit.subs(n, 20) - centre_like(20)[0]) / centre_like(20)[0]), 50)
print(f"  (A) held-out relative miss, 50 digits: {sp.N(rel, 8)}")
print(f"      passes a 1e-6 acceptance test: {bool(rel < 1e-6)}")
print(f"      passes the file's actual assert (1e-3): {bool(rel < sp.Rational(1,1000))}")
assert rel > 1e-6, "the print would be right after all"
# 244's own number, for the regime the phrase was lifted from:
print("      (r244's 2.72e-08 belongs to their 6-point, matched-ansatz model;")
print("       this miniature's miss is 7.5e-06 and FAILS the 1e-6 test it cites.)")

# ---- (B) the square positive instance cannot fail ----
rnd = random.Random(246)
def rnd_square():
    while True:
        M = sp.Matrix(3, 3, lambda i, j: sp.Integer(rnd.randint(-5, 5))
                      + (n if rnd.random() < 0.3 else 0))
        if sp.simplify(M.det()) != 0:
            return M
fails = 0
TRIALS = 60
for _ in range(TRIALS):
    M = rnd_square()                       # a WRONG system: never the true one
    rhs = sp.Matrix([rnd.randint(-5, 5) + (n if rnd.random() < 0.3 else 0)
                     for _ in range(3)])
    r = residual_on_full(M, rhs, [0, 1, 2])
    if r != sp.zeros(3, 1):
        fails += 1
print(f"\n  (B) {TRIALS} random corrupt SQUARE systems, pivot_rows = all rows:"
      f" {fails} failures")
assert fails == 0, "a square all-pivot instance failed -- vacuousness disproved"
print("      the file's positive (b) instance CANNOT fail -- r243's finding")
print("      ('the square one cannot') reproduced against the NEW checker.")

# ...and the same checker discriminates as soon as pivot_rows is proper:
bad = residual_on_full(sp.Matrix([[1, n, 2], [0, n-2, 1], [1, 2*n-2, 3]]),
                       sp.Matrix([n+3, 1, 0]), [0, 1])      # r243's ORIGINAL witness
good = residual_on_full(sp.Matrix([[1, n, 2], [0, n-2, 1], [1, 2*n-2, 3]]),
                        sp.Matrix([n+3, 1, n+4]), [0, 1])   # consistent variant
print(f"      r243's original witness under the checker, pivots [0,1]: "
      f"residual {sp.simplify(bad.T)} -- CAUGHT")
print(f"      consistent over-determined variant: residual {sp.simplify(good.T)} -- passes")
assert bad != sp.zeros(3, 1) and good == sp.zeros(3, 1)
print("      So the checker is sound; the POSITIVE INSTANTIATION is what tests")
print("      nothing.  r243's owed item 6 ('rebuild the screen on an")
print("      over-determined miniature') is applied only in the negative")
print("      direction (the regression), not in the passing direction.")
