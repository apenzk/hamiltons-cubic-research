"""r244 / claim 3.  Does Cramer on a pivoted system really give Q(n) entries,
and is ONE sign-constancy obligation on xi(n) enough?

Four separate questions, answered separately.

  Q1  Is the STATED hypothesis the right one?  A2' asks for "a pivot minor
      xi(n) sign-constant on [12, infinity)".  Cramer needs xi(n) NONZERO.
      Those are different conditions.  WITNESS BELOW.

  Q2  Given a generic pivot set with xi(n) nonvanishing on the range, does the
      rank stay put, so that the specialised Cramer family is the WHOLE
      solution set at each n?  Proved and demonstrated.

  Q3  Does the pivot set have to be certified as a whole, i.e. do OTHER minors
      matter?  Demonstrated: no -- but the ONE that matters is the one actually
      used, and a different legal generic choice can fail on the range.

  Q4  Is B_p "the minimum-Frobenius-norm solution", as A2' says, the same point
      Cramer-on-a-pivoted-system produces?  Demonstrated: no.
"""
import sympy as sp

n = sp.symbols('n')
line = lambda s='': print(s)

# ================= Q1: sign-constant is not nonvanishing =====================
line("Q1  the stated hypothesis vs the needed one")
xi_bad = (n - 20)**2 + 0*n            # a determinant with an even-multiplicity root
# sign-constancy on [12, oo): xi >= 0 throughout, sign never changes.
samples = [sp.Rational(k, 2) for k in range(24, 61)]
signs = {sp.sign(xi_bad.subs(n, s)) for s in samples if xi_bad.subs(n, s) != 0}
line(f"    xi(n) = {sp.expand(xi_bad)}  --  signs taken on [12,30]: {signs}")
line(f"    sign-constant on [12, oo)?  {signs <= {1}}   (it is >= 0 throughout)")
line(f"    xi(20) = {xi_bad.subs(n, 20)}   <-- Cramer is UNDEFINED at n = 20")
assert xi_bad.subs(n, 20) == 0 and signs <= {1}
line("    => sign-constancy does NOT imply nonvanishing.  A2' states the wrong")
line("       obligation; A5's minors want sign-constancy, a Cramer DENOMINATOR")
line("       wants root-freeness.  The file's own screen checks root-freeness,")
line("       not the property the theorem hypothesises.")

# a live instance: a 2x2 system whose pivot minor is exactly (n-20)^2
A1 = sp.Matrix([[1, 0], [0, (n - 20)**2]])
b1 = sp.Matrix([1, 1])
x1 = sp.simplify(A1.solve(b1))
line(f"\n    live instance x(n) = {list(x1)}")
line(f"    at n = 20 the entry is a pole; the family has NO member there,")
line(f"    yet the stated hypothesis is satisfied.\n")

# ============ a genuinely underdetermined miniature, with a pivot CHOICE =====
# 2 equations, 4 unknowns.  Generic rank 2, so a pivot set is a CHOICE of 2 of
# the 4 columns: six candidate minors, and they do not vanish together.
line("Q2/Q3  a miniature that actually has a pivot choice (2 x 4, rank 2)")
A = sp.Matrix([[1,      n,      n - 20,   2],
               [0,  n - 12,  (n-20)*(n-13), n + 1]])
b = sp.Matrix([n + 3, 1])
cols = list(range(4))
import itertools
minors = {}
for S in itertools.combinations(cols, 2):
    minors[S] = sp.factor(sp.expand(A[:, list(S)].det()))
line("    every 2x2 column minor of A:")
for S, m in minors.items():
    rts = [r for r in sp.solve(sp.Eq(m, 0), n) if r.is_real and r >= 12]
    line(f"      cols {S}: {m}      real roots in [12,oo): {rts}")

good = [S for S, m in minors.items()
        if not [r for r in sp.solve(sp.Eq(m, 0), n) if r.is_real and r >= 12]]
bad  = [S for S in minors if S not in good]
line(f"\n    pivot sets legal on [12,oo): {good}")
line(f"    pivot sets that FAIL on [12,oo): {bad}")
assert good and bad, "the miniature was meant to have both kinds"
line("    => several minors DO vanish inside the range.  This is 242's")
line("       phenomenon in miniature.  It does not sink the claim, because a")
line("       pivot set is a CHOICE: it is enough that ONE choice survives.")

# Q2 proper: where the chosen minor is nonzero, the rank cannot drop, so the
# specialised family is the whole solution set.
S = good[0]; NS = [c for c in cols if c not in S]
xi = minors[S]
line(f"\n    take S = {S}, xi(n) = {xi}")
M = A[:, list(S)]
Minv = M.inv()
xp = sp.zeros(4, 1)
for i, c in enumerate(S): xp[c] = sp.simplify((Minv*b)[i])
K = []
for f in NS:
    v = sp.zeros(4, 1); v[f] = 1
    w = sp.simplify(-Minv*A[:, f])
    for i, c in enumerate(S): v[c] = w[i]
    K.append(v)
line(f"    basic solution x_p(n)   = {[sp.nsimplify(e) for e in xp]}")
for j, v in enumerate(K):
    line(f"    kernel basis K_{j}(n)      = {[sp.nsimplify(e) for e in v]}")

assert sp.simplify(A*xp - b) == sp.zeros(2, 1), "x_p is not a solution"
for v in K: assert sp.simplify(A*v) == sp.zeros(2, 1), "K_i is not in the kernel"
line("    A x_p - b == 0 and A K_i == 0 identically in n  (Q(n), not at samples)")

# rank constancy on the range, at the even integers
drops = []
for n0 in range(12, 61, 2):
    if xi.subs(n, n0) == 0: drops.append(('xi vanishes', n0)); continue
    r = A.subs(n, n0).rank()
    ker = sp.Matrix(A.subs(n, n0)).nullspace()
    if r != 2 or len(ker) != 2: drops.append((r, len(ker), n0))
line(f"    rank/nullity at even n in [12,60]: anomalies {drops if drops else 'none'}")
assert not drops
line("    => THEOREM (and it is the missing argument in A2'):  xi(n0) != 0")
line("       forces rank A(n0) >= |S| = generic rank, and rank can only DROP")
line("       under specialisation, so rank A(n0) = generic rank exactly.  The")
line("       nullity is therefore constant, and the K_i -- which carry a unit")
line("       vector on the non-pivot coordinates -- stay independent and stay a")
line("       BASIS.  ONE minor genuinely is enough.  A2' asserts this without")
line("       the argument, and the argument is what carries it.")

# ================= Q4: min-norm is not the pivoted-Cramer point ==============
line("\nQ4  is B_p 'the minimum-Frobenius-norm solution'?")
G = sp.simplify(A*A.T)
detG = sp.factor(sp.expand(G.det()))
xmin = sp.simplify(A.T*(G.inv())*b)
line(f"    det(A A^T) = {detG}")
line(f"    basic (pivoted Cramer) x_p = {[sp.nsimplify(e) for e in xp]}")
line(f"    minimum-norm            x* = {[sp.nsimplify(e) for e in xmin]}")
same = sp.simplify(xp - xmin) == sp.zeros(4, 1)
line(f"    are they the same point?  {same}")
assert not same
line("    => they are different points with DIFFERENT denominators.  The basic")
line("       solution's denominator is xi(n); the minimum-norm solution's is")
line(f"       det(A A^T), here of degree {sp.degree(sp.expand(detG), n)} against xi's degree "
     f"{sp.degree(sp.expand(xi), n)}.")
line("       A2' names the minimum-norm point and then guards it with a single")
line("       PIVOT minor.  Those guard two different objects.  Guarding the")
line("       right one -- the basic solution -- costs nothing, since soundness")
line("       needs SOME particular solution, not the shortest.  As written the")
line("       obligation does not cover the point the theorem names.")
line("\n    (det(A A^T) = sum of squared maximal minors by Cauchy-Binet, so it is")
line("     >= 0 on the reals and positive wherever ANY maximal minor is; that is")
line("     why 242's bare linear factor 869n - 2767 in a Gram determinant is")
line("     itself an anomaly -- a real root of odd multiplicity cannot survive")
line("     in a sum of real squares, so either the Gram is not over R at that")
line("     step or the factor is paired.)")

# ============ Q5: does the screen under review exercise ANY of this? =========
line("\nQ5  what the screen in run_a2prime_point_formula.py actually tests")
Aug = sp.Matrix([[1, n, 2], [0, n - 2, 1], [1, 1, -1]])
line(f"    the augmented miniature is {Aug.shape[0]} x {Aug.shape[1]}, det = "
     f"{sp.factor(Aug.det())}")
line(f"    nullspace over Q(n): {Aug.nullspace()}  (empty -- the file asserts this)")
line("    so in the screen there is:")
line("      * exactly ONE square submatrix using all columns -- no pivot CHOICE;")
line("      * no free parameters t, hence no kernel basis K_i to certify;")
line("      * one unique solution, so 'minimum-Frobenius-norm' is vacuous;")
line("      * no way for one minor to vanish while another does not.")
line("    The screen therefore exercises NONE of claim 3's structure.  It")
line("    demonstrates that sympy can solve a 3x3 system symbolically.")
sq = [c for c in [3] ]
line("    Contrast the 2 x 4 miniature above, where 4 of the 6 candidate pivot")
line("    sets vanish inside [12, oo) and only 2 survive -- the phenomenon the")
line("    screen was supposed to exhibit.")
