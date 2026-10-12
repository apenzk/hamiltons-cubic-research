"""r68: direct optimisation attack -- try to make theta exceed bound (c) (hence (a) or (b)).

Bound (c) is the pointwise minimum of the two, so a violation of (c) is the weakest
target that still implies a violation of one of the recorded bounds... no: (c) <= (a),(b),
so theta > (c) alone is not a refutation of (a) or (b).  We therefore track all three
separately and report the worst slack of EACH.

The optimisation runs over full symmetric operators on so(n) (unit norm, traceless),
started from the two recorded exact points and from random S=0 configurations.
"""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from scipy.optimize import minimize
import review_r68_core as R
from review_r68_bounds import bounds

rng = np.random.default_rng(680)


def sym_from_vec(z, N):
    A = np.zeros((N, N))
    iu = np.triu_indices(N)
    A[iu] = z
    A = A + A.T - np.diag(np.diag(A))
    A -= np.trace(A) / N * np.eye(N)
    nrm = np.linalg.norm(A)
    return A / nrm if nrm > 0 else A


def vec_from_sym(A):
    iu = np.triu_indices(A.shape[0])
    return A[iu]


def slacks(n, W, C, tol=1e-9):
    an = R.analyse(n, W, C, tol)
    bd = bounds(an['lam'], n, tol)
    return dict(a=bd['a'] - an['theta'], b=bd['b'] - an['theta'], c=bd['c'] - an['theta'],
                Smmm=an['S']['mmm'], theta=an['theta'], d=an['d'])


def attack(n, target, starts, C, maxiter=4000, keep_S0=True):
    N = n * (n - 1) // 2
    best = (np.inf, None)
    for W0 in starts:
        z0 = vec_from_sym(W0)

        def obj(z):
            W = sym_from_vec(z, N)
            s = slacks(n, W, C)
            pen = 1e3 * s['Smmm'] if keep_S0 else 0.0     # stay on the S=0 stratum
            return s[target] + pen

        r = minimize(obj, z0, method='Powell',
                     options=dict(maxiter=maxiter, maxfev=maxiter * 10, xtol=1e-10, ftol=1e-12))
        W = sym_from_vec(r.x, N)
        s = slacks(n, W, C)
        if s[target] < best[0] and s['Smmm'] < 1e-8:
            best = (s[target], (W, s))
    return best


if __name__ == '__main__':
    for n in [5, 6]:
        C = R.struct(n)
        N = n * (n - 1) // 2
        starts = [R.padded_cp2(n), R.sphere_product(n, n // 2)]
        # random d<=2 starts (automatically S_mmm = 0)
        for _ in range(4):
            Q = np.linalg.qr(rng.normal(size=(N, N)))[0]
            d = 2
            neg = -np.abs(rng.gamma(1.0, size=d))
            pos = np.abs(rng.gamma(1.0, size=N - d))
            pos *= (-neg.sum()) / pos.sum()
            spec = np.concatenate([neg, pos])
            starts.append((Q * spec) @ Q.T / np.linalg.norm(spec))
        for target in ['a', 'b', 'c']:
            val, info = attack(n, target, starts, C)
            W, s = info
            print(f"n={n} target=({target}) best slack {val:+.6e}   theta={s['theta']:.6f} d={s['d']} S_mmm={s['Smmm']:.2e}")
