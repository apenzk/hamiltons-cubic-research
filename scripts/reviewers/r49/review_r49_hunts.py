"""Reviewer 49: two Levenberg-Marquardt hunts, with the trilinear tensor precomputed
so the Jacobian is analytic (Q'(Y) = 2 L_Y).

  (A) n = 6: critical points with Q(W) = 0, i.e. theta = 0, the stratum where B3's
      strict inequality degenerates.
  (B) n = 8: critical Y inside ker(L_X) for X = the padded W_CP2, i.e. Q-additive
      companions of X that are themselves critical.  Coordinate splits predict only
      the Lambda^- twin on {0,1,2,3} (5 dims) and Weyl_4 on {4..7} (10 dims); the
      kernel is 155-dimensional.
"""
import sys, time
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, 'scripts/lib')
import review_r49_core as C


def trilinear(n, Rows, Cols):
    """T[k,i,j] = <Rows_k, Cols_i o Cols_j>."""
    m = len(Cols)
    T = np.zeros((len(Rows), m, m))
    Rf = Rows.reshape(len(Rows), -1)
    for i in range(m):
        for j in range(i, m):
            v = Rf @ C.circ(n, Cols[i], Cols[j]).ravel()
            T[:, i, j] = v
            T[:, j, i] = v
    return T


def solve(T, npar, seed, extra=None):
    rng = np.random.default_rng(seed)
    def res(z):
        y, th = z[:-1], z[-1]
        r = T @ y @ y - th * (extra @ y if extra is not None else 0)
        return r, y, th
    return rng


# ---------------- (A) theta = 0 at n = 6 ----------------
t0 = time.time()
n = 6
B = C.weyl_basis(n); d = B.shape[0]
T = trilinear(n, B, B)                       # Q(y)_k = T[k,i,j] y_i y_j
print(f"(A) n=6, dim Weyl = {d}, trilinear tensor built [{time.time()-t0:.0f}s]", flush=True)


def resA(y):
    return np.concatenate([np.einsum('kij,i,j->k', T, y, y), [y @ y - 1.0]])


def jacA(y):
    return np.vstack([2 * np.einsum('kij,j->ki', T, y), 2 * y[None, :]])


rng = np.random.default_rng(11)
solsA = []
for s in range(300):
    sol = least_squares(resA, rng.standard_normal(d), jac=jacA,
                        xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=300)
    if np.linalg.norm(sol.fun) < 1e-11:
        solsA.append(sol.x)
print(f"    {len(solsA)}/300 starts converged to Q(W)=0, |W|=1  [{time.time()-t0:.0f}s]", flush=True)
if solsA:
    W0 = np.einsum('k,kij->ij', solsA[0], B)
    print(f"    |Q(W0)|_max = {np.abs(C.Qmap(n, W0)).max():.2e}, theta = {C.Pval(n, W0):.2e}", flush=True)
    m = 12
    WA = C.embed(W0, 6, m, tuple(range(6)))
    WB = C.embed(W0, 6, m, tuple(range(6, 12)))
    worst = 0.0
    for a in np.linspace(0, 1, 21):
        W = C.normalize(a * WA + np.sqrt(1 - a * a) * WB)
        r, t = C.crit_residual(m, W)
        worst = max(worst, r)
    print(f"    two copies on disjoint 6-blocks of R^12: max criticality residual over the "
          f"entire unit circle = {worst:.2e}, theta == 0 throughout", flush=True)
    print("    => on the theta_i = 0 stratum theta = min_i theta_i, so B3's STRICT clause fails.",
          flush=True)

# ---------------- (B) critical points inside ker L_X at n = 8 ----------------
t1 = time.time()
n = 8
B = C.weyl_basis(n); d = B.shape[0]
X = C.embed(C.fox_cp2(4), 4, n, (0, 1, 2, 3))
M = np.array([np.einsum('kij,ij->k', B, C.circ(n, X, E)) for E in B]).T
u, s, vt = np.linalg.svd(M)
rank = int((s > s[0] * 1e-10).sum())
Kc = vt[rank:]                                  # (155, d) kernel coordinates
K = np.einsum('mk,kij->mij', Kc, B)             # kernel basis as operators
print(f"\n(B) n=8, dim Weyl = {d}, dim ker L_X = {K.shape[0]}", flush=True)
TB = trilinear(n, B, K)                         # (300, 155, 155)
print(f"    trilinear tensor built [{time.time()-t1:.0f}s]", flush=True)
KB = np.einsum('kij,mij->km', B, K)             # (300,155): coordinates of K in B


def resB(z):
    y, th = z[:-1], z[-1]
    return np.concatenate([np.einsum('kij,i,j->k', TB, y, y) - th * (KB @ y), [y @ y - 1.0]])


def jacB(z):
    y, th = z[:-1], z[-1]
    Jy = 2 * np.einsum('kij,j->ki', TB, y) - th * KB
    Jt = -(KB @ y)
    top = np.hstack([Jy, Jt[:, None]])
    bot = np.concatenate([2 * y, [0.0]])[None, :]
    return np.vstack([top, bot])


ps, idx = C.pindex(n)
inA = [a for a, (i, j) in enumerate(ps) if i < 4 and j < 4]
inB = [a for a, (i, j) in enumerate(ps) if i >= 4]


def masses(W):
    tot = np.sum(W * W)
    mA = sum(W[a, b]**2 for a in inA for b in inA)
    mB = sum(W[a, b]**2 for a in inB for b in inB)
    return mA / tot, mB / tot, 1 - (mA + mB) / tot


rng = np.random.default_rng(23)
p = K.shape[0]
found = []
for sN in range(300):
    z0 = np.concatenate([rng.standard_normal(p), [rng.standard_normal()]])
    z0[:-1] /= np.linalg.norm(z0[:-1])
    sol = least_squares(resB, z0, jac=jacB, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=300)
    if np.linalg.norm(sol.fun) > 1e-10 or abs(sol.x[-1]) < 1e-7:
        continue
    Y = np.einsum('m,mij->ij', sol.x[:-1], K)
    r, th = C.crit_residual(n, Y)
    if r > 1e-9:
        continue
    found.append((abs(th), masses(Y)))
print(f"    {len(found)}/300 starts gave a nonzero critical point inside ker L_X "
      f"[{time.time()-t1:.0f}s]", flush=True)
if found:
    keys = np.unique(np.round([f[0] for f in found], 6))
    print(f"    {'|theta|':>10} {'count':>6} {'mass Lam^2(A)':>14} {'mass Lam^2(B)':>14} {'cross':>8}",
          flush=True)
    for t in keys:
        sel = [f for f in found if abs(round(f[0], 6) - t) < 1e-9]
        mA = np.mean([f[1][0] for f in sel]); mB = np.mean([f[1][1] for f in sel])
        mC = np.mean([f[1][2] for f in sel])
        print(f"    {t:10.6f} {len(sel):6d} {mA:14.4f} {mB:14.4f} {mC:8.4f}", flush=True)
print(f"    reference: sqrt(3/2) = {np.sqrt(1.5):.6f}, theta_0(8) = {np.sqrt(2*7*6)/8:.6f}, "
      f"sqrt(3)/2 = {np.sqrt(3)/2:.6f}", flush=True)
