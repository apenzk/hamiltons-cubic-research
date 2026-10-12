"""theta on the quaternionic family HP^m, in closed form, for every m at once.

    theta^2(HP^m) = (m+2)^2 (4m-1) / ( 9 m (m-1) (2m+1) )

strictly decreasing in m, maximal at m = 2 with theta = sqrt(56/45) = 1.1155467, and
tending to sqrt(2)/3.  So the ENTIRE quaternionic family sits below sqrt(3/2) = 1.2247449,
by proof rather than by the two tabulated points the record previously carried.

LITERATURE FIRST, and it supplied the input.  Petersen-Stanfield section 3.5 gives the
CURVATURE OPERATOR eigenvalues of every Wolf space of dimension 4n in closed form:

    lam_sp(1) = (1/2) n/(n+2),      lam_h2 = (1/2) (n/(n+2)) (2n+1)/dim h2 .

For HP^m these are m/(2(m+2)) on sp(1) (dim 3) and 1/(2(m+2)) on sp(m) (dim m(2m+1)),
with 0 on the complement.  What is derived here is the WEYL part's theta, which is this
project's functional and is not in that paper.

THE DERIVATION.  W = R - c*Id with c = scal/(n(n-1)), n = 4m, scal = 2 tr R -- the
project's own Weyl projection.  Then theta = tr(W^3) + <W, W#>, and the sharp term is the
block-mass sum over the three blocks sp(1), sp(m) and the complement m-part:

    <W,W#> = (1/2)[ w1^3 S111 + w2^3 S222 + 3 w1 w3^2 S133 + 3 w2 w3^2 S233 + w3^3 S333 ].

Block masses, all from Killing data with rho = 2(n-2) the universal row marginal:

    S111 = 12/m           sp(1) in so(4m) has c = 4/m
    S222 = 2(m+1) d2      sp(m) in so(4m) has c = 2(m+1)

Both constants are stated here WITHOUT a Dynkin index, deliberately.  This file previously
justified them as c = 2 h^v / I while plan.md states the rule as c = 4 h^v / I_rho, with
the index conventions unstated and different in the two places -- right numbers, unusable
rule, and it is precisely the factor-2 trap plan.md warns about.  Both Gate 2 reviewers
re-derived them from the definition instead, which needs no convention at all:

    c_k  =  ( -Killing_k )  /  <.,.>_ambient

  sp(1):  |J_p|^2 = (1/2) tr(Id_{4m}) = 2m  and  [L_i,L_j] = 2 L_k   ->  c = 4/m
  sp(m):  -K(A,A) = 4(m+1) Re tr(A^2),  <A,A> = 2 Re tr(A^2)         ->  c = 2(m+1)

Consistency witness: at m = 1 both formulas describe sp(1) on R^4 and both return 4.
    S133 = rho d1 - S111,   S233 = rho d2 - S222        since [sp(1), sp(m)] = 0
    S333 = rho d3 - 2(S133 + S233)

*** THE LAST ONE IS WHY THIS TOOK TWO ATTEMPTS. ***  The first derivation set S333 = 0,
reasoning that [m,m] is inside h for a symmetric pair.  But (so(4m), sp(1)+sp(m)) IS NOT A
SYMMETRIC PAIR -- HP^m's symmetric pair is (sp(m+1), sp(m)+sp(1)), and here h merely sits
inside so(4m) with m-part its orthogonal complement there, not the tangent space.  The
premise was never stated and never checked.  It is invisible at m = 2, where S333 happens
to vanish, so the wrong formula reproduced HP^2 exactly and failed at HP^3.

S333 is DERIVED rather than fitted: for a in the m-part, splitting the marginal identity
sum_b ||[a,b]||^2 = rho ||a||^2 by block and using total symmetry of T gives
rho d3 = S133 + S233 + (S133 + S233 + S333).  It reproduces the measured 0, 224, 810 and
9504/5 at m = 2, 3, 4, 5 exactly.

CLASSIFICATION against the record.  HP^2 = sqrt(56/45) and HP^3 = 275/378 AGREE with the
values already in findings/graded-half.md; HP^4 = 5/9 agrees with the project's own
machinery out of sample.  The closed form in m and the monotonicity are new.

USAGE: python3 scripts/route-b/b_hp_closed_form.py
"""
import sympy as sp

m = sp.symbols('m', positive=True)
THETA_SQ = (m + 2)**2 * (4*m - 1) / (9*m*(m - 1)*(2*m + 1))


def blocks(mm):
    """(n, dims, curvature-operator eigenvalues) for HP^mm, from Petersen-Stanfield 3.5."""
    n = 4*mm
    d1, d2 = sp.Integer(3), mm*(2*mm + 1)
    d3 = sp.simplify(n*(n - 1)/2 - d1 - d2)
    r1 = sp.Rational(1, 2)*mm/(mm + 2)
    r2 = sp.Rational(1, 2)/(mm + 2)
    return n, (d1, d2, d3), (r1, r2, sp.Integer(0))


def theta_sq_from_scratch(mm):
    """Rebuild theta^2 from the block data, independently of the closed form."""
    n, (d1, d2, d3), (r1, r2, r3) = blocks(mm)
    rho = 2*(n - 2)
    S111 = sp.Rational(12, 1)/mm
    S222 = 2*(mm + 1)*d2
    S133, S233 = rho*d1 - S111, rho*d2 - S222
    S333 = rho*d3 - 2*(S133 + S233)
    scal = 2*(d1*r1 + d2*r2)
    c = sp.simplify(scal/(n*(n - 1)))
    w1, w2, w3 = r1 - c, r2 - c, r3 - c
    assert sp.simplify(d1*w1 + d2*w2 + d3*w3) == 0, "Weyl part must be trace-free"
    num = (d1*w1**3 + d2*w2**3 + d3*w3**3) + sp.Rational(1, 2)*(
        w1**3*S111 + w2**3*S222 + 3*w1*w3**2*S133 + 3*w2*w3**2*S233 + w3**3*S333)
    return sp.simplify(num**2 / (d1*w1**2 + d2*w2**2 + d3*w3**2)**3)


def main():
    print("=== the closed form, and the block rebuild, agree at every m ===")
    print(f"  {'m':>3}{'theta^2 (closed form)':>24}{'from blocks':>22}{'theta':>14}")
    for mm in range(2, 9):
        # sp.Rational(sp.simplify(...)), never nsimplify: nsimplify returns a radical
        # for 736/1755 at m = 6, which fires the assertion below on a tooling artefact
        # rather than on a real disagreement.
        a = sp.Rational(sp.simplify(THETA_SQ.subs(m, mm)))
        b = theta_sq_from_scratch(sp.Integer(mm))
        assert sp.simplify(a - b) == 0, f"disagreement at m={mm}"
        print(f"  {mm:>3}{str(a):>24}{str(b):>22}{float(sp.sqrt(a)):>14.9f}")

    print("\n=== monotonicity, analytically ===")
    d = sp.factor(sp.together(sp.diff(THETA_SQ, m)))
    num, den = sp.fraction(d)
    print(f"  d/dm theta^2 = {d}")
    # Count roots on the half-line rather than filtering sp.solve by .is_real -- two of
    # the three roots report is_real = None and get silently dropped, which is how the
    # false claim "the cubic has no real root" got into the record.  It has exactly one
    # (negative; discriminant -157464 < 0).  What matters is that none is positive.
    cub = sp.Poly(34*m**3 - 12*m**2 + 3*m + 2, m)
    print(f"  denominator {sp.factor(den)} > 0 for m > 1")
    print(f"  cubic 34m^3-12m^2+3m+2: discriminant {sp.discriminant(cub.as_expr(), m)} < 0, "
          f"so exactly one real root; roots in (0,oo): {cub.count_roots(0, sp.oo)}")
    print("  elementary: for m >= 1/2, m^2(34m-12) >= 5m^2 > 0; for 0 < m < 1/2, "
          "2 + 3m - 12m^2 > 0.  So the cubic is positive on m > 0.")
    print("  so theta^2 is strictly decreasing on m > 1, and the maximum is at m = 2.")

    print("\n=== the cap ===")
    print(f"  sup_m theta(HP^m) = sqrt(56/45) = {float(sp.sqrt(sp.Rational(56,45))):.9f}")
    print(f"  target threshold    sqrt(3/2)   = {float(sp.sqrt(sp.Rational(3,2))):.9f}")
    print(f"  limit m -> oo:      sqrt(2)/3   = {float(sp.sqrt(sp.Rational(2,9))):.9f}")
    print("\n  So the whole quaternionic family lies below the target, for every m.")


if __name__ == '__main__':
    main()
