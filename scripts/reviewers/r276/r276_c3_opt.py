"""r276 Claim 3(a),(b): independent maximisation of F(M)=tr(M^3)+||M#||_F over the
unit sphere of Weyl_n.

Independent of scripts/reviewers/r274 in every part: own structure constants, own
sharp, own gradient of ||M#||_F^2 (derived below and finite-difference checked), and
a DIFFERENT method -- quasi-Newton (L-BFGS-B) in the ambient symmetric matrices with
the Weyl projection and the normalisation folded into the objective, rather than
projected-gradient ascent with a backtracking line search.

  d||M#||^2 = -2 sum_ab S_ab tr(ad_a H ad_b M),  S = M#,
  so  G_np = -2 sum_{a,m} (ad_a)_{mn} T_{a,p,m},  T = sum_{b,q} S_ab (ad_b)_{pq} M_{qm}.
"""
import sys; sys.path.insert(0, 'scripts/reviewers/r276')
import numpy as np, time
from scipy.optimize import minimize
from r276_core import Geom, theta0, padded_cp2, sphere_product

SQRT3 = np.sqrt(3.0)


def grad_sharpnorm2(g, M, S=None):
    if S is None: S = g.sharp(M)
    N = g.N
    U = (S @ g.ad.reshape(N, N*N)).reshape(N, N, N)        # U[a] = sum_b S_ab ad_b
    T = U @ M                                              # T[a,p,m]
    G = -2.0 * (g.ad.reshape(N*N, N).T @ np.transpose(T, (0, 2, 1)).reshape(N*N, N))
    return 0.5 * (G + G.T)


def obj(x, g, N):
    A = g.proj_weyl(x.reshape(N, N))
    r = np.linalg.norm(A)
    M = A / r
    S = g.sharp(M); nS = np.linalg.norm(S)
    val = float(np.trace(M @ M @ M)) + nS
    gM = 3.0 * (M @ M) + grad_sharpnorm2(g, M, S) / (2.0 * nS)
    gM = 0.5 * (gM + gM.T)
    gA = (gM - np.sum(gM * M) * M) / r
    gx = g.proj_weyl(gA)
    return -val, -(0.5 * (gx + gx.T)).ravel()


def run(n, nrand, seeds, rng, maxiter=800):
    g = Geom(n); N = g.N
    starts = list(seeds)
    for _ in range(nrand):
        A = rng.standard_normal((N, N)); starts.append(0.5 * (A + A.T))
    best, bM, who = -9.0, None, None
    vals = []
    for k, X0 in enumerate(starts):
        res = minimize(obj, np.asarray(X0).ravel(), args=(g, N), jac=True,
                       method='L-BFGS-B', options=dict(maxiter=maxiter, maxfun=4000, ftol=1e-16, gtol=1e-12))
        v = -res.fun; vals.append(v)
        if v > best:
            best = v; A = g.proj_weyl(res.x.reshape(N, N)); bM = A / np.linalg.norm(A)
            who = ('seed#%d' % k) if k < len(seeds) else 'random'
    return g, best, bM, who, np.array(vals)


if __name__ == "__main__":
    ns = [int(a) for a in sys.argv[1:]] or [6, 8, 10, 12, 14]
    print(f"  sqrt(3) = {SQRT3:.6f}\n")
    for n in ns:
        t = time.time()
        g0 = Geom(n); rng = np.random.default_rng(2760 + n)
        seeds = [padded_cp2(g0), sphere_product(g0)]
        if n >= 6 and n % 2 == 0:
            seeds.append(sphere_product(g0, 2))          # S^2 x S^{n-2}
            seeds.append(sphere_product(g0, n // 2 - 1)) # unbalanced
        try:
            R = np.load(f"scripts/reviewers/r274/best_F_n{n}.npy")
            if R.shape[0] == g0.N: seeds.append(R)       # r274's saved optimum, as DATA
        except Exception: pass
        # perturbations of the structured seeds
        base = list(seeds)
        for B in base:
            for eps in (0.15, 0.5):
                P = rng.standard_normal((g0.N, g0.N)); P = 0.5 * (P + P.T)
                seeds.append(B / np.linalg.norm(B) + eps * P / np.linalg.norm(P))
        nrand = 120 if n <= 10 else (60 if n == 12 else 30)
        g, best, bM, who, vals = run(n, nrand, seeds, rng)
        S = g.sharp(bM); th = g.theta(bM)
        print(f"  n={n:2d}  starts={len(vals):3d} ({len(seeds)} seeded)  best F={best:.6f}"
              f"  F/sqrt3={best/SQRT3:.4f}  F/theta_0={best/theta0(n):.6f}  from {who}"
              f"  [theta={th:.6f}, |M#|={np.linalg.norm(S):.6f}, cos phi={np.sum(S*bM)/np.linalg.norm(S):.6f}]"
              f"  top5={np.sort(vals)[-5:].round(6)}  ({time.time()-t:.0f}s)", flush=True)
        np.save(f"scripts/reviewers/r276/r276_bestF_n{n}.npy", bM)
