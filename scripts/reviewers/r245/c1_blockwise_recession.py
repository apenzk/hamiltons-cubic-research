"""r245, claim 1: the recession argument in the shape the file's screen skips.

The theorem's objects are VECTOR-VALUED: the Gram D is 184x184 block-diagonal
(blocks of size m_lambda, the multiplicities), while a covariant evaluation
q_{lambda,a}(W) is a vector in the irreducible V_lambda of dimension d_lambda.
The represented sextic is

    P_D(W) = sum_lambda tr( D_lambda G_lambda(W) ),
    G_lambda(W)_{ab} = <q_{lambda,a}(W), q_{lambda,b}(W)>,

and the statement "D p(W) = 0" typechecks only as (D_lambda x I_{d_lambda})
acting on the concatenated evaluation vector -- equivalently D_lambda times the
m x d matrix of evaluations, per block.  This miniature runs every link of the
proof exactly, in that shape, over Q:

  Block A: d = 2, m = 2, covariants qA1(W) = (a, b), qA2(W) = (b, a).
  Block B: d = 1, m = 1, covariant  qB(W)  = ab.        W = (a, b).

WHAT IT SETTLES, LINK BY LINK.

  (ii-1) NO SCALAR p(W) EXISTS.  P_D(W) = p(W)^T D p(W) with p(W) a scalar
     3-vector would force det G_A(W) == 0; here det G_A = (a^2-b^2)^2, not
     identically zero.  The file's formula is notation for the tensor reading,
     not a statement about a scalar vector.
  (ii-2) THE LINEAR KERNEL IS NONZERO EVEN WITH INDEPENDENT COVARIANTS.
     {D : P_D == 0} is 1-dimensional here (D_A = diag(x, -x)), so psd-ness is
     what carries the theorem, not the linear conditions.  The file's screen has
     it the other way around: its honest branch imposes the ANNIHILATION
     conditions D p = 0 directly -- the post-psd conclusion -- and gets a ZERO
     linear kernel, so its honest direction never exercises the psd step at all.
     The real object has linear kernel of dimension k >= 1 by construction (the
     t-space!); boundedness is exactly "the psd part of a nonzero kernel is 0".
  (ii-3) PSD-NESS APPLIES GLOBALLY AND ACTS BLOCKWISE.  D psd <=> each D_lambda
     psd; each tr(D_lambda G_lambda(W)) >= 0 pointwise; nonnegative terms
     summing to zero vanish separately; and tr(L L^T G_lambda) = |L^T E|_F^2
     turns each vanishing trace into D_lambda E_lambda(W) = 0, E_lambda the
     m x d evaluation matrix.  Checked symbolically.
  (iii) WHAT "SPANNING" MUST MEAN.  D_lambda E_lambda(W) = 0 for all W kills
     D_lambda iff the d-dimensional coordinate SLICES of the evaluations span
     R^{m_lambda} -- which holds iff the m_lambda covariants are linearly
     independent AS FUNCTIONS.  The right space is the per-block multiplicity
     space, not R^184 swept by single vectors.
  (i)  THE AUGMENTED ROWS SHRINK AND CANNOT RESCUE.  Homogenising B v = 0 gives
     (D x I) v = 0.  Independent case: it cuts the kernel 1 -> 0 (shrinks).
     Plant qA2 = 2 qA1: the rank-one psd annihilator D = (2e1-e2)(2e1-e2)^T + 0
     satisfies (D x I) v = 0 AUTOMATICALLY -- a functional relation vanishes at
     W_* in particular -- so the kernel conditions never exclude the recession
     direction that a relation manufactures.  Below the stable range the theorem
     fails WITH the augmentation, exactly as the file says.
"""
import itertools
import sympy as sp

a, b = sp.symbols('a b', real=True)
x0, x1, x2, x3 = sp.symbols('x0 x1 x2 x3')


def blocks(dependent):
    qA1 = sp.Matrix([a, b])
    qA2 = 2 * qA1 if dependent else sp.Matrix([b, a])
    qB = sp.Matrix([a * b])
    return qA1, qA2, qB


def represented(qA1, qA2, qB, DA, dB):
    GA = sp.Matrix([[(qA1.T * qA1)[0], (qA1.T * qA2)[0]],
                    [(qA2.T * qA1)[0], (qA2.T * qA2)[0]]])
    return sp.expand((DA[0, 0] * GA[0, 0] + 2 * DA[0, 1] * GA[0, 1]
                      + DA[1, 1] * GA[1, 1]) + dB * (qB.T * qB)[0]), GA


# ---------------------------------------------------------------- (ii-1)
qA1, qA2, qB = blocks(dependent=False)
DA = sp.Matrix([[x0, x1], [x1, x2]])
P, GA = represented(qA1, qA2, qB, DA, x3)
detGA = sp.factor(GA.det())
print(f"  (ii-1) det G_A(W) = {detGA}")
assert sp.simplify(detGA - (a**2 - b**2)**2) == 0 and detGA != 0, (
    "det G_A vanished identically: the miniature degenerated and no longer "
    "witnesses that a scalar p(W) cannot exist")
print("         != 0, so no scalar 3-vector p(W) has P_D = p^T D p: the "
      "formula is the tensor reading or nothing")

# ---------------------------------------------------------------- (ii-2)
# P_D == 0 as a polynomial identity in (a, b): linear conditions on (x0..x3).
conds = [sp.Eq(c, 0) for c in sp.Poly(P, a, b).coeffs()]
M = sp.Matrix([[sp.diff(c.lhs, v) for v in (x0, x1, x2, x3)] for c in conds])
ker = M.nullspace()
print(f"  (ii-2) linear kernel {{D : P_D == 0}} has dimension {len(ker)}, "
      f"basis {[list(k) for k in ker]}")
assert len(ker) == 1 and ker[0][1] == 0 and ker[0][3] == 0 \
    and sp.simplify(ker[0][0] + ker[0][2]) == 0 and ker[0][0] != 0, (
    "the trace-form kernel is not the expected span of diag(1,-1): the "
    "miniature no longer models a nonzero t-space cut to 0 by psd-ness alone")
# psd element of span{diag(x, -x) + 0}: needs x >= 0 AND -x >= 0, so x = 0.
print("         nonzero, and its only psd element is 0 (diagonal entries x "
      "and -x): psd-ness, not linearity, is what bounds S_n")

# ---------------------------------------------------------------- (ii-3)
L = sp.Matrix([[sp.Symbol('l00'), 0], [sp.Symbol('l10'), sp.Symbol('l11')]])
E = sp.Matrix([[qA1[0], qA1[1]], [qA2[0], qA2[1]]])   # m x d evaluation matrix
lhs = sp.expand(sp.trace(L * L.T * E * E.T))
rhs = sp.expand(sum(e**2 for e in (L.T * E)))
assert sp.simplify(lhs - rhs) == 0, (
    "tr(L L^T E E^T) != |L^T E|_F^2: the psd-to-annihilation conversion "
    "identity failed symbolically")
print("  (ii-3) tr(L L^T G_A) = |L^T E|_F^2 identically: trace zero forces "
      "L^T E = 0, hence D_A E = 0 -- annihilation is BLOCKWISE, on the m x d "
      "evaluation matrix, and psd-ness enters globally as blockwise psd")

# ---------------------------------------------------------------- (iii)
# D_A E(W) = 0 for all W <=> rows of D_A are relations among the covariants.
c1, c2 = sp.symbols('c1 c2')
rel = sp.expand(c1 * qA1 + c2 * qA2)
sols = sp.solve([co for i in range(2)
                 for co in sp.Poly(rel[i], a, b).coeffs()], [c1, c2],
                dict=True)
assert sols == [{c1: 0, c2: 0}], (
    f"independent covariants admitted a relation {sols}: the (iii) "
    "equivalence has the wrong witness")
print("  (iii)  no relation among qA1, qA2 => the coordinate slices span "
      "R^m => D_A = 0.  The space that must be spanned is the per-block "
      "multiplicity space R^{m_lambda}, by slices, not R^184 by single p(W)")

# ---------------------------------------------------------------- (i)
Wstar = {a: 1, b: 2}
vA = E.subs(Wstar)                # m x d evaluation matrix at W_*
# augmented rows, homogenised: (D_A x I_d) v = 0  <=>  D_A * vA = 0 (m x d)
aug = sp.expand(DA * vA)
aug_conds = [sp.Eq(e, 0) for e in aug]
Maug = M.col_join(sp.Matrix([[sp.diff(c.lhs, v) for v in (x0, x1, x2, x3)]
                             for c in aug_conds]))
ker_aug = Maug.nullspace()
print(f"  (i)    independent case: augmenting with (D x I)v = 0 cuts the "
      f"kernel {len(ker)} -> {len(ker_aug)} (shrinks, never enlarges)")
assert len(ker_aug) == 0, (
    "the augmented kernel did not shrink to 0 here; the (i) demonstration "
    "that kernel rows only restrict is broken")

# plant: the relation qA2 = 2 qA1 manufactures a psd recession direction that
# the augmented rows CANNOT exclude.
qA1p, qA2p, qBp = blocks(dependent=True)
Dplant = sp.Matrix([[4, -2], [-2, 1]])
Pp, GAp = represented(qA1p, qA2p, qBp, Dplant, 0)
assert sp.expand(Pp) == 0, f"plant: P_D = {Pp}, expected identically 0"
eigs = Dplant.eigenvals()
assert all(sp.simplify(e) >= 0 for e in eigs) and Dplant != sp.zeros(2, 2), (
    "plant annihilator is not psd-nonzero")
vAp = sp.Matrix([[qA1p[0], qA1p[1]], [qA2p[0], qA2p[1]]]).subs(Wstar)
assert sp.expand(Dplant * vAp) == sp.zeros(2, 2), (
    "plant: (D x I)v != 0 -- but a functional relation vanishes at W_* in "
    "particular, so the augmented rows were supposed to be automatic")
print("  (i)    plant qA2 = 2 qA1: D = (2e1-e2)(2e1-e2)^T is psd, nonzero, "
      "represents the zero form, AND satisfies (D x I)v = 0 automatically -- "
      "the augmentation cannot rescue boundedness below the stable range")

print("\n  every link of the recession argument holds in the vector-valued "
      "shape; what carries n >= 12 is independence of the covariants ACTUALLY "
      "USED, per block, at each n -- see REVIEW_r245.md for what the record "
      "does and does not establish about that hypothesis.")
