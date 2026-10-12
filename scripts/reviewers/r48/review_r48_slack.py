"""B5: what the block-sum law does NOT reach -- padded critical points.
Own implementation of the structural slack S = sum_{i<j} |Pi_m [X_i,X_j]|^2 over an
orthonormal basis of m = negative eigenspace of W, brackets taken in so(n) = Lambda^2."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r48_core import *

def slack(n, W, tol=1e-9):
    c = cconst(n)
    w, V = np.linalg.eigh(W)
    m = V[:, w < -tol]
    Pm = m @ m.T
    k = m.shape[1]
    tot = 0.0
    for i in range(k):
        for j in range(i + 1, k):
            br = np.einsum('abg,a,b->g', c, m[:, i], m[:, j])
            tot += float(br @ Pm @ br)
    return tot, k

FOX4 = fox_point(4)
print(f"{'point':28s} {'n':>3} {'theta':>12} {'theta_0(n)':>11} {'ratio':>8} {'S':>10} {'dim m':>6} {'crit res':>9}")
rows = []
rows.append(("Fox (native)", 4, fox_point(4)))
for n in (8, 10, 12, 14, 16):
    rows.append((f"Fox padded", n, fox_point(n)))
for n in (6, 8, 10, 12, 14):
    rows.append((f"S^3xS^3 padded", n, pad(6, sphere_product((3, 3)), n)))
for n in (10, 12, 14, 16):
    rows.append((f"S^4xS^4 padded", n, pad(8, sphere_product((4, 4)), n)))
# block sums for contrast
def bs(nA, WA, nB, WB, n):
    thA, thB = P(nA, WA), P(nB, WB)
    th = 1 / np.sqrt(1 / thA**2 + 1 / thB**2)
    return (th / thA) * pad(nA, WA, n, 0) + (th / thB) * pad(nB, WB, n, nA)
rows.append(("Fox+Fox plateau", 8, bs(4, FOX4, 4, FOX4, 8)))
rows.append(("Fox+Fox plateau padded", 12, bs(4, FOX4, 4, FOX4, 12)))
rows.append(("Fox+S^3xS^3", 12, bs(4, FOX4, 6, sphere_product((3, 3)), 12)))
for lbl, n, W in rows:
    th = P(n, W); S, k = slack(n, W)
    res = np.linalg.norm(Q(n, W) - th * W)
    print(f"{lbl:28s} {n:3d} {th:12.9f} {theta0(n):11.6f} {th/theta0(n):8.4f} {S:10.2e} {k:6d} {res:9.1e}", flush=True)
print("\nFINDINGS line 811 asserts: 'Every ungraded S=0 point found sits low, theta/theta_0 <= 0.53")
print("measured and capped at 0.89 for n=12 by the law above'.")
