"""Closed form for ||A||^2 at the EQUIVARIANT graded point (the sphere product), derived
from the Weyl projection of a diagonal curvature operator:
   W_ij = K_ij - (r_i + r_j)/(n-2) + scal/((n-1)(n-2)).
For S^a x S^b: K = 1 inside a factor, 0 across; r = a-1 / b-1; scal = a(a-1)+b(b-1)."""
import sympy as sp

a, b = sp.symbols('a b', positive=True)
n = a + b
scal = a*(a-1) + b*(b-1)
s = scal/((n-1)*(n-2))
Waa = 1 - 2*(a-1)/(n-2) + s
Wbb = 1 - 2*(b-1)/(n-2) + s
Wab = -1 + s
Caa, Cbb, Cab = a*(a-1)/2, b*(b-1)/2, a*b
nrm2 = sp.simplify(Caa*Waa**2 + Cbb*Wbb**2 + Cab*Wab**2)
A2 = sp.simplify((Caa*Waa**2 + Cbb*Wbb**2)/nrm2)
B2 = sp.simplify(Cab*Wab**2/nrm2)
dp = sp.simplify(Caa + Cbb)
print('||W||^2 (unnormalised)      =', sp.factor(nrm2))
print('||A||^2 / ||W||^2           =', sp.simplify(sp.factor(A2)))
print('dim p / C(n-1,2)            =', sp.simplify(dp/((n-1)*(n-2)/2)))
print('difference                  =', sp.simplify(A2 - dp/((n-1)*(n-2)/2)))
print('||B||^2 vs (dim m - n + 1)/C(n-1,2):',
      sp.simplify(B2 - (a*b - n + 1)/((n-1)*(n-2)/2)))
print()
for (aa, bb) in ((3,5),(4,4),(2,6),(3,3),(2,4),(4,6),(5,5),(3,9),(6,8)):
    v = A2.subs({a: aa, b: bb})
    print(f'  S^{aa} x S^{bb} (n={aa+bb}): ||A||^2 = {sp.nsimplify(v)} = {float(v):.9f}'
          f'   dim p/C(n-1,2) = {sp.Rational(aa*(aa-1)//2 + bb*(bb-1)//2, (aa+bb-1)*(aa+bb-2)//2)}')
