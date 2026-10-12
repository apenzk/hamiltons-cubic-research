"""r281 Claim 5: Theta_5 = sqrt(3/2) via F_5 = (3/2)||W||^6 - P(W)^2 on Weyl_5."""
import sys, os
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', '..'))
from review_r30_core import weyl_basis, Q, P, sharp
rng = np.random.default_rng(5281)

def rand_weyl(n, scale=1.0):
    B = weyl_basis(n)
    c = rng.normal(size=B.shape[0]) * scale
    return np.einsum('k,kij->ij', c, B)

print("=== Lovelock collapse: is P(W) = 3 tr(W^3) on Weyl_n? ===")
for n in (4, 5, 6, 7):
    worst = 0.0
    for _ in range(6):
        W = rand_weyl(n, scale=rng.uniform(0.3, 2.0))
        p = P(n, W); t = 3.0*np.trace(W @ W @ W)
        worst = max(worst, abs(p - t)/max(abs(p), 1e-30))
    # also <W^#,W> vs 2 tr(W^3)
    W = rand_weyl(n)
    sh = float(np.tensordot(sharp(n, W), W)); tr3 = float(np.trace(W@W@W))
    print(f"  n={n}: max rel |P - 3tr(W^3)| = {worst:.3e}   <W^#,W>={sh:+.9f}  2tr(W^3)={2*tr3:+.9f}")

print()
print("=== F_5 identity at non-unit scales (Weyl_5) ===")
for _ in range(5):
    W = rand_weyl(5, scale=rng.uniform(0.5, 2.5))
    nw2 = float(np.tensordot(W, W))
    F_a = 1.5*nw2**3 - 9.0*np.trace(W@W@W)**2
    F_b = 1.5*nw2**3 - P(5, W)**2
    print(f"  ||W||^2={nw2:8.4f}   (3/2)||W||^6-9tr(W^3)^2 = {F_a:.12e}   (3/2)||W||^6-P^2 = {F_b:.12e}"
          f"   diff {abs(F_a-F_b):.2e}   F>=0? {F_b>=0}")

print()
print("=== does F_5 >= 0 imply theta <= sqrt(3/2)?  arithmetic check ===")
print("  F_5 >= 0  <=>  P^2 <= (3/2)||W||^6  <=>  |P| <= sqrt(3/2) ||W||^3.  At ||W||=1: |theta| <= sqrt(3/2).")
print(f"  sqrt(3/2) = {np.sqrt(1.5):.15f}")

print()
print("=== the certificate file ===")
import json, pathlib
p = pathlib.Path(__file__).resolve().parents[2] / 'scripts' / 'runs' / 'n5_certificate.json'
print(f"  {p} exists: {p.exists()}", f"size={p.stat().st_size}" if p.exists() else "")
