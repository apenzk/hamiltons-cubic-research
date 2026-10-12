"""Reviewer 49 P6b: are there critical points in the NON-coordinate annihilator?

The block-sum law's real hypothesis is X o Y = 0 with X, Y both critical.  Coordinate
disjointness is one way to get it; phase P6 showed the annihilator ker(L_X) is far
bigger than the coordinate picture predicts.  This hunts critical Y inside ker(L_X)
at n = 8 with X = the padded W_CP2 on {0,1,2,3}, and classifies whatever it finds.
"""
import sys
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, 'scripts/lib')
import review_r49_core as C

n = 8
B = C.weyl_basis(n)
d = B.shape[0]
X = C.embed(C.fox_cp2(4), 4, n, (0, 1, 2, 3))
print(f"X = padded W_CP2, n={n}, dim Weyl = {d}, theta_X = {C.Pval(n, X):.9f}", flush=True)

# sanity: a random element of ker L_X really is Q-additive with X
M = np.array([np.einsum('kij,ij->k', B, C.circ(n, X, E)) for E in B]).T
u, s, vt = np.linalg.svd(M)
tol = max(M.shape) * s[0] * 1e-12
K = vt[(s <= tol).sum() * 0:][int((s > tol).sum()):]   # kernel rows in Weyl coordinates
print(f"dim ker L_X = {K.shape[0]}", flush=True)
rng = np.random.default_rng(31)
y = rng.standard_normal(K.shape[0]) @ K
Y = np.einsum('k,kij->ij', y, B)
print(f"  random kernel element: |Q(X+Y)-Q(X)-Q(Y)| = "
      f"{np.abs(C.Qmap(n, X+Y)-C.Qmap(n, X)-C.Qmap(n, Y)).max():.2e}", flush=True)

# reference subspaces inside the kernel
ps, idx = C.pindex(n)
insideA = [a for a, (i, j) in enumerate(ps) if i < 4 and j < 4]
outsideA = [a for a, (i, j) in enumerate(ps) if i >= 4]


def classify(W):
    """mass inside Lambda^2{0..3}, inside Lambda^2{4..7}, and elsewhere."""
    tot = np.sum(W * W)
    mA = sum(W[a, b]**2 for a in insideA for b in insideA)
    mB = sum(W[a, b]**2 for a in outsideA for b in outsideA)
    return mA / tot, mB / tot, 1 - (mA + mB) / tot


def resid(z):
    y = z[:-1]
    th = z[-1]
    Y = np.einsum('k,kij->ij', y, B)
    r1 = np.einsum('kij,ij->k', B, C.Qmap(n, Y) - th * Y)
    r2 = M @ y                       # X o Y = 0
    r3 = np.array([np.sum(Y * Y) - 1.0])
    return np.concatenate([r1, r2, r3])


found = []
for s_ in range(120):
    z0 = np.concatenate([rng.standard_normal(d), [rng.standard_normal()]])
    z0[:-1] /= np.linalg.norm(z0[:-1])
    sol = least_squares(resid, z0, xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=400)
    if np.linalg.norm(sol.fun) > 1e-9:
        continue
    Y = np.einsum('k,kij->ij', sol.x[:-1], B)
    th = sol.x[-1]
    if abs(th) < 1e-8:
        continue
    found.append((th, classify(Y)))

print(f"\n{len(found)} converged nonzero critical points inside ker L_X out of 120 starts", flush=True)
ths = np.array([f[0] for f in found])
print("  distinct |theta| values:", flush=True)
for t in np.unique(np.round(np.abs(ths), 7)):
    sel = [f for f in found if abs(round(abs(f[0]), 7) - t) < 1e-9]
    mA = np.mean([f[1][0] for f in sel]); mB = np.mean([f[1][1] for f in sel])
    mC = np.mean([f[1][2] for f in sel])
    print(f"    |theta| = {t:.7f}  count {len(sel):3d}  mean mass  "
          f"Lambda^2(A)={mA:.4f}  Lambda^2(B)={mB:.4f}  cross={mC:.4f}", flush=True)

print("\n  sqrt(3/2) =", np.sqrt(1.5), "  theta_0(8) =", np.sqrt(2*7*6)/8, flush=True)
print("\n  a companion with mass outside both Lambda^2(A) and Lambda^2(B) would be a", flush=True)
print("  Q-additive partner that no coordinate split produces.", flush=True)
