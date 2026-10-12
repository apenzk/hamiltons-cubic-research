"""Closed form for the conjectured maximiser's position in the bi-spectral plane.

From Li 2022 Thm 1.8, the balanced S^m x S^m (n=2m, Einstein) has full second-kind
spectrum {c (mult (m-1)(m+2)), 0 (mult m^2), -c(m-1) (mult 1)}, and the Weyl part
subtracts s/(n(n-1)) from every eigenvalue.  Normalising |M|_F = 1 gives everything.
"""
import sympy as sp
m=sp.symbols('m', positive=True, integer=True)
A=1/(m*sp.sqrt((m-1)*(2*m-1)))                     # claimed p3(mu)
om1, k1 =  m*A,                (m-1)*(m+2)         # Weyl second-kind eigenvalues
om2, k2 = -(m-1)*A,             m**2
om3, k3 = -2*m*(m-1)*A,         sp.Integer(1)
tr  = sp.simplify(k1*om1 + k2*om2 + k3*om3)
sq  = sp.simplify(k1*om1**2 + k2*om2**2 + k3*om3**2)
cu  = sp.simplify(k1*om1**3 + k2*om2**3 + k3*om3**3)
print("sum omega        =", tr,            "   (must be 0)")
print("sum omega^2      =", sp.simplify(sq), "   (must be 3)")
print("p3(omega)        =", sp.factor(sp.simplify(cu)))
theta = sp.simplify(sp.Rational(3,2)*A - sp.Rational(1,2)*cu)
theta0 = sp.sqrt((m-1)*(2*m-1))/m                  # theta_0(2m)
print("3/2 p3(mu) - 1/2 p3(omega) =", sp.simplify(theta))
print("theta_0(2m)                =", theta0)
print("difference                 =", sp.simplify(sp.radsimp(theta-theta0)))
print("multiplicities sum         =", sp.expand(k1+k2+k3), " vs dim S^2_0(R^{2m}) =", sp.expand((2*m-1)*(2*m+2)/2))
print()
print("p3(mu) closed form matches the record's tr(W^3) at the balanced product:")
rec = 2*sp.sqrt(2)/( (2*m) * sp.sqrt((2*m-1)*(2*m-2)) )
print("   record 2sqrt2/(n sqrt((n-1)(n-2))) - A =", sp.simplify(sp.radsimp(rec - A)))
print()
for mm in [3,4,5,6,8,12]:
    print(f"  m={mm:2d} (n={2*mm:2d}): p3(mu)={float(A.subs(m,mm)):+.9f}  p3(omega)={float(cu.subs(m,mm)):+.9f}  theta={float(theta.subs(m,mm)):.9f}  theta_0={float(theta0.subs(m,mm)):.9f}")

print()
print("=== the residual radical, pinned ===")
inner = 4*m**4 - 12*m**3 + 13*m**2 - 6*m + 1
print("  4m^4-12m^3+13m^2-6m+1 - (2m^2-3m+1)^2 =", sp.expand(inner - (2*m**2-3*m+1)**2))
theta_c = sp.Rational(3,2)*A - sp.Rational(1,2)*cu
theta_c = theta_c.subs(sp.sqrt(inner), 2*m**2-3*m+1)
print("  theta with the radical resolved      =", sp.simplify(sp.radsimp(theta_c)))
print("  theta - theta_0                      =", sp.simplify(sp.radsimp(sp.together(theta_c - theta0))))
