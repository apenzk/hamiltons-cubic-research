"""r68: C5 -- fast structured maximisation of bounds (a),(b),(c) over spectra.

Family: positives  = lam1 (multiplicity r1) and l (multiplicity r2)
        negatives  = b   (multiplicity 1)  and delta (multiplicity d-1)
with sum lam = 0 and ||lam|| = 1.  Scanned over all (r1, r2, d) with a local
optimisation over the two free ratios.  Cross-checked against unstructured
Nelder-Mead in review_r68_c5.py.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from scipy.optimize import minimize


def value(lam, n, N, which='c'):
    lam = np.asarray(lam, float)
    d = int((lam < -1e-14).sum())
    p = np.sort(lam[lam > 1e-14])[::-1]
    q = -lam[lam < -1e-14]
    if len(p) == 0 or d == 0:
        return -np.inf
    lam1 = p[0]
    h3 = 3.0 / np.sum(1.0 / p[:3]) if len(p) >= 3 else 0.0
    s = p.sum(); u = (p**2).sum(); v = (q**2).sum(); b = q.max()
    cube = (p**3).sum() - (q**3).sum()
    ppp_spec = h3 * (s*s - u); ppp_mass = 0.5*lam1**3*(n-2)*(2*N-3*d)
    pmm_spec = 3*lam1*(s*s - v); pmm_mass = 1.5*lam1*b*b*(n-2)*d
    return dict(a=cube+ppp_mass+pmm_mass, b=cube+ppp_spec+pmm_spec,
                c=cube+min(ppp_spec, ppp_mass)+min(pmm_spec, pmm_mass))[which]


def build(x, r1, r2, d, N):
    """x = (ratio of l to lam1, ratio of delta to b) in (0,1]; returns spectrum or None."""
    t1, t2 = x
    t1 = min(max(t1, 1e-9), 1.0); t2 = min(max(t2, 1e-9), 1.0)
    if r1 + r2 > N - d:
        return None
    pos = np.concatenate([np.ones(r1), t1*np.ones(r2)])
    neg = np.concatenate([np.ones(1), t2*np.ones(d-1)]) if d >= 1 else np.zeros(0)
    # scale neg so trace = 0
    neg = neg * (pos.sum()/neg.sum())
    lam = np.concatenate([pos, -neg, np.zeros(N - d - r1 - r2)])
    return lam/np.linalg.norm(lam)


def scan(n, which='c', dmin=3, dmax=None):
    N = n*(n-1)//2
    dmax = dmax or (n*n//4 - 1)
    best = (-np.inf, None)
    for d in range(dmin, dmax+1):
        for r1 in range(1, min(6, N-d)+1):
            for r2 in range(0, N-d-r1+1):
                f = lambda x: -(value(build(x, r1, r2, d, N), n, N, which)
                                if build(x, r1, r2, d, N) is not None else -1e9)
                bestloc = (-np.inf, None)
                for x0 in [(0.99, 0.99), (0.5, 0.5), (0.1, 0.99), (0.99, 0.05), (0.3, 0.9)]:
                    r = minimize(f, x0, method='Nelder-Mead',
                                 options=dict(maxiter=400, fatol=1e-13, xatol=1e-12))
                    if -r.fun > bestloc[0]:
                        bestloc = (-r.fun, r.x)
                if bestloc[0] > best[0]:
                    best = (bestloc[0], (d, r1, r2, bestloc[1]))
    return best


if __name__ == '__main__':
    ns = [int(a) for a in sys.argv[1:]] or [8, 10, 12]
    for n in ns:
        N = n*(n-1)//2
        th0 = ((n-1)/n)*np.sqrt(2*(n-2)/(n-1))
        for which in ['c', 'a', 'b']:
            val, info = scan(n, which)
            d, r1, r2, x = info
            print(f"n={n:3d} N={N:3d} bound({which}) max over 3<=d<{n*n//4}: {val:10.4f}"
                  f"   at d={d}, r1={r1}, r2={r2}, ratios={np.round(x,4)}")
            sys.stdout.flush()
        print(f"        target max(sqrt(3/2), theta_0({n})) = {max(np.sqrt(1.5), th0):.6f}")
