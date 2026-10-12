"""Hunt for a critical point with Delta > 0 and lambda_max(L_e|e-perp) <= 1/2.
Such a point refutes V3 outright."""
import sys, os, time
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, core, points, le
from scipy.optimize import least_squares

def make(n):
    B = core.weyl_basis(n); d = B.shape[0]; Bf = B.reshape(d, -1)
    def W_of(c):
        c = c/np.linalg.norm(c)
        return np.einsum('k,kij->ij', c, B), c
    def F(c):
        W, cn = W_of(c)
        q = Bf @ core.Q(n, W).reshape(-1)     # gradient in weyl coords
        th = float(cn @ q)
        return q - th*cn
    return B, Bf, d, W_of, F

def run(n, ntr, seed, tmax):
    B, Bf, d, W_of, F = make(n)
    rng = np.random.default_rng(seed)
    found = []
    t0 = time.time(); ok = 0
    for k in range(ntr):
        if time.time()-t0 > tmax: break
        c0 = rng.normal(size=d)
        sol = least_squares(F, c0/np.linalg.norm(c0), xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=400)
        if np.max(np.abs(sol.fun)) > 1e-10: continue
        W, c = W_of(sol.x)
        th = core.P(n, W)
        if th <= 1e-6:
            W = -W; th = core.P(n, W)
            if th <= 1e-6: continue
        ok += 1
        Lm, _, _, Bf2 = le.Lmat(n, W, th)
        Lp, Uc, w = le.restrict_perp(Lm, Bf2, W)
        lmax = np.linalg.eigvalsh(0.5*(Lp+Lp.T))[-1]
        D, tot, lam, g = points.defect(n, W)
        found.append((th, D, lmax))
        if D > 1e-6 and lmax <= 0.5 + 1e-9:
            np.save(f"scripts/reviewers/r299/REFUTER_n{n}_{th:.6f}.npy", W)
            print(f"!!! REFUTER n={n} theta={th:.9f} Delta={D:.6f} lam_max={lmax:.9f}")
    return found, ok

if __name__ == "__main__":
    n = int(sys.argv[1]); ntr = int(sys.argv[2]); tmax = float(sys.argv[3])
    found, ok = run(n, ntr, 20299+n, tmax)
    a = np.array(found)
    if len(a) == 0:
        print(f"n={n}: no converged critical points"); sys.exit()
    pos = a[a[:,1] > 1e-6]
    print(f"n={n}: converged={ok} theta in [{a[:,0].min():.4f},{a[:,0].max():.4f}] "
          f"Delta>0 count={len(pos)}  lam_max over Delta>0 in "
          f"[{pos[:,2].min():.6f},{pos[:,2].max():.6f}]" if len(pos) else f"n={n}: converged={ok}, no Delta>0")
    d0 = a[a[:,1] <= 1e-6]
    if len(d0):
        print(f"   Delta=0 points: {len(d0)}, lam_max in [{d0[:,2].min():.6f},{d0[:,2].max():.6f}], "
              f"# with lam_max<=1/2: {(d0[:,2]<=0.5+1e-9).sum()}")
    print(f"   min lam_max over Delta>0 = {pos[:,2].min():.9f}" if len(pos) else "")
