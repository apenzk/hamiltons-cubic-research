"""r244 / claim 5, structurally.  IS THERE A REASON A CONSTANT t WOULD OR WOULD
NOT EXIST?  And is 'then t is polynomial in n of bounded degree' a valid
fallback?

Nothing here is evidence from a solver run.  The two results are:

  R1 (positive, a reduction).  The constant-t question is nonemptiness of an
     intersection of spectrahedra in a FIXED t-space.  Under one checkable
     hypothesis -- some S_n bounded -- Helly's theorem makes it a (k+1)-wise
     condition, so a REFUTATION needs only k+1 dimensions and is finite and
     exact.  The infinite family is not the obstacle it looks like.

  R2 (negative, a witness).  A2's fallback "t must be taken polynomial in n of
     bounded degree" can be VACUOUSLY unavailable.  Exhibited: a family of
     exactly A2's shape, B_p(n) + t K(n) with entries in Q(n), whose feasible
     set S_n is a nonempty interval for every n >= 12 and for which NO
     polynomial t(n) of ANY degree is feasible.  The correct fallback is t
     rational in n, which costs claim (b) and A5 nothing.

  R3 (what the owed degree bound is a bound ON).  Follows from R2's mechanism.
"""
import sympy as sp
from fractions import Fraction as F

n, t = sp.symbols('n t')
line = lambda s='': print(s)

# ============================ R1 ============================================
line("R1  the constant-t question, stated structurally")
line("    For each even n >= 12 put  S_n = { t in R^k : B_p(n) + sum t_i K_i(n) >= 0 }.")
line("    * t |-> B(t;n) is AFFINE and the psd cone is closed convex, so every")
line("      S_n is a closed convex set -- a spectrahedron -- in ONE fixed R^k.")
line("      (k is constant on the range: that is r244's claim-3 theorem, since")
line("      xi(n) nonzero pins the rank, hence the nullity.)")
line("    * A constant t works  <=>  intersection over all n of S_n is nonempty.")
line("    So this is convex feasibility in a fixed finite-dimensional space.  It")
line("    is NOT a fitting problem and needs no ansatz.")
line()
line("    HELLY.  If at least one S_{n0} is bounded, then intersecting the whole")
line("    family with it makes every member compact and convex, and Helly's")
line("    theorem in R^k applies: the full intersection is nonempty IFF every")
line("    k+1 of the S_n have a common point.")
line("    CONSEQUENCE -- a finite refutation exists.  Constant t is dead as soon")
line("    as k+1 dimensions have no common feasible point, and infeasibility of")
line("    that ONE joint system carries an exact Farkas certificate.  This is a")
line("    legitimate screen: it refutes, it does not establish.")
line()
line("    BOUNDEDNESS is itself structural and checkable:  S_n is bounded  <=>")
line("    its recession cone { t : sum t_i K_i(n) >= 0 } is {0}  <=>  the span of")
line("    the kernel basis contains no nonzero psd matrix.  A single linear-")
line("    algebra fact about the K_i, decidable at one n.")
line()
line("    WHAT THE BOUNDARY STRUCTURE DOES AND DOES NOT COST.  At even n the")
line("    forced kernel makes every feasible B singular, so S_n has empty")
line("    interior in the UNRESTRICTED family.  A2' already imposes B v(n) = 0")
line("    inside the family, so B(t;n) lives in the psd cone of v(n)^perp and")
line("    S_n can have nonempty RELATIVE interior there.  The moving kernel")
line("    v(n) is absorbed by B_p and K_i being n-dependent, so it does not by")
line("    itself obstruct a constant t.  Sharpness is therefore NOT a reason")
line("    the intersection must be empty.")

# ============================ R2: the witness ===============================
line("\nR2  the polynomial fallback, refuted by a witness of A2's own shape")
Bp = sp.Matrix([[1, -1/n], [-1/n, 1/n**4]])
K  = sp.Matrix([[0, 1], [1, 0]])
B  = Bp + t*K
line(f"    B_p(n) = {Bp.tolist()}          entries in Q(n)")
line(f"    K      = {K.tolist()}                     entries in Q(n)")
line(f"    B(t;n) = B_p(n) + t K,  affine in t, rational in n -- A2's shape")
d = sp.factor(sp.simplify(B.det()))
line(f"    det B(t;n) = {d}")
line(f"    leading entry B_11 = 1 > 0, so  B(t;n) >= 0  <=>  det >= 0")
sol = sp.solve(sp.Eq(B.det(), 0), t)
line(f"    det = 0 at t = {sol}")
line(f"    => S_n = [ 1/n - 1/n^2 , 1/n + 1/n^2 ],  NONEMPTY for every n >= 12,")
line(f"       of width 2/n^2 > 0.")

# verify nonemptiness and the exclusion of every polynomial, exactly
for n0 in (12, 14, 100, 10**6):
    lo, hi = F(1, n0) - F(1, n0**2), F(1, n0) + F(1, n0**2)
    mid = F(1, n0)
    Bm = B.subs({n: n0, t: sp.Rational(mid)})
    assert Bm.det() >= 0 and Bm[0, 0] >= 0, n0
    assert lo < hi
line("    checked exactly at n = 12, 14, 100, 10^6: nonempty, and t = 1/n is in it.")

line("\n    NO POLYNOMIAL t(n) IS FEASIBLE, AT ANY DEGREE.  Proof:")
line("      feasibility forces |t(n) - 1/n| <= 1/n^2 for all even n >= 12,")
line("      hence t(n) -> 0 as n -> oo.  A polynomial tending to 0 along an")
line("      infinite set of integers is the zero polynomial.  But t = 0 gives")
line("      |0 - 1/n| = 1/n > 1/n^2 for n > 1.  Contradiction.")
line("      (And the same kills every polynomial of every bounded degree, so no")
line("       degree bound could rescue it.)")
# exhibit the contradiction numerically-exactly for the only surviving candidate
for n0 in (12, 20, 50):
    assert F(1, n0) > F(1, n0**2)
line("      verified at n = 12, 20, 50: |0 - 1/n| > 1/n^2.")
line("\n    Yet  t(n) = 1/n  in Q(n) is feasible at every n >= 12, and B(t(n);n)")
line("    still has entries in Q(n) -- so claim (b) and A5 are untouched.")
line("    => A2's fallback as WRITTEN ('t polynomial in n of bounded degree') is")
line("       not merely missing a bound; it can be unavailable while a rational")
line("       t exists.  The fallback should read t in Q(n).  This costs nothing")
line("       and removes a false dichotomy: A2' currently reads 'constant, else")
line("       polynomial', and the true trichotomy is 'constant, else rational,")
line("       else no member of the family certifies at all'.")

# ============================ R3 ============================================
line("\nR3  what the owed degree bound is a bound ON")
line("    In the witness the obstruction was the WIDTH of S_n against the")
line("    distance from the admissible curves to the centre of S_n.  In general:")
line("    S_n is cut out by minors of B(t;n), so its boundary is an ALGEBRAIC")
line("    function of n with a Puiseux expansion in powers of n^(1/q).  A")
line("    polynomial t(n) of degree d can track an algebraic centre curve only")
line("    to within the resolution its own degree allows.  So:")
line()
line("      a degree bound exists  <=>  the width of S_n is bounded BELOW by")
line("      some n^(-M), and then d is bounded in terms of M and q.")
line()
line("    That is the shape of 242's owed bound, and it is owed on a quantity")
line("    the record does not have: an effective lower bound on the width of")
line("    S_n -- the margin of the certificate -- uniformly in n.  Nothing in")
line("    the record bounds it.  Without it, 'fit the coefficients of t' has no")
line("    stopping rule: no failure at degree d refutes degree d+1.")
line()
line("    NOTE the direction this cuts.  The witness shows the width can be")
line("    positive at every n while shrinking, which is the DANGEROUS case: the")
line("    search never terminates and never refutes.  A width lower bound is")
line("    therefore the first thing to derive, before any t is chosen.")

# ============================ the screen, demoted ============================
line("\nSCREEN (refuting only, per the programme rule)")
line("    The record's one completed certificate, n=5, is strictly positive")
line("    definite -- see c5_n5_interior_or_boundary.py, every block's LDL^H")
line("    pivots > 0 over Q(i), smallest 2.258e-02.  n=5 is odd, has no balanced")
line("    product and no forced kernel, so it is the INTERIOR regime.  This")
line("    screens out one reading of the record: it cannot be cited as evidence")
line("    that an arbitrary or constant selection survives at even n, because it")
line("    is an instance of the other regime.  It establishes nothing positive.")
