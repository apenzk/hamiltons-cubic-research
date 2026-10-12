"""Reviewer 124: the odd fourth-moment lemma, closed.

Three independent checks of
    min{ sum v^4 : sum v = 0, sum v^2 = 1 } = (n^2+3)/(n(n^2-1))   (n odd)

  A. enumeration of ALL critical points (Lagrange -> at most three values),
  B. the polynomial identity that settles the three-value branch,
  C. free numerical minimisation as an outside check.
"""
import itertools
from fractions import Fraction as F
import numpy as np
import sympy as sp
from scipy.optimize import minimize


def two_value_min(n):
    """min over two-value critical points of n/(pq) - 3/n."""
    return min((F(n, p * (n - p)) - F(3, n), (p, n - p)) for p in range(1, n // 2 + 1))


def G(m):
    """Objective at the three-value critical point with multiplicities m."""
    a, b, c = m
    u = (c - b, a - c, b - a)
    M2 = sum(mi * ui ** 2 for mi, ui in zip(m, u))
    M4 = sum(mi * ui ** 4 for mi, ui in zip(m, u))
    return None if M2 == 0 else F(M4, M2 ** 2)


def three_value_min(n):
    cands = [(G((a, b, n - a - b)), (a, b, n - a - b))
             for a in range(1, n - 1) for b in range(a, n - a)
             if n - a - b >= b and G((a, b, n - a - b)) is not None]
    return min(cands) if cands else None


print("A. critical-point enumeration, odd n")
print(f"{'n':>4} {'target':>18} {'2-value min':>18} {'3-value min':>18} {'1/(n-1)':>12}")
for n in range(5, 32, 2):
    t = F(n * n + 3, n * (n * n - 1))
    t2, split = two_value_min(n)
    t3 = three_value_min(n)
    assert t2 == t and split == ((n - 1) // 2, (n + 1) // 2), n
    assert t3 is None or t3[0] > t, n
    assert t3 is None or t3[0] == F(1, n - 1), n
    print(f"{n:>4} {float(t):>18.12f} {float(t2):>18.12f} "
          f"{float(t3[0]):>18.12f} {1/(n-1):>12.8f}")

print("\nB. (n-1)*M4 - M2^2 >= 0 for real a,b,c >= 1  --  all-nonnegative expansion")
s, x, y = sp.symbols('s x y', nonnegative=True)          # a = 1+s, b = a+x, c = b+y
a, b, c = 1 + s, 1 + s + x, 1 + s + x + y
u = (y, -(x + y), x)
m = (a, b, c)
n_ = a + b + c
M2 = sum(mi * ui ** 2 for mi, ui in zip(m, u))
M4 = sum(mi * ui ** 4 for mi, ui in zip(m, u))
D = sp.expand((n_ - 1) * M4 - M2 ** 2)
terms = sp.Poly(D, s, x, y).terms()
assert all(coef > 0 for _, coef in terms), [t for t in terms if t[1] < 0]
print("   monomials:", len(terms), " negative coefficients:", 0)
for k in range(3):
    print(f"   s^{k}:", sp.factor(sp.expand(D.coeff(s, k))))
print("   at y=0:", sp.factor(D.subs(y, 0)),
      " -> equality iff (s=0 and y=0) or u=0, i.e. {a,b,c}={1,m,m} or a=b=c")

print("\nC. free numerical minimisation")
rng = np.random.default_rng(7)
for n in range(4, 17):
    tgt = (n * n + 3) / (n * (n * n - 1)) if n % 2 else 1.0 / n
    best = np.inf
    cons = [{'type': 'eq', 'fun': lambda v: v.sum()},
            {'type': 'eq', 'fun': lambda v: (v ** 2).sum() - 1}]
    for _ in range(200):
        r = minimize(lambda v: (v ** 4).sum(), rng.normal(size=n), constraints=cons,
                     method='SLSQP', options={'maxiter': 600, 'ftol': 1e-14})
        if r.success and abs(r.x.sum()) < 1e-7 and abs((r.x ** 2).sum() - 1) < 1e-7:
            best = min(best, (r.x ** 4).sum())
    print(f"   n={n:>3}  closed form {tgt:.12f}   numeric {best:.12f}   gap {best-tgt:+.2e}")
    assert best > tgt - 1e-9
print("\nall assertions passed")
