"""r243 -- two loose ends.

(1)  claim 1's 'costs nothing at ODD n'.  The file's reason is a SOUNDNESS
     statement -- "a restriction of the family, any member of which still
     certifies" -- and losslessness is a different statement, about whether
     the restriction can DELETE a member that would have worked.  The file's
     reason does not establish it; a correct argument exists and is given.

(2)  claim (a) calls B_p 'the minimum-Frobenius-norm solution'.  Cramer on a
     pivoted system returns the BASIC solution with the free variables set to
     zero, which is a different point.  The misdescription matters, because
     the min-norm solution comes with a STRICTLY BETTER denominator: by
     Cauchy-Binet det(A A^T) is a sum of squares of maximal minors, so its
     sign-constancy on [12,oo) is automatic and A2's one new Sturm item
     disappears.  The file's own words point at a repair it does not take.
"""
import sympy as sp
import numpy as np

n = sp.symbols('n')

# ---- (1) losslessness at odd n --------------------------------------------
print("  (1) 'costs nothing at odd n'")
print("      What the file says: the restricted family's members still certify.")
print("      That is soundness.  Losslessness asks: can the restriction delete a")
print("      member that would have certified?  A restriction can do exactly that:")
Bfam = sp.Matrix([[1, sp.Symbol('s')], [sp.Symbol('s'), 1]])
s = sp.Symbol('s')
print("      e.g. the psd family B(s) = [[1,s],[s,1]], psd for |s| <= 1; the extra")
print("      linear condition B(s)(1,-1)^T = 0 forces s = 1 and deletes every")
print("      other psd member.  'Still certifies' says nothing about that.")
sol = sp.solve(list(Bfam * sp.Matrix([1, -1])), s, dict=True)
print(f"      condition B v = 0 with v=(1,-1): s in {[d[s] for d in sol]}, out of |s| <= 1.")
assert [d[s] for d in sol] == [1]

print("\n      The correct argument, which the file does not give:")
print("        Let B(n) have entries in Q(n), satisfy the constraints identically,")
print("        and be psd at every even integer n >= 12.  At each such n the")
print("        target vanishes at W* (c1), so v(n)^T B(n) v(n) = 0 and psd gives")
print("        B(n) v(n) = 0.  Each entry of B(n)v(n) is a rational function of n")
print("        vanishing at infinitely many points, hence identically zero.")
print("      So within the class route A searches -- families RATIONAL in n --")
print("      B v(n) = 0 is not a restriction at all: it is implied.  Losslessness")
print("      holds, at odd n and at every real n, for a reason about rationality")
print("      rather than about odd n.  It would fail for a non-rational family.")

# demonstrate the density step is not vacuous: a rational function vanishing on
# the even integers >= 12 is zero
f = sp.Symbol('f')
p = sp.Poly(sp.prod([n - k for k in range(12, 40, 2)]), n)
print(f"\n      (the step is finite in practice: {p.degree()} even points already force")
print("       a rational function of bounded degree to vanish identically.)")

# ---- (2) B_p is not the minimum-norm solution ------------------------------
print("\n  (2) B_p: pivoted Cramer vs minimum Frobenius norm")
A = sp.Matrix([[1, 1, 0], [0, 1, n]])
b = sp.Matrix([1, n])
basic = sp.Matrix([A[:, [0, 1]].solve(b)[0], A[:, [0, 1]].solve(b)[1], 0])
minnorm = sp.simplify(A.T * (A * A.T).inv() * b)
print(f"      pivoted-Cramer basic solution : {list(sp.simplify(basic))}")
print(f"      minimum-Frobenius-norm solution: {list(minnorm)}")
assert sp.simplify(basic - minnorm) != sp.zeros(3, 1)
nb = sp.simplify(sum(e**2 for e in basic))
nm = sp.simplify(sum(e**2 for e in minnorm))
print(f"      |basic|^2 - |minnorm|^2 at n=12: "
      f"{sp.nsimplify(sp.simplify((nb-nm).subs(n,12)))} > 0, so they differ.")
assert (nb - nm).subs(n, 12) > 0
print("      Harmless for (a) and (b) -- the difference is a kernel element and is")
print("      absorbed into t -- but the theorem statement is wrong as written, and")
print("      it names the wrong denominator:")

gram = sp.factor(sp.simplify((A * A.T).det()))
minors = [sp.factor(A[:, c].det()) for c in [[0, 1], [0, 2], [1, 2]]]
print(f"\n      det(A A^T) = {gram}")
print(f"      maximal minors of A: {minors}")
print(f"      sum of their squares = {sp.factor(sum(m**2 for m in minors))}")
assert sp.simplify(gram - sum(m**2 for m in minors)) == 0
print("      Cauchy-Binet: det(A A^T) = sum of squares of the maximal minors, so")
print("      it is >= 0 for every real n with no Sturm run at all -- only")
print("      NONVANISHING is left, and that is the rank condition already needed.")
print("      Taking B_p = A^T (A A^T)^{-1} b, and the kernel basis from the")
print("      projector I - A^T(A A^T)^{-1}A, keeps every entry in Q(n) with the")
print("      SAME denominator and RETIRES A2's one new Sturm item.")
print("      (It also makes B_p canonical, hence equivariant under the symmetries")
print("       of the constraint system, which a pivot-basic solution is not.)")

# numerical sanity: the projector kernel basis really is a kernel basis
An = np.array([[1., 1., 0.], [0., 1., 12.]])
Pk = np.eye(3) - An.T @ np.linalg.inv(An @ An.T) @ An
print(f"\n      numeric check at n=12: |A * (I - A^T(AA^T)^-1 A)| = "
      f"{np.max(np.abs(An @ Pk)):.2e}")
assert np.max(np.abs(An @ Pk)) < 1e-12
