"""r275 claim 2 support: where the maximiser of F = tr(M^3)+||M#||_F actually sits.

F is n-independent at padded W_{CP^2}: padding adds only zero rows and columns to
the Lambda^2 matrix, and both tr(M^3) and ||M#||_F are computed from the same
block.  So F(padded W_CP2) = 1 + 1/sqrt6 at EVERY even n >= 4, and the ascent's
maximum is a small perturbation of it.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from r275_geo import Geo, cp_m, pad, theta0

print(f"  1 + 1/sqrt6 = {1+1/np.sqrt(6):.12f}   sqrt(3/2) = {np.sqrt(1.5):.12f}   sqrt3 = {np.sqrt(3):.12f}")
print(f"\n  {'n':>3} {'F(padded W_CP2)':>18} {'theta':>12} {'tr(M^3)':>12} {'||M#||_F':>12}"
      f" {'theta_0(n)':>12} {'F/theta_0':>10}")
g4 = Geo(4); W4 = cp_m(g4, 2)
for n in (4, 6, 8, 10, 12, 14, 16):
    g = Geo(n)
    W = g.proj_weyl(pad(g4, W4, g)) if n > 4 else W4
    W = W / np.linalg.norm(W)
    tr3 = float(np.trace(W @ W @ W)); nn = float(np.linalg.norm(g.sharp(W)))
    print(f"  {n:>3} {tr3+nn:>18.12f} {g.theta(W):>12.9f} {tr3:>12.9f} {nn:>12.9f}"
          f" {theta0(n):>12.9f} {(tr3+nn)/theta0(n):>10.6f}")
print("\n  the rank-3 configuration lambda=(2,-1,-1)/sqrt6 has tr(M^3) = 6/6^{3/2} = 1/sqrt6 =",
      f"{1/np.sqrt(6):.12f}")

print("\n  eigenvalue signature of r275's own F-maximisers (top and bottom):")
for n in (6, 8, 10, 12, 14):
    f = f"scripts/reviewers/r275/r275_bestF_n{n}.npy"
    if not os.path.exists(f):
        continue
    W = np.load(f); g = Geo(n)
    ev = np.linalg.eigvalsh(W)
    tr3 = float(np.trace(W @ W @ W)); nn = float(np.linalg.norm(g.sharp(W)))
    print(f"   n={n:>3} F={tr3+nn:.9f}  top={ev[-1]:+.6f}  next two={ev[0]:+.6f},{ev[1]:+.6f}"
          f"  (compare (2,-1,-1)/sqrt6 = {2/np.sqrt(6):+.6f},{-1/np.sqrt(6):+.6f})"
          f"  rest in [{ev[2]:+.6f},{ev[-2]:+.6f}]")
