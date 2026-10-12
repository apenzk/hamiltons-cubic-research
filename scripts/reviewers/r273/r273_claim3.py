"""r273 Claim 3: (a) the 'target' is the conjecture verbatim; (b) closed form and
positivity of the Cauchy-Schwarz excess at the balanced sphere product."""
import sympy as sp

m = sp.symbols('m', positive=True, integer=True)
E   = 8*m**4 - 28*m**3 + 32*m**2 - 12*m + 1
tr3 = 1/(m*sp.sqrt((m-1)*(2*m-1)))
ip  = (2*m-3)/sp.sqrt((m-1)*(2*m-1))
nrm = sp.sqrt(E)/(sp.sqrt(m*(m-1))*(2*m-1))
th0 = sp.sqrt((m-1)*(2*m-1))/m

print("E factorises as (2m-1)[m(2m-3)^2 + m - 1] :",
      sp.simplify(E - (2*m-1)*(m*(2*m-3)**2 + m - 1)) == 0)
print("theta - theta_0 == 0 identically      :", sp.simplify(tr3 + ip - th0) == 0)
print("theta_0(2m) == sqrt(2(n-1)(n-2))/n    :",
      sp.simplify(th0 - sp.sqrt(2*(2*m-1)*(2*m-2))/(2*m)) == 0)

u  = m*(2*m-3)
ex_closed = m/((2*m-1)*(u + sp.sqrt(u**2 + m**2 - m)))
ex_direct = (tr3 + nrm)/th0 - 1
print("excess closed form matches            :",
      all(abs(float(ex_direct.subs(m,k) - ex_closed.subs(m,k))) < 1e-14 for k in range(2,60)))
print("excess > 0 for every m>=1             :",
      all(float(ex_closed.subs(m,k)) > 0 for k in range(1,400)))
print("excess * n^2 -> ", [ (2*k, float(ex_direct.subs(m,k))*(2*k)**2) for k in [3,6,12,50,200,1000] ])
print("limit of n^2 * excess                 :", sp.limit(ex_closed*(2*m)**2, m, sp.oo))
print("cos(phi) at the maximiser  = ip/nrm   :", sp.simplify(sp.limit(ip/nrm, m, sp.oo)))
