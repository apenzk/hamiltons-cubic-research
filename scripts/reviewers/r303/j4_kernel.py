"""J4: is dim ker M = 1 a theorem?  And does any kernel vector give an
admissible, non-radial member of the deformation family N_ij = 2 M_ij (a_i+a_j)?"""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np
from diagcore import V_basis, theta_of, Lop, defect, crit_residual
from census2 import census, normalise
from core303 import sphere_product_M


def family(M, a):
    return 2 * M * (a[:, None] + a[None, :])


def report(n, ns=80):
    B = V_basis(n)
    _, tab = census(n, ns)
    print(f"--- n={n} ---")
    for key, (M, aa, st) in sorted(tab.items(), key=lambda kv: -kv[1][1]['theta']):
        u, s, vt = np.linalg.svd(M)
        K = vt[s < 1e-8]                       # kernel basis
        k = len(K)
        # split off the span of 1
        one = np.ones(n) / np.sqrt(n)
        best = None
        for _ in range(200):
            c = np.random.default_rng(_).normal(size=k)
            a = c @ K
            a = a - (a @ one) * one            # kill the radial part
            if np.linalg.norm(a) < 1e-9:
                continue
            a /= np.linalg.norm(a)
            N = family(M, a)
            rs = np.abs(N.sum(1)).max()
            # radial component
            rad = np.sum(N * M) / np.sum(M * M)
            resid = np.linalg.norm(N - rad * M)
            if best is None or resid > best[0]:
                best = (resid, np.linalg.norm(N), rs)
        zr = int(np.sum(np.abs(M).sum(1) < 1e-10))   # identically zero rows
        msg = 'no non-radial member' if best is None or best[0] < 1e-9 else \
              f'NON-RADIAL MEMBER |N-rad M|={best[0]:.3e}'
        print(f" th={aa['theta']:9.6f} D={aa['Delta']:8.4f} dim ker={k} zero rows={zr}"
              f"  |N|={0 if best is None else best[1]:.3e} rowsum={0 if best is None else best[2]:.1e}  {msg}")


for n in [int(x) for x in sys.argv[1:]]:
    report(n)
