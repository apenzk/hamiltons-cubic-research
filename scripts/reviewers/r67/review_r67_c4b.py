"""Reviewer 67 -- C4 exactness / failure ratios, and C6 non-composability."""
import numpy as np
from review_r67_core import *

rows = []
for n in [6, 8, 10, 12]:
    om = omega_tensor(n)
    for name, W in [("padded W_CP2", padded_cp2(n)), ("balanced sphere", balanced_sphere_product(n))]:
        lam, V, T = spectrum_data(W, om)
        N = len(lam)
        th = theta_from(lam, T)
        st = spectral_stats(lam)
        ba, bb, bc = bound_a(lam, n, N), bound_b(lam, n, N), bound_c(lam, n, N)
        bs = bound_swap(lam, n, N)
        rows.append((n, name, st['d'], th, ba, bb, bc, bs))

hdr = f"{'n':>3} {'point':>16} {'d':>4} {'theta':>10} | {'(a)':>12} {'a/th':>8} | {'(b)':>12} {'b/th':>8} | {'(c)':>10} {'c/th':>8} | {'swap':>10} {'sw/th':>8}"
print(hdr); print('-'*len(hdr))
for (n, name, d, th, ba, bb, bc, bs) in rows:
    print(f"{n:>3} {name:>16} {d:>4} {th:>10.6f} | {ba:>12.4f} {ba/th:>8.2f} | {bb:>12.4f} {bb/th:>8.2f} | {bc:>10.6f} {bc/th:>8.4f} | {bs:>10.4f} {bs/th:>8.2f}")

print()
print("C4(a) exactness at balanced sphere products (bound - theta):")
for (n, name, d, th, ba, bb, bc, bs) in rows:
    if 'sphere' in name:
        print(f"  n={n:>3}  theta={th:.12f}  bound(a)={ba:.12f}  diff={ba-th:.3e}")
print("C4(b) exactness at padded W_CP2 (bound - theta):")
for (n, name, d, th, ba, bb, bc, bs) in rows:
    if 'CP2' in name:
        print(f"  n={n:>3}  theta={th:.12f}  bound(b)={bb:.12f}  diff={bb-th:.3e}")
print("C4(c) exactness at ALL eight (bound - theta):")
for (n, name, d, th, ba, bb, bc, bs) in rows:
    print(f"  n={n:>3} {name:>16}  diff={bc-th:.3e}")
