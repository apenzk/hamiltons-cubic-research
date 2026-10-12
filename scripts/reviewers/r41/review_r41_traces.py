"""R41: do the fitted closed forms satisfy the algebra's own trace identities
identically in m?  tr(L_e)=0 and tr(L_x L_y)=kappa_F <x,y> with
kappa_F(n)=(2n-1)(n-1)/4 (Frobenius normalisation), so tr(L_e^2)=kappa_F/theta^2.
These are constraints the eigenvalue list must satisfy for EVERY m, so they test
the closed forms outside the range where they were measured."""
import sympy as sp
m = sp.symbols('m', positive=True)

dims = {'triv': sp.Integer(1),
        'ad': m**2 - 1,
        'orbit': m * (m - 1),
        'V1111': m**2 * (m + 1) * (m - 3) / 4,
        'V211': 2 * m**2 * (m**2 - 4) / 3,
        'V22': m**2 * (m + 3) * (m - 1) / 4,
        'V2200': m**2 * (m**2 - 1) / 6}
lam = {'triv': sp.Integer(1),
       'ad': (m + 2) / (2 * (m + 1)),
       'orbit': sp.Rational(1, 2),
       'V1111': 2 / (m + 1),
       'V211': sp.Integer(0),
       'V22': sp.Integer(0),
       'V2200': -3 / (m + 1)}

tr1 = sp.simplify(sum(dims[k] * lam[k] for k in dims))
print("tr(L_e)        =", tr1, "   (must be 0):", tr1 == 0)

tr2 = sp.simplify(sum(dims[k] * lam[k]**2 for k in dims))
n = 2 * m
theta2 = (m + 1) * (2 * m - 1) / (3 * m * (m - 1))
kap = (2 * n - 1) * (n - 1) / 4
pred = sp.simplify(kap / theta2)
print("sum d_i lam_i^2 =", sp.factor(tr2))
print("kappa_F/theta^2 =", sp.factor(pred))
print("equal identically in m:", sp.simplify(tr2 - pred) == 0)

print("\nsum of dims  =", sp.factor(sp.simplify(sum(dims.values()))))
print("dim Weyl_2m  =", sp.factor(m * (m + 1) * (2 * m + 1) * (2 * m - 3) / 3))
print("\nnondegeneracy: 1/2 is attained only on 'orbit' unless 2/(m+1)=1/2:")
print("   2/(m+1) = 1/2  <=>  m =", sp.solve(sp.Eq(2/(m+1), sp.Rational(1,2)), m),
      "; dim V1111 there =", dims['V1111'].subs(m, 3))
print("lambda_max on W^perp - 1/2 =",
      sp.simplify(lam['ad'] - sp.Rational(1, 2)), "> 0 for all m > 0")
