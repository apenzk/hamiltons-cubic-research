"""Diagonal (coordinate-2-plane) critical Weyl operators: a broad kernel-free population.
Tests post-40's bound and theta <= (n-1)|lambda_min| off the structured catalogue."""
import sys; sys.path.insert(0,'scripts/reviewers/r319')
import numpy as np, build, core
from scipy.optimize import least_squares

n = int(sys.argv[1]); ntr = int(sys.argv[2])
A = build.Arena(n); N = A.N; P = A.P
iu = np.triu_indices(n, 1)

def W_of(w):                    # w: symmetric zero-diagonal n x n
    M = np.zeros((n, n)); M[iu] = w; M = M + M.T
    return np.diag([M[i, j] for (i, j) in P]), M

def resid(w):
    W, M = W_of(w)
    nrm = np.sqrt(np.sum(W*W)); W = W/nrm; M = M/nrm
    th = A.P3(W)
    R = A.Q(W) - th*W
    return np.concatenate([np.diag(R), M.sum(axis=1), [nrm-1.0]])

rng = np.random.default_rng(31900+n)
seen = []
viol = 0
for t in range(ntr):
    w0 = rng.normal(size=len(iu[0]))
    sol = least_squares(resid, w0, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=6000)
    if np.linalg.norm(sol.fun) > 1e-11: continue
    W, M = W_of(sol.x); W = W/np.sqrt(np.sum(W*W))
    th = A.P3(W)
    if th < 1e-7: continue
    ev = np.linalg.eigvalsh(W); tol = 1e-9
    rp = int((ev > tol).sum()); rm = int((ev < -tol).sum()); z = N-rp-rm
    bd = (2.0/n)*np.sqrt(rp*N/(N-rp)) if 0 < rp < N else np.inf
    lam = (n-1)*abs(ev[0])
    key = (round(th, 8), rp, rm, z)
    if key in seen: continue
    seen.append(key)
    okb = th <= bd + 1e-9; okl = th <= lam + 1e-9
    if (not okb) and z == 0: viol += 1
    print(f"theta={th:.9f} dimE+={rp:3d} dimE-={rm:3d} ker={z:3d} | post40={bd:9.6f} {'OK ' if okb else 'FAIL'}"
          f" | (n-1)|lmin|={lam:9.6f} {'OK ' if okl else 'FAIL'} | th/lam={th/lam:.6f}", flush=True)
print(f"n={n}: {len(seen)} distinct classes; kernel-free post-40 violations: {viol}")
print("DONE")
