"""r245, claim 2: what the Helly step actually needs from the augmented system.

The brief asks whether "the sets live in a FIXED R^k" requires the nullity of
the augmented system to be constant on n >= 12, and whether that is established.
The accounting comes out finer than the brief's phrasing:

  (a) THE AMBIENT R^k IS FIXED BY CONSTRUCTION.  k is the nullity of the
      augmented system over the FIELD Q(n) -- one number, computed once.  The
      K_i(n) are rational matrix families, so S_n = {t : B_p(n) + sum t_i
      K_i(n) psd} sits in the same R^k at every n where the entries are
      DEFINED.  No constancy statement is needed for the ambient space.
  (b) WHAT CAN FAIL AT A SPECIAL n IS THE SPECIALISATION, two ways:
      -- entries undefined (a Cramer denominator vanishes), so S_n is not
         defined there at all;
      -- the specialised K_i(n*) span a PROPER subspace of the true kernel at
         n* (nullity jumps up), so the family misses certificates at n* and a
         Farkas refutation there refutes only "no constant t IN THIS FAMILY".
      Both are governed by the SAME hypothesis: the chosen pivot minor xi(n) is
      root-free on [12, infinity).  Rank semicontinuity then pins the rank, so
      the nullity is constant and the K_i specialise to a basis.
  (c) THE K_i CANNOT BECOME DEPENDENT WHERE DEFINED.  Cramer's kernel basis
      carries a unit vector on each free coordinate (r244), so any
      specialisation of the K_i stays independent.  The failure mode is only
      the kernel GROWING past their span, never their collapsing.

This file exhibits (b) with a witness family whose nullity jumps at n = 20 --
a genuine certificate at n = 20 outside the specialised family -- and verifies
(a)/(c) on it exactly.  Deliverable point: root-freeness of xi(n) for the REAL
89+kernel-row system (degree of order several hundred, r244) is the single
undischarged obligation carrying "fixed R^k"; nothing in the record checks it,
and the system it must be checked on is not yet assembled (A2 owes the
coordinate-picking steps, plan section 2 items 1-2).
"""
import sympy as sp

n = sp.symbols('n')

# Witness family: 2 constraint rows + 1 kernel row on 4 unknowns, entries in
# Q(n).  Generic rank 3, so k = nullity over Q(n) = 1.
Aug = sp.Matrix([[1, 0, 0, 2],
                 [0, n - 20, 0, n - 20],
                 [0, 0, 1, 0]])

r_generic = Aug.rank()          # rank over the field Q(n)
k = Aug.cols - r_generic
print(f"  generic rank {r_generic}, so k = {k}: the t-space R^k is fixed by "
      "construction, once, over Q(n)")
assert (r_generic, k) == (3, 1)

# Cramer at pivot columns (0,1,2): xi(n) = n - 20, a root INSIDE [12, inf).
xi = Aug[:, [0, 1, 2]].det()
print(f"  chosen pivot minor xi(n) = {xi} -- root at n = 20 in [12, infinity):"
      "\n    the root-freeness obligation FAILS for this choice")
assert sp.simplify(xi - (n - 20)) == 0

# The Cramer kernel basis at that pivot set: unit vector on the free column.
K1 = sp.Matrix([-2, -1, 0, 1])
assert sp.simplify(Aug * K1) == sp.zeros(3, 1), "K1 is not in the kernel"
print(f"  Cramer kernel basis K1 = {list(K1.T)}: unit free coordinate, so its "
      "specialisations can never become dependent (point (c)), and here it is "
      "even defined at every n")

# At n = 20 the true nullity jumps: rank drops to 2, kernel is 2-dimensional.
A20 = Aug.subs(n, 20)
ker20 = A20.nullspace()
print(f"  at n = 20: rank {A20.rank()}, nullity {len(ker20)} -- the nullity "
      "is NOT constant, exactly at the root of xi")
assert A20.rank() == 2 and len(ker20) == 2

# A certificate direction at n = 20 the family cannot see: e2 solves the
# homogeneous system at 20 but lies outside span{K1(20)}, so the affine family
# B_p + t K1 sweeps a proper subset of the solution set exactly at n = 20.
e2 = sp.Matrix([0, 1, 0, 0])
assert A20 * e2 == sp.zeros(3, 1)
print("  witness: e2 is a homogeneous solution at n = 20 invisible to the "
      "family -- a Farkas refutation touching n = 20 would refute only 'no "
      "constant t IN THIS FAMILY', not 'no constant certificate'")

# The repaired choice: pivot columns (0,1,2) of a system whose minor is
# root-free on [12, inf) -- rank semicontinuity then gives constant nullity.
Aug2 = sp.Matrix([[1, 0, 0, 2],
                  [0, n - 2, 0, 1],
                  [0, 0, 1, 0]])
xi2 = Aug2[:, [0, 1, 2]].det()
roots = sp.solve(sp.Eq(xi2, 0), n)
assert all(not (r.is_real and r >= 12) for r in roots)
ranks = {m: Aug2.subs(n, m).rank() for m in (12, 14, 20, 50, 1000)}
print(f"\n  repaired family, xi(n) = {xi2}, root-free on [12, infinity): "
      f"specialised ranks {ranks}")
assert set(ranks.values()) == {3}, "rank moved despite a root-free minor"
print("  rank is pinned at the generic value at every sampled n, and rank "
      "semicontinuity makes that a theorem on all of [12, infinity): "
      "xi(n) != 0 forces rank >= 3, and specialisation cannot exceed the "
      "generic rank 3.  Constant nullity is EQUIVALENT to the root-freeness "
      "obligation -- undischarged, on a system not yet assembled.")
