"""Reviewer 63 -- closed-form attack on C5.

Ingredients proved by hand and checked here:
  (P1) exact decoupling:  G = sum_P lam^3 - b^3 - c^3 + 6 lam_1 b c + 3 M(lam_P)
  (P2) LP duality with z_ab = mu lam_a lam_b :   3M <= h * (s^2 - u),
       h = harmonic mean of the three largest positives ( = 0 if k < 3 ),
       and h <= min(lam_1, 3 lam_3).
  (P3) sum_P lam^3 <= lam_1^3 + min(lam_1, sqrt(d)) * d,  d = u - lam_1^2.
  (P4) d <= sigma^2 with sigma = s - lam_1 (nonnegativity / Cauchy-Schwarz).
"""
import sys, itertools, numpy as np
sys.path.insert(0, 'scripts/lib')[0])
from review_r63_G import G_closed, tables
from scipy.optimize import linprog

TARGET = np.sqrt(1.5)

def M_exact(lp):
    k = len(lp)
    if k < 3: return 0.0
    tri, prs, A, _ = tables(k)
    w = np.array([3*lp[a]*lp[b]*lp[g] for (a,b,g) in tri])
    r = linprog(-w, A_ub=A, b_ub=2*np.ones(len(prs)), bounds=[(0,None)]*len(tri), method='highs')
    return -r.fun          # this is 3M

def h_of(lp):
    x = np.sort(lp)[::-1]
    if len(x) < 3 or x[2] <= 0: return 0.0
    return 3.0/(1/x[0]+1/x[1]+1/x[2])

def check_P2(rng, n=4000):
    worst = -1e9; worstcase=None
    for _ in range(n):
        k = rng.integers(3, 9)
        lp = rng.random(k)**rng.uniform(0.2, 4)
        s = lp.sum(); u = (lp**2).sum()
        lhs = M_exact(lp); rhs = h_of(lp)*(s*s-u)
        if lhs - rhs > worst: worst = lhs-rhs; worstcase = lp.copy()
    return worst, worstcase

def relaxed_bound(l1, sig, d):
    """R(l1,sigma,d) >= G, using P1-P4. Returns -inf when (b,c) infeasible."""
    s = l1 + sig; u = l1*l1 + d
    if u > 1: return -np.inf
    bc2 = 1 - u                    # b^2 + c^2
    bc = 0.5*(s*s - bc2)           # b*c
    if bc < 0: return -np.inf
    if s*s - 4*bc < -1e-14: return -np.inf
    disc = max(s*s-4*bc, 0.0)
    b = 0.5*(s+np.sqrt(disc)); c = 0.5*(s-np.sqrt(disc))
    if c < 0: return -np.inf
    cube = l1**3 + min(l1, np.sqrt(d))*d
    tri3 = min(l1, 3*np.sqrt(d/2.0))*(s*s-u)
    return cube + tri3 - b**3 - c**3 + 6*l1*bc

def scan_relaxed(N=260):
    best = (-1e9, None)
    for l1 in np.linspace(1e-4, 1.0, N):
        for sig in np.linspace(0.0, 1.2, N):
            dmax = sig*sig
            for d in np.linspace(0.0, dmax, 40):
                v = relaxed_bound(l1, sig, d)
                if v > best[0]: best = (v, (l1, sig, d))
    return best

if __name__ == '__main__':
    rng = np.random.default_rng(99)
    w, wc = check_P2(rng, 1500)
    print('P2 (3M <= h(s^2-u)) : max violation over 1500 random positive spectra = %.3e'%w)
    print('P3/P4 spot check ...')
    bad = 0
    for _ in range(2000):
        k = rng.integers(1, 9); lp = rng.random(k)**rng.uniform(0.2,4)
        l1 = lp.max(); u=(lp**2).sum(); s=lp.sum(); d=u-l1*l1; sig=s-l1
        if (lp**3).sum() > l1**3 + min(l1,np.sqrt(d))*d + 1e-12: bad += 1
        if d > sig*sig + 1e-12: bad += 1
    print('   violations of P3/P4:', bad)
    v, arg = scan_relaxed(200)
    print('relaxed bound R: max over grid = %.9f  (target %.9f)  argmax (l1,sig,d)=%s'%(v, TARGET, arg))
