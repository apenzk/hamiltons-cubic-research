"""The great-circle ladder's coefficients, extracted EXACTLY by series.

From the identity validated in screen_I106a_great_circle.py at 2.3e-13,

    Phi(gamma(theta)) - Phi(p) = -(1/2) Phi0 (c-1)^2 (c+2) + (1/2) c s^2 Q + s^3 (Xi - S),

the Taylor coefficients follow by elementary expansion, with no finite differences.
Two earlier finite-difference attempts by this parent were wrong: a sign error in the
third-derivative stencil, and a theta^4 guard requiring Xi = S that never fired, so it
reported 0.000 as a pass when nothing had been compared (proposal 127's rule, applied
to the parent rather than to a reviewer).
"""
import sympy as sp
th=sp.symbols('theta'); Phi0,Q,XiS=sp.symbols('Phi0 Q XiS')
c,s=sp.cos(th),sp.sin(th)
expr=-sp.Rational(1,2)*Phi0*(c-1)**2*(c+2)+sp.Rational(1,2)*c*s**2*Q+s**3*XiS
ser=sp.series(expr,th,0,6).removeO().expand()
for k in range(2,6):
    print(f"[theta^{k}] = {sp.simplify(ser.coeff(th,k))}")
c4=sp.simplify(ser.coeff(th,4))
assert sp.simplify(c4.subs(Q,0)+sp.Rational(3,8)*Phi0)==0
print("\nat Q = 0 the quartic coefficient is -3 Phi0 / 8, matching the record's chordal")
print("quartic -3 theta / 8 on the null cone of B (second-order.md, reviewers 287, 288).")
