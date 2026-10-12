"""Reviewer 66 / C6(a): is S = 0 really invisible to the bracket-transportation LP?

Maximises the LP value over unit trace-free spectra lambda, twice: once with the
free tensor T, once with T forced to vanish on triples of negative indices
(which is exactly S = 0).  If S = 0 were invisible the two maxima would agree.
"""
import itertools, sys
import numpy as np
from review_r66_c6 import lp_theta


def climb(n, forbid, restarts, seed, iters=200):
    N = n * (n - 1) // 2
    rng = np.random.default_rng(seed)
    best = (-np.inf, None)
    for r in range(restarts):
        lam = rng.normal(size=N); lam -= lam.mean(); lam /= np.linalg.norm(lam)
        v = evaluate(lam, n, forbid)
        step = 0.35
        for it in range(iters):
            cand = lam + step * rng.normal(size=N)
            cand -= cand.mean(); cand /= np.linalg.norm(cand)
            vc = evaluate(cand, n, forbid)
            if vc > v:
                lam, v = cand, vc
            else:
                step *= 0.97
        if v > best[0]:
            best = (v, lam.copy())
    return best


def evaluate(lam, n, forbid):
    N = len(lam)
    f = None
    if forbid:
        f = [t for t in itertools.combinations(range(N), 3) if all(lam[x] < 0 for x in t)]
    v, mass, _ = lp_theta(lam, n, forbid_mmm=f)
    return -np.inf if v is None else v


if __name__ == '__main__':
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 6
    R = int(sys.argv[2]) if len(sys.argv) > 2 else 20
    vf, lf = climb(n, False, R, seed=0)
    vs, ls = climb(n, True, R, seed=0)
    N = n * (n - 1) // 2
    forb = [t for t in itertools.combinations(range(N), 3) if all(lf[x] < 0 for x in t)]
    v0, mass0, _ = lp_theta(lf, n)
    v1, mass1, _ = lp_theta(lf, n, forbid_mmm=forb)
    print(f"n={n}, sqrt(3/2)={np.sqrt(1.5):.9f}")
    print(f"  max over spectra, free T          : {vf:.9f}  (#neg={int((lf<0).sum())}, "
          f"(---) mass at optimum = {mass0:.4f})")
    print(f"  same spectrum with S = 0 imposed  : "
          f"{'INFEASIBLE' if v1 is None else f'{v1:.9f}'}")
    print(f"  max over spectra WITH S = 0       : {vs:.9f}  (#neg={int((ls<0).sum())})")
    print(f"  => S = 0 {'is INVISIBLE' if abs(vf-vs)<1e-6 else 'CHANGES the LP by '+f'{vf-vs:.6f}'}")
