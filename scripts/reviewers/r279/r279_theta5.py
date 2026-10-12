"""r279 claim 3: does F_5 >= 0 give Theta_5 = sqrt(3/2)?"""
import os, sys, json
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..'))
import review_r27_core as C
rng = np.random.default_rng(2790)

print("=== Lovelock: is <W,W#> = 2 tr(W^3) on Weyl_n? ===")
for n in (4, 5, 6, 7):
    B = C.weyl_basis(n)
    worst = 0.0
    for _ in range(6):
        a = rng.standard_normal(B.shape[0]); W = np.einsum('i,ijk->jk', a, B)
        W /= np.sqrt(np.trace(W@W))
        lhs = float(np.trace(W @ C.sharp(n, W))); rhs = 2*float(np.trace(W@W@W))
        worst = max(worst, abs(lhs-rhs)/max(1e-30, abs(rhs)))
    print(f"  n={n}: dim={B.shape[0]}, max rel |<W,W#>-2tr(W^3)| = {worst:.3e}")

print()
print("=== so at n=5, is P(W) = 3 tr(W^3) and F_5 = (3/2)||W||^6 - P(W)^2 ? ===")
n = 5; B = C.weyl_basis(5)
for _ in range(4):
    a = rng.standard_normal(B.shape[0]); W = np.einsum('i,ijk->jk', a, B)
    nrm2 = float(np.trace(W@W))
    P = C.P(5, W); t3 = float(np.trace(W@W@W))
    F5 = 1.5*nrm2**3 - 9*t3**2
    print(f"  ||W||^2={nrm2:8.4f}  P={P: .6f}  3tr(W^3)={3*t3: .6f}  "
          f"F5={F5: .6e}  (3/2)||W||^6-P^2={1.5*nrm2**3-P**2: .6e}")

print()
print("=== max P on the unit sphere of Weyl_5, by projected ascent ===")
D = B.shape[0]
Bf = B.reshape(D, -1)
best = -9
for trial in range(40):
    a = rng.standard_normal(D); a /= np.linalg.norm(a)
    for it in range(4000):
        W = (a @ Bf).reshape(B.shape[1], B.shape[2])
        g = 3.0 * (Bf @ C.Q(5, W).reshape(-1))     # grad of P in coords
        g -= (g @ a) * a
        a = a + 0.02*g/(np.linalg.norm(g)+1e-12); a /= np.linalg.norm(a)
    W = (a @ Bf).reshape(B.shape[1], B.shape[2])
    best = max(best, C.P(5, W))
print(f"  best P over 40 ascents = {best:.12f}   sqrt(3/2) = {np.sqrt(1.5):.12f}")
print(f"  min F5 over those = {1.5 - best**2:.3e}")

print()
print("=== the certificate file ===")
p = os.path.join('scripts', 'runs', 'n5_certificate.json')
print("  exists:", os.path.exists(p), os.path.getsize(p) if os.path.exists(p) else '')
