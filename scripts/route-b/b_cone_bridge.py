"""Conjecture A's constant theta_0(n), DERIVED from the Bohm-Wilking cone conjecture.

The cone conjecture (Beitz thesis Remark 6.3.15) asks that Omega_a be invariant under
the Hamilton ODE dR/dt = Phi(R), Phi(R) = R^2 + R^#, for n >= 12 and a in [0, n/4].
Invariance runs through dF_R(Phi(R)) <= 0 with F = ||R||^2 / ||ric(R)||^2, i.e.

    G(R) <= 0   <=>   <R, Phi(R)>  <=  F(R) <ric R, ric Phi(R)>.

This script shows that on the a = 0 boundary, restricted to the slice R_ric0 = 0, that
criterion is EXACTLY  theta <= theta_0(n) = sqrt(2(n-1)(n-2))/n.

Ingredients, all from the literature rather than derived here:
  BW08 Lemma 2.1   R + R#I = (n-1) R_I + (n-2)/2 R_Ric0,  and <W> is in the KERNEL,
                   so W#I = -W and hence Phi(I, W) = (IW + WI)/2 + W#I = W - W = 0.
  BW08 eq. (6)     Ric(Phi(R))_ij = sum_k Ric_kk R_kijk,  so Ric(W) = 0 => Ric(Phi(W)) = 0:
                   Phi maps Weyl tensors to Weyl tensors.
  Beitz p. 96      R in Omega_a  <=>  (4a-n)/4 ||R_I||^2 + a ||R_ric0||^2
                                      + ((n-2)/4 + a) ||R_W||^2 <= 0.

Convention: the identity operator on Lambda^2 has ||I||^2 = dim Lambda^2 = n(n-1)/2.
This is DEFINITIONAL, with no freedom to choose, and Beitz uses the same value (her
Remark 1.1.7, <R,S> = tr(R.S); independently forced by F(I) = 2/(n-1) at the Omega_{n/4}
endpoint).  An earlier docstring here claimed Beitz used n(n-1), a factor 2 out; that
came from a pdftotext artefact which drops fraction denominators onto the next line.
Reviewers 89 and 90 both refuted it.  The REAL convention gap is that Beitz's ric
carries a factor 1/2 against BW08 (her Definition 1.1.10); it cancels here because
F <ric, ric Phi> is invariant under rescaling ric, but it matters for any figure
quoting ||ric|| or scal across the two sources.

Also used, and named here because the write-up first omitted them: Phi preserves the
first Bianchi identity (else Phi(W) could carry a Lambda^4 part), and invariance implies
G <= 0 (Beitz Lemma 2.3.4 gives only the converse; it holds via d/dt scal = 2||ric||^2).

Run: python3 scripts/route-b/b_cone_bridge.py
"""
import sys, os
sys.path.insert(0, os.path.join(os.getcwd(), 'scripts'))
import sympy as sp

n, c, W2, normI2, ricI2, PW = sp.symbols('n c W2 normI2 ricI2 PW', positive=True)

def main():
    print("STEP 1  Phi on the slice R = c I + W  (R_ric0 = 0)")
    print("    Phi(I, W) = 0            by BW08 Lemma 2.1, W in ker(R -> R + R#I)")
    print("    Phi(cI + W) = c^2 (n-1) I + Phi(W)")
    print("    Phi(W) is again WEYL     by BW08 eq. (6), since Ric(W) = 0")

    print("\nSTEP 2  the cubic form: every cross term vanishes")
    print("    <W, Phi(I)>   = (n-1) <W, I> = 0        (Weyl perp I)")
    print("    <I, Phi(W)>   = 0                        (Phi(W) is Weyl, so perp I)")
    lhs = c**3 * (n - 1) * normI2 + PW          # <R, Phi(R)>,  PW = <W, Q(W)>
    print(f"    <R, Phi(R)> = {lhs}")

    print("\nSTEP 3  the right-hand side")
    ric_pair = c**3 * (n - 1) * ricI2           # <ric R, ric Phi(R)>
    F = (c**2 * normI2 + W2) / (c**2 * ricI2)   # ||R||^2 / ||ric R||^2
    rhs = sp.simplify(F * ric_pair)
    print(f"    <ric R, ric Phi(R)> = {ric_pair}")
    print(f"    F(R) <ric R, ric Phi R> = {sp.expand(rhs)}      -- ||ric(I)||^2 CANCELS")

    print("\nSTEP 4  the criterion collapses to a bound on the project's cubic form")
    crit = sp.simplify(sp.expand(rhs - lhs))
    print(f"    G <= 0  <=>  0 <= {crit}  <=>  <W, Q(W)> <= c (n-1) ||W||^2")

    print("\nSTEP 5  the a = 0 constraint fixes c, once ||W|| = 1")
    # partial Omega_0 :  (n-2)/n ||R_W||^2 = ||R_I||^2 = c^2 ||I||^2,  ||I||^2 = n(n-1)/2
    # c is a positive scale factor: take the positive root explicitly rather than
    # filtering on .is_positive, which returns None for a symbolic radical and lets
    # the negative root through.
    c2 = sp.solve(sp.Eq((n - 2) / n * 1, sp.Symbol('c2', positive=True) * sp.Rational(1, 2) * n * (n - 1)),
                  sp.Symbol('c2', positive=True))[0]
    cval = sp.sqrt(sp.simplify(c2))
    print(f"    ||I||^2 = n(n-1)/2   =>   c = {sp.simplify(cval)}")

    bound = sp.simplify(cval * (n - 1))
    theta0 = sp.sqrt(2 * (n - 1) * (n - 2)) / n
    print(f"\nSTEP 6  the bound the criterion demands:  c(n-1) = {sp.simplify(bound)}")
    print(f"        theta_0(n) = sqrt(2(n-1)(n-2))/n = {theta0}")
    # Compare SQUARES: both quantities are positive, and sympy will not collapse
    # sqrt((n-2)/(n-1)) against sqrt(n-2)/sqrt(n-1) for symbolic n -- a branch-choice
    # artefact of the tool, not a statement about the mathematics.
    same = sp.simplify(sp.expand(bound**2 - theta0**2)) == 0
    print(f"        bound^2    = {sp.factor(sp.simplify(bound**2))}")
    print(f"        theta_0^2  = {sp.factor(sp.simplify(theta0**2))}")
    print(f"        IDENTICAL (compared as squares): {same}")

    print("\n    values:")
    for N in (12, 13, 14, 16, 20):
        print(f"      n={N:3d}   c(n-1) = {float(bound.subs(n, N)):.9f}   "
              f"theta_0 = {float(theta0.subs(n, N)):.9f}")

    print("\n" + ("THEOREM.  On the slice R_ric0 = 0, the a = 0 case of the Bohm-Wilking cone\n"
                  "conjecture is EXACTLY Conjecture A:  theta <= theta_0(n).  The target constant\n"
                  "is therefore derived rather than posited." if same else "MISMATCH"))
    print("\nSCOPE.  a = 0 leaves R_ric0 unconstrained, so the full cone conjecture is strictly\n"
          "more than Conjecture A; Conjecture A is its R_ric0 = 0 slice.  What is settled here is\n"
          "that the constant is right, not that the two statements coincide.")

if __name__ == '__main__':
    main()
