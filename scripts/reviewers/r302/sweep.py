"""Sweep for critical points and test V3: Delta > 0 => lambda_max(L_e|e-perp) > 1/2.

Two families.
 (A) DIAGONAL: W diagonal in the omega basis and Ricci-free is automatically in Weyl_n
     (Bianchi holds because R_{ijkl} = 0 whenever i,j,k,l are distinct), and Q preserves
     the family.  So criticality is a small polynomial system on R^{n(n-3)/2}.
 (B) FULL Weyl_n at small n, through the precomputed trilinear tensor T_{ijk} = <b_i o b_j, b_k>.
"""
import sys, os, time, itertools
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from core import Geom
from le import build_weyl, Le_matrix, HA_span, compression
from defect import Delta
from run_h1 import log


def diag_weyl_basis(n):
    """orthonormal basis of {diagonal in omega basis, Ricci-free}"""
    g = Geom(n)
    rows = []
    for i in range(n):
        r = np.zeros(g.N)
        for a, (x, y) in enumerate(g.pairs):
            if x == i or y == i:
                r[a] = 1.0
        rows.append(r)
    A = np.array(rows)
    u, s, vt = np.linalg.svd(A)
    return g, vt[(s > 1e-9 * s[0]).sum():].T          # N x d


def diag_Q(g, lam):
    """Q of a diagonal operator, as the vector of diagonal entries."""
    n = g.n
    L = np.zeros((n, n))
    for a, (i, j) in enumerate(g.pairs):
        L[i, j] = L[j, i] = lam[a]
    M = L @ L
    out = np.empty(g.N)
    for a, (i, j) in enumerate(g.pairs):
        out[a] = lam[a] ** 2 + M[i, j] - lam[a] * (L[i, i] + L[j, j]) / 1.0 - lam[a] * lam[a] * 0
    # M[i,j] = sum_k L[i,k] L[k,j] over ALL k, so drop k = i and k = j
    for a, (i, j) in enumerate(g.pairs):
        out[a] = lam[a] ** 2 + (M[i, j] - L[i, i] * L[i, j] - L[i, j] * L[j, j])
    return out


def solve_diag(n, tries=400, seed=0):
    g, Bd = diag_weyl_basis(n)
    d = Bd.shape[1]
    rng = np.random.default_rng(seed)
    found = []
    for t in range(tries):
        x0 = rng.normal(size=d); x0 /= np.linalg.norm(x0)

        def F(x):
            lam = Bd @ x
            q = diag_Q(g, lam)
            th = float(q @ lam)
            r = Bd.T @ q - th * x
            return np.concatenate([r, [float(x @ x) - 1.0]])
        r = least_squares(F, x0, xtol=3e-16, ftol=3e-16, gtol=3e-16, max_nfev=4000)
        if np.linalg.norm(r.fun) > 1e-11:
            continue
        x = r.x
        lam = Bd @ x
        th = float(diag_Q(g, lam) @ lam)
        if th < 0:
            x, lam, th = -x, -lam, -th
        if th < 1e-8:
            continue
        found.append((th, lam))
    return g, found


def canon(g, lam, th):
    """a permutation-invariant fingerprint"""
    n = g.n
    L = np.zeros((n, n))
    for a, (i, j) in enumerate(g.pairs):
        L[i, j] = L[j, i] = lam[a]
    ev = np.sort(np.round(np.linalg.eigvalsh(L), 7))
    return (round(th, 7), tuple(ev.tolist()))


def full_tensor(g, B, sv):
    d = B.shape[1]
    ad = g.ad
    mats = [sv.mat(B[:, k]) for k in range(d)]
    ADM = np.array([ad @ m for m in mats])            # d x N x N x N
    T = np.zeros((d, d, d))
    for i in range(d):
        Sij = -0.25 * (np.einsum('aij,cbji->cab', ADM[i], ADM, optimize=True))
        for j in range(d):
            sh = Sij[j] + Sij[j].T
            circ = 0.5 * (mats[i] @ mats[j] + mats[j] @ mats[i]) + sh
            T[i, j] = B.T @ sv.vec(circ)
    return T


def solve_full(T, tries=400, seed=0):
    d = T.shape[0]
    rng = np.random.default_rng(seed)
    out = []
    for t in range(tries):
        x0 = rng.normal(size=d); x0 /= np.linalg.norm(x0)

        def F(x):
            q = np.einsum('ijk,i,j->k', T, x, x, optimize=True)
            th = float(q @ x)
            return np.concatenate([q - th * x, [float(x @ x) - 1.0]])

        def J(x):
            Lx = 2.0 * np.einsum('ijk,i->jk', T, x, optimize=True)   # d(Q)/dx, as (j,k)
            q = np.einsum('ijk,i,j->k', T, x, x, optimize=True)
            th = float(q @ x)
            Jm = Lx.T - th * np.eye(d) - 3.0 * np.outer(x, q)
            return np.vstack([Jm, 2.0 * x[None, :]])
        r = least_squares(F, x0, jac=J, xtol=3e-16, ftol=3e-16, gtol=3e-16, max_nfev=2000)
        if np.linalg.norm(r.fun) > 1e-11:
            continue
        x = r.x
        q = np.einsum('ijk,i,j->k', T, x, x, optimize=True)
        th = float(q @ x)
        if th < 0:
            x, th = -x, -th
        if th < 1e-8:
            continue
        out.append((th, x))
    return out
