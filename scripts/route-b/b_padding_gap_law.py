"""The padding gap law, and the uniformity problem it exposes.

Reviewers 50 and 51 established that padding a critical seed from n_0 into any
larger n leaves

    min |lambda - 1/2|  off the orbit  =  1 / (2 (n_0 - 1)),

independent of the target dimension n.  Verified to seven digits by full
eigensolve, deflated eigensolve and matrix-free Lanczos at n_0 = 10 and 12,
giving 1/18 and 1/22.

The consequence this file records: padding the BALANCED product from n_0 gives a
critical point whose value is frozen at theta_0(n_0) while the ambient bound rises
to theta_0(n).  As n_0 grows both tend to sqrt(2), so

    theta / theta_0(n)  ->  1      while      gap = 1/(2(n_0-1))  ->  0.

So padded points approach the top value and become arbitrarily close to degenerate
at the same time.  Each one is nondegenerate -- the gap never reaches zero.

HOW MUCH THIS COSTS, STATED CAREFULLY.  It is NOT an obstruction to route B at a
fixed n.  Conjecture A is a statement per dimension; at fixed n the padded points
come from the finitely many seeds n_0 <= n, all with gap >= 1/(2(n-1)), and
compactness of Crit(P) supplies a constant c_n > 0 that is allowed to depend on n.
What the table rules out is narrower: no argument can rest on a spectral gap or a
theta-margin that is UNIFORM IN n, because both shrink to zero.  That matches the
obstruction already recorded for two-block nondegeneracy -- gap O(1/n), no constant
uniform in n -- and it is a constraint on the shape of the argument rather than on
its conclusion.
"""
import numpy as np

def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n

def gap(n0):
    """Off-orbit spectral gap of any padding of a seed from n_0."""
    return 1.0 / (2.0 * (n0 - 1))

if __name__ == "__main__":
    print(f"{'n_0':>5} {'n':>4} {'theta = theta_0(n_0)':>21} {'theta/theta_0(n)':>17} {'gap':>10}")
    for n0 in (6, 8, 10, 12, 16, 20, 40, 100, 1000):
        n = n0 + 2
        print(f"{n0:5d} {n:4d} {theta0(n0):21.9f} {theta0(n0)/theta0(n):17.6f} {gap(n0):10.6f}")
    print("\n  as n_0 -> infinity: theta/theta_0(n) -> 1 and gap -> 0")
    print("  so no spectral gap uniform in n is available from this family")
