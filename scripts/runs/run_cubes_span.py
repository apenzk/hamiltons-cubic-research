"""CUBES SPAN Sym^3(U) -- so a covariant loses nothing at the diagonal.

WHERE OBLIGATION (i) STANDS.  Two accountings (r265, r266) showed the 10,393
collapse is the passage V^{tensor 12} -> Weyl^{tensor 3}, the SUBSPACE step, and
that restitution accounts for none of it.  r265 then sharpened the surviving
figure: rank 2 is m_empty EXACTLY, so r260 probed 2 of the 184 multiplicities and
found no loss at those two, leaving 182 untested in either direction.

THE 182 DO NOT NEED TESTING, AND THE REASON IS ONE LINE.

  A covariant is an equivariant map Sym^3(Weyl_n) -> V_lambda.  Restriction to
  the diagonal is evaluation at W tensor W tensor W.  For ANY real vector space
  U, the cubes { u tensor u tensor u : u in U } SPAN Sym^3(U) -- this is Theorem
  I.2.1 of the polarization primer applied to U itself, complete polarization
  being the inverse of restitution.  Take U = Weyl_n.

  A covariant vanishing at every W tensor W tensor W therefore vanishes on a
  spanning set of its own domain, hence is zero.  SO EVALUATION AT CUBES IS
  INJECTIVE ON THE COVARIANT SPACE, at every block and every n.

WHY THIS IS NOT THE RETRACTED ARGUMENT.  The retracted claim applied polarization
to the wrong space: it took the gamma_D, which are functionals on V^{tensor 12},
and asserted that restriction to the diagonal lost only the non-symmetric part.
It does not -- the domain first shrinks from V^{tensor 12} to Weyl^{tensor 3},
and a Weyl tensor is not a generic element of V^{tensor 4}.

  Here the space is Sym^3(Weyl_n) FROM THE START.  Nothing is restricted to a
  subspace; the covariants are constructed on that space and the only operation
  is evaluation at its own cubes.  The subspace step that killed the previous
  argument has already happened before this one begins.

WHAT IT REDUCES OBLIGATION (i) TO.  Independence of the 184 constructed
covariants AS FUNCTIONS OF W is now equivalent to their independence as elements
of the direct sum of Hom(V_lambda, Sym^3 Weyl_n) -- finite-dimensional linear
algebra at n = 12, in a space whose dimension the block table already gives as
184.  The function-space question is gone; a rank computation replaces it.

  WHAT IS NOT SETTLED: whether the constructed set actually HAS rank 184.  That
  is the check the reduction enables, not one it performs.
"""
import numpy as np
from itertools import combinations_with_replacement as cwr
from math import comb

def cube_rank(dim_U, samples, seed=0):
    """rank of { u^{tensor 3} } inside Sym^3(U), read in the monomial basis."""
    rng = np.random.default_rng(seed)
    mons = list(cwr(range(dim_U), 3))
    rows = []
    for _ in range(samples):
        u = rng.standard_normal(dim_U)
        rows.append([np.prod(u[list(m)]) for m in mons])
    M = np.array(rows)
    # RELATIVE tolerance.  An absolute tol=1e-9 reports rank 0 on the same matrix
    # rescaled by 1e-4 -- r266 found this once already and it came back here with
    # the exponent raised.
    return np.linalg.matrix_rank(M), len(mons)

# THE STATEMENT NEEDS NO NUMERICS AT ALL (r268).  The seven-cube identity
#
#   6xyz = (x+y+z)^3 - (x+y)^3 - (y+z)^3 - (x+z)^3 + x^3 + y^3 + z^3
#
# rebuilds every monomial of Sym^3 from cubes exactly, so cubes span by
# construction and the ranks below are a CHECK on the arithmetic, not the proof.
def seven_cube_identity(x, y, z):
    return ((x+y+z)**3 - (x+y)**3 - (y+z)**3 - (x+z)**3 + x**3 + y**3 + z**3) / 6

from fractions import Fraction as F
for a, b, c in ((F(2), F(3), F(5)), (F(-1), F(7), F(4)), (F(1,3), F(2,5), F(-3))):
    assert seven_cube_identity(a, b, c) == a * b * c, (
        f"the seven-cube identity failed at ({a},{b},{c}); it is what makes "
        "cubes-span a construction rather than a measurement, so it must be exact")
print("  the seven-cube identity is exact over Q -- cubes span Sym^3 BY CONSTRUCTION.")
print("  The ranks below check the arithmetic; they are not the proof.\n")

print("  cubes span Sym^3(U): rank of { u tensor u tensor u } against dim Sym^3(U)\n")
print(f"    {'dim U':>6} {'samples':>8} {'rank':>6} {'dim Sym^3':>10}")
for d in (2, 3, 4, 5, 6, 8):
    want = comb(d + 2, 3)
    got, mons = cube_rank(d, 3 * want + 25)
    print(f"    {d:>6} {3*want+25:>8} {got:>6} {want:>10}")
    assert got == want, (
        f"the cubes of a {d}-dimensional space spanned {got} dimensions inside "
        f"Sym^3, not {want}; complete polarization says every symmetric trilinear "
        "form is determined by its restitution, so the cubes must span and this "
        "would refute that at a dimension where it is checkable")

print("\n  and the same statement at degree 2 and 4, since the argument is not")
print("  special to 3:\n")
print(f"    {'dim U':>6} {'d':>2} {'rank':>6} {'dim Sym^d':>10}")
for d_U in (3, 4, 5):
    for deg in (2, 4):
        mons = list(cwr(range(d_U), deg))
        want = comb(d_U + deg - 1, deg)
        rng = np.random.default_rng(1)
        rows = [[np.prod(u[list(m)]) for m in mons]
                for u in rng.standard_normal((3 * want + 25, d_U))]
        got = np.linalg.matrix_rank(np.array(rows))
        print(f"    {d_U:>6} {deg:>2} {got:>6} {want:>10}")
        assert got == want, f"cubes-span fails at (dim U, d) = ({d_U}, {deg})"

print("\n  So evaluation at cubes is INJECTIVE on functionals of Sym^d(U), for any U.")
print("  Taking U = Weyl_n: a covariant vanishing at every W tensor W tensor W is")
print("  zero, at every block and every n.  Obligation (i) becomes a rank")
print("  computation in a 184-dimensional space, not a question about functions.")
print("\n  STILL OPEN: whether the constructed 184 attain rank 184.")
