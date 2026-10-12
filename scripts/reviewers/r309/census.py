import sys, os, numpy as np
sys.path.insert(0, os.path.dirname(__file__))
import core
from scipy.optimize import least_squares

def coords(n):
    B = core.diag_locus_basis(n)
    return B

def build(x, B):
    M = np.zeros(B[0].shape)
    for c, X in zip(x, B): M = M + c * X
    return M

def theta_of(M):
    return 0.5 * (np.sum(M ** 3) + np.trace(M @ M @ M))

def resid(x, B):
    M = build(x, B)
    th = theta_of(M)
    Phi = M * M + M @ M
    r = [np.tensordot(X, Phi) - th * np.tensordot(X, M) for X in B]
    r.append(np.dot(x, x) - 2.0)
    return np.array(r)

def find(n, tries=400, seed=0):
    B = coords(n); k = len(B); rng = np.random.default_rng(seed)
    out = []
    for t in range(tries):
        x0 = rng.normal(size=k); x0 *= np.sqrt(2) / np.linalg.norm(x0)
        s = least_squares(resid, x0, args=(B,), xtol=1e-14, ftol=1e-14, gtol=1e-14)
        if np.max(np.abs(s.fun)) > 1e-11: continue
        M = build(s.x, B)
        out.append(M)
    return out

def defect_diag(M, tol=1e-9):
    n = M.shape[0]; s = (M ** 2).sum(1); tot = 0.0
    for a in range(n):
        for b in range(a + 1, n):
            if M[a, b] > tol:
                d = M[a] - M[b]
                g = 2 * (np.dot(d, d) - 2 * M[a, b] ** 2)
                tot += g
    return tot

def canon(M, prec=6):
    ev = np.round(np.sort(np.linalg.eigvalsh(M)), prec)
    en = np.round(np.sort(M[np.triu_indices(M.shape[0], 1)]), prec)
    return (tuple(ev), tuple(en))
