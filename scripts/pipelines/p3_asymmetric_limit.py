"""
J_5 at maximal asymmetry, where the difficulty actually is.

The balanced case is proven and is a local MAXIMUM of theta, so it is where the
statement is least at risk.  The numerical sweep put J_5's minimum at the other
extreme, 0.154185 at (2,2,2,2,2,50).  This examines that family symbolically.

The extreme family is (2, 2, ..., 2, N) with j twos and one large block, so
n = 2j + N.  Two limits matter and they are different questions:

  * j fixed, N -> infinity: one block swallows the space
  * N fixed, j -> infinity: many small blocks

If J_5/r^2 has a positive infimum along both, the family cannot approach zero and
the grant holds on it; if either tends to zero, that limit is exactly where a
proof must be sharp, and if either goes negative the grant fails on the family
that the sweep already flagged as worst.

theta^2 is closed in form, so both limits are computable exactly rather than
sampled.  RHS needs the vertex values, so the gap RHS - theta is evaluated along
the family numerically at increasing sizes and compared against the symbolic
theta to see which way it trends.
"""
import sympy as sp
import numpy as np

j, N = sp.symbols('j N', positive=True, integer=True)

# theta^2 for blocks (2,...,2,N) with j twos: n = 2j + N, k = j + 1
n = 2*j + N
k = j + 1
D = (k - 1)*n**2 + j*(n - 2)**2/(2 - 1) + (n - N)**2/(N - 1)
theta2 = sp.simplify(2*(n - 1)**2 / D)
print("theta^2 for blocks (2,...,2,N), j twos:")
print("   ", sp.simplify(theta2))

print("\nlimits:")
lim_N = sp.simplify(sp.limit(theta2, N, sp.oo))
print(f"   j fixed, N -> oo :  theta^2 -> {lim_N}")
lim_j = sp.simplify(sp.limit(theta2, j, sp.oo))
print(f"   N fixed, j -> oo :  theta^2 -> {lim_j}")

print("\n   at j = 5 (the sweep's worst case), as N grows:")
for Nv in (10, 50, 200, 1000):
    t2 = float(theta2.subs({j: 5, N: Nv}))
    print(f"      N={Nv:>5}: theta = {np.sqrt(t2):.6f}")

print("\n   at N = 50, as j grows:")
for jv in (2, 5, 20, 100):
    t2 = float(theta2.subs({j: jv, N: 50}))
    print(f"      j={jv:>4}: theta = {np.sqrt(t2):.6f}")

print("\nthe slack S, to confirm these stay ungraded:")
# e_3 for (2,...,2,N): choose 3 twos, or 2 twos and N
e3 = sp.binomial(j, 3)*8 + sp.binomial(j, 2)*4*N
S = sp.simplify(3*theta2*e3/(n - 1)**2)
print("   S =", sp.simplify(S))
print(f"   at j=5, N=50: S = {float(S.subs({j: 5, N: 50})):.6f}  (positive, so ungraded)")
print(f"   j fixed at 5, N -> oo: S -> {sp.simplify(sp.limit(S.subs(j, 5), N, sp.oo))}")
