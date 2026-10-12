"""r68: how high does theta go on the S=0 class (trace 0, unit norm, S_mmm = 0)?

Ascent over full symmetric operators with a penalty on S_mmm, started from the
SD-triple/mixed-negative point and from the recorded test points.  The resulting
value is a lower bound for ANY bound that is valid on the whole S=0 class.
"""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from scipy.optimize import minimize
import review_r68_core as R
from review_r68_c5_obstruction import W_sd_split

rng = np.random.default_rng(6851)


def sym_from_vec(z, N):
    A = np.zeros((N, N)); iu = np.triu_indices(N)
    A[iu] = z; A = A + A.T - np.diag(np.diag(A))
    A -= np.trace(A) / N * np.eye(N)
    nr = np.linalg.norm(A)
    return A / nr if nr > 0 else A


if __name__ == '__main__':
    for n in [5, 6, 7, 8]:
        C = R.struct(n)
        N = n * (n - 1) // 2
        iu = np.triu_indices(N)
        starts = [W_sd_split(n, 4), R.padded_cp2(n), R.sphere_product(n, n // 2)]
        for _ in range(3):
            A = rng.normal(size=(N, N)); A = (A + A.T) / 2
            starts.append(A / np.linalg.norm(A))
        best = (-np.inf, None)
        for W0 in starts:
            def obj(z):
                W = sym_from_vec(z, N)
                an = R.analyse(n, W, C)
                return -(an['theta'] - 1e3 * an['S']['mmm'])
            r = minimize(obj, W0[iu], method='Powell',
                         options=dict(maxiter=200000, maxfev=200000, xtol=1e-9, ftol=1e-11))
            W = sym_from_vec(r.x, N)
            an = R.analyse(n, W, C)
            if an['S']['mmm'] < 1e-7 and an['theta'] > best[0]:
                best = (an['theta'], (an['d'], an['S'], np.round(np.sort(an['lam'])[::-1], 5)))
        th0 = ((n - 1) / n) * np.sqrt(2 * (n - 2) / (n - 1))
        print(f"n={n}  max theta on S=0 class found: {best[0]:.6f}   target max(sqrt(3/2),theta_0) = {max(np.sqrt(1.5), th0):.6f}")
        print(f"   d={best[1][0]} S={ {k: round(v,4) for k,v in best[1][1].items()} }")
        print(f"   spectrum: {best[1][2][:8]} ...")
        sys.stdout.flush()
