"""r276 Claim 4: post 34's exact excess formula at the balanced sphere product."""
import sys; sys.path.insert(0, 'scripts/reviewers/r276')
import numpy as np
from r276_core import Geom, theta0, sphere_product

print(f"{'n':>3} {'m':>2} {'tr3':>12} {'tr3_cf':>12} {'<M#,M>':>12} {'b_cf':>12} {'|M#|_F':>12} {'a_cf':>12} {'a_adform':>12}")
for n in (6, 8, 10, 12, 14, 16):
    m = n // 2; g = Geom(n); W = sphere_product(g); S = g.sharp(W)
    tr3 = float(np.trace(W@W@W)); b = float(np.sum(S*W)); a = float(np.linalg.norm(S))
    r = np.sqrt((m-1)*(2*m-1)); u = m*(2*m-3); E = (2*m-1)*(m*(2*m-3)**2 + m - 1)
    print(f"{n:>3} {m:>2} {tr3:12.8f} {1/(m*r):12.8f} {b:12.8f} {(2*m-3)/r:12.8f} "
          f"{a:12.8f} {np.sqrt(u*u+m*m-m)/(m*r):12.8f} {np.sqrt(m*E)/(np.sqrt(m*(m-1))*(2*m-1)):12.8f}")

print()
print(f"{'n':>3} {'F-theta0 ABS':>16} {'F/theta0-1 REL':>16} {'post34 formula':>16} {'1/(2n^2)':>12} {'sqrt2/(2n^2)':>13}")
for n in (6, 8, 10, 12, 14, 16, 40, 100, 1000):
    m = n // 2
    r = np.sqrt((m-1)*(2*m-1)); u = m*(2*m-3)
    tr3 = 1/(m*r); a = np.sqrt(u*u+m*m-m)/(m*r); t0 = theta0(n)
    f = m/((2*m-1)*(u+np.sqrt(u*u+m*m-m)))
    print(f"{n:>3} {tr3+a-t0:16.10f} {(tr3+a)/t0-1:16.10f} {f:16.10f} {1/(2*n*n):12.10f} {np.sqrt(2)/(2*n*n):13.10f}")
