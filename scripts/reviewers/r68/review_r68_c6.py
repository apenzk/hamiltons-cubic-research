"""r68: C6 -- the swapped bound, and whether min() circumvents non-composability.
Also: numerical support for the pair-cap proof ||ad_X||_op^2 <= 2 for unit X in so(n)."""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
import review_r68_core as R
from review_r68_bounds import bounds

print("=== C6: swapped bound  cube + h3(s^2-u) [from (b)] + (3/2)lam1 b^2 (n-2) d [from (a)] ===")
print(f"{'n':>3} {'point':8} {'theta':>11} {'(a)/th':>9} {'(b)/th':>9} {'swap/th':>9} {'swap2/th':>10} {'(c)/th':>9}")
for n in [6, 8, 10, 12]:
    C = R.struct(n)
    for name, W in [('cp2', R.padded_cp2(n)), ('sphere', R.sphere_product(n, n // 2))]:
        an = R.analyse(n, W, C)
        bd = bounds(an['lam'], n)
        th = an['theta']
        print(f"{n:>3} {name:8} {th:11.7f} {bd['a']/th:9.3f} {bd['b']/th:9.3f} "
              f"{bd['swap']/th:9.3f} {bd['swap2']/th:10.3f} {bd['c']/th:9.5f}")

print()
print("=== pair cap proof check: for unit X in so(n), lam_max(-ad_X^2) = max_{k!=l}(|a_k|+|a_l|)^2 ===")
rng = np.random.default_rng(2)
for n in [4, 5, 6, 7, 8, 9]:
    C = R.struct(n)
    N = n * (n - 1) // 2
    worst = 0.0
    for t in range(200):
        x = rng.normal(size=N); x /= np.linalg.norm(x)
        ad = np.einsum('pqr,p->qr', C, x)          # (ad_X)_{q->r}
        M = ad.T @ ad                              # = -ad_X^2, PSD
        ev = np.linalg.eigvalsh(M)
        # block normal form of X: singular values of the n x n antisymmetric matrix
        Xm = np.einsum('p,pij->ij', x, R.phi_mats(n))
        sv = np.linalg.svd(Xm, compute_uv=False)
        a = np.sort(sv)[::-1][::2]                 # each block value appears twice
        pred = (a[0] + a[1])**2 if len(a) >= 2 else a[0]**2
        worst = max(worst, ev[-1])
        assert abs(ev[-1] - pred) < 1e-8, (n, ev[-1], pred)
        assert abs(np.trace(M) - 2 * (n - 2)) < 1e-8
    print(f" n={n}: 200 random unit X -- lam_max(-ad_X^2) matches (a_1+a_2)^2 to 1e-8;"
          f" max observed {worst:.9f} <= 2; trace = 2(n-2) exact")
