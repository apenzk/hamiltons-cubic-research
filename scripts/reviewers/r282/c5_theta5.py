"""r282 claim 5: Theta_5 = sqrt(3/2) -- is F_5 = (3/2)||W||^6 - P(W)^2 an identity
on Weyl_5, and does the SOS give the bound?"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, weyl as W

print("Lovelock collapse:  <W, W^#>  vs  2 tr(W^3)   on random unit Weyl_n")
rng = np.random.default_rng(5282)
for n in (4, 5, 6, 7):
    worst = 0.0; sample = None
    for _ in range(12):
        M = W.random_weyl(n, rng)
        lhs = float(np.tensordot(W.sharp(M, n), M))
        rhs = 2.0 * float(np.trace(M @ M @ M))
        worst = max(worst, abs(lhs - rhs))
        sample = (lhs, rhs)
    print(f"  n={n}: max |<W,W^#> - 2tr(W^3)| = {worst:.3e}   (last: {sample[0]:+.9f} vs {sample[1]:+.9f})")

print("\nConsequence at n=5:  P(W) = tr(W^3) + <W,W^#> = 3 tr(W^3),  so")
print("  F_5 := (3/2)||W||^6 - 9 tr(W^3)^2  ==  (3/2)||W||^6 - P(W)^2   identically on Weyl_5")
for _ in range(4):
    M = W.random_weyl(5, rng) * rng.normal()
    t3 = float(np.trace(M @ M @ M)); p = W.P(M, 5); nn = W.norm(M)
    print(f"   |W|={nn:.6f}: 9tr^2={9*t3**2:.12f}  P^2={p**2:.12f}  diff={9*t3**2-p**2:+.2e}")

print("\nSOS => the bound:  F_5 >= 0 and |W|=1  =>  P^2 <= 3/2  =>  |P| <= sqrt(3/2).")
print("Ascent check on Weyl_5 (independent of any certificate):")
def proj(M, n):
    return W.tensor_to_op(W.project_weyl(W.op_to_tensor(M, n), n), n)
best = -9.9
for _ in range(60):
    M = W.random_weyl(5, rng)
    for _ in range(400):
        M = proj(M + 0.35 * proj(W.Q(M, 5), 5), 5); M = M / W.norm(M)
    best = max(best, W.P(M, 5))
print(f"  max P over Weyl_5 = {best:.15f}   sqrt(3/2) = {np.sqrt(1.5):.15f}   excess = {best-np.sqrt(1.5):+.2e}")
