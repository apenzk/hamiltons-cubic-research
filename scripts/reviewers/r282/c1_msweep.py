"""r282 claim 1(c): is M(s) = sqrt(3/2) for 5 <= s <= 11?  Projected ascent."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, weyl as W

def proj(M, n):
    return W.tensor_to_op(W.project_weyl(W.op_to_tensor(M, n), n), n)

def ascend(n, rng, restarts=40, iters=400):
    best = -1e9; bestM = None
    for _ in range(restarts):
        M = W.random_weyl(n, rng)
        if rng.random() < 0.5:
            M = -M
        for _ in range(iters):
            G = proj(W.Q(M, n), n)
            Mn = M + 0.35 * G
            Mn = proj(Mn, n)
            Mn = Mn / W.norm(Mn)
            if W.norm(Mn - M) < 1e-13:
                M = Mn; break
            M = Mn
        v = W.P(M, n)
        if v > best:
            best, bestM = v, M
    return best, bestM

rng = np.random.default_rng(2820)
tgt = np.sqrt(1.5)
print(f"sqrt(3/2) = {tgt:.15f}   theta_0(12) = {W.theta0(12):.15f}")
for n in range(5, 13):
    b, M = ascend(n, rng, restarts=(40 if n <= 9 else 18), iters=300)
    ev = np.round(np.linalg.eigvalsh(M), 4)
    print(f"n={n:2d}  max P found = {b:.12f}   excess over sqrt(3/2) = {b-tgt:+.3e}   "
          f"theta_0={W.theta0(n):.6f}  s={W.support_dim(M,n)}")
    print(f"      spectrum: {ev}")
