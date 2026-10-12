"""r275 claim 1: route M's reduction chain, link by link, from the definitions.

Link (b) is the one under test:  does  M(n) <= sqrt3  give  |theta| <= M(n)/sqrt2 ?
The only derivation of the 1/sqrt2 on record is the harmonic-square law
    1/theta^2 = sum_i 1/theta_i^2   =>   |theta| <= max_i|theta_i|/sqrt(k),
which needs k >= 2 circ-orthogonal pieces, i.e. DECOMPOSABILITY -- exactly what
the sum law has already removed from the residual.

This script measures, at the residual's own sharp case (padded W_{CP^2}, n=12)
and at the balanced sphere product, the quantities the chain needs.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from r275_geo import Geo, sphere_product, cp_m, pad, theta0, L_e_spectrum

np.set_printoptions(precision=6, suppress=True)

def offdiag_mass(g, W, tries=40, seed=0):
    """frame-minimised off-diagonal Frobenius mass of W, crude: random O(n) + local descent."""
    rng = np.random.default_rng(seed)
    n = g.n
    def mass(R):
        # conjugate W by R in O(n): act on Lambda^2
        A = np.zeros((g.N, g.N))
        for a, (i, j) in enumerate(g.pairs):
            for b, (k, l) in enumerate(g.pairs):
                A[a, b] = R[i, k] * R[j, l] - R[i, l] * R[j, k]
        Wn = A @ W @ A.T
        return np.linalg.norm(Wn - np.diag(np.diag(Wn)))
    best = mass(np.eye(n))
    for _ in range(tries):
        X = rng.standard_normal((n, n)); R, _ = np.linalg.qr(X)
        step = 0.4
        cur = mass(R)
        for _ in range(120):
            Y = rng.standard_normal((n, n)); Y = (Y - Y.T) * step
            R2 = R @ (np.eye(n) + Y + Y @ Y / 2)
            R2, _ = np.linalg.qr(R2)
            v = mass(R2)
            if v < cur: R, cur = R2, v
            else: step *= 0.97
        best = min(best, cur)
    return best

n = 12
g = Geo(n)
g4 = Geo(4)
Wcp2 = cp_m(g4, 2)
Wp = pad(g4, Wcp2, g); Wp = g.proj_weyl(Wp); Wp /= np.linalg.norm(Wp)
Wsp = sphere_product(g, 6, 6)

for name, W in (("padded W_CP2 (n=12)", Wp), ("S^6 x S^6 (n=12)", Wsp)):
    th = g.theta(W); S = g.sharp(W)
    tr3 = float(np.trace(W @ W @ W)); nn = float(np.linalg.norm(S))
    res = float(np.abs(g.Q(W) - th * W).max())
    print(f"{name}:")
    print(f"   theta            = {th:.12f}   (sqrt(3/2)={np.sqrt(1.5):.12f}, theta_0={theta0(n):.12f})")
    print(f"   criticality res  = {res:.2e}")
    print(f"   tr(M^3)          = {tr3:.12f}")
    print(f"   ||M#||_F         = {nn:.12f}")
    print(f"   F = tr+||M#||    = {tr3+nn:.12f}      cos(phi) = {(th-tr3)/nn:.9f}")
    print(f"   F vs sqrt(3/2)   = {tr3+nn-np.sqrt(1.5):+.9f}     F vs theta_0 = {tr3+nn-theta0(n):+.9f}")
    ev, d = L_e_spectrum(g, W, th)
    print(f"   dim Weyl_12      = {d};  dim E(1) of L_e = {int(np.sum(np.abs(ev-1)<1e-6))}"
          f";  lambda_max = {ev.max():.9f}")
    print(f"   frame-min off-diagonal mass = {offdiag_mass(g, W):.6f}")
    print()
