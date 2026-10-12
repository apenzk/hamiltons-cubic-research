"""Reviewer 60, C3 part C: where does the dim-1 collapse ACTUALLY fail?
Sharp two-equal-block tests, and degenerate x supported on a 4-plane."""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from review_r60_core import *
from review_r60_c3 import block_x, nullspace, centraliser, collapse

rng = np.random.default_rng(6032)

print("=== A. two EQUAL-size blocks, adversarial alpha ratios (the near-miss the argument rests on) ===")
for (m, k) in [(8, 2), (12, 3), (16, 4), (8, 2)]:
    for ratio in [1.0000001, 1.001, 1.5, 2.0, 3.0, 1e3]:
        x = block_x(m, (k, k), [ratio, 1.0])
        d, _ = collapse(m, x)
        print(f"  m={m} part=({k},{k}) alpha ratio={ratio:<12g} dim(z(c) cap c^perp) = {d}")
    print()

print("=== B. DEGENERATE x: multiple of a complex structure on a 4-plane, padded ===")
for m in [6, 8, 10, 12]:
    x = np.zeros((m, m))
    x[0, 1] = 1; x[1, 0] = -1; x[2, 3] = 1; x[3, 2] = -1     # J on the first 4-plane, 0 elsewhere
    G = np.linalg.qr(rng.standard_normal((m, m)))[0]
    x = G @ x @ G.T
    d, U = collapse(m, x)
    xv = mat_to_vec(m, x); xv /= np.linalg.norm(xv)
    print(f"  m={m} rank(x)=4, x|_supp a complex structure: dim(z(c) cap c^perp) = {d}"
          f"   x inside: {np.linalg.norm(U.T @ xv):.6f}")

print("\n=== C. degenerate x with support 2r, generic alphas (NOT a complex structure) ===")
for m in [8, 10, 12]:
    for r in [1, 2, 3, 4]:
        if 2 * r > m: continue
        al = list(np.sort(rng.uniform(0.5, 3.0, r))[::-1])
        x = block_x(m, (1,) * r + (1,) * ((m // 2) - r), al + [0.0] * ((m // 2) - r))
        d, _ = collapse(m, x)
        note = " (complex structure on its 4-dim support)" if r == 2 and len(set(np.round(al,9))) == 1 else ""
        print(f"  m={m} rank(x)={2*r} alphas={np.round(al,3)}: dim = {d}{note}")

print("\n=== D. degenerate x, support 4, alphas EQUAL vs DISTINCT ===")
for m in [6, 8, 10]:
    for al in [[1.0, 1.0], [1.0, 0.7]]:
        x = block_x(m, (1, 1) + (1,) * (m // 2 - 2), al + [0.0] * (m // 2 - 2))
        d, _ = collapse(m, x)
        print(f"  m={m} rank 4, alphas={al}: dim = {d}")

print("\n=== E. degenerate x, support 6 or 8, restricted to a complex structure there ===")
for m in [8, 10, 12]:
    for s in [6, 8]:
        if s > m: continue
        p = s // 2
        x = block_x(m, (1,) * (m // 2), [1.0] * p + [0.0] * (m // 2 - p))
        d, _ = collapse(m, x)
        print(f"  m={m} rank(x)={s}, complex structure on support: dim = {d}")
