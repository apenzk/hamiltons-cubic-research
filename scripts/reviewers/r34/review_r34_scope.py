"""M8 scope: what happens at p=2, and the exact arithmetic of mu = 1/2."""
import sympy as sp, numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r34_spec import measured, predicted

p_, q_ = sp.symbols('p q', positive=True)
mu = (p_+q_-2)/(2*(p_-1)*(q_-1))
print("mu - 1/2 =", sp.factor(sp.simplify(mu - sp.Rational(1,2))))
print("  numerator of (1/2 - mu):", sp.factor(sp.numer(sp.simplify(sp.Rational(1,2)-mu))))
print("  so mu <= 1/2  <=>  (p-2)(q-2) >= 1, equality iff (p-2)(q-2)=1 iff p=q=3")
lam = (p_-2)/(2*(p_-1))
print("lambda_m - 1/2 =", sp.simplify(lam - sp.Rational(1,2)), " (< 0 for every m > 1)")

print()
print("p=2 control (outside the claim's range): lambda_max must exceed 1/2")
for (p,q) in [(2,4),(2,5),(2,6),(2,7),(2,8)]:
    meas, D, theta = measured(p,q)
    top = max(v for v,m in meas if v < 0.999)
    print(f"  ({p},{q}): lambda_max on W-perp = {top:.6f}   "
          f"1/2 + 1/(2(n-3)) = {0.5+1/(2*(p+q-3)):.6f}   mu = {float((p+q-2)/(2*(p-1)*(q-1))):.6f}")

print()
print("=== Casimir-label coincidences, solved symbolically over all p,q >= 3 ===")
import itertools
cas = lambda lam, m: sum(li*(li + m - 2*(i+1)) for i, li in enumerate(lam))
labels = {"<W>":        ((), ()),
          "Weyl_p":     ((2,2), ()),   "Weyl_q":  ((), (2,2)),
          "orbit":      ((1,), (1,)),
          "S2_0(p)":    ((2,), ()),    "S2_0(q)": ((), (2,)),
          "S2_0xS2_0":  ((2,), (2,)),  "L2xL2":   ((1,1), (1,1)),
          "X_p x R^q":  ((2,1), (1,)), "X_q x R^p": ((1,), (2,1))}
found = []
for (n1, (a1, b1)), (n2, (a2, b2)) in itertools.combinations(labels.items(), 2):
    eqs = [sp.Eq(cas(a1, p_), cas(a2, p_)), sp.Eq(cas(b1, q_), cas(b2, q_))]
    sol = sp.solve(eqs, [p_, q_], dict=True)
    real = [s for s in sol if s]
    if real:
        found.append((n1, n2, real))
for n1, n2, s in found:
    print(f"   {n1:12s} vs {n2:12s} : {s}")
print("   (only solutions with p,q >= 3 matter)")
