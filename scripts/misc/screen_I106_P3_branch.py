"""Does a LOWER bound on P_3 escape the sign obstruction, or confirm it?

Batch 20 owes "an upper bound on mu OR a lower bound on P_3".  I recorded the
obstruction purely in mu.  This tests the other branch.

    Phi = 2 mu T - 2 P_3      (batch 20, value_at_critical)

so P_3 >= g gives Phi <= 2 mu T - 2g, and the comparison needs 2 mu T - 2g < Phi_diag(T).

r970's reported bound is g = -3 mu T, giving Phi <= 2 mu T + 6 mu T = 8 mu T.

THE QUESTION: mu is bounded BELOW (batch 18, 21, orbit, radial all give mu >= ...),
never above.  So is 2 mu T - 2g bounded above at all?  Checked at the three survivors'
own (mu, T), and symbolically in the sign of the mu-coefficient.
"""
import sympy as sp

mu, T = sp.symbols('mu T', positive=True)
g = -3*mu*T                       # r970's reported tangent-trace bound
bound = 2*mu*T - 2*g
print("Phi <= 2 mu T - 2 g   with g = -3 mu T :", sp.simplify(bound))
print("  coefficient of mu   :", sp.simplify(sp.diff(bound, mu)))
print("  increasing in mu    :", sp.simplify(sp.diff(bound, mu)) > 0)
print()
print("mu is bounded BELOW only, so a bound increasing in mu is unbounded above.")
print()
# at the three survivors
for tag, m, t in [("(1,-3,2)", 11.60060, 178.2407),
                  ("(-1,-3,4)", 24.43870, 645.4986),
                  ("(19,-20,1)", 762.38453, 350181.3948)]:
    val = float(bound.subs({mu: m, T: t}))
    print(f"  {tag:<12} mu={m:>12.5f} T={t:>14.4f}   Phi <= {val:>18.2f}")
print()
print("Compare batch 35's recorded Phi at those points: 2143.11, 19982.02, 526210564.02")
print("and the diagonal values 3290.16, 28862.02, 577574913.52.")
print()
print("So this branch gives an upper bound on Phi that GROWS with mu, while every")
print("recorded lever bounds mu from below. The P_3 route does not escape the sign")
print("obstruction: it inherits it.")
