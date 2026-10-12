"""r68: C5 -- maximise bound (c) (and (a),(b)) over admissible spectra at fixed n,d.

A spectrum is lam in R^N with sum lam = 0, ||lam|| = 1, exactly d strictly negative
entries.  The bounds depend on lam only, so this is a pure spectral optimisation --
no operator is needed.  Whether such a spectrum is realised by a Weyl operator with
S=0 is a separate (and unused) question: the recorded bounds are stated as functions
of the spectrum alone, so their maximum over spectra is what "the band" means.
"""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from scipy.optimize import minimize

rng = np.random.default_rng(6805)


def spec_from(z, N, d):
    q = np.abs(z[:d]) + 1e-12
    p = np.abs(z[d:]) + 0.0
    if p.sum() <= 0:
        p = np.ones(N - d)
    q = q / q.sum()
    p = p / p.sum()
    t = 1.0 / np.sqrt((p**2).sum() + (q**2).sum())
    return p * t, q * t


def bound_terms(p, q, n, N, d):
    ps = np.sort(p)[::-1]
    npos = int((p > 1e-14).sum())
    lam1 = ps[0]
    h3 = 3.0 / np.sum(1.0 / ps[:3]) if npos >= 3 else 0.0
    s = p.sum(); u = (p**2).sum(); v = (q**2).sum(); b = q.max()
    cube = (p**3).sum() - (q**3).sum()
    ppp_spec = h3 * (s**2 - u)
    ppp_mass = 0.5 * lam1**3 * (n - 2) * (2 * N - 3 * d)
    pmm_spec = 3.0 * lam1 * (s**2 - v)
    pmm_mass = 1.5 * lam1 * b**2 * (n - 2) * d
    return dict(a=cube + ppp_mass + pmm_mass,
                b=cube + ppp_spec + pmm_spec,
                c=cube + min(ppp_spec, ppp_mass) + min(pmm_spec, pmm_mass),
                swap=cube + ppp_spec + pmm_mass,
                swap2=cube + ppp_mass + pmm_spec)


def maximise(n, d, which='c', restarts=25, maxiter=3000):
    N = n * (n - 1) // 2
    best = -np.inf; bestz = None
    for _ in range(restarts):
        z0 = rng.gamma(1.0, size=N) + 1e-3
        f = lambda z: -bound_terms(*spec_from(z, N, d), n, N, d)[which]
        r = minimize(f, z0, method='Nelder-Mead',
                     options=dict(maxiter=maxiter * N // 10, maxfev=maxiter * N // 5,
                                  fatol=1e-12, xatol=1e-12))
        if -r.fun > best:
            best = -r.fun; bestz = r.x
    p, q = spec_from(bestz, N, d)
    return best, p, q


if __name__ == '__main__':
    import sys
    ns = [int(x) for x in sys.argv[1:]] or [8, 10, 12]
    for n in ns:
        N = n * (n - 1) // 2
        cap = n * n // 4
        rows = []
        for d in range(3, cap):
            val, p, q = maximise(n, d, 'c', restarts=12)
            rows.append((d, val, int((p > 1e-12).sum())))
        rows.sort(key=lambda r: -r[1])
        print(f"n={n} N={N} floor(n^2/4)={cap}  top-5 (d, max bound(c), #positives):")
        for r in rows[:5]:
            print(f"    d={r[0]:3d}  max(c)={r[1]:10.4f}  npos={r[2]}")
        th0 = ((n - 1) / n) * np.sqrt(2 * (n - 2) / (n - 1))
        print(f"    target max(sqrt(3/2), theta_0({n})) = {max(np.sqrt(1.5), th0):.6f}")
