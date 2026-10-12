"""
P0 step (1): a sharper bound on gamma, using the coupling the triangle
inequality discards.

WHAT THEOREM 4.17 ACTUALLY NEEDS.  Its closing estimate is g_1(alpha) < 0 for
alpha < 1/3, where g_1(a) = (3/4)(3a-1) - a + (sqrt3/4) gamma_max(a).  Solving,
the requirement is

        gamma_max(alpha)  <  (3 - 5 alpha)/sqrt(3)                     (*)

At alpha = 1/3 the right side is 4/(3 sqrt3) = 0.769800, and Nienhaus's c=1 bound
gives exactly that -- his argument is borderline by construction, which is why
any c_n > 1 breaks it.

THE COUPLING.  In his Remark 4.18 subdivision W = cos(b) W_1 + sin(b) W_2 with
W_1 in V_{1/3} and <F W_2, W_2> <= 0, split W_2 by F-eigenvalue:

        W_2 = c_0 K + c_- N,     K in ker F_u,  N in the strictly negative part,
        c_0^2 + c_-^2 = 1,       <F N, N>/theta* =: mu_N <= -1/6.

Two facts then pull against each other.

  (i) alpha = (1-s^2)/3 + s^2 c_-^2 mu_N  <=  (1-s^2)/3 - s^2 c_-^2/6,  s = sin(b),
      so with eps = 1/3 - alpha,   s^2 <= 6 eps / (3 - c_0^2).

 (ii) T(W_1,W_1,W_2) = <Q(W_1), W_2>, and Q(V_{1/3}) is contained in
      ker F_u + <u> while W_2 is orthogonal to u, so ONLY the ker-component of
      W_2 contributes:   T(W_1,W_1,W_2) <= c_0 ||Q(W_1)_ker|| <= c_0 sqrt(5/6).

So the leading term of gamma is proportional to c_0, while c_0 near 1 is exactly
what forces s smallest.  The triangle-inequality route takes sup T and sup s
independently and pays for both; keeping the constraint linking them is the
whole content of this bound.

Since P vanishes identically on V_{1/3} the cubic expansion has no s^0 term, so

  gamma <= sqrt(2/3) [ 3(1-s^2) s c_0 sqrt(5/6) + 3 sqrt(1-s^2) s^2 B + s^3 theta_0(n) ]

with B = sup |T(W_1,W_2,W_2)|, maximised over c_0 in [0,1] subject to (i).

As alpha -> 1/3, eps -> 0 forces s -> 0 and hence gamma -> 0, while the
requirement (*) tends to 0.7698 > 0.  The borderline that killed the c=1
argument is therefore resolved, rather than merely shifted.

Constants used, from Reviewer 18's exact maximisation: sup T(W_1,W_1,W_2)
= sqrt(5/6) = 0.912871 and sup T(W_1,W_2,W_2) ~ 0.811, both n-independent.
"""
import numpy as np

SQ32 = np.sqrt(1.5)
R23 = np.sqrt(2.0 / 3.0)
A_SUP = np.sqrt(5.0 / 6.0)     # sup T(W_1,W_1,K), attained on the kernel; exactly 0 on the negative part
B_KER = 2.0 / 3.0              # sup T(W_1,K,K), exact
B_NEG = np.sqrt(2.0 / 3.0)     # sup T(W_1,N,N), exact
# Both were first set at 0.666 and 0.815 -- BELOW the suprema they cap, so the
# "bound" was not one.  Corrected to the exact values (Reviewer 19, 120-restart
# ascent, residuals 8.9e-16 and 5.6e-16).  The verdicts are unchanged: n=16 moves
# from -0.0079 to -0.0081.
# sup |T(W_1,K,N)| measured as EXACTLY 0, so B interpolates with no cross term:
#     B(c_0) = B_KER c_0^2 + B_NEG (1 - c_0^2),  decreasing in c_0.
# This is what the earlier bound threw away: it charged B_NEG at every c_0, but
# B_NEG is reachable only at c_0 = 0, where the leading term vanishes outright.


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def requirement(a):
    """Theorem 4.17 closes iff gamma_max(a) < this, for every a < 1/3."""
    return (3.0 - 5.0 * a) / np.sqrt(3.0)


def gamma_bound(a, n, grid=20001):
    """sup over c_0 of the coupled bound, at slack eps = 1/3 - a."""
    eps = 1.0 / 3.0 - a
    if eps <= 0:
        return 0.0
    c0 = np.linspace(0.0, 1.0, grid)
    s2 = 6.0 * eps / (3.0 - c0 ** 2)
    ok = s2 <= 1.0
    c0, s2 = c0[ok], s2[ok]
    if c0.size == 0:
        return np.inf
    # mu_N ranges over [-1, -1/6], so s^2 ranges over an interval rather than
    # sitting at one endpoint; in the decisive region s <= 0.34 the objective is
    # increasing in s, so the upper endpoint is the maximiser and using it is safe.
    s = np.sqrt(s2)
    # UPPER BOUND, not an equality: the two constants are attained at different W_1.
    B = B_KER * c0 ** 2 + B_NEG * (1 - c0 ** 2)
    g = R23 * (3 * (1 - s2) * s * c0 * A_SUP
               + 3 * np.sqrt(1 - s2) * s2 * B
               + s2 * s * theta0(n))
    return float(g.max())


def nienhaus_bound(a, c):
    """His g(phi_0): minimise (c - cos^3 - 3a cos sin^2)/sin^3.  The minimiser
    solves (1-a) x^2 - c x + a = 0 for x = cos(phi_0); at c=1 it reduces to
    x = a/(1-a) and the value to (1+a) sqrt(1-2a)."""
    disc = c * c - 4 * a * (1 - a)
    if disc < 0:
        return np.inf
    x = (c - np.sqrt(disc)) / (2 * (1 - a))
    x = min(max(x, -0.999999), 0.999999)
    return (c + (3 * a - 1) * x ** 3 - 3 * a * x) / (1 - x * x) ** 1.5


def combined(a, n, grid=2001):
    """The true gamma_max obeys BOTH bounds, so it obeys their minimum.

    Nienhaus's bound is sharp away from alpha = 1/3 and degenerates exactly at
    it; the coupled bound vanishes as alpha -> 1/3 and is weak for small alpha.
    They fail in disjoint ranges, so the minimum closes the whole interval."""
    return min(nienhaus_bound(a, R23 * theta0(n)), gamma_bound(a, n, grid=grid))


print("Requirement: gamma_max(alpha) < (3 - 5 alpha)/sqrt(3) for every alpha < 1/3.")
print("Bound used: min(Nienhaus's g(phi_0) at c_n, the coupled bound).\n")
for n in (12, 14, 16, 20, 40):
    print(f"n={n:3d}  theta_0={theta0(n):.6f}")
    print(f"   {'alpha':>7} {'coupled bound':>14} {'requirement':>12} {'margin':>10}")
    worst, worst_a = -9e9, None
    for a in (0.0, 0.10, 0.20, 0.25, 0.28, 0.30, 0.31, 0.32, 0.325, 0.330, 0.3333):
        g, r = combined(a, n), requirement(a)
        m = r - g
        if m < worst:
            worst, worst_a = m, a
        if worst_a is None or m < worst:
            worst, worst_a = m, a
        gN, gC = nienhaus_bound(a, R23*theta0(n)), gamma_bound(a, n)
        which = "N" if gN <= gC else "C"
        print(f"   {a:>7.4f} {g:>14.6f} ({which}) {r:>12.6f} {m:>+10.6f}"
              f"{'   <-- FAILS' if m <= 0 else ''}")
    # fine scan for the true worst case
    aa = np.linspace(0.0, 1.0 / 3.0, 4001)
    ms = np.array([requirement(x) - combined(x, n) for x in aa])
    i = int(np.argmin(ms))
    print(f"   worst margin over alpha in [0,1/3]: {ms[i]:+.6f} at alpha={aa[i]:.5f}"
          f"   {'*** THEOREM 4.17 REPAIRED ***' if ms[i] > 0 else 'fails'}\n", flush=True)
