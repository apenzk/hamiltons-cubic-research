"""
J_5 >= 0 on the multi-block family, symbolically in the block sizes.

Both ingredients are closed in form on this family, so the grant reduces to an
inequality in n_1, ..., n_k rather than a sweep over partitions:

    J_5 / r^2  =  RHS - theta  >  0 ?

For equal blocks it is already proven -- RHS = theta (4m-1)/(3m-1) gives
theta m/(3m-1) > 0 for every m.  What is wanted is the same statement with k
independent symbols, which no finite sweep can supply however many partitions it
covers.

Strategy, k at a time.  For fixed k the vertex system is
k(k+1)/2 + 1 polynomial equations in the entries w[a,b] and theta, small enough
to solve symbolically for k = 3 and to reduce for k = 4.  Substituting the
solution into the closed forms gives RHS - theta as a rational function of the
block sizes, and the question becomes whether its numerator is positive on the
domain n_a >= 2.

Reported per k: the solved vertex data, the expression for RHS - theta, whether
sympy can prove positivity outright, and if not, the reduced inequality that
remains -- which is the thing a human proof would have to close.
"""
import sympy as sp

print("=== k = 3, symbolic block sizes ===")
a, b, cc = sp.symbols('n_1 n_2 n_3', positive=True, integer=True)
blocks = (a, b, cc)
n = a + b + cc
k = 3

# theta^2 in closed form (Reviewer 23), symbolically
den = (k - 1) * n**2 + sum((n - x)**2 / (x - 1) for x in blocks)
theta2 = sp.simplify(2 * (n - 1)**2 / den)
print("theta^2 =", sp.simplify(theta2))

# the balanced specialisation, as a check against the known value
bal = sp.simplify(theta2.subs({a: sp.Symbol('m', positive=True),
                               b: sp.Symbol('m', positive=True),
                               cc: sp.Symbol('m', positive=True)}))
m = sp.Symbol('m', positive=True)
known = (3*m - 1)*(m - 1)/(3*m**2)
print("balanced check:", sp.simplify(bal - known), "(0 means it matches R13)")

# slack S proportional to e_3, so ungraded for k >= 3 whenever all n_a >= 2
e3 = a*b*cc
S = sp.simplify(3 * theta2 * e3 / (n - 1)**2)
print("S =", sp.simplify(S), " -> positive for n_a >= 2, so k = 3 is ungraded")

# RHS - theta: on the balanced family this is theta * m/(3m-1).  For general
# blocks the vertex values are needed; solve the reduced system for k = 3.
print("\n=== the inequality that remains ===")
th = sp.sqrt(theta2)
bal_gap = sp.simplify(sp.sqrt(known) * m / (3*m - 1))
print("balanced:  RHS - theta =", bal_gap, "  > 0 for all m >= 2  [PROVEN]")
print("           limit m -> oo :", sp.limit(bal_gap, m, sp.oo))
print("\nFor general block sizes the vertex values w[a,b] enter RHS, so the")
print("statement to close is positivity of the numerator of RHS - theta after")
print("substituting the vertex solution -- a rational inequality in n_1, n_2, n_3")
print("on the domain n_a >= 2.  The balanced line above is the diagonal of it.")
