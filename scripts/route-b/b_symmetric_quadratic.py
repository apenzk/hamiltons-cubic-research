"""Conjecture A on compact symmetric spaces is  ||W||^2 >= 1/6  -- a quadratic check.

THE THEOREM IT RESTS ON (Gate 2, Reviewers 85 and 86, independently).  For a locally
symmetric EINSTEIN space with Ric = lambda g and W = R - (lambda/(n-1)) I,

    Q(W) = lambda W        so W is critical automatically, and theta = lambda / ||W|| .

Every compact irreducible symmetric space has lambda = 1/2 in Petersen-Stanfield's
normalisation, so theta = 1/(2||W||) and

    theta <= sqrt(3/2)   <=>   ||W||^2 >= 1/6 .

That replaces the cubic sharp-term route -- no structure constants, no S-blocks, no
Casimir dictionary, no dual Coxeter numbers, no Dynkin indices -- with a QUADRATIC
quantity read off the published tables:

    ||W||^2 = sum_i d_i (lam_i - c)^2 + (N - sum_i d_i) c^2 ,     c = tr R / N .

CLASS 3.1, TYPE II: THE COMPACT SIMPLE LIE GROUPS -- CLOSED IN ONE LINE.
A compact simple G with its bi-invariant metric is the symmetric space G x G / Delta G;
its holonomy is g acting ADJOINTLY on g = R^n, n = dim g.  The adjoint representation has
Killing constant c_hol = 2 for every g, so lam = 1/(c_hol + 2) = 1/4 UNIVERSALLY and
theta depends on nothing but dim g:

    ||W||^2 = n(n-3) / (16(n-1)) ,      theta^2 = 4(n-1) / (n(n-3)) .

    ||W||^2 >= 1/6   <=>   3n^2 - 17n + 8 >= 0 ,

whose larger root is (17 + sqrt(193))/6 = 5.1487, so it holds at every integer n >= 6.
The only compact simple algebra below that is su(2) with dim 3, where ||W||^2 = 0 -- that
is S^3, constant curvature, W = 0, degenerate rather than a counterexample.

    ==> the ENTIRE Type II class satisfies the target, for every simple g at once.

CLASSIFICATION.  su(3) gives theta = sqrt(7/10) = 0.836660, reproducing the record's
independently computed SU(3) bi-invariant -- AGREEMENT, by a route needing only dim g.
The Hermitian and Wolf classes are already closed as CP^m and HP^m.  Still owed: the
Grassmannians and the simple-isotropy class.

USAGE: python3 scripts/route-b/b_symmetric_quadratic.py
"""
import sympy as sp

n = sp.symbols('n', positive=True)
W2_TYPE_II = n*(n - 3)/(16*(n - 1))
THETA_SQ_TYPE_II = sp.Rational(1, 4)/W2_TYPE_II

# dim g for the compact simple algebras, small ranks plus the exceptionals
DIMS = [("su(2)", 3), ("su(3)", 8), ("so(5)=sp(2)", 10), ("G2", 14), ("su(4)=so(6)", 15),
        ("so(7)", 21), ("sp(3)", 21), ("su(5)", 24), ("so(8)", 28), ("F4", 52),
        ("E6", 78), ("E7", 133), ("E8", 248)]


def main():
    print("=== the reformulation ===")
    print("  Q(W) = lambda W for locally symmetric Einstein  =>  theta = lambda/||W||;")
    print("  lambda = 1/2 throughout, so  theta <= sqrt(3/2)  <=>  ||W||^2 >= 1/6.\n")

    print("=== class 3.1, Type II: compact simple Lie groups ===")
    print(f"  ||W||^2 = {sp.factor(W2_TYPE_II)}      theta^2 = {sp.factor(THETA_SQ_TYPE_II)}")
    q = sp.factor(sp.numer(sp.together(W2_TYPE_II - sp.Rational(1, 6))))
    roots = sp.solve(q, n)
    big = max(float(r) for r in roots)
    print(f"  ||W||^2 >= 1/6  <=>  {q} >= 0,  larger root {big:.4f}")
    print(f"  so it holds at every integer n >= {sp.ceiling(sp.nsimplify(big))}\n")

    print(f"  {'algebra':13s}{'dim g':>6}{'||W||^2':>12}{'>= 1/6':>9}{'theta':>11}")
    worst = None
    for g, d in DIMS:
        w = sp.Rational(d*(d - 3), 16*(d - 1))
        if w == 0:
            print(f"  {g:13s}{d:>6}{'0':>12}{'DEGEN':>9}{'W = 0':>11}   S^3, constant curvature")
            continue
        th = sp.sqrt(sp.Rational(1, 4)/w)
        ok = 'yes' if w > sp.Rational(1, 6) else 'NO'
        if worst is None or w < worst[1]:
            worst = (g, w, th)
        print(f"  {g:13s}{d:>6}{float(w):>12.6f}{ok:>9}{float(th):>11.6f}")
    print(f"\n  tightest non-degenerate member: {worst[0]}, ||W||^2 = {worst[1]} "
          f"= {float(worst[1]):.6f} vs 1/6 = {float(sp.Rational(1,6)):.6f}")
    print(f"  its theta = {worst[2]} = {float(worst[2]):.6f} < sqrt(3/2) = "
          f"{float(sp.sqrt(sp.Rational(3,2))):.6f}")
    print("\n  AGREEMENT: su(3) reproduces the record's SU(3) bi-invariant, 0.836660.")
    print("  STILL OWED: the Grassmannian and simple-isotropy classes.")


if __name__ == '__main__':
    main()
