"""Reviewer 127, phase 3: diagonal critical points.  K hollow sym, K1=0, |K|_F^2=2.
Criticality:  K^{o2} + K^2 = lam K + D,  D = diag(diag K^2).
"""
import numpy as np

def projV(A):
    n = A.shape[0]
    A = 0.5*(A+A.T)
    g = A.sum(axis=1) - np.diag(A)
    s = g.sum()/(2*n-2)
    u = (g - s)/(n-2)
    P = A - np.add.outer(u, u)
    np.fill_diagonal(P, 0.0)
    return P

def rhs(K):
    H = K*K + K@K
    np.fill_diagonal(H, 0.0)
    return H

def lam_of(K):
    return float((rhs(K)*K).sum())/2.0

def resid(K, lam):
    return float(np.abs(rhs(K)-lam*K).max())

def iterate(K, iters=3000, tol=1e-15):
    for _ in range(iters):
        H = rhs(K)
        nH = np.linalg.norm(H)
        if nH < 1e-13: return None
        Kn = H/nH*np.sqrt(2.0)
        d = np.linalg.norm(Kn-K); K = Kn
        if d < tol: break
    return K

def report(K, tag):
    n = K.shape[0]; lam = lam_of(K)
    ev = np.sort(np.linalg.eigvalsh(K))[::-1]
    t = float((K*K).sum())
    pos = ev[ev > 1e-8]; neg = ev[ev < -1e-8]
    inside = pos[pos < lam-1e-8]
    psd = float(np.linalg.eigvalsh(K@K - lam*K).min())
    print(f"{tag:20s} n={n:2d} lam={lam:.6f} t={t:.6f} res={resid(K,lam):.1e} "
          f"r={len(pos)} s={len(neg)} minEig(K2-lamK)={psd:+.2e} in(0,lam)={len(inside)} pmax={ev[0]:.6f}")
    return lam, ev

if __name__ == "__main__":
    rng = np.random.default_rng(127)
    for n in range(4, 13):
        seen = {}
        for trial in range(120):
            A = rng.normal(size=(n,n)); A = A+A.T
            K = projV(A); nk = np.linalg.norm(K)
            if nk < 1e-9: continue
            K = iterate(K/nk*np.sqrt(2.0))
            if K is None: continue
            lam = lam_of(K)
            if resid(K, lam) > 1e-7: continue
            key = round(lam, 6)
            seen.setdefault(key, K.copy())
        for key in sorted(seen, reverse=True)[:6]:
            report(seen[key], "attractor")
        print("-")
