"""Reviewer 49: verify that a critical companion found inside ker L_X really obeys the
harmonic-square law, even though the pair is NOT a coordinate block sum."""
import sys, time
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, 'scripts/lib')
import review_r49_core as C

n = 8
B = C.weyl_basis(n); d = B.shape[0]
X = C.fox_cp2(4)
X = C.embed(X, 4, n, (0, 1, 2, 3))
thX = C.Pval(n, X)
M = np.array([np.einsum('kij,ij->k', B, C.circ(n, X, E)) for E in B]).T
u, s, vt = np.linalg.svd(M)
rank = int((s > s[0] * 1e-10).sum())
Kc = vt[rank:]
K = np.einsum('mk,kij->mij', Kc, B)
p = K.shape[0]
T = np.zeros((d, p, p)); Bf = B.reshape(d, -1)
for i in range(p):
    for j in range(i, p):
        v = Bf @ C.circ(n, K[i], K[j]).ravel()
        T[:, i, j] = v; T[:, j, i] = v
KB = np.einsum('kij,mij->km', B, K)


def res(z):
    y, th = z[:-1], z[-1]
    return np.concatenate([np.einsum('kij,i,j->k', T, y, y) - th * (KB @ y), [y @ y - 1.0]])


def jac(z):
    y, th = z[:-1], z[-1]
    return np.vstack([np.hstack([2*np.einsum('kij,j->ki', T, y) - th*KB, (-(KB @ y))[:, None]]),
                      np.concatenate([2*y, [0.0]])[None, :]])


ps, idx = C.pindex(n)
inA = [a for a, (i, j) in enumerate(ps) if i < 4 and j < 4]
inB = [a for a, (i, j) in enumerate(ps) if i >= 4]
rng = np.random.default_rng(101)
best = None
for k in range(40):
    z0 = np.concatenate([rng.standard_normal(p), [rng.standard_normal()]])
    z0[:-1] /= np.linalg.norm(z0[:-1])
    sol = least_squares(res, z0, jac=jac, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=300)
    if np.linalg.norm(sol.fun) > 1e-10 or abs(sol.x[-1]) < 1e-6:
        continue
    Y = np.einsum('m,mij->ij', sol.x[:-1], K)
    r, th = C.crit_residual(n, Y)
    if r > 1e-10:
        continue
    tot = np.sum(Y*Y)
    mA = sum(Y[a, b]**2 for a in inA for b in inA)/tot
    mB = sum(Y[a, b]**2 for a in inB for b in inB)/tot
    cross = 1 - mA - mB
    if cross > 0.05 and (best is None or cross > best[3]):
        best = (Y, th, r, cross, mA, mB)
Y, thY, rY, cross, mA, mB = best
print(f"X = padded W_CP2, theta_X = {thX:.9f}", flush=True)
print(f"Y found in ker L_X: theta_Y = {thY:+.9f}, residual {rY:.1e}", flush=True)
print(f"  mass: Lambda^2({{0..3}}) = {mA:.4f}, Lambda^2({{4..7}}) = {mB:.4f}, "
      f"cross planes = {cross:.4f}  -> NOT a coordinate block sum with X", flush=True)
print(f"  cross term |X o Y|_max = {np.abs(C.circ(n, X, Y)).max():.2e}, "
      f"<X,Y> = {C.fro(X, Y):.2e}", flush=True)
pred = 1.0/np.sqrt(1/thX**2 + 1/thY**2)
W = C.normalize((pred/thX)*X + (pred/thY)*Y)
r, th = C.crit_residual(n, W)
print(f"  harmonic-square prediction {pred:.12f}   measured {abs(th):.12f}   "
      f"diff {abs(pred-abs(th)):.1e}   criticality residual {r:.1e}", flush=True)
print(f"  |Ricci| {np.abs(C.ricci(n, W)).max():.1e}  |Bianchi| {np.abs(C.bianchi(n, W)).max():.1e}",
      flush=True)
