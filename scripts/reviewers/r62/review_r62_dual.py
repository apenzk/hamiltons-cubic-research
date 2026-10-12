"""Reviewer 62: the harmonic dual bound  3F <= 4 sum_{a<b} w_a^2 w_b^2/(w_a+w_b),
and the relaxed inequality it yields for C5."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, itertools, sys
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r62_g import FTP
from scipy.optimize import minimize

r3 = np.sqrt(3.0)


def harmonic_dual(w):
    n = len(w)
    tot = 0.0
    for a in range(n):
        for b in range(a + 1, n):
            d = w[a] + w[b]
            if d > 0:
                tot += w[a] ** 2 * w[b] ** 2 / d
    return 4.0 * tot


def feas_margin(u):
    """z_ab = 2 w_a^2 w_b^2/(w_a+w_b); dual feasibility z_ab+z_ag+z_bg >= 3 w_a w_b w_g."""
    a, b, g = u
    z = lambda x, y: 2 * x * x * y * y / (x + y)
    return z(a, b) + z(a, g) + z(b, g) - 3 * a * b * g


if __name__ == '__main__':
    rng = np.random.default_rng(11)
    print("1. dual feasibility of z_ab = 2 w_a^2 w_b^2/(w_a+w_b):  min over 400000 random triples")
    U = rng.random((400000, 3)) ** rng.choice([1, 3, 6], size=(400000, 1))
    m = np.min([feas_margin(u) for u in U[:20000]])
    print(f"   min margin (20000 sampled, mixed scales) = {m:.3e}")
    # targeted: extreme ratios
    worst = 1e9
    for e in np.geomspace(1e-6, 1, 200):
        for cfg in [(1, e, e), (1, 1, e), (1, e, e * e), (1, np.sqrt(e), e)]:
            worst = min(worst, feas_margin(cfg) / max(3 * cfg[0] * cfg[1] * cfg[2], 1e-300))
    print(f"   min RELATIVE margin over structured extremes = {worst:.6f}  (>=0 means feasible)")

    print("\n2. the bound vs the true 3F")
    for k in [3, 4, 5, 6, 7]:
        worst_r = 1e9
        for _ in range(60):
            w = rng.random(k) ** rng.choice([1, 2, 4]); w /= np.linalg.norm(w)
            t = 3 * FTP(w); bd = harmonic_dual(w)
            worst_r = min(worst_r, (bd - t))
        print(f"   k={k}: min (bound - 3F) over 60 random w = {worst_r:.3e}")
        t = 3 * FTP(np.full(k, 1 / np.sqrt(k)))
        print(f"        symmetric: 3F={t:.9f}  bound={harmonic_dual(np.full(k,1/np.sqrt(k))):.9f}")

    print("\n3. relaxed C5:  Psi + 1.5 S^2 w1 - S^3/4  <=  (sqrt3/4)(S^2+2)^{3/2} ?")
    def R(w):
        w = np.abs(w); n = np.linalg.norm(w)
        if n == 0: return -1e9
        w = w / n
        S = w.sum()
        lhs = (w ** 3).sum() + harmonic_dual(w) + 1.5 * S * S * w.max() - S ** 3 / 4
        return lhs - r3 / 4 * (S * S + 2) ** 1.5
    best = (-1e9, None)
    for k in range(1, 13):
        for t in range(300):
            st = t % 5
            if st == 0: w0 = rng.random(k)
            elif st == 1: w0 = np.ones(k) + 0.05 * rng.normal(size=k)
            elif st == 2: w0 = np.concatenate([[1.0], 0.05 * rng.random(k)])[:k]
            elif st == 3: w0 = np.geomspace(1, 0.005, k) * (1 + 0.1 * rng.normal(size=k))
            else: w0 = rng.random(k) ** 4
            w0 = np.abs(w0) + 1e-9
            r = minimize(lambda z: -R(z), w0, method='Nelder-Mead',
                         options={'maxiter': 3000, 'xatol': 1e-10, 'fatol': 1e-12})
            v = R(r.x)
            if v > best[0]: best = (v, np.abs(r.x) / np.linalg.norm(r.x), k)
        print(f"   up to k={k}: max residual = {best[0]:+.6e}")
    print(f"   argmax w = {np.round(np.sort(best[1])[::-1], 6)}  (k={best[2]})")


# ---- sharpened relaxation: min of the harmonic dual and the max-partner bound ----
def psi_max_partner(w):
    """3F <= 2 sum_{a<b} w_a w_b * max_{g not in {a,b}} w_g   (vanishes for k<=2)."""
    n = len(w)
    if n < 3:
        return 0.0
    srt = np.sort(w)[::-1]
    tot = 0.0
    for a in range(n):
        for b in range(a + 1, n):
            rest = [w[g] for g in range(n) if g not in (a, b)]
            tot += w[a] * w[b] * max(rest)
    return 2.0 * tot


def R2(w):
    w = np.abs(np.asarray(w, float)); nn = np.linalg.norm(w)
    if nn == 0: return -1e9
    w = w / nn
    S = w.sum()
    psi = min(harmonic_dual(w), psi_max_partner(w))
    lhs = (w ** 3).sum() + psi + 1.5 * S * S * w.max() - S ** 3 / 4
    return lhs - r3 / 4 * (S * S + 2) ** 1.5
