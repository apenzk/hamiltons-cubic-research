"""Reviewer 179: the arithmetic behind claims 3 and 4."""
from fractions import Fraction as F
import itertools, sympy as sp

print("== claim 3: B2 roots, the (4,1)/(3,3) pair ==")
a1 = sp.Matrix([1,-1]); a2 = sp.Matrix([0,1])
def coeffs(v):
    M = sp.Matrix([[1, 0], [-1, 1]])            # columns are alpha_1, alpha_2
    c = M.solve(sp.Matrix(v))                   # v = c1*alpha_1 + c2*alpha_2
    return (c[0], c[1])
print("  (4,1)-(3,3) =", coeffs([1,-2]), " -> record says  alpha_1 - alpha_2")
print("  (3,3)-(4,1) =", coeffs([-1,2]), " -> record says -alpha_1 + 2 alpha_2")
print("  -alpha_1+2alpha_2 =", list(-a1+2*a2), " but (3,3)-(4,1) = [-1, 2]")
# are the WEIGHT SETS disjoint?  a dominant mu <= lam is always a weight of V_lam.
def is_weight(lam, mu):
    c = coeffs([lam[0]-mu[0], lam[1]-mu[1]])
    return all(x >= 0 and x == int(x) for x in c)
print("  0 is a weight of V_(4,1):", is_weight((4,1),(0,0)),
      " and of V_(3,3):", is_weight((3,3),(0,0)),
      " -> weight SETS are NOT disjoint")
print("  (3,3) a weight of V_(4,1):", is_weight((4,1),(3,3)),
      "; (4,1) a weight of V_(3,3):", is_weight((3,3),(4,1)))

print()
print("== claim 4: is p_12 = Pf^2 ? ==")
for lam in [(0,0,0,0,0,0), (1,1,1,1,0,0), (2,2,0,0,0,0)]:
    ell = [lam[i] + (5-i) for i in range(6)]
    p12 = sum(x**12 for x in ell); pf2 = 1
    for x in ell: pf2 *= x*x
    print(f"  lam={lam} ell={ell}  p_12={p12}  Pf^2={pf2}  equal: {p12==pf2}")
print("  (Pf^2 = e_6(ell^2) IS a polynomial in p_2..p_12 by Newton, and conversely;")
print("   the two generate the same ring over p_2..p_10 -- but they are not equal.)")

print()
print("== claim 4: Newton recovers the multiset, and l_1>...>l_5>|l_6|>=0 ==")
bad = []
for lam in itertools.product(range(4), repeat=5):
    if list(lam) != sorted(lam, reverse=True): continue
    for l6 in range(-lam[4], lam[4]+1):
        ell = [lam[i]+(5-i) for i in range(5)] + [l6]
        if not (ell[0]>ell[1]>ell[2]>ell[3]>ell[4]>abs(ell[5])>=0): bad.append((lam,l6,ell))
print("  dominant D6 weights violating l_1>...>l_5>|l_6|>=0 :", len(bad))
