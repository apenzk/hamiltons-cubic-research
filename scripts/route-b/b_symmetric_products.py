"""Conjecture A on EVERY compact symmetric space -- reducible case, completing the class.

Normalisation: Einstein constant 1/2.  A product is Einstein iff every factor is Einstein
with the SAME constant, so no flat factors occur and each factor carries constant 1/2.

For M = M_1 x ... x M_k the curvature operator is block-diagonal on Lambda^2 and ZERO on
the mixed terms p_a (x) p_b, so ||R||^2 = sum_a ||R_a||^2.  With ||R_a||^2 = ||W_a||^2 +
n_a/(8(n_a - 1)) from the universal-c identity applied factorwise,

    ||W||^2 = sum_a ||W_a||^2 + B(n_1,...,n_k),   B = sum_a f(n_a) - n/(8(n-1)),  f(m) = m/(8(m-1)).

f is decreasing and convex on m > 1, so Jensen minimises sum f at the balanced split for
fixed k, and k f(n/k) = kn/(8(n-k)) increases in k, so k = 2 balanced is the global minimum.
Every ||W_a||^2 >= 0 vanishes exactly when the factor has constant curvature, i.e. is a sphere.
Hence the minimum over all reducible compact symmetric spaces is attained exactly at
S^(n/2) x S^(n/2), where it equals n^2/(8(n-1)(n-2)) = 1/(4 theta_0(n)^2).

Run: python3 scripts/route-b/b_symmetric_products.py
"""
import sys, os
sys.path.insert(0, os.path.join(os.getcwd(), 'scripts'))
import sympy as sp
from fractions import Fraction as F

n, k, m = sp.symbols('n k m', positive=True)
f = m / (8 * (m - 1))

def main():
    print("STEP 1  f(m) = m/(8(m-1)) is decreasing and convex on m > 1")
    print(f"    f'  = {sp.simplify(sp.diff(f, m))}      f'' = {sp.simplify(sp.diff(f, m, 2))}")

    print("\nSTEP 2  Jensen for fixed k, then monotonicity in k")
    kf = sp.simplify(k * f.subs(m, n / k))
    print(f"    k f(n/k) = {sp.factor(kf)}        d/dk = {sp.factor(sp.simplify(sp.diff(kf, k)))} > 0  ->  k = 2")

    B = sp.simplify(kf.subs(k, 2) - n / (8 * (n - 1)))
    th2 = sp.simplify(sp.Rational(1, 4) / B)
    th0 = 2 * (n - 1) * (n - 2) / n**2
    print(f"\nSTEP 3  minimum of ||W||^2 over reducible = {sp.factor(B)}")
    print(f"    => max theta^2 = {sp.factor(th2)},  theta_0(n)^2 = {sp.factor(th0)}"
          f"   identical: {sp.simplify(th2 - th0) == 0}")

    print("\nSTEP 4  the irreducible bound 1/6 clears that threshold exactly for n >= 12")
    poly = sp.expand(sp.numer(sp.together(sp.Rational(1, 6) - n**2 / (8 * (n - 1) * (n - 2)))))
    roots = sorted(sp.solve(sp.Eq(poly, 0), n))
    print(f"    1/6 >= n^2/(8(n-1)(n-2))  <=>  {poly} >= 0,  larger root {sp.nsimplify(roots[-1])}"
          f" = {float(roots[-1]):.6f}  ->  n >= 12")

    print("\nSTEP 5  integer splits: theta_0(n) is attained only for even n")
    for N in range(12, 20):
        best = min((F(a, 8 * (a - 1)) + F(N - a, 8 * (N - a - 1)) - F(N, 8 * (N - 1)), a)
                   for a in range(2, N - 1))
        t2 = F(1, 4) / best[0]
        t0 = F(2 * (N - 1) * (N - 2), N * N)
        print(f"    n={N:3d}  best split S^{best[1]} x S^{N-best[1]:<2d}  theta^2 = {str(t2):>10}"
              f"   theta_0^2 = {str(t0):>10}   {'EQUAL' if t2 == t0 else 'strictly below'}")

    print("\nSTEP 6  the recorded claim that Conjecture A on symmetric spaces is ||W||^2 >= 1/6")
    for P, Q in [(5, 7), (6, 6)]:
        N = P + Q
        a, b = F(1, 2 * (P - 1)), F(1, 2 * (Q - 1))
        NN, dp, dq = F(N * (N - 1), 2), F(P * (P - 1), 2), F(Q * (Q - 1), 2)
        c = (dp * a + dq * b) / NN
        W2 = dp * (a - c)**2 + dq * (b - c)**2 + (NN - dp - dq) * c**2
        print(f"    S^{P} x S^{Q}: ||W||^2 = {W2} < 1/6 = {F(1,6)}, short by {F(1,6) - W2};"
              f"  theta^2 = {F(1,4)/W2}  -- satisfies Conjecture A, violates 1/6")
    print("    So 1/6 is the CP^2 threshold, NOT Conjecture A's.  The correct quadratic form of")
    print("    Conjecture A on compact symmetric spaces is  ||W||^2 >= n^2/(8(n-1)(n-2)).")

    print("\nTHEOREM.  For every n >= 12, every compact symmetric space of dimension n satisfies")
    print("theta <= theta_0(n), with equality exactly at S^(n/2) x S^(n/2) for n even.")
    print("That is Conjecture A, proved on the whole symmetric class.")

if __name__ == '__main__':
    main()
