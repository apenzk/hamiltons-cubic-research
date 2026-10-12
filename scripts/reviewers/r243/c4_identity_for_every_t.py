"""r243 / claim 4 -- 'the constraint identity holds in the universal ring for
EVERY t, so soundness never depends on how t is chosen.'

Three findings, each with a witness.

  (4A) The t-freedom is a TAUTOLOGY of affine linear algebra, valid over any
       field, hence over Q(n).  It is true.  Its content is nil beyond
       'B_p solves the system and K_i span a kernel'.
  (4B) It has an unstated hypothesis.  Cramer on a PIVOTED subsystem returns a
       solution of the PIVOT ROWS.  If the augmented system's rows are
       Q(n)-dependent -- and they are, since B_lambda M_lambda = 0 is m^2
       equations on m(m+1)/2 unknowns -- then a maximal minor xi(n) != 0
       certifies only the pivot rows, and the DELETED rows must separately be
       certified as Q(n)-combinations of them.  Witness below: a system that
       passes every check the file's screen performs, with xi(n) = n-2 never
       zero on [12,oo), and for which A(n)B(t;n) - b(n) != 0 for every t.
  (4C) The screen offered for (b) has zero discriminating power.  The miniature
       builds a SQUARE nonsingular Aug and then asserts Aug*Aug.solve(bug) == bug.
       That is an identity of exact linear algebra for every nonsingular matrix,
       correct or corrupt.  Demonstrated on 200 randomly WRONG systems.
"""
import sympy as sp
import random

n = sp.symbols('n')

# ---- (4A) the tautology, stated ------------------------------------------
print("  (4A)  If A Bp = b and A K_i = 0 then A(Bp + sum t_i K_i) - b = 0 for")
print("        every t, as an identity in the t_i over Q(n).  True in any field.")
print("        The t-freedom is therefore NOT evidence about the certificate;")
print("        it is the definition of an affine solution set.")

# ---- (4B) the witness ------------------------------------------------------
print("\n  (4B)  WITNESS: the pivoted Cramer solve satisfies the pivot rows and")
print("        misses the rest, with a pivot minor that is nonzero on [12,oo).")
A = sp.Matrix([[1, n,      2],
               [0, n - 2,  1],
               [1, 2*n - 2, 3]])          # row3 = row1 + row2 EXACTLY
b = sp.Matrix([n + 3, 1, 0])              # but b3 = 0 != b1 + b2 = n + 4
print(f"        rank_Q(n) A = {A.rank()}, rank_Q(n) [A|b] = {A.row_join(b).rank()}"
      "   -- INCONSISTENT over Q(n)")

piv_rows, piv_cols = [0, 1], [0, 1]       # a legal pivot choice
xi = sp.simplify(A[piv_rows, piv_cols].det())
print(f"        pivot minor xi(n) = {xi};  roots {sp.solve(sp.Eq(xi, 0), n)}"
      " -- none in [12, oo),")
print("        so the file's ONE Sturm obligation is met in full.")
xp = A[piv_rows, piv_cols].solve(b[piv_rows, :])          # free var x3 = 0
x = sp.Matrix([xp[0], xp[1], 0])
resid_pivot = sp.simplify(A[piv_rows, :] * x - b[piv_rows, :])
resid_full = sp.simplify(A * x - b)
print(f"        residual on the PIVOT rows : {list(resid_pivot)}   <- what the screen checks")
print(f"        residual on the FULL system: {list(resid_full)}   <- what claim (b) asserts")
assert resid_pivot == sp.zeros(2, 1)
assert resid_full != sp.zeros(3, 1)
ker = A[piv_rows, :].nullspace()
for K in ker:
    t = sp.symbols('t')
    assert sp.simplify((A * (x + t * K) - b)[2]) != 0
print("        and no kernel direction repairs it: the third row is off by n+4")
print("        for EVERY t.  Claim (b) FAILS on this system while every stated")
print("        obligation of A2' is satisfied.")
print("\n        The missing obligation, nameable: the non-pivot rows of [Aug|bug]")
print("        must be Q(n)-combinations of the pivot rows.  One symbolic check,")
print("        not an n-by-n one -- but the file names only sign-constancy of xi.")

# ---- (4C) the screen is a tautology ---------------------------------------
print("\n  (4C)  the screen's identity check cannot fail.")
random.seed(243)
tried = wrong = 0
for _ in range(200):
    M = sp.Matrix(3, 3, lambda i, j: random.randint(-4, 4) + random.randint(-2, 2)*n)
    if M.det() == 0:
        continue
    rhs = sp.Matrix([random.randint(-5, 5) + n, random.randint(-5, 5), 0])
    r = sp.simplify(M * M.solve(rhs) - rhs)
    tried += 1
    if r != sp.zeros(3, 1):
        wrong += 1
print(f"        {tried} random nonsingular SQUARE systems, none of them the true")
print(f"        constraint system: residual nonzero in {wrong} of them.")
assert wrong == 0
print("        => `assert Aug*Aug.solve(bug) == bug` is satisfied by every")
print("           nonsingular matrix.  It tests sympy's solver, not the claim.")
print("           The planted-corruption check DOES have content, but it only")
print("           shows Aug_bad != Aug; it says nothing about t-freedom.")

print("\n  VERDICT on claim 4: (b) is TRUE and it is the weakest true thing in")
print("  the file, not the strongest.  It converts numerical error from a")
print("  soundness risk into a completeness risk -- a real gain over fitting --")
print("  but it does NOT make the n=12 SDP's numerics irrelevant: PSD-ness of")
print("  B(t;n), which is the entire mathematical content, is a function of t")
print("  and t is what the numerics choose.")
