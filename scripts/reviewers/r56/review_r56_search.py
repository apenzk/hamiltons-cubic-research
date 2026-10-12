"""Reviewer 56 -- D6: a null result needs a positive control.

Random-start solve of Q(W) = theta W on the unit sphere of Weyl_6, measuring the
structural slack and the frame-minimised off-diagonal mass at every point found.
Positive control first: a start perturbed off S^3xS^3 must return S^3xS^3.
"""
import numpy as np, sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
from review_r56_core import *
from scipy.optimize import least_squares

n = 6
idx, pos, N, c, basis = weyl_basis(n)
D = len(basis)
Bmat = np.array([b.reshape(-1) for b in basis])
print(f"n={n}, dim Weyl = {D}")

def to_W(x):
    return (x @ Bmat).reshape(N, N)

def resid(x):
    W = to_W(x)
    nq = np.linalg.norm(W)
    if nq < 1e-8:
        return np.ones(D + 1) * 10.0
    W = W / nq
    QW = Q(W, c)
    th = float(np.sum(W * QW))
    R = QW - th * W
    return np.append(Bmat @ R.reshape(-1), np.linalg.norm(x) - 1.0)

def solve(x0):
    r = least_squares(resid, x0, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=3000)
    if np.linalg.norm(r.fun) > 1e-10:
        return None
    W = to_W(r.x); W /= np.linalg.norm(W)
    th = float(np.sum(W * Q(W, c)))
    if th < 0:
        W, th = -W, -th
    return W, th

print("\n-- POSITIVE CONTROL --")
Wstar = sphere_product(n, (3, 3), idx)
x0 = np.array([np.sum(Wstar * b) for b in basis])
rng = np.random.default_rng(0)
for eps in (0.002, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2):
    xp = x0 + eps * rng.normal(size=D); xp /= np.linalg.norm(xp)
    got = solve(xp)
    if got is None:
        print(f"  eps={eps}: solver FAILED")
    else:
        W, th = got
        S, _ = slack_struct(W, c)
        d = min(np.linalg.norm(W - Wstar), np.linalg.norm(W + Wstar))
        print(f"  eps={eps}: theta={th:.9f}  S={S:.2e}  dist to S^3xS^3 = {d:.2e}")

print("\n-- 200 random starts --")
rng = np.random.default_rng(42)
pts = []
for t in range(200):
    x0r = rng.normal(size=D); x0r /= np.linalg.norm(x0r)
    got = solve(x0r)
    if got is None:
        continue
    W, th = got
    if th < 1e-6:
        continue
    S, leak = slack_struct(W, c)
    pts.append((th, S, offdiag_mass(W), W))
print(f"  converged nonzero critical points: {len(pts)}")
if pts:
    ths = np.array([p[0] for p in pts]); Ss = np.array([p[1] for p in pts])
    print(f"  theta range: [{ths.min():.6f}, {ths.max():.6f}]   theta_0(6)={theta0(6):.6f}")
    z = [p for p in pts if p[1] < 1e-8]
    print(f"  with S_structural = 0: {len(z)} of {len(pts)}")
    for th, S, mf, W in sorted(z, key=lambda p: -p[0])[:12]:
        mn = min_offdiag_over_frames(W, n, idx, tries=4, seed=1)
        print(f"     theta={th:.9f} th/th0={th/theta0(6):.4f} S={S:.1e} "
              f"massF={mf:.4f} minF={mn:.4f}")
