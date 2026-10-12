"""Reviewer 56 -- enlarge the hyperkaehler seed toward Fox's 6-dimensional B_r,
and characterise the third branch (theta = sqrt(24/25) at r=8)."""
import numpy as np, sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
from review_r56_core import *
from review_r56_hk import hyper_triple, kahler_weyl, close_algebra, idempotents
from review_r56_d4 import full_report

for (n, r) in ((8, 8), (12, 12)):
    idx, pos, N, c = struct(n)
    I, J, K = hyper_triple(n, r)
    seed = [kahler_weyl(n, a, idx) for a in (I, J, K)]
    for (a, b) in ((I, J), (J, K), (K, I)):
        T = (np.einsum('ik,jl->ijkl', a, b) - np.einsum('il,jk->ijkl', a, b)
             + np.einsum('ik,jl->ijkl', b, a) - np.einsum('il,jk->ijkl', b, a)
             + 2 * np.einsum('ij,kl->ijkl', a, b) + 2 * np.einsum('ij,kl->ijkl', b, a))
        seed.append(weyl_project(T, idx, n))
    seed = [s / np.linalg.norm(s) for s in seed if np.linalg.norm(s) > 1e-10]
    B = close_algebra(seed, c)
    print(f"n={n} r={r}: seeded {len(seed)} generators -> closed algebra dim = {len(B)}")
    ids = idempotents(B, c, tries=900, seed=5)
    mags = sorted({round(t, 9) for _, t in ids}, reverse=True)
    print(f"   distinct theta magnitudes: {mags}")
    for W, th in sorted(ids, key=lambda t: -t[1]):
        S, leak = slack_struct(W, c)
        print(f"     theta={th:11.9f} th/th0={th/theta0(n):7.4f} S={S:11.4e} "
              f"massF={offdiag_mass(W):6.4f}")

print("\n=== the third hyperkaehler branch at r=8, n=8: what is it? ===")
idx, pos, N, c = struct(8)
I, J, K = hyper_triple(8, 8)
gens = [kahler_weyl(8, a, idx) for a in (I, J, K)]
gens = [g / np.linalg.norm(g) for g in gens]
B = close_algebra(gens, c)
ids = idempotents(B, c, tries=400, seed=11)
for W, th in sorted(ids, key=lambda t: -t[1]):
    if abs(th - 0.979795897) < 1e-6:
        ev = np.round(np.linalg.eigvalsh(W), 8)
        u, ct = np.unique(ev, return_counts=True)
        print("   spectrum:", list(zip(u, ct)))
        full_report("hyperkaehler third branch, theta=sqrt(24/25)", 8, W, idx, c,
                    frames=True, refl=True, pl=True)
        break
