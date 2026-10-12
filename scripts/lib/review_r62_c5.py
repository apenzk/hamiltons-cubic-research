"""Reviewer 62: adversarial maximisation of G on the two-negative stratum (claim C5).

Reduction proved in the report:
  write x = rho*w with |w|=1, w>0 the positive part, S = sum w.
  Then G(rho) = C3 rho^3 - C1 rho with C1 = (3/2)(S+2w_1) > 0, so the max over the
  admissible interval rho in [1/sqrt(S^2+1), sqrt(2/(S^2+2))] is at an ENDPOINT.
  Left endpoint (bc = 0, i.e. c = 0) gives G = rho^3 (M3 + 3F - S^3) <= 0.
  So sup G lives on the face b = c, where
      G = H(w) := [ M3 + 3F - S^3/4 + (3/2) S^2 w_1 ] * (2/(S^2+2))^{3/2}.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import numpy as np, itertools, sys
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r62_g import FTP, G_closed, spectrum_from_x
from scipy.optimize import minimize

TARGET = np.sqrt(1.5)


def H(w):
    w = np.abs(np.asarray(w, float))
    n = np.linalg.norm(w)
    if n == 0:
        return -np.inf
    w = w / n
    S = w.sum()
    return float((( w ** 3).sum() + 3.0 * FTP(w) - S ** 3 / 4.0 + 1.5 * S * S * w.max())
                 * (2.0 / (S * S + 2.0)) ** 1.5)


def maxH(k, restarts=120, seed=0):
    rng = np.random.default_rng(seed)
    best = (-np.inf, None)
    for t in range(restarts):
        st = t % 6
        if st == 0:   w0 = rng.random(k)
        elif st == 1: w0 = np.ones(k) + 0.05 * rng.normal(size=k)
        elif st == 2: w0 = np.concatenate([[1.0], 0.02 * rng.random(max(k - 1, 1))])[:k]
        elif st == 3: w0 = np.geomspace(1.0, 0.01, k) * (1 + 0.1 * rng.normal(size=k))
        elif st == 4: w0 = np.concatenate([[1.0, 1.0], 0.3 * rng.random(max(k - 2, 1))])[:k]
        else:         w0 = rng.random(k) ** 3
        w0 = np.abs(w0) + 1e-6
        r = minimize(lambda z: -H(z), w0, method='Nelder-Mead',
                     options={'maxiter': 4000, 'xatol': 1e-11, 'fatol': 1e-13})
        v = H(r.x)
        if v > best[0]:
            best = (v, np.abs(r.x) / np.linalg.norm(r.x))
    return best


if __name__ == '__main__':
    print(f"target sqrt(3/2) = {TARGET:.12f}\n")
    print("A. cross-check: H(w) equals G on the b=c face")
    rng = np.random.default_rng(3)
    err = 0.0
    for k in range(1, 7):
        for _ in range(30):
            w = rng.random(k); w /= np.linalg.norm(w)
            S = w.sum(); rho = np.sqrt(2.0 / (S * S + 2.0))
            err = max(err, abs(G_closed(rho * w) - H(w)))
    print(f"   max |G_closed(rho_max w) - H(w)| = {err:.2e}\n")

    print("B. max H per k (Nelder-Mead multistart)")
    for k in range(1, 11):
        v, w = maxH(k, restarts=120 if k <= 8 else 60, seed=1000 + k)
        flag = ' *** EXCEEDS ***' if v > TARGET + 1e-9 else ''
        print(f"   k={k:2d}  max H = {v:.10f}   gap = {v - TARGET:+.3e}{flag}")
        print(f"         w = {np.round(np.sort(w)[::-1], 6)}")
