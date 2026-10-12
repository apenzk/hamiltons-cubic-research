"""Reviewer 19: recompute the claimed combined bound with (i) the EXACT coupling
constants B_KER = 2/3, B_NEG = sqrt(2/3) measured by single-vector ascent, and
(ii) the FULL admissible range of s at each c_0, not just its upper endpoint.

Admissible region at slack eps = 1/3 - alpha:
    eps = s^2 (1/3 - c_-^2 mu),  mu = <F N,N>/theta* in [-1, -1/6],  c_-^2 = 1-c_0^2
=>  s^2 in [ 3 eps/(1+3t), 6 eps/(2+t) ]  with t = 1 - c_0^2,  intersect [0,1].
The audited script uses only the right endpoint.
"""
import numpy as np

R23 = np.sqrt(2.0/3.0)
A_SUP = np.sqrt(5.0/6.0)
EX = dict(BK=2.0/3.0, BN=np.sqrt(2.0/3.0))      # exact
AS = dict(BK=0.666,  BN=0.815)                  # as coded in p0_sharp_gamma.py


def theta0(n):
    return np.sqrt(2.0*(n-1)*(n-2))/n


def requirement(a):
    return (3.0 - 5.0*a)/np.sqrt(3.0)


def G(s, c0, n, BK, BN):
    s2 = s*s
    B = BK*c0**2 + BN*(1-c0**2)
    return R23*(3*(1-s2)*s*c0*A_SUP + 3*np.sqrt(max(1-s2, 0.0))*s2*B + s2*s*theta0(n))


def gamma_bound(a, n, BK, BN, endpoint_only, nc=1201, ns=401):
    eps = 1.0/3.0 - a
    if eps <= 0:
        return 0.0
    c0 = np.linspace(0.0, 1.0, nc)[:, None]
    t = 1 - c0*c0
    s2hi = np.minimum(6*eps/(2+t), 1.0)
    s2lo = np.minimum(3*eps/(1+3*t), s2hi)
    if endpoint_only:
        ok = (6*eps/(2+t) <= 1.0)
        s2 = np.where(ok, s2hi, np.nan)
    else:
        lam = np.linspace(0.0, 1.0, ns)[None, :]
        s2 = s2lo + (s2hi - s2lo)*lam
    s = np.sqrt(s2)
    B = BK*c0**2 + BN*(1-c0**2)
    g = R23*(3*(1-s2)*s*c0*A_SUP + 3*np.sqrt(np.maximum(1-s2, 0.0))*s2*B + s2*s*theta0(n))
    return float(np.nanmax(g))


def nienhaus_bound(a, c):
    disc = c*c - 4*a*(1-a)
    if disc < 0:
        return np.inf
    x = (c - np.sqrt(disc))/(2*(1-a))
    x = min(max(x, -0.999999), 0.999999)
    return (c + (3*a-1)*x**3 - 3*a*x)/(1-x*x)**1.5


def nienhaus_bound_brute(a, c):
    ph = np.linspace(1e-4, np.pi-1e-4, 400001)
    v = (c - np.cos(ph)**3 - 3*a*np.cos(ph)*np.sin(ph)**2)/np.sin(ph)**3
    return v.min()


def combined(a, n, BK, BN, endpoint_only):
    return min(nienhaus_bound(a, R23*theta0(n)), gamma_bound(a, n, BK, BN, endpoint_only))


if __name__ == "__main__":
    # sanity on the Nienhaus closed form
    for a in (0.0, 0.15, 0.30, 0.3333):
        for n in (12, 16):
            c = R23*theta0(n)
            print(f"  nienhaus a={a} n={n}: closed={nienhaus_bound(a,c):.6f} brute={nienhaus_bound_brute(a,c):.6f}")
    print()
    for n in (12, 14, 16, 20, 40):
        print(f"n={n}  theta_0={theta0(n):.6f}  c_n={R23*theta0(n):.6f}")
        aa = np.linspace(0.0, 1.0/3.0, 1001)
        for tag, (BK, BN), ep in (("as-coded  s=max ", (AS['BK'], AS['BN']), True),
                                  ("exact     s=max ", (EX['BK'], EX['BN']), True),
                                  ("exact     s free", (EX['BK'], EX['BN']), False)):
            ms = np.array([requirement(x) - combined(x, n, BK, BN, ep) for x in aa])
            i = int(np.argmin(ms))
            print(f"   {tag}: worst margin {ms[i]:+.6f} at alpha={aa[i]:.4f}"
                  f"   {'REPAIRED' if ms[i] > 0 else 'FAILS'}")
        print(flush=True)
