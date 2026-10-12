"""Reviewer 67 -- C3: the refuted monotonicity, made sharper.

S_mmm = 0 says [m,m] _|_ m, S_mhh = 0 says [h,h] _|_ m i.e. h = m^perp is a
subalgebra.  Together they say exactly that (h,m) is a SYMMETRIC decomposition
of so(n) -- so the S_mhh = 0 stratum of {S = 0} is a FINITE list:
h = so(p)+so(q) (p+q=n) and h = u(k) (n=2k).  The tempting monotonicity
("theta is maximised at S_mhh = 0") therefore predicts that the maximiser of
theta over {S=0} sits on that finite list.  This script maximises theta over
each member (frame rotations inside h and inside m, plus the spectrum) and
compares with padded W_CP2's sqrt(3/2).
"""
import numpy as np, sys
from scipy.linalg import expm
from scipy.optimize import minimize
from review_r67_core import *


def symmetric_pairs(n):
    """returns [(name, hmask_projector)] for every symmetric subalgebra of so(n)."""
    P, _ = so_basis(n)
    N = len(P)
    out = []
    for p in range(1, n // 2 + 1):
        mask = np.array([1.0 if (i < p) == (j < p) else 0.0 for (i, j) in P])
        out.append((f"so({p})+so({n-p})", np.diag(mask)))
    if n % 2 == 0:
        k = n // 2
        # u(k) inside so(2k): commutant of J = sum_a phi_{2a,2a+1}
        J = np.zeros((n, n))
        for a in range(k):
            J[2 * a, 2 * a + 1] = 1.0; J[2 * a + 1, 2 * a] = -1.0
        # ad_J on Lambda^2 ; u(k) = kernel
        B = np.zeros((N, n, n))
        for kk, (i, j) in enumerate(P):
            B[kk, i, j] = 1.0; B[kk, j, i] = -1.0
        AD = np.zeros((N, N))
        for kk in range(N):
            M = J @ B[kk] - B[kk] @ J
            AD[:, kk] = np.array([M[a, b] for (a, b) in P])
        w, U = np.linalg.eigh(AD.T @ AD)
        ker = U[:, w < 1e-8]
        out.append((f"u({k})", ker @ ker.T))
    return out


def theta_max(om, Ph, n, N, iters=250, seed=0):
    """max theta over (frame inside h, frame inside m, spectrum) for the grading Ph."""
    rg = np.random.default_rng(seed)
    w, U = np.linalg.eigh(Ph)
    hcols = U[:, w > 0.5]; mcols = U[:, w <= 0.5]
    d = mcols.shape[1]
    best = -1e9; bestlam = None
    def lam_of(x):
        neg = np.abs(x[:d]) + 1e-8; pos = np.abs(x[d:]) + 1e-8
        neg = neg * (pos.sum() / neg.sum())
        l = np.concatenate([-neg, pos]); return l / np.linalg.norm(l)
    Qm = np.eye(d); Qh = np.eye(N - d)
    x = rg.standard_normal(N)
    for it in range(iters):
        sc = 0.6 * (0.5 ** (it / (iters / 6)))
        Am = rg.standard_normal((d, d)) * sc; Ah = rg.standard_normal((N - d, N - d)) * sc
        Qm2 = Qm @ expm(Am - Am.T); Qh2 = Qh @ expm(Ah - Ah.T)
        V = np.concatenate([mcols @ Qm2, hcols @ Qh2], axis=1)
        T = c_tensor(om, V) ** 2
        r = minimize(lambda z: -theta_from(lam_of(z), T), x, method='Nelder-Mead',
                     options=dict(maxfev=4000, fatol=1e-13, xatol=1e-11))
        if -r.fun > best:
            best, bestlam, Qm, Qh, x = -r.fun, lam_of(r.x), Qm2, Qh2, r.x
    return best, d, bestlam


if __name__ == "__main__":
    ns = [int(a) for a in sys.argv[1].split(',')] if len(sys.argv) > 1 else [6, 8]
    for n in ns:
        om = omega_tensor(n); P, _ = so_basis(n); N = len(P)
        print(f"--- n={n}  N={N}  sqrt(3/2)={np.sqrt(1.5):.6f}  theta0={theta0(n):.6f} ---", flush=True)
        gmax = -1e9
        for name, Ph in symmetric_pairs(n):
            # sanity: S_mhh = 0 and S_mmm = 0 for this decomposition
            w, U = np.linalg.eigh(Ph)
            V = np.concatenate([U[:, w <= 0.5], U[:, w > 0.5]], axis=1)
            d = int((w <= 0.5).sum())
            T = c_tensor(om, V) ** 2
            Smmm = T[:d, :d, :d].sum() / 6.0
            Smhh = T[:d, d:, d:].sum() / 2.0
            th, dd, lam = theta_max(om, Ph, n, N, iters=120, seed=hash((n, name)) % 10 ** 6)
            gmax = max(gmax, th)
            print(f"  h={name:14s} dim h={N-d:3d} d={d:3d}  S_mmm={Smmm:.2e} S_mhh={Smhh:.2e}"
                  f"   max theta found = {th:.6f}", flush=True)
        print(f"  => max over the whole S_mhh=0 stratum (search lower bound): {gmax:.6f}")
        print(f"     padded W_CP2 (S_mhh = {2*(n-4)} > 0) has theta = {np.sqrt(1.5):.6f}\n", flush=True)
