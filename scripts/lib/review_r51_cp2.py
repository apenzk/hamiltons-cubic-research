"""Padded W_CP2 and other padded points that sit ABOVE the three J4 data points."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r51_core import *
from review_r51_j3 import full_Le

def W_cp2(n, sign=+1):
    """Self-dual Weyl operator of CP^2 in dim 4, zero-padded into Lambda^2 R^n."""
    P, idx, sgn = pairs_of(n); N = len(P)
    def v(pairs_signs):
        u = np.zeros(N)
        for (i, j, s) in pairs_signs:
            u[idx[i, j]] += s * sgn0(i, j)
        return u / np.linalg.norm(u)
    def sgn0(i, j): return 1.0 if i < j else -1.0
    w1 = v([(0,1,1.0), (2,3, sign*1.0)])
    w2 = v([(0,2,1.0), (3,1, sign*1.0)])
    w3 = v([(0,3,1.0), (1,2, sign*1.0)])
    W = (2*np.outer(w1,w1) - np.outer(w2,w2) - np.outer(w3,w3)) / np.sqrt(6.0)
    return W

def measure(name, n, W, tol=1e-6):
    W = normalize(W)
    alt = np.abs(alt_part(n, W)).max(); ric = np.abs(ricci_of(n, W)).max()
    th, L, B, asym, leak = full_Le(n, W, verbose=False)
    res = np.abs(Qop(n, W) - th*W).max()
    ev = np.linalg.eigvalsh(L)
    orb = onb_rows(orbit_tangent(n, W)).shape[0]
    half = int(np.sum(np.abs(ev - 0.5) < tol))
    rest = np.sort(np.abs(ev - 0.5))
    gap = rest[half] if half < len(rest) else np.nan
    print(f"{name:>22} n={n:2d} theta={th:.9f} th/th0={th/theta0(n):.4f} "
          f"|Alt|={alt:.0e} |Ric|={ric:.0e} crit={res:.0e} orbit={orb:4d} dimE={half:4d} "
          f"excess={half-orb:4d} gap={gap:.3e} {'NONDEG' if half==orb else 'DEGENERATE'}", flush=True)
    return th/theta0(n), half-orb

if __name__ == "__main__":
    print("== W_CP2 padded ==")
    for n in (4, 5, 6, 8, 10, 12, 14):
        measure("W_CP2 pad", n, W_cp2(n))

# NOTE: the two-block eigenvalue rule in sphere_product_W (1/(p(p-1)) within,
# -1/(pq) across) is Ricci-flat only for TWO blocks.  A three-block attempt gave
# |Ric| = 0.4 and criticality residual 0.07, so three-block products are outside
# what this reviewer tested.
