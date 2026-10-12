"""r275 claim 4: post 34's exact excess at the balanced sphere product.

Post 34 states     excess = m / ((2m-1)(u + sqrt(u^2+m^2-m))),  u = m(2m-3),
asymptotically 1/(8m^2) = 1/(2n^2).

Here the excess is (a) measured numerically from an independent build of the
S^m x S^m Weyl operator, (b) derived symbolically from the closed forms, and the
two compared with post 34's formula.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, sympy as sp
from r275_geo import Geo, sphere_product, theta0

m = sp.symbols('m', positive=True, integer=True)
u = m * (2 * m - 3)

# --- closed forms, re-derived and checked against the numerics below ---
tr3   = 1 / (m * sp.sqrt((m - 1) * (2 * m - 1)))
inner = (2 * m - 3) / sp.sqrt((m - 1) * (2 * m - 1))
E     = (2 * m - 1) * (m * (2 * m - 3) ** 2 + m - 1)
nrm_asfiled = sp.sqrt(m * E) / (sp.sqrt(m * (m - 1)) * (2 * m - 1))   # ad-form-attempt.md
nrm_fixed   = sp.sqrt(E)     / (sp.sqrt(m * (m - 1)) * (2 * m - 1))   # sqrt(E), not sqrt(mE)

excess_true = sp.simplify(nrm_fixed - inner)
excess_post34 = m / ((2 * m - 1) * (u + sp.sqrt(u ** 2 + m ** 2 - m)))
excess_closed = sp.sqrt((m - 1) / (2 * m - 1)) / (u + sp.sqrt(u ** 2 + m ** 2 - m))

print("symbolic:  excess_true - my closed form  =",
      sp.simplify(sp.radsimp(excess_true - excess_closed)))
print("symbolic:  excess_true - post34          =",
      sp.simplify(sp.radsimp(excess_true - excess_post34)))
print("ratio post34/true  ->  m/sqrt((2m-1)(m-1)) ; limit =",
      sp.limit(sp.simplify(excess_post34 / excess_true), m, sp.oo))
print("asymptotics:  n^2 * excess_true  ->",
      sp.limit(sp.simplify(4 * m ** 2 * excess_true), m, sp.oo), " (n=2m, so this is n^2*excess)")
print("asymptotics:  n^2 * excess_post34->",
      sp.limit(sp.simplify(4 * m ** 2 * excess_post34), m, sp.oo))
print()
print(f"{'n':>4} {'measured excess':>18} {'closed (mine)':>16} {'post34':>16} {'post34/true':>12}"
      f" {'1/(sqrt2 n^2)':>14} {'1/(2n^2)':>12}")
for n in (6, 8, 10, 12, 14, 16):
    g = Geo(n); k = n // 2
    W = sphere_product(g, k, k)
    F = np.trace(W @ W @ W) + np.linalg.norm(g.sharp(W))
    meas = F - theta0(n)
    a = float(excess_closed.subs(m, k)); b = float(excess_post34.subs(m, k))
    print(f"{n:>4} {meas:>18.12f} {a:>16.12f} {b:>16.12f} {b/meas:>12.6f}"
          f" {1/(np.sqrt(2)*n*n):>14.9f} {1/(2*n*n):>12.9f}")
    # also check the two normal-form pieces against the numerics
    if n == 12:
        print("     tr(M^3) closed", float(tr3.subs(m, k)), " measured", np.trace(W@W@W))
        print("     <M#,M>  closed", float(inner.subs(m, k)), " measured", float(np.sum(g.sharp(W)*W)))
        print("     ||M#||  as filed (sqrt(mE))", float(nrm_asfiled.subs(m, k)),
              " fixed (sqrt E)", float(nrm_fixed.subs(m, k)),
              " measured", float(np.linalg.norm(g.sharp(W))))
