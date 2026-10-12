"""Reviewer 61 / C6 clause 1: maximise theta over sums of two padded Weyl_4
elements on two 4-planes in general position, subject to at most two negative
eigenvalues.  C6 claims every such witness has theta <= 0."""
import numpy as np
from scipy.optimize import minimize
from scipy.linalg import expm
from review_r61_core import theta, ricci_defect, bianchi_defect, project_weyl
from review_r61_c5 import W4, dimU


def build(m, params, nplanes=2):
    """params: for each plane, 2 coefficients (third = -sum) and m(m-1)/2 rotation
    generators applied to the standard 4-frame."""
    E = np.eye(m)
    k = m*(m-1)//2
    W = np.zeros((m*(m-1)//2, m*(m-1)//2))
    off = 0
    for pl in range(nplanes):
        c1, c2 = params[off], params[off+1]
        off += 2
        g = params[off:off+k]; off += k
        A = np.zeros((m, m))
        idx = 0
        for i in range(m):
            for j in range(i+1, m):
                A[i, j] = g[idx]; A[j, i] = -g[idx]; idx += 1
        Rm = expm(A)
        fs = [Rm[:, 4*pl % m], Rm[:, (4*pl+1) % m], Rm[:, (4*pl+2) % m], Rm[:, (4*pl+3) % m]]
        # re-orthonormalise the 4-frame (columns of a rotation are already orthonormal)
        W = W + W4(fs, m, (c1, c2, -(c1+c2)))
    return W


def nparams(m, nplanes):
    return nplanes * (2 + m*(m-1)//2)


def objective(params, m, nplanes, mu=50.0):
    W = build(m, params, nplanes)
    nr = np.linalg.norm(W)
    if nr < 1e-8:
        return 10.0
    Wn = W / nr
    lam = np.linalg.eigvalsh(Wn)
    pen = np.sum(np.minimum(lam[2:], 0.0)**2)     # 3rd-most-negative onward
    return -theta(Wn, m) + mu * pen


def run(m, nplanes, starts, seed):
    rng = np.random.default_rng(seed)
    best = None
    for s in range(starts):
        x0 = rng.normal(size=nparams(m, nplanes)) * 0.6
        r = minimize(objective, x0, args=(m, nplanes), method='Nelder-Mead',
                     options={'maxiter': 6000, 'fatol': 1e-10, 'xatol': 1e-8})
        W = build(m, r.x, nplanes)
        if np.linalg.norm(W) < 1e-8:
            continue
        Wn = W/np.linalg.norm(W)
        lam = np.linalg.eigvalsh(Wn)
        nneg = int((lam < -1e-7).sum())
        if nneg > 2:
            continue
        du, _ = dimU(Wn)
        th = theta(Wn, m)
        if best is None or th > best[0]:
            best = (th, nneg, du, Wn.copy(), lam)
    return best


if __name__ == '__main__':
    for m, npl in [(6, 2), (8, 2), (8, 3), (10, 3), (12, 3)]:
        b = run(m, npl, starts=25 if m <= 8 else 15, seed=100+m+npl)
        if b is None:
            print(f"m={m} planes={npl}: no feasible (<=2 negative) point found")
            continue
        th, nneg, du, W, lam = b
        print(f"m={m} planes={npl}: best theta={th:+.6f}  #neg={nneg}  dimU={du}"
              f"  ricci={ricci_defect(W,m):.1e} bianchi={bianchi_defect(W,m):.1e}"
              f" dist(Weyl)={np.linalg.norm(W-project_weyl(W,m)):.1e}")
        print("   spectrum:", np.round(lam[np.abs(lam) > 1e-8], 6))
