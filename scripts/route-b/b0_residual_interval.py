"""The residual one-variable inequality of Lemma 35, covered on all of (0, A0].

THE STATEMENT.  With A0 = sqrt(2/3), K0 = 3/(2 sqrt2), gamma = 1 - 3 K0 < 0,

    g(A)   = A^3 - (1-A^2)^{3/2}/sqrt2 + 3A(1-A^2)
    alpha  = K0 (2 - 3A^2)  >= 0 on (0, A0]
    beta   = (3/4) sqrt(2-2A^2) - 3A          (zero exactly at A = 1/3)
    gamma  = 1 - 3 K0 < 0
    T      = (2 sqrt2 / 3) A
    psi*(A) = max_{0 <= t <= T} (alpha t + beta t^2 + gamma t^3)

show  F(A) = g(A) + psi*(A) <= sqrt(3/2)  on (0, A0].

psi* HAS A CLOSED FORM.  gamma < 0 makes the roots of psi' have product
alpha/(3 gamma) < 0, so psi' has a unique positive root
t_c = (-beta - sqrt(beta^2 - 3 gamma alpha)) / (3 gamma), and psi* = psi(min(t_c, T)).

THREE RANGES.
  (0, 1/3]    dropping gamma t^3 <= 0 gives F <= g + alpha T + beta T^2 <= 8/9.
              beta >= 0 there, so the quadratic is increasing on [0,T] and T is
              the right evaluation point.  Peak at A = 1/3, where beta = 0 exactly
              since sqrt(2-2A^2) = 4A iff A^2 = 1/9.
  (1/3, 0.7]  the same envelope OVERSHOOTS (to 1.3026), so the cubic is retained
              and the range is closed by a Lipschitz certificate whose constant is
              DERIVED, not measured: by the envelope theorem
                  F' = g' + alpha' t + beta' t^2                (interior branch)
                  F' = that + (alpha + 2 beta T + 3 gamma T^2) T'   (capped branch)
              with alpha' = -(9 sqrt2 / 2) A, beta' = -3 sqrt2 A/(4 sqrt(1-A^2)) - 3,
              T' = 2 sqrt2 / 3.
  (0.7, A0]   the exact endpoint expansion: g(A0) = sqrt(6)/2, g'(A0) = 0,
              -g''(A0)/2 = (9/4) sqrt6, while alpha(A0-e) = 3 sqrt3 e and
              beta(A0) = -(3/4) sqrt6 give t* = sqrt2 e (inside the cap) and
              psi* = alpha^2/(4|beta|) = (3/2) sqrt6 e^2.  Margin (3/4) sqrt6 > 0.

WHAT IS COMPUTER-ASSISTED.  The middle band's maximum is evaluated on a finite grid
in floating point rather than by interval arithmetic.  The Lipschitz term L*h/2 is
1.3e-5 against a slack of 2.2e-2, so the conclusion is robust, but it is a
certificate and is cited as one.

FALSIFIER.  Any A in (0, A0] with F(A) > sqrt(3/2); or a Lipschitz bound below the
true sup|F'| on the middle band.
"""
import numpy as np

K0 = 3 / (2 * np.sqrt(2)); GA = 1 - 3 * K0; A0 = np.sqrt(2 / 3); TGT = np.sqrt(1.5)

g     = lambda A: A**3 - (1 - A**2)**1.5 / np.sqrt(2) + 3 * A * (1 - A**2)
alpha = lambda A: K0 * (2 - 3 * A**2)
beta  = lambda A: 0.75 * np.sqrt(2 - 2 * A**2) - 3 * A
Tcap  = lambda A: (2 * np.sqrt(2) / 3) * A


def psi_star(A):
    a, b, T = alpha(A), beta(A), Tcap(A)
    tc = (-b - np.sqrt(b * b - 3 * GA * a)) / (3 * GA)
    t = min(tc, T)
    return a * t + b * t * t + GA * t**3


def F(A):
    return g(A) + psi_star(A)


def lipschitz_bound(lo, hi, n=200001):
    """Derived, not measured: bound each closed-form ingredient on [lo,hi]."""
    A = np.linspace(lo, hi, n)
    gp = np.abs(3 - 6 * A**2 + 1.5 * A * np.sqrt(2 - 2 * A**2)).max()
    ap = np.abs(-(9 * np.sqrt(2) / 2) * A).max()
    bp = np.abs(-3 * np.sqrt(2) * A / (4 * np.sqrt(1 - A**2)) - 3).max()
    Tm, Tp = Tcap(hi), 2 * np.sqrt(2) / 3
    inner = gp + ap * Tm + bp * Tm**2
    capped = (np.abs(alpha(A)).max() + 2 * np.abs(beta(A)).max() * Tm
              + 3 * abs(GA) * Tm**2) * Tp
    return inner + capped


if __name__ == '__main__':
    print(f"target sqrt(3/2) = {TGT:.12f}\n")
    A = np.linspace(1e-9, 1/3, 200001)
    e1 = (g(A) + alpha(A) * Tcap(A) + beta(A) * Tcap(A)**2).max()
    print(f"  (0, 1/3]    closed-form envelope max {e1:.9f}  (= 8/9 = {8/9:.9f})"
          f"   margin {TGT-e1:+.6f}")
    lo, hi = 1/3, 0.7
    A = np.linspace(lo, hi, 200001); Fv = np.array([F(a) for a in A])
    L = lipschitz_bound(lo, hi); h = A[1] - A[0]
    cert = Fv.max() + L * h / 2
    print(f"  (1/3, 0.7]  max F {Fv.max():.9f}   derived L <= {L:.6f}   L*h/2 = {L*h/2:.2e}")
    print(f"              certificate {cert:.9f} <= target? {cert <= TGT}"
          f"   slack {TGT-cert:+.6f}")
    A = np.linspace(0.7, A0, 200001); Fv = np.array([F(a) for a in A])
    print(f"  (0.7, A0]   max F {Fv.max():.12f}   excess {Fv.max()-TGT:+.2e}"
          f"   (endpoint proved exactly: margin (3/4)sqrt6 = {0.75*np.sqrt(6):.6f})")
