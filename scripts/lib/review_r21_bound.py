"""Reviewer 21 phases (c)-(e): the bound arithmetic, recomputed from scratch.

Nienhaus's branch:  gamma <= min_phi (c_n - cos^3 - 3 alpha cos sin^2)/sin^3,
minimiser from (1-alpha)x^2 - c_n x + alpha = 0, x = cos(phi).
The coupled/frontier branch: with W2 = c0 K + c- N,

  gamma <= sqrt(2/3)[ 3c^2 s c0 V(s c0/c) + 3 c s^2 (1-c0^2) sqrt(2/3) + s^3 theta0(n) ]

maximised over c0 in [0,1] and s^2 <= 6 eps/(3-c0^2), where V(t) = max_{W1,K}(A+tB)
is the joint frontier.  Three choices of V are compared:
  corner   V = sqrt(5/6) + (2/3) t            (the old bound; always valid)
  claim    V = sqrt(5/6) for t <= 0.65        (the audited claim)
  closed   V = max(sqrt(5/6), 5/(16t)+2t/3)   (this reviewer's closed form)
"""
import numpy as np

R23 = np.sqrt(2.0 / 3.0)
A_SUP = np.sqrt(5.0 / 6.0)
B_SUP = 2.0 / 3.0
B_NEG = np.sqrt(2.0 / 3.0)
TSTAR = 0.75 * A_SUP            # sqrt(30)/8


def theta0(n):
    return np.sqrt(2.0 * (n - 1.0) * (n - 2.0)) / n


def c_n(n):
    return R23 * theta0(n)


def requirement(alpha):
    return (3.0 - 5.0 * alpha) / np.sqrt(3.0)


def nienhaus_gamma(alpha, c):
    """min over phi in (0,pi) of (c - cos^3 - 3 a cos sin^2)/sin^3, closed form."""
    A = 1.0 - alpha
    disc = c * c - 4.0 * alpha * A
    cands = []
    if disc >= 0:
        r = np.sqrt(disc)
        for x in ((c - r) / (2 * A), (c + r) / (2 * A)):
            if -1.0 < x < 1.0:
                cands.append(x)
    best = np.inf
    for x in cands:
        s = np.sqrt(1 - x * x)
        best = min(best, (c - x ** 3 - 3 * alpha * x * s * s) / s ** 3)
    return best


def nienhaus_gamma_brute(alpha, c, m=2000001):
    phi = np.linspace(1e-7, np.pi - 1e-7, m)
    x, s = np.cos(phi), np.sin(phi)
    return float(np.min((c - x ** 3 - 3 * alpha * x * s * s) / s ** 3))


def V_corner(t):
    return A_SUP + B_SUP * t


def V_claim(t):
    return A_SUP if t <= 0.65 else A_SUP + B_SUP * t


def V_closed(t):
    """Exact frontier: hard-case TRS value g(sqrt(5/6), 2/3, t).
    t <= t* = sqrt(30)/8 -> A_SUP (B = 0);  t > t* -> 5/(16t) + 2t/3."""
    return A_SUP if t <= TSTAR else 5.0 / (16.0 * t) + 2.0 * t / 3.0


def coupled_gamma(alpha, n, V, nc0=2001, ns=1201):
    """max over c0 in [0,1] and s in [0, sqrt(6 eps/(3-c0^2))] of the bound."""
    eps = 1.0 / 3.0 - alpha
    if eps <= 0:
        return 0.0, 1.0, 0.0
    th0 = theta0(n)
    best = (-1.0, None, None)
    for c0 in np.linspace(0.0, 1.0, nc0):
        smax = np.sqrt(min(1.0, 6.0 * eps / (3.0 - c0 * c0)))
        for s in np.linspace(1e-9, smax, ns):
            cb = np.sqrt(max(0.0, 1.0 - s * s))
            if cb < 1e-12:
                continue
            t = s * c0 / cb
            val = R23 * (3 * cb * cb * s * c0 * V(t)
                         + 3 * cb * s * s * (1 - c0 * c0) * B_NEG
                         + s ** 3 * th0)
            if val > best[0]:
                best = (val, c0, s)
    return best


if __name__ == "__main__":
    import sys
    print(f"t* = 3 sqrt(5/6)/4 = sqrt(30)/8 = {TSTAR:.12f};  "
          f"s^2 = {TSTAR**2/(1+TSTAR**2):.12f} = 15/47;  alpha* = {1/3 - TSTAR**2/(1+TSTAR**2)/3:.12f} = 32/141")
    print(f"t = 0.65 -> alpha = {1/3 - (0.65**2/(1+0.65**2))/3:.9f}")
    print("\n--- Nienhaus branch: closed form vs brute force, and its reach ---")
    print(f"  {'n':>5} {'theta0':>12} {'c_n':>12} {'a_N (bound<req)':>16} {'check':>10}")
    for n in (12, 13, 14, 16, 18, 20, 24, 40, 60, 80, 100, 110, 120, 130, 150, 1000):
        c = c_n(n)
        lo, hi = 0.0, 1.0 / 3.0
        for _ in range(200):
            mid = 0.5 * (lo + hi)
            if nienhaus_gamma(mid, c) < requirement(mid):
                lo = mid
            else:
                hi = mid
        aN = 0.5 * (lo + hi)
        chk = nienhaus_gamma_brute(0.9 * aN, c, 200001) - nienhaus_gamma(0.9 * aN, c)
        print(f"  {n:>5d} {theta0(n):>12.9f} {c:>12.9f} {aN:>16.9f} {chk:>10.2e}")
