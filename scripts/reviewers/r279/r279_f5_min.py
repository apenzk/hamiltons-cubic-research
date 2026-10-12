"""r279: try to FALSIFY F_5 >= 0 on Weyl_5, i.e. find |P| > sqrt(3/2) at unit norm."""
import os, sys
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..'))
import review_r27_core as C
rng = np.random.default_rng(77279)
B = C.weyl_basis(5); D, N, _ = B.shape
Bf = B.reshape(D, -1)
def P_of(a):
    W = (a @ Bf).reshape(N, N); return C.P(5, W)
def grad(a):
    W = (a @ Bf).reshape(N, N); return 3.0*(Bf @ C.Q(5, W).reshape(-1))
best = -9.0; bestv = None
for trial in range(200):
    a = rng.standard_normal(D); a /= np.linalg.norm(a)
    step = 0.1
    cur = P_of(a)
    for it in range(6000):
        g = grad(a); g -= (g @ a)*a
        b = a + step*g/(np.linalg.norm(g)+1e-14); b /= np.linalg.norm(b)
        v = P_of(b)
        if v > cur: a, cur = b, v
        else: step *= 0.7
        if step < 1e-13: break
    if cur > best: best, bestv = cur, a.copy()
print(f"max P over 200 ascents on Weyl_5 = {best:.14f}")
print(f"sqrt(3/2)                        = {np.sqrt(1.5):.14f}")
print(f"excess (positive would REFUTE)   = {best-np.sqrt(1.5):.3e}")
W = (bestv @ Bf).reshape(N, N)
W /= np.sqrt(np.trace(W@W))
print(f"criticality residual at the top  = {np.linalg.norm(C.Q(5,W)-C.P(5,W)*W):.2e}")
ev = np.linalg.eigvalsh(W)
print("Lambda^2 spectrum at the top (x sqrt6):", np.round(ev*np.sqrt(6), 6))
