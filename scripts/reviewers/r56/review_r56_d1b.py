"""Reviewer 56 -- D1 part 2: is 'coordinate-diagonal' frame-independent?

(1) POSITIVE CONTROL for the frame minimiser: rotate a genuinely coordinate-
    diagonal point by a random g in SO(n) and check the minimiser drives the
    off-diagonal mass back to 0.  A null result from a searcher that cannot
    find a known positive is worthless.
(2) RIGOROUS obstruction: for each eigenspace E of W, minimise ||w ^ w|| over
    unit w in E.  A coordinate-diagonal W has every eigenspace spanned by
    coordinate 2-planes, all decomposable, so a strictly positive minimum on
    ANY eigenspace proves W is coordinate-diagonal in no frame at all.
"""
import numpy as np, sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
from review_r56_core import *
from scipy.linalg import expm

def eigenspaces(W, tol=1e-8):
    ev, V = np.linalg.eigh(W)
    out, i = [], 0
    while i < len(ev):
        j = i
        while j + 1 < len(ev) and abs(ev[j + 1] - ev[i]) < tol:
            j += 1
        out.append((float(np.mean(ev[i:j + 1])), V[:, i:j + 1]))
        i = j + 1
    return out

print("=== (1) POSITIVE CONTROL: rotated coordinate-diagonal points ===")
for n, sizes in ((8, (4, 4)), (10, (5, 5))):
    idx, pos, N, c = struct(n)
    W = sphere_product(n, sizes, idx)
    rng = np.random.default_rng(7)
    A = rng.normal(size=(n, n)); A = 0.7 * (A - A.T)
    g = expm(A)
    R = rho(g, idx)
    Wr = R @ W @ R.T
    print(f"  n={n} S^{sizes[0]}xS^{sizes[1]} rotated: massF before search = {offdiag_mass(Wr):.4f}"
          f"   after search = {min_offdiag_over_frames(Wr, n, idx, tries=8, seed=1):.2e}")

print()
print("=== (2) eigenspace decomposability (Pluecker) ===")
idx8, _, _, c8 = struct(8)
idx10, _, _, c10 = struct(10)
idx12, _, _, c12 = struct(12)
cases = [("CP^4 (n=8)", 8, idx8, cpm(8, idx8)),
         ("CP^5 (n=10)", 10, idx10, cpm(10, idx10)),
         ("padded W_CP2 -> 10", 10, idx10, w_cp2_padded(10, idx10)),
         ("S^5xS^5 (control)", 10, idx10, sphere_product(10, (5, 5), idx10))]
for label, n, idx, W in cases:
    W = W / np.linalg.norm(W)
    es = eigenspaces(W)
    print(f"  {label}: eigenvalues/multiplicities " +
          ", ".join(f"{v:+.5f}x{E.shape[1]}" for v, E in es))
    for v, E in es:
        if E.shape[1] > 6:      # big eigenspaces: skip, the small ones decide
            continue
        pm = plucker_min(E, idx, n, tries=25, seed=3)
        print(f"      lambda={v:+.6f} mult={E.shape[1]:2d}  min||w^w|| = {pm:.3e}"
              f"   {'DECOMPOSABLE element exists' if pm < 1e-6 else 'NO decomposable element -> obstruction'}")
