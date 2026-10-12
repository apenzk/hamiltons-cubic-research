"""Reviewer 61 / C6 clause 1 (full-support variant): maximise theta over the padded-Weyl_4 construction
itself, subject to at most two negative eigenvalues.  C6 asserts every witness of
this kind has theta <= 0 'because each summand does'.  Summand thetas are
reported alongside, so the additivity claim can be checked directly."""
import numpy as np, sys
from scipy.optimize import minimize
from scipy.linalg import expm
from review_r61_core import theta, ricci_defect, bianchi_defect, project_weyl
from review_r61_c5 import W4, dimU


def frames(m, gens, nplanes):
    k = m*(m-1)//2
    fr = []
    for pl in range(nplanes):
        g = gens[pl*k:(pl+1)*k]
        A = np.zeros((m, m)); idx = 0
        for i in range(m):
            for j in range(i+1, m):
                A[i, j] = g[idx]; A[j, i] = -g[idx]; idx += 1
        R = expm(A)
        base = (4*pl) % m
        fr.append([R[:, (base+t) % m] for t in range(4)])
    return fr


def build(m, x, nplanes):
    k = m*(m-1)//2
    cs = x[:2*nplanes].reshape(nplanes, 2)
    fr = frames(m, x[2*nplanes:], nplanes)
    D = k
    W = np.zeros((D, D)); parts = []
    for pl in range(nplanes):
        c1, c2 = cs[pl]
        P = W4(fr[pl], m, (c1, c2, -(c1+c2)))
        parts.append(P); W = W + P
    return W, parts


def obj(x, m, nplanes, mu, tau=0.0):
    W, _ = build(m, x, nplanes)
    n = np.linalg.norm(W)
    if n < 1e-8:
        return 10.0
    Wn = W/n
    lam, V = np.linalg.eigh(Wn)
    pen = float(np.sum(np.minimum(lam[2:], 0.0)**2))
    from review_r61_core import vec_to_skew
    X0 = vec_to_skew(V[:, 0], m); X1 = vec_to_skew(V[:, 1], m)
    lmin = float(np.linalg.eigvalsh(X0 @ X0.T + X1 @ X1.T)[0])
    return -theta(Wn, m) + mu*pen + mu*max(0.0, tau-lmin)**2


def run(m, nplanes, starts, seed, tau=0.0):
    rng = np.random.default_rng(seed)
    npar = 2*nplanes + nplanes*(m*(m-1)//2)
    best = None
    for s in range(starts):
        x = rng.normal(size=npar)*0.7
        for mu in (10.0, 1e3, 1e5):
            r = minimize(obj, x, args=(m, nplanes, mu, tau), method='L-BFGS-B',
                         options={'maxiter': 500, 'maxfun': 200000})
            x = r.x
        W, parts = build(m, x, nplanes)
        n = np.linalg.norm(W)
        if n < 1e-8:
            continue
        Wn = W/n
        lam = np.linalg.eigvalsh(Wn)
        nneg = int((lam < -1e-7).sum())
        pen = float(np.sum(np.minimum(lam[2:], 0.0)**2))
        from review_r61_core import vec_to_skew
        lam2, V2 = np.linalg.eigh(Wn)
        X0 = vec_to_skew(V2[:, 0], m); X1 = vec_to_skew(V2[:, 1], m)
        lmin = float(np.linalg.eigvalsh(X0 @ X0.T + X1 @ X1.T)[0])
        if nneg > 2 or pen > 1e-12 or lmin < 0.9*tau:
            continue
        th = theta(Wn, m)
        du, _ = dimU(Wn)
        if best is None or th > best[0]:
            sth = [theta(P/np.linalg.norm(P), m) if np.linalg.norm(P) > 1e-8 else 0.0
                   for P in parts]
            best = (th, nneg, du, Wn.copy(), lam, sth)
    return best


if __name__ == '__main__':
    for m, npl, st, frac in [(6, 2, 30, 0.5), (6, 2, 30, 0.9), (8, 2, 30, 0.5),
                             (8, 3, 20, 0.5), (10, 3, 15, 0.5), (12, 3, 10, 0.5)]:
        tau = frac*4.0/m
        print(f"--- m={m} planes={npl} tau={tau:.4f} (ceiling {4.0/m:.4f}) ---")
        b = run(m, npl, st, seed=555+10*m+npl, tau=tau)
        if b is None:
            print(f"m={m} planes={npl}: no <=2-negative point reached")
            sys.stdout.flush(); continue
        th, nneg, du, W, lam, sth = b
        print(f"m={m} planes={npl}: MAX theta = {th:+.6f}  #neg={nneg}  dimU={du}"
              f"  ricci={ricci_defect(W,m):.1e} bianchi={bianchi_defect(W,m):.1e}"
              f" dist(Weyl)={np.linalg.norm(W-project_weyl(W,m)):.1e}")
        print(f"   per-summand thetas: {np.round(sth,6)}")
        print(f"   spectrum: {np.round(lam[np.abs(lam)>1e-8],6)}")
        sys.stdout.flush()
