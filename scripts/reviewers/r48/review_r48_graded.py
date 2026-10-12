"""Is a padded critical point really ungraded?  h = m^perp in so(n); graded means
[m,m] subset h  AND  [h,h] subset h (symmetric pair).  Measure both leaks."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r48_core import *

def leaks(n, W, tol=1e-9):
    c = cconst(n)
    w, V = np.linalg.eigh(W)
    m = V[:, w < -tol]
    N = W.shape[0]
    Pm = m @ m.T
    Ph = np.eye(N) - Pm
    def leak(U1, U2, Pout, same):
        tot = 0.0
        for i in range(U1.shape[1]):
            js = range(i + 1, U2.shape[1]) if same else range(U2.shape[1])
            for j in js:
                br = np.einsum('abg,a,b->g', c, U1[:, i], U2[:, j])
                tot += float(br @ Pout @ br)
        return tot
    h = V[:, np.arange(N)][:, [i for i in range(N) if w[i] >= -tol]]
    # orthonormal basis of h = m^perp
    return leak(m, m, Pm, True), leak(h, h, Pm, True), m.shape[1], h.shape[1]

FOX4 = fox_point(4)
print(f"{'point':26s} {'n':>3} {'S=|Pi_m[m,m]|^2':>16} {'|Pi_m[h,h]|^2':>15} {'dim m':>6} {'dim h':>6} {'graded?':>8}")
rows = [("Fox native", 4, fox_point(4))]
for n in (8, 12, 14):
    rows.append(("Fox padded", n, fox_point(n)))
for n in (6, 12):
    rows.append(("S^3xS^3 padded", n, pad(6, sphere_product((3, 3)), n)))
rows.append(("S^6xS^6 native", 12, sphere_product((6, 6))))
for lbl, n, W in rows:
    s1, s2, dm, dh = leaks(n, W)
    print(f"{lbl:26s} {n:3d} {s1:16.3e} {s2:15.3e} {dm:6d} {dh:6d} "
          f"{'graded' if s1<1e-16 and s2<1e-16 else 'UNGRADED':>8}", flush=True)
