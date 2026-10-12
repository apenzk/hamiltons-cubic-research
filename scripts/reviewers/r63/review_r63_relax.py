"""Reviewer 63 -- the 3-parameter rigorous relaxation R(A,s,u) >= G(lam), and its global max.

Ingredients (each a theorem, proved in reviews/REVIEW_r63.md):
  P1  G = sum_P lam^3 - b^3 - c^3 + 6 lam_1 b c + 3 M(lam_P)          (exact decoupling)
  P2  3M <= h (s^2-u),  h = harmonic mean of the 3 largest positives  (LP duality)
  P2' h <= min(lam_1, (3/(2 sqrt2)) sqrt(d)),   d = u - lam_1^2
  P3  sum_P lam^3 <= lam_1^3 + min(lam_1, sqrt d) d
  P4  d <= (s - lam_1)^2
  P5  b+c = s, b^2+c^2 = 1-u  =>  bc = (s^2-1+u)/2 >= 0, disc = 2-s^2-2u >= 0
"""
import numpy as np
from scipy.optimize import differential_evolution, minimize

K0 = 3.0/(2.0*np.sqrt(2.0))
TARGET = np.sqrt(1.5)

def feasible(A, s, u):
    d = u - A*A
    if d < -1e-15 or A <= 0 or A > s + 1e-15: return None
    d = max(d, 0.0)
    if d > (s-A)**2 + 1e-15: return None
    bc = 0.5*(s*s - 1.0 + u)
    if bc < -1e-15: return None
    disc = 2.0 - s*s - 2.0*u
    if disc < -1e-15: return None
    return d, max(bc, 0.0), max(disc, 0.0)

def R(A, s, u):
    f = feasible(A, s, u)
    if f is None: return -np.inf
    d, bc, disc = f
    b = 0.5*(s + np.sqrt(disc)); c = 0.5*(s - np.sqrt(disc))
    return (A**3 + min(A, np.sqrt(d))*d + min(A, K0*np.sqrt(d))*(s*s-u)
            - b**3 - c**3 + 6*A*bc)

def negR(x): return -R(*x)

if __name__ == '__main__':
    bnds = [(1e-9, 1.0), (1e-9, np.sqrt(2)), (1e-9, 1.0)]
    best = (-9, None)
    for seed in range(40):
        r = differential_evolution(negR, bnds, seed=seed, tol=1e-14, maxiter=4000,
                                   popsize=45, polish=True)
        if -r.fun > best[0]: best = (-r.fun, r.x.copy())
    print('global max of R  = %.12f' % best[0])
    print('target sqrt(3/2) = %.12f' % TARGET)
    print('excess           = %+.3e' % (best[0]-TARGET))
    A, s, u = best[1]
    d, bc, disc = feasible(A, s, u)
    print('argmax  A=%.9f s=%.9f u=%.9f  d=%.3e  s^2-u=%.3e  disc=%.3e' % (A, s, u, d, s*s-u, disc))
    print('        A/s=%.9f  s^2=%.9f (2/3=%.9f)' % (A/s, s*s, 2/3))
    # dense grid sweep as a second opinion
    m = -9; arg=None
    for A in np.linspace(1e-3, 1.0, 500):
        for s in np.linspace(A, np.sqrt(2), 400):
            lo, hi = A*A, min(1.0, (2-s*s)/2)
            if hi < lo: continue
            for u in np.linspace(lo, hi, 120):
                v = R(A, s, u)
                if v > m: m, arg = v, (A, s, u)
    print('grid  max of R   = %.12f  at %s' % (m, np.round(arg, 6)))


# ------------------------------------------------------------------ 2-d reduction
# R is strictly increasing in u (dR/du >= (3/2)s + 2A > 0) and in s (dR/ds = 6sA+3bc+... > 0),
# so both sit at their upper bounds: s = sqrt(2-2u)  (disc = 0, i.e. b = c).
def R2(A, u):
    d = u - A*A
    if d < 0 or u > 1 or A <= 0: return -np.inf
    s2 = 2 - 2*u
    if s2 < 0: return -np.inf
    s = np.sqrt(s2)
    if s < A + np.sqrt(d) - 1e-12: return -np.inf     # d <= (s-A)^2
    return (A**3 + min(A, np.sqrt(d))*d + min(A, K0*np.sqrt(d))*(2-3*u)
            - (2-2*u)**1.5/4 + 3*A*(1-u))

def scan2(nA=4000, nu=4000):
    best = (-9, None)
    for A in np.linspace(1e-6, 1.0, nA):
        us = np.linspace(A*A, 1.0, nu)
        for u in us:
            v = R2(A, u)
            if v > best[0]: best = (v, (A, u))
    return best


# ------------------------------------------------------- closed-form region bounds
def region_bounds(n=4000001):
    """Closed-form maxima of R2 on the three branch regions of  d = u - A^2."""
    out = {}
    u = np.linspace(1e-9, 1.0, n)
    # III:  d > A^2  <=>  A <= sqrt(u/2);  min's both take A;  R2 = 5A(1-u) - (2-2u)^{3/2}/4
    f = 5*np.sqrt(u/2)*(1-u) - (2-2*u)**1.5/4
    out['III  d > A^2'] = (f.max(), u[f.argmax()])
    # II:  8A^2/9 < d <= A^2  =>  A^2 <= 9u/17, d^{3/2} <= A^3, min(A,K0 sqrt d) = A
    A = 3*np.sqrt(u/17)
    f = 2*A**3 + A*(5-6*u) - (2-2*u)**1.5/4
    out['II   8A^2/9 < d <= A^2'] = (f.max(), u[f.argmax()])
    return out


def g_slice(A):
    """R2 on d = 0 (i.e. k = 1)."""
    return A**3 - (1-A*A)**1.5/np.sqrt(2) + 3*A*(1-A*A)


def region_I_envelope(nA=200001, nt=20001):
    """Region I (K0 sqrt d <= A).  With t = sqrt d,

        R2 <= g(A) + psi(t),  psi(t) = alpha t + beta t^2 + gamma t^3,
        alpha = K0 (2 - 3A^2),  beta = (3/4) sqrt(2-2A^2) - 3A,  gamma = 1 - 3 K0 < 0,
        0 <= t <= (2 sqrt2 / 3) A.

    For A > sqrt(2/3): alpha <= 0, beta < 0, gamma < 0, so psi <= 0 and R2 <= g(A).
    For A <= sqrt(2/3) the one-dimensional maximisation below closes it.
    """
    gam = 1 - 3*K0
    best = (-9, None)
    for A in np.linspace(1e-6, np.sqrt(2/3), nA):
        al = K0*(2-3*A*A); be = 0.75*np.sqrt(2-2*A*A) - 3*A
        t = np.linspace(0, (2*np.sqrt(2)/3)*A, nt)
        v = g_slice(A) + (al*t + be*t*t + gam*t**3).max()
        if v > best[0]: best = (v, A)
    return best
