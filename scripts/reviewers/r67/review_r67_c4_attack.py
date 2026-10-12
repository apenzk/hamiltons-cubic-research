"""Reviewer 67 -- hard adversarial attack on the VALIDITY of C4's bounds (a),(b),(c).

Free variables: the orthonormal eigenframe V of so(n) (its first d columns must
span an isotropic subspace so that S_mmm = 0) and the spectrum lam (negative
exactly on those d columns, traceless, unit).  Objective: theta - bound.
Any positive value refutes the bound.  Three attack modes:
  d2    -- d <= 2, where EVERY 2-plane is isotropic, so the frame is completely
           free; this is the stratum where (b) and (c) are exact.
  iso   -- m a random d-dim subspace of the symmetric-pair odd part.
  tight -- local ascent seeded exactly at the two points where the bounds are
           exact (padded W_CP2 and the balanced sphere product).
"""
import numpy as np, sys
from scipy.optimize import minimize
from scipy.linalg import expm
from review_r67_core import *
from review_r67_c5 import bound_d, bound_e


def make_lam(x, d, N):
    # floors well above spectral_stats' zero-snapping tolerance, so that no
    # eigenvalue can sit in the ambiguous band and fake a violation
    neg = np.abs(x[:d]) + 1e-8
    pos = np.abs(x[d:]) + 1e-8
    neg = neg * (pos.sum() / neg.sum())
    lam = np.concatenate([-neg, pos])
    # clean ONCE, so theta and the bound are evaluated on the very same vector
    return clean_spectrum(lam / np.linalg.norm(lam))


def best_lam(T, fn, n, N, d, nstart=6, seed=0, x0=None, maxfev=8000):
    best = (-1e9, None)
    starts = [] if x0 is None else [x0]
    starts += [np.random.default_rng(seed * 7919 + k).standard_normal(N) for k in range(nstart)]
    for s in starts:
        r = minimize(lambda x: -(theta_from(make_lam(x, d, N), T) - fn(make_lam(x, d, N), n, N)),
                     s, method='Nelder-Mead', options=dict(maxfev=maxfev, fatol=1e-14, xatol=1e-12))
        if -r.fun > best[0]:
            best = (-r.fun, r.x)
    return best


def rand_skew(N, rg, scale):
    A = rg.standard_normal((N, N)) * scale
    return A - A.T


def climb(V0, T_of, fn, n, N, d, iters, rg, x0=None, scale=0.25, isotropy_proj=None):
    V = V0.copy()
    T = T_of(V)
    val, xb = best_lam(T, fn, n, N, d, nstart=4, seed=int(rg.integers(1e6)), x0=x0)
    for it in range(iters):
        sc = scale * (0.5 ** (it / max(iters / 6, 1)))
        Vp = V @ expm(rand_skew(N, rg, sc))
        if isotropy_proj is not None:
            Vp = isotropy_proj(Vp)
        Tp = T_of(Vp)
        v, x = best_lam(Tp, fn, n, N, d, nstart=1, seed=int(rg.integers(1e6)), x0=xb, maxfev=3000)
        if v > val:
            val, V, T, xb = v, Vp, Tp, x
    return val, V, xb


if __name__ == "__main__":
    mode = sys.argv[1]
    ns = [int(x) for x in sys.argv[2].split(',')]
    for n in ns:
        om = omega_tensor(n)
        P, _ = so_basis(n); N = len(P)
        T_of = lambda V: c_tensor(om, V) ** 2
        rg = np.random.default_rng(hash((mode, n)) % (2 ** 31))
        if mode == 'd2':
            for d in [1, 2]:
                for key, fn in [('a', bound_a), ('b', bound_b), ('c', bound_c), ('d', bound_d), ('e', bound_e)]:
                    best = -1e9
                    for trial in range(6):
                        A = rg.standard_normal((N, N)); V0, _ = np.linalg.qr(A)
                        v, V, x = climb(V0, T_of, fn, n, N, d, 40, rg)
                        best = max(best, v)
                    print(f"n={n} d={d} bound({key}):  max(theta-bound) = {best:12.4e}", flush=True)
        elif mode == 'iso':
            cap = (n * n) // 4
            for d in [3, 4, max(3, cap // 2), cap - 1, cap]:
                m0 = np.array([1.0 if (i < n // 2) != (j < n // 2) else 0.0 for (i, j) in P])
                cols = np.where(m0 > 0)[0]
                if d > len(cols):
                    continue
                for key, fn in [('a', bound_a), ('b', bound_b), ('c', bound_c), ('d', bound_d), ('e', bound_e)]:
                    best = -1e9
                    for trial in range(8):
                        Q, _ = np.linalg.qr(rg.standard_normal((len(cols), d)))
                        Vm = np.zeros((N, d)); Vm[cols, :] = Q
                        V0, _ = np.linalg.qr(np.concatenate([Vm, rg.standard_normal((N, N - d))], axis=1))
                        T = T_of(V0)
                        assert float(T[:d, :d, :d].sum()) < 1e-16
                        v, _ = best_lam(T, fn, n, N, d, nstart=8, seed=trial * 13 + d)
                        best = max(best, v)
                    print(f"n={n} d={d:3d} bound({key}):  max(theta-bound) = {best:12.4e}", flush=True)
        elif mode == 'tight':
            for name, W in [("padded W_CP2", padded_cp2(n)), ("balanced sphere", balanced_sphere_product(n))]:
                lam0, V0, T0 = spectrum_data(W, om)
                order = np.argsort(lam0)
                lam0 = lam0[order]; V0 = V0[:, order]; T0 = c_tensor(om, V0) ** 2
                d = int((lam0 < -1e-9).sum())
                x0 = np.concatenate([np.abs(lam0[:d]), lam0[d:]])
                for key, fn in [('a', bound_a), ('b', bound_b), ('c', bound_c), ('d', bound_d), ('e', bound_e)]:
                    v0 = theta_from(lam0, T0) - fn(lam0, n, N)
                    v, _ = best_lam(T0, fn, n, N, d, nstart=10, seed=n * 3 + ord(key), x0=x0, maxfev=25000)
                    print(f"n={n} {name:16s} d={d:3d} bound({key}): at the point {v0:11.3e},"
                          f"  best over spectra on the SAME frame {v:11.3e}", flush=True)
