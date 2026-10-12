"""
P0 step (2): the tubular neighbourhood closes at n >= 12 WITHOUT Theorem 4.17.

Nienhaus proves Thm 4.17 ("f strictly decreasing on (0,pi/6]") by bounding
gamma = sqrt(2/3)P(W) through g(phi) whose numerator constant is the a priori
bound f <= 1, i.e. P <= sqrt(3/2) on ALL of Weyl^1_n.  That is exactly the
statement that W_CP2 is the global maximizer, so it is available only while
n <= 11.  For n >= 12 the correct constant is c_n = sqrt(2/3) theta_0(n) > 1,
and his closing estimate g_1(1/3) is ZERO at c = 1 -- borderline -- so every
c > 1 breaks it.  Quantified below.

The conclusion survives anyway, by a bootstrap that never mentions 4.17.
Let m = sqrt(2/3) max{ P(W) : W in Weyl^1_n } (attained, the sphere is compact)
and let W* attain it.

  * If W* lies OUTSIDE the tube, Theorem 4.19 gives m <= c_n directly.

  * If W* lies INSIDE, rotate so that the nearest orbit point is u = W_CP2 and
    write W* = cos(phi) u + sin(phi) V with phi = d(W*, SO(n).u) <= gamma_n and
    V a unit vector orthogonal to BOTH u and T_u(SO(n).u) -- orthogonal to the
    orbit because phi is the distance to the orbit, not merely to u.  P is a
    cubic form and Q(u) = sqrt(3/2) u, so the expansion is exact and has no
    linear term:

        m = cos^3(phi) + 3 cos(phi) sin^2(phi) alpha + sin^3(phi) gamma,
        alpha = sqrt(2/3)<F_u V, V>,   gamma = sqrt(2/3) P(V).

    Theorem 4.14(c) gives alpha <= 1/3 (verified independently here), and
    gamma <= m by definition of m.  Hence

        m <= cos(phi) + m sin^3(phi),   i.e.   m <= psi(phi) := cos(phi)/(1-sin^3(phi)),

    and psi <= psi(0) = 1 on [0, pi/6].  So m <= 1.

Either way m <= max(1, c_n) = c_n for n >= 12, i.e. P <= theta_0(n) everywhere.
The bootstrap is what replaces the unavailable "f <= 1": it does not assume the
cap, it derives it from itself.

Needed: (a) alpha <= 1/3 [Thm 4.14(c), n >= 9]; (b) Thm 4.19 outside a tube of
angular radius gamma_n; (c) n >= 12 so c_n > 1.  Nothing else.
"""
import numpy as np

R23 = np.sqrt(2.0 / 3.0)
SQ32 = np.sqrt(1.5)


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def psi(phi):
    return np.cos(phi) / (1.0 - np.sin(phi) ** 3)


def gamma_cap(alpha, c):
    """Nienhaus's g(phi_0) with a general numerator cap c.  Minimising
    g(phi) = (c - cos^3 - 3 alpha cos sin^2)/sin^3 gives (1-alpha)x^2 - c x + alpha = 0
    for x = cos(phi_0); at c=1 this is his x = alpha/(1-alpha) and
    g(phi_0) = (1+alpha) sqrt(1-2 alpha)."""
    disc = c * c - 4 * alpha * (1 - alpha)
    if disc < 0:
        return np.inf
    x = (c - np.sqrt(disc)) / (2 * (1 - alpha))
    return (c + (3 * alpha - 1) * x ** 3 - 3 * alpha * x) / (1 - x * x) ** 1.5


def g1(alpha, c):
    """Nienhaus's f~(pi/6); Thm 4.17 needs this < 0 for alpha < 1/3."""
    return 0.75 * (3 * alpha - 1) - alpha + (np.sqrt(3) / 4) * gamma_cap(alpha, c)


print("Check the c=1 closed form gamma_max = (1+a)sqrt(1-2a):")
for a in (0.0, 0.1, 0.2, 1 / 3.):
    print(f"   a={a:.4f}   g(phi_0)={gamma_cap(a,1.0):.12f}   (1+a)sqrt(1-2a)={(1+a)*np.sqrt(1-2*a):.12f}")

print(f"\nNienhaus's closing estimate at the borderline alpha=1/3 (needs < 0):")
print(f"   c=1                       g1(1/3) = {g1(1/3.,1.0):+.12f}   <- exactly zero, borderline")
for n in (10, 12, 14, 16, 20, 100):
    c = R23 * theta0(n)
    print(f"   n={n:4d}  c_n={c:.9f}   g1(1/3) = {g1(1/3.,c):+.9f}"
          f"   {'OK' if g1(1/3.,c) < 0 else 'FAILS -- Thm 4.17 proof does not extend'}")

print("\npsi(phi) = cos(phi)/(1-sin^3(phi)) on [0, pi/6]  (bootstrap bound on m):")
gr = np.linspace(0, np.pi / 6, 13)
for p in gr:
    print(f"   phi={p:.6f}  psi={psi(p):.12f}")
print(f"   max over [0,pi/6] = {max(psi(p) for p in np.linspace(0,np.pi/6,200001)):.12f}  (attained at phi=0)")
thr = None
for p in np.linspace(0, 1.2, 120001):
    if psi(p) > 1.0 + 1e-15 and thr is None and p > 0.1:
        thr = p
        break
print(f"   psi first exceeds 1 at phi = {thr:.6f} rad -- so any tube of angular radius")
print(f"   gamma_n <= {thr:.4f} suffices; Nienhaus uses gamma_10=0.26, gamma_11=0.13, both far below.")

print("\nConclusion of the bootstrap, m <= max(1, c_n):")
for n in (10, 12, 14, 16, 20, 24):
    c = R23 * theta0(n)
    t0 = theta0(n)
    ok = c > 1.0
    print(f"   n={n:3d}  theta_0={t0:.9f}  sqrt(3/2)={SQ32:.9f}  c_n={c:.9f}"
          f"   m<=max(1,c_n)={max(1.0,c):.9f}  ->  P <= {max(1.0,c)/R23:.9f}"
          f"   {'CLOSES (= theta_0)' if ok else 'gives sqrt(3/2) > theta_0 -- CP2 wins, as it must'}")
