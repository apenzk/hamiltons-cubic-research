"""A2': the certificate point as a formula -- Cramer on the pivoted system.

THE FLAW BEING REPAIRED (reviewer 242).  A4 as written solves the SDP
numerically at n = 12, 14, 16, 18 and fits a rational curve through the four
points.  Those are four arbitrary points of four DIFFERENT feasible bodies -- an
SDP solver returns whatever its path-following happens to hit -- and there is no
reason they lie on one rational curve.  Fitting them is not a method.

THE REPAIR.  Do not fit a point; DEFINE one, uniformly in n, by conditions that
are linear with Q(n) coefficients, so Cramer makes it rational by construction.

WHAT EVERYTHING RESTS ON, AND WHAT THE FIRST VERSION OF THIS FILE NEVER STATED
(reviewer 243).  The balanced product is CRITICAL:

    Q(W_*) = ((n-2)/2) W_*,   identically in n,

derived in closed form from the vertex matrix and cross-checked on the full
Lambda^2 operator at n = 8, 10, 12 to 4.5e-16.  Criticality is what makes C - B
vanish there, so the mu term drops FOR EVERY mu and the target vanishes.  Without
it there is no forced kernel at all, and the first version of this file asserted
the vanishing while omitting the identity that causes it.

v(n) IS NOT RATIONAL AS WRITTEN, AND THE RESCUE IS LOAD-BEARING (243).
||W_*||^2 = n^2(n-2)/(8(n-1)) is NOT a square in Q(n) -- by the (n-2)-adic
valuation -- so evaluation at the NORMALISED extremiser carries the same root as
Theta_n.  What saves it: the evaluation is homogeneous of degree 3 and the
condition B v = 0 is scale-invariant, so the UNNORMALISED covector may be used
and it is rational.  That step is what makes "entries in Q(n)" true, and it must
be written rather than assumed.

THE FORCED KERNEL IS IMPLIED, NOT IMPOSED -- AND THE FIRST VERSION ARGUED THE
WRONG THING (243).  Saying "any member still certifies" is a claim about
SOUNDNESS; losslessness is a different claim, and 243 exhibits a psd family where
an analogous condition deletes every member but one.  The correct argument is
stronger: for a family rational in n, psd at the even integers FORCES B v == 0
identically.  So the condition costs nothing because it is a consequence, not
because dropping members would be harmless.

  THE FORCED KERNEL NEEDS v(n) NONZERO AS AN EXPLICIT HYPOTHESIS (244, against
  243's claim 1).  The n=5 certificate is STRICTLY positive definite -- every
  LDL^H pivot > 0, minimum 2.26e-2 -- so "sharp implies forced kernel" is false
  in general and the implication runs only where the evaluation covector does not
  itself vanish.

  Theorem (A2').  Let A(n)x = b(n) be the constraint system (89 equations, the
  477 block-Gram unknowns, entries in Q(n) by A2), augmented by B v(n) = 0 with
  v the UNNORMALISED evaluation covector.  Then

    (a) the solution set is  B(t; n) = B_p(n) + sum_i t_i K_i(n),  entries in
        Q(n) identically in n;
    (b) the constraint identity  A(n) B(t;n) - b(n) = 0  holds in the universal
        ring for every t -- PROVIDED every non-pivot row is a Q(n)-combination
        of the pivot rows (see the witness below);
    (c) the n = 12 SDP's role shrinks to SELECTING t -- one search, at one
        dimension, whose numerical output never enters the proof.

CLAIM (b) IS TRUE BUT DOWNGRADED, AND 243 HAS A WITNESS.  A system with pivot
minor xi(n) = n - 2 -- sign-constant on [12, infinity), so the ONLY obligation
the first version stated is fully met -- nevertheless has
A(n) B(t;n) - b(n) = (0, 0, n+4) for every t.  The missing obligation is ROW
DEPENDENCE: non-pivot rows must be Q(n)-combinations of the pivot rows.  Here
they are, since B_lambda M_lambda = 0 is m^2 equations on m(m+1)/2 unknowns --
but that is a fact to check, not a freebie.

WHY ONE MINOR SUFFICES -- THE ARGUMENT THE FILE OMITTED (reviewer 244).  The
pivot set is a CHOICE, and in a 2x4 miniature 4 of 6 candidate sets have a minor
vanishing inside [12, infinity) -- reviewer 242's 869n - 2767 in miniature.  What
carries the claim is RANK SEMICONTINUITY: xi(n_0) nonzero pins the rank, hence
the nullity, hence the K_i remain a basis throughout.  One minor is enough
because of that, not by assumption.

AND THE PREDICATE WAS WRONG.  Cramer needs ROOT-FREENESS; the file asked for
sign-constancy, which is A5's PSD predicate imported by mistake.  244's witness:
xi(n) = (n-20)^2 is sign-constant on [12, infinity) and zero at n = 20.  The
script below already checked root-freeness, so it tested a property the prose did
not state.

AND THE STURM ITEM IS RETIRED (243's repair).  B_p was called "the
minimum-Frobenius-norm solution" while pivoted Cramer returns the BASIC solution.
Taking the actual pseudoinverse point instead gives denominator det(A A^T), which
by Cauchy-Binet is a SUM OF SQUARES OF MINORS -- positive wherever the rows are
independent, so no sign-constancy obligation arises at all.  It also makes B_p
canonical, hence equivariant, which is what claim 1's one-covector wording
silently needs.

  STILL OPEN, AND THE FALLBACK WAS FALSE AS WRITTEN (244).  I wrote that if t
  must vary it may be taken POLYNOMIAL in n.  Witness against it, in exactly A2's
  shape: B_p = [[1, -1/n], [-1/n, 1/n^4]], K = [[0,1],[1,0]] gives feasible set
  S_n = [1/n - 1/n^2, 1/n + 1/n^2], nonempty at every n -- and NO polynomial t(n)
  of any degree is feasible, while t(n) = 1/n is.  The fallback must read
  t in Q(n).

  WHETHER A CONSTANT t EXISTS IS REFUTABLE BY A FINITE CHECK (244).  Reviewer
  246's correction: 244 wrote that Helly REFUTES and does not establish, so
  "decidable" overstates -- the negative side is finitely certifiable and the
  affirmative side still needs A5 on a candidate.  Each S_n is a
  spectrahedron in a fixed R^k, so if one is bounded -- checkable at a single n
  via its recession cone -- HELLY makes constant-t refutable from k+1 dimensions
  with an exact Farkas certificate.  And sharpness is NOT a reason the
  intersection must be empty: the moving kernel is absorbed by B_p(n) and K_i(n).
  The first version conceded the open case without doing this analysis.

  242'S OWED DEGREE BOUND, IDENTIFIED: it exists IFF the width of S_n is bounded
  below.  Nothing in the record bounds that margin, so the fitted-t route
  currently has no stopping rule.

THE SCREEN.  A miniature carrying every clause.  The first version's check for
(b) COULD NOT FAIL: it asserted Aug * Aug.solve(bug) == bug on a square
nonsingular matrix, which holds for any matrix, correct or corrupt -- 243 ran 200
random wrong systems and none failed.  The replacement below solves against the
PIVOT rows alone and tests the residual on the FULL system, which is what (b)
actually asserts, with 243's (0, 0, n+4) witness as the regression case.
"""
import sympy as sp

n = sp.symbols('n')

# --- miniature: 3 unknowns, entries polynomial in n, one kernel condition ---
A = sp.Matrix([[1, n, 2],
               [0, n - 2, 1]])
b = sp.Matrix([n + 3, 1])
v = sp.Matrix([1, 1, -1])            # forced kernel: x . v = 0 (miniature of Bv=0)

Aug = A.col_join(v.T)
bug = b.col_join(sp.Matrix([0]))

# pivot minor and its sign on [12, inf): one Sturm item, here by inspection
xi = Aug[:, [0, 1, 2]].det()
xi = sp.simplify(xi)
print(f"  pivot minor xi(n) = {xi}")
roots = sp.solve(sp.Eq(xi, 0), n)
bad = [r for r in roots if r.is_real and r >= 12]
assert not bad, (
    f"the pivot minor has a real root {bad} in [12, infinity): the Cramer "
    "formula is singular there and the 'formula not fit' repair fails on its "
    "own precondition -- exactly the kind of denominator A5 must certify")
print(f"  roots {roots} -- none in [12, infinity), so Cramer is legal there")

x = Aug.solve(bug)                    # exact symbolic solve = Cramer
x = sp.simplify(x)
print(f"  x(n) = {[sp.nsimplify(e) for e in x]}")

# CLAIM (b), TESTED AS IT IS ACTUALLY STATED.  The first version asserted
# Aug * Aug.solve(bug) == bug, which is true for ANY square nonsingular matrix,
# correct or corrupt -- reviewer 243 ran 200 random wrong systems and none
# failed.  What (b) claims is that solving against the PIVOT rows reproduces the
# FULL system's right-hand side, which is false exactly when a non-pivot row is
# not a Q(n)-combination of the pivot rows.
def residual_on_full(full_A, full_b, pivot_rows):
    """solve against the pivot rows only, then measure on the FULL system.
    The pivot block is generally WIDE -- that is the point, the free columns
    being the t-directions -- so a parametric solve is needed, and the residual
    must be independent of the free parameters for claim (b) to hold."""
    P = full_A[pivot_rows, :]
    xp, params = P.gauss_jordan_solve(full_b[pivot_rows, :])
    r = sp.simplify(full_A * xp - full_b)
    if params:
        # claim (b) says the residual is zero for EVERY t; if it depends on the
        # free parameters at all, that is already a failure of (b).
        for t in params:
            assert sp.simplify(sp.diff(r, t)) == sp.zeros(*r.shape), (
                f"the residual depends on the free parameter {t}, so the "
                "constraint identity does not hold for every t")
        r = sp.simplify(r.subs({t: 0 for t in params}))
    return r

# INSTANTIATED WHERE IT CAN FAIL, WHICH TOOK TWO ATTEMPTS.
#
# The first version pivoted on all three rows -- a square nonsingular system,
# where the residual vanishes for ANY matrix, correct or corrupt (r246 ran 60
# corrupt systems, zero failures).  That recreated one level up the very defect
# r243 had just refuted.
#
# Pivoting on rows [0,1] instead FAILS, and correctly: the kernel row is a
# genuine extra constraint there, not a combination of the others, so the
# residual moves with the free parameter.  That is (b) being false for that
# pivot choice, and it exposed the real gap -- THE MINIATURE LACKED THE ROW
# REDUNDANCY (b) RELIES ON.  In the true system the redundancy is structural:
# B_lambda M_lambda = 0 is m^2 equations on m(m+1)/2 unknowns.
#
# So the miniature now carries a fourth row that IS a Q(n)-combination of the
# first three.  Pivoting on [0,1,2] leaves it a genuine non-pivot row, and the
# check has something to catch.
REDUN = (n + 1) * Aug[0, :] - 2 * Aug[2, :]
Aug4 = Aug.col_join(REDUN)
bug4 = bug.col_join(sp.Matrix([(n + 1) * bug[0] - 2 * bug[2]]))
resid = residual_on_full(Aug4, bug4, [0, 1, 2])
assert resid == sp.zeros(Aug4.rows, 1), (
    f"solving against the pivot rows leaves residual {resid.T} on the full "
    "system, so a non-pivot row is not a Q(n)-combination of the pivots and "
    "claim (b) fails -- the constraint identity does NOT hold for every t")
print("  claim (b): pivot solve reproduces the full system, symbolically in n")

# CORRUPT THE REDUNDANT ROW: it is then no longer a Q(n)-combination, and (b)
# must fail.  Without this the four-row instantiation would be as empty as the
# square one it replaced.
Aug4_bad = Aug4.copy(); Aug4_bad[3, 2] = Aug4_bad[3, 2] + 1
r_bad = residual_on_full(Aug4_bad, bug4, [0, 1, 2])
assert r_bad != sp.zeros(4, 1), (
    "corrupting the redundant row left the residual zero, so this instantiation "
    "still cannot see a non-pivot row escaping the pivot span -- the same "
    "emptiness r246 found in the square version")
print(f"  corrupted redundant row: residual {r_bad.T} -- caught")

# REGRESSION -- reviewer 243's witness.  Pivot minor n-2 is sign-constant on
# [12, inf), so A2's ONLY stated obligation is met, yet the residual is (0,0,n+4)
# for every t.  A check that passes this is not testing (b).
W_A = sp.Matrix([[1, 0, 0], [0, n - 2, 0], [0, 0, 0]])
W_b = sp.Matrix([1, 1, n + 4])
w_resid = residual_on_full(W_A, W_b, [0, 1])
print(f"  regression (243's witness): residual on the full system = {w_resid.T}")
assert w_resid != sp.zeros(3, 1), (
    "243's witness passed, so this check still cannot see a non-pivot row that "
    "escapes the pivot span -- which is the entire content of claim (b)")
print("  it FAILS, as it must -- the pivot minor being sign-constant is not")
print("  enough, and row dependence is a separate obligation.")

# AND THE STURM ITEM IS RETIRED: the pseudoinverse point's denominator is
# det(A A^T), a sum of squares of minors by Cauchy-Binet, hence positive
# wherever the rows are independent -- no sign-constancy to certify.
G = sp.simplify(A * A.T)
detG = sp.factor(sp.simplify(G.det()))
print(f"\n  det(A A^T) = {detG}")
minors = [A[:, c].det() if A.rows == 1 else sp.Matrix(A[:, list(c)]).det()
          for c in __import__('itertools').combinations(range(A.cols), A.rows)]
cb = sp.simplify(sum(m**2 for m in minors) - detG)
assert cb == 0, (
    f"Cauchy-Binet failed: sum of squared maximal minors minus det(A A^T) = "
    f"{cb}.  The retirement of the Sturm item rests on that identity")
print("  = sum of squares of maximal minors (Cauchy-Binet, checked), so it is")
print("  positive wherever the rows are independent: NO Sturm item is added.")

# --- the flaw A2' replaces: exhibited HONESTLY (reviewer 244) ---
#
# The first version simulated solver outputs by adding a RANDOM kernel component
# and showed a four-point fit missing loudly (median relative miss 2.45e-01).
# 244 refuted that as a straw man cutting the wrong way:
#
#   * an honest interior-point solver returns the ANALYTIC CENTRE, a canonical
#     algebraic function of n -- not a random point;
#   * where that centre is RATIONAL the fit reproduces it EXACTLY, so the old
#     assert would have fired and crashed the screen;
#   * where it is merely algebraic the miss is 2.72e-08, which PASSES a 1e-6
#     acceptance test -- about 9e6 times quieter than the screen manufactured.
#
# So A4's real hazard is a QUIET wrong answer, and a screen that only shows a
# loud one argues for A2' on a premise that is false.  THE HONEST REASON A2' IS
# THE RIGHT REPAIR: the analytic centre is algebraic of UNCONTROLLED DEGREE, so
# no bounded-degree rational ansatz is JUSTIFIED however well it fits -- fit
# quality is not evidence of correctness.  That is what the check below tests.
#
# The old assert (fit must miss) is deleted: it is false for a rational centre.
ker2 = A.nullspace()[0]
c0, c1, c2, d0 = sp.symbols('c0 c1 c2 d0')

def centre_like(ni, exact_rational=True):
    """a solver-like output: the canonical point of the 1-parameter family."""
    t = sp.Rational(1, ni) if exact_rational else sp.sqrt(ni + 1) / (ni + 1)
    return (x + t * ker2).subs(n, ni)

# the honest hazard: an ALGEBRAIC centre, fitted by a rational ansatz
pts = {ni: centre_like(ni, exact_rational=False)[0] for ni in (12, 14, 16, 18)}
f = (c0 + c1*n + c2*n**2) / (n + d0)
sol = sp.solve([sp.Eq(f.subs(n, ni), pts[ni]) for ni in pts], [c0, c1, c2, d0],
               dict=True)
assert sol, "the four-point fit had no solution at all, so nothing is exhibited"
ffit = f.subs(sol[0])
miss = abs(sp.N(ffit.subs(n, 20) - centre_like(20, exact_rational=False)[0]))
rel = miss / abs(sp.N(centre_like(20, exact_rational=False)[0]))
print(f"\n  algebraic centre, four-point rational fit, held-out n=20:")
print(f"    relative miss {sp.N(rel, 3)}  -- QUIET.  (An earlier line here said")
print("    'would pass a 1e-6 test'; this miss is 7.52e-6 and would NOT.  The")
print("    phrase was lifted from r244's 2.72e-8, a different regime -- r246.)")
assert rel < sp.Rational(1, 1000), (
    f"the miss was {sp.N(rel,3)}, which is loud.  244's point is that the real "
    "hazard is QUIET -- a fit that looks right and is not -- and a screen "
    "showing a loud failure argues for A2' on a false premise")

# and the rational-centre case, where fitting is exactly right and proves nothing
ptsR = {ni: centre_like(ni)[0] for ni in (12, 14, 16, 18)}
solR = sp.solve([sp.Eq(f.subs(n, ni), ptsR[ni]) for ni in ptsR],
                [c0, c1, c2, d0], dict=True)
exact = solR and sp.simplify(f.subs(solR[0]).subs(n, 20) - centre_like(20)[0]) == 0
print(f"  rational centre, same fit, held-out n=20 reproduced exactly: {exact}")
print("  -- FALSE here, and for 244's OTHER reason: this ansatz is deg 2 / deg 1")
print("     while the data is deg 3 / deg 2, so it is under-parameterised even")
print("     with no noise at all.  244 reports exact reproduction for a rational")
print("     centre with a matched ansatz, where the old screen's assert WOULD")
print("     have crashed; the miniature here cannot reach that case.")
print("  A2' is right because the analytic centre is algebraic of uncontrolled")
print("  degree, so no bounded-degree ansatz is JUSTIFIED however well it fits --")
print("  not because fits miss.")
