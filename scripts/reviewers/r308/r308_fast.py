"""r308: precompute the symmetric cubic tensor T_abc = <B_a, Phi(B_b,B_c)> on the
graded block-diagonal Weyl basis, then Newton-solve criticality in coordinates.

Phi(Y,Z) = 1/2 (YZ+ZY) + sharp_bilin(Y,Z);  Q(W)=Phi(W,W).  All from r308_lib,
which is anchored on the published diagonal sharp formula.
"""
import sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from scipy.optimize import least_squares
import r308_lib as L


def graded_basis(n, p):
    idx, pos, N, c = L.struct(n)
    kidx, midx = L.split_indices(n, p, idx)
    sb = L.sym_basis_blocks(N, kidx, midx)
    rows = L.weyl_constraints(n, sb, idx, pos)
    B = L.nullspace_basis(sb, rows)
    return idx, pos, N, c, kidx, midx, B


def cubic_tensor(c, B, log=None):
    C = L.ad(c)                       # C[a,g,z]
    N = C.shape[0]; d = B.shape[0]
    U = np.einsum('agz,bzd->bagd', C, B, optimize=True)      # (d,N,N,N)
    Ut = np.ascontiguousarray(U.transpose(0, 1, 3, 2)).reshape(d * N, N * N)
    Bf = B.reshape(d, N * N)
    T = np.zeros((d, d, d))
    for b in range(d):
        A1 = U[b].reshape(N, N * N)
        M = (A1 @ Ut.T).reshape(N, d, N).transpose(1, 0, 2)   # Sraw[c,a,e]
        Tsh = -0.5 * (Bf @ M.reshape(d, N * N).T)             # (a, c)
        P = np.einsum('ij,cjk->cik', B[b], B, optimize=True)  # B_b B_c
        Tsq = 0.5 * (Bf @ P.reshape(d, N * N).T
                     + Bf @ np.ascontiguousarray(P.transpose(0, 2, 1)).reshape(d, N * N).T)
        T[:, b, :] = Tsh + Tsq
        if log and b % 25 == 0:
            print(f"    T column {b}/{d}", flush=True)
    return T


def solver(T):
    d = T.shape[0]

    def resid(x):
        g = T @ x @ x if False else np.einsum('abc,b,c->a', T, x, x, optimize=True)
        th = float(g @ x)
        return np.append(g - th * x, x @ x - 1.0)

    def jac(x):
        g = np.einsum('abc,b,c->a', T, x, x, optimize=True)
        th = float(g @ x)
        H = 2.0 * np.einsum('abc,c->ab', T, x, optimize=True)
        J = H - 3.0 * np.outer(x, g) - th * np.eye(d)
        return np.vstack([J, 2.0 * x])
    return resid, jac


def hunt(n, p, nstarts=2000, seed=0, verbose=True, kick=None):
    idx, pos, N, c, kidx, midx, B = graded_basis(n, p)
    A = L.ad(c)
    T = cubic_tensor(c, B)
    resid, jac = solver(T)
    W0 = L.sphere_product_W(n, p, idx)
    x0 = np.einsum('aij,ij->a', B, W0)
    if verbose:
        print(f"n={n} pair so({p})+so({n-p})  dim graded Weyl {len(B)}  "
              f"control {np.abs(resid(x0)).max():.1e}", flush=True)
    rng = np.random.default_rng(seed)
    found = {}
    for t in range(nstarts):
        if t == 0:
            x = x0.copy()
        elif kick is not None:
            x = x0 + kick * rng.normal(size=len(x0))
        else:
            x = rng.normal(size=len(x0))
            x /= np.linalg.norm(x)
        s = least_squares(resid, x, jac=jac, xtol=3e-16, ftol=3e-16, gtol=3e-16,
                          max_nfev=300)
        if np.abs(s.fun).max() > 1e-11:
            continue
        x = s.x / np.linalg.norm(s.x)
        W = np.einsum('a,aij->ij', x, B)
        th = float(np.einsum('abc,a,b,c->', T, x, x, x))
        if th < 0:
            W, th, x = -W, -th, -x
        full = float(np.abs(L.Qop(A, W) - th * W).max())
        if full > 1e-9:
            continue
        nA2 = float(np.sum(W[np.ix_(kidx, kidx)] ** 2))
        nB2 = float(np.sum(W[np.ix_(midx, midx)] ** 2))
        lam = np.linalg.eigvalsh(W)
        ndist = len(np.unique(np.round(lam, 6)))
        npos = len(np.unique(np.round(lam[lam > 1e-9], 6)))
        key = (round(th, 6), round(nA2, 6), ndist)
        if key not in found:
            found[key] = dict(theta=th, nA2=nA2, nB2=nB2, ndist=ndist, npos=npos,
                              full=full, W=W, hits=0)
        found[key]['hits'] += 1
    return found, dict(idx=idx, kidx=kidx, midx=midx, B=B, A=A, T=T, W0=W0)
