"""Reviewer 62: final adversarial checks -- direct maximisation of G (no reduction used),
strict-interior maxima, and the 'max G decreases in k' claim."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys, itertools
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r62_g import G_closed, spectrum_from_x
from scipy.optimize import minimize, differential_evolution

TARGET = np.sqrt(1.5)


def negG(x):
    x = np.abs(x)
    v = G_closed(x)
    return 1e6 if not np.isfinite(v) else -v


def direct_max(k, seed, restarts=60):
    rng = np.random.default_rng(seed)
    best = (-np.inf, None)
    for t in range(restarts):
        x0 = np.abs(rng.random(k) ** rng.choice([1, 2, 4]))
        x0 = x0 / np.linalg.norm(x0) * (0.65 + 0.3 * rng.random())
        r = minimize(negG, x0, method='Nelder-Mead',
                     options={'maxiter': 3000, 'xatol': 1e-11, 'fatol': 1e-13})
        v = G_closed(np.abs(r.x))
        if np.isfinite(v) and v > best[0]:
            best = (v, np.abs(r.x))
    return best


def interior_max(k, delta, seed, restarts=60):
    """max G subject to every positive eigenvalue >= delta*lam_1, i.e. k genuinely present.
    Run on the b=c face (where the supremum provably lives), so every draw is feasible."""
    from review_r62_c5 import H
    rng = np.random.default_rng(seed)
    def f(z):
        w = np.abs(z)
        if w.max() <= 0:
            return 1e6
        w = w / w.max()
        if w.min() < delta - 1e-12:
            return 1e6
        return -H(w)
    best = -np.inf
    for _ in range(restarts):
        w0 = delta + (1 - delta) * rng.random(k); w0[0] = 1.0
        r = minimize(f, w0, method='Nelder-Mead', options={'maxiter': 2500, 'xatol': 1e-11})
        w = np.abs(r.x); w = w / w.max()
        if w.min() >= delta - 1e-9:
            best = max(best, H(w))
    return best


if __name__ == '__main__':
    print(f"target sqrt(3/2) = {TARGET:.12f}\n")
    print("A. direct maximisation of G over the positive part x (no face reduction used)")
    for k in range(1, 9):
        v, x = direct_max(k, 900 + k)
        lam, b, c = spectrum_from_x(x)
        print(f"   k={k}: max G = {v:.10f}  gap {v-TARGET:+.2e}   b={b:.6f} c={c:.6f}"
              f"  x={np.round(np.sort(x)[::-1],5)}{'  *** EXCEEDS ***' if v>TARGET+1e-9 else ''}")

    print("\nB. maxima with all k positives genuinely present (lam_min >= delta*lam_1)")
    print(f"   {'k':>3} " + " ".join(f"{'d='+str(d):>12}" for d in (0.5, 0.2, 0.05, 0.01)))
    for k in range(1, 5):
        row = [interior_max(k, d, 500 + 17 * k + int(100 * d)) for d in (0.5, 0.2, 0.05, 0.01)]
        print(f"   {k:>3} " + " ".join(f"{v:12.8f}" for v in row))

    print("\nC. is max G decreasing in k?  (sup over the closure of each k-stratum)")
    print("   the k-stratum closure contains every j<k stratum (send k-j positives to 0),")
    print("   so sup_k G is non-decreasing in k by inclusion; it equals sqrt(3/2) for every k.")
