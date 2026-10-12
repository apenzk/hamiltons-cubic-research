"""r243 / claim 2 -- is v(n) rational in n, and is B v(n) = 0 linear in B?

A2' asserts both in one clause: "the forced-kernel conditions B v(n) = 0 --
linear, since v(n), the evaluation covector at the balanced product, is
rational in n."

Three separate questions, answered separately below.

  (2a) Taken LITERALLY -- v(n) = m(W*/|W*|), the cubic basis evaluated at the
       normalised extremiser -- v(n) is NOT rational in n.  |W*|^3 carries a
       square root, and it is not removable by rescaling the basis.
  (2b) The conclusion survives, but only through homogeneity: B v = 0 is
       scale-invariant and m is homogeneous of degree 3, so v(n) may be taken
       at the UNNORMALISED W*, whose entries are polynomial in n after clearing
       2(n-1).  This step is load-bearing for Cramer-over-Q(n) and is absent
       from the file.
  (2c) Linearity holds, because v(n) depends only on the extremiser and not on
       B.  In the multiplicity coordinates the honest form of the condition is
       B_lambda M_lambda(n) = 0 with M_lambda the Gram of the block-lambda
       covariants at W* -- still linear, still rational, and it needs no basis
       of the irreducible V_lambda.
"""
import sympy as sp

n = sp.symbols('n', positive=True)
normsq = n**2*(n-2)/(8*(n-1))          # |W*|^2, from c1

print("  (2a)  |W*|^2 =", normsq)
print("        Is |W*| in Q(n)?  Suppose |W*| = f/g with f,g in Q[n], g != 0.")
print("        Then n^2 (n-2) g^2 = 8 (n-1) f^2.  Take the (n-2)-adic valuation:")
print("        LHS has 1 + 2 v(g)  (odd), RHS has 2 v(f)  (even).  Contradiction.")
print("        => |W*| is a genuine quadratic irrationality over Q(n), and so is")
print("           |W*|^3.  sympy agrees it does not simplify to a rational:")
r = sp.sqrt(normsq)
print("        sqrt(|W*|^2) =", sp.simplify(r), "  is_rational_function(n):",
      sp.simplify(r).is_rational_function(n))
assert not sp.simplify(r).is_rational_function(n)

# the same obstruction, exhibited: Theta_n itself is irrational in n
Theta = sp.sqrt(2*(n-1)*(n-2))/n
print("        (Theta_n =", Theta, "-- the same square root, as the brief says.)")
assert not Theta.is_rational_function(n)
print("        Only Theta_n^2 = 2(n-1)(n-2)/n^2 enters the TARGET, so b(n) is safe;")
print("        the extremiser's NORMALISATION is where the root would enter.\n")

# (2b) homogeneity kills it -----------------------------------------------
print("  (2b)  homogeneity.  Every cubic covariant c is homogeneous of degree 3,")
print("        so c(W*/|W*|) = c(W*)/|W*|^3, i.e.  v_normalised = |W*|^{-3} v_raw.")
print("        B v = 0 is invariant under v -> s v for any s != 0, so the")
print("        condition is IDENTICAL for the two, and v_raw may be used.")
w11, w12 = n/(2*(n-1)), -(n-2)/(2*(n-1))
print(f"        W* raw entries: w11 = w22 = {w11},  w12 = {sp.simplify(w12)}")
print(f"        cleared by 2(n-1):  {sp.simplify(2*(n-1)*w11)}  and  {sp.simplify(2*(n-1)*w12)}"
      "  -- POLYNOMIAL in n.")
print("        A cubic in these entries is polynomial in n; so v_raw(n) is")
print("        polynomial in n up to the overall factor (2(n-1))^{-3}, which")
print("        scale-invariance discards.  v(n) IS rational -- via homogeneity,")
print("        which the file does not invoke.\n")

# a concrete rational cubic evaluation, to make the point non-vacuous
K = sp.Matrix(6, 6, lambda i, j: 0 if i == j else
              (w11 if (i < 3) == (j < 3) else w12))          # n = 6 shape, symbolic n
tr3 = sp.simplify(sum(K[i, j]**3 for i in range(6) for j in range(6) if i != j))
print("        e.g. the cubic invariant sum K_ab^3 at the (shape-6) balanced split:")
print("            raw   :", sp.factor(tr3), " -- rational in n")
print("            normed:", sp.simplify(tr3/normsq**sp.Rational(3, 2)),
      " -- carries the root")
assert sp.factor(tr3).is_rational_function(n)
assert not sp.simplify(tr3/normsq**sp.Rational(3, 2)).is_rational_function(n)

# (2c) linearity, and the honest shape of the condition -------------------
print("\n  (2c)  linearity.  For FIXED v, B -> B v is linear; v depends only on the")
print("        extremiser, never on B, so B v(n) = 0 is linear, not quadratic.")
print("        (It would be quadratic only if v were defined as a kernel vector")
print("         OF B -- the file's wording 'the forced kernel' invites that")
print("         reading, and it is not what is meant.)")
print("\n        But in the BLOCK coordinates the forced condition is not one")
print("        covector.  With B = (+)_lambda B_lambda (x) Id_{V_lambda} and")
print("        c_i^lambda the m_lambda covariants of block lambda,")
print("            G(W*) = sum_lambda tr(B_lambda M_lambda),   "
      "M_lambda := [<c_i^lambda(W*), c_j^lambda(W*)>].")
print("        M_lambda is psd, so each trace vanishes, so B_lambda M_lambda = 0:")
print("        rank(M_lambda) conditions per block, not one.  See c3 script.")
