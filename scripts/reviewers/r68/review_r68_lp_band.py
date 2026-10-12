"""r68 (C5): does the LP bound stay below max(sqrt(3/2), theta_0(n)) across the band?

For each d in [3, floor(n^2/4)) it maximises, over spectra, the exact LP supremum of
theta -- with and without the vector identity R.lam = -2 lam.  The LP value is the
sharpest bound obtainable from the stated structural facts, so its maximum over the
band is the honest replacement for the 8.16 / 11.13 / 13.78 figures of bound (c).
"""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from scipy.optimize import minimize
from review_r68_lp import lp_sup
from review_r68_c5_fast import build
from review_r68_bounds import bounds

rng = np.random.default_rng(68681)


def spectra_for(d, N, k):
    """random spectra with exactly d negatives"""
    out = []
    for _ in range(k):
        r = int(rng.integers(1, N-d+1))
        pos = rng.gamma(rng.uniform(0.2, 3.0), size=r)
        pos = np.concatenate([pos, np.zeros(N-d-r)])
        neg = rng.gamma(rng.uniform(0.2, 3.0), size=d)
        neg = neg*(pos.sum()/neg.sum())
        lam = np.concatenate([pos, -neg])
        out.append(lam/np.linalg.norm(lam))
    return out


if __name__ == '__main__':
    n = int(sys.argv[1]); nrand = int(sys.argv[2]) if len(sys.argv) > 2 else 25
    N = n*(n-1)//2
    th0 = ((n-1)/n)*np.sqrt(2*(n-2)/(n-1))
    target = max(np.sqrt(1.5), th0)
    gbest = {'plain': (-1, None), 'vecid': (-1, None), 'c': (-1, None)}
    for d in range(3, n*n//4):
        cands = spectra_for(d, N, nrand)
        # structured candidates: r1 top values, r2 mid values, two-level negatives
        for r1 in [1, 2, 3]:
            for r2 in [0, 3, max(0, N-d-r1)]:
                if r1+r2 > N-d:
                    continue
                for t1 in [0.15, 0.3, 0.6, 1.0]:
                    for t2 in [0.3, 0.6, 1.0]:
                        lam = build((t1, t2), r1, r2, d, N)
                        if lam is not None:
                            cands.append(lam)
        bd_ = -1; bp = -1; bv = -1
        for lam in cands:
            bd_ = max(bd_, bounds(lam, n)['c'])
            p, _ = lp_sup(n, lam, False)
            v, _ = lp_sup(n, lam, True)
            if p is not None and p > bp:
                bp = p; lp_arg = lam
            if v is not None and v > bv:
                bv = v; lv_arg = lam
        for key, val, arg in [('plain', bp, lp_arg), ('vecid', bv, lv_arg), ('c', bd_, None)]:
            if val > gbest[key][0]:
                gbest[key] = (val, (d, arg))
        print(f"n={n} d={d:3d}  max bound(c) {bd_:10.4f}   max LP(plain) {bp:9.6f}   max LP(+vecid) {bv:9.6f}")
        sys.stdout.flush()
    print(f"n={n} BAND MAX: bound(c) {gbest['c'][0]:.4f} | LP plain {gbest['plain'][0]:.6f} (d={gbest['plain'][1][0]})"
          f" | LP+vecid {gbest['vecid'][0]:.6f} (d={gbest['vecid'][1][0]}) | target {target:.6f}")
    for key in ['plain', 'vecid']:
        print(f"   {key} argmax spectrum:", np.round(np.sort(gbest[key][1][1])[::-1], 4))
