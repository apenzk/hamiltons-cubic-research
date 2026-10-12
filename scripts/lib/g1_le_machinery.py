"""The multiplication operator L_e at a critical point, vectorised.

At a critical point Q(W) = theta W, e = W/theta is an idempotent of the
polarization X o Y = (1/2)(Q(X+Y) - Q(X) - Q(Y)), and L_e = e o (.).  The
Hessian of P constrained to the unit sphere of the Weyl space is
6 theta (L_e - (1/2) Id), so second-order optimality reads

    lambda_max(L_e restricted to W^perp)  <=  1/2,

with equality on the orbit tangent at a nondegenerate maximizer.

The Weyl basis must be ORTHONORMAL or the eigenvalues come out in the wrong
metric -- an unnormalised Sym^2 basis once produced 0.5303 at the balanced
sphere product, where the true value is exactly 1/2.  The assertion below
guards that.
"""
import itertools

import numpy as np

from weyl import build_structure_constants
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import alt_mop

_CACHE = {}


def weyl_basis(n):
    """Orthonormal basis of {W symmetric on Lambda^2 : Ric(W) = 0, Alt(W) = 0}."""
    if n in _CACHE:
        return _CACHE[n]
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt_idx = build_alt_indices(L2)
    ij = [(a, b) for a in range(N) for b in range(a, N)]
    rows = []
    for (a, b) in ij:
        M = np.zeros((N, N))
        M[a, b] = M[b, a] = 1.0
        M /= np.linalg.norm(M)
        rows.append(np.concatenate([ricci_from_mop(L2, M).ravel(),
                                    alt_mop(M, alt_idx).ravel()]))
    A = np.array(rows).T
    U, s, Vt = np.linalg.svd(A, full_matrices=True)
    ker = Vt[int(np.sum(s > 1e-9 * s[0])):]
    B = np.zeros((ker.shape[0], N, N))
    for k, (a, b) in enumerate(ij):
        sc = 1.0 if a == b else 1.0 / np.sqrt(2.0)
        B[:, a, b] += sc * ker[:, k]
        if a != b:
            B[:, b, a] += sc * ker[:, k]
    gram = np.einsum('imn,jmn->ij', B, B)
    assert np.allclose(gram, np.eye(len(B)), atol=1e-9), "Weyl basis not orthonormal"
    _CACHE[n] = (N, c, L2, alt_idx, B)
    return _CACHE[n]


def Le_matrix(e, B, c, chunk=64):
    """L_e in the given orthonormal basis: (1/2)(eX + Xe) + e # X.

    Chunked over the basis index: the intermediate c (x) B has shape
    (D, N, N, N), which is 3.8 GB at n = 12 and kills the process.  Processing
    `chunk` basis elements at a time keeps it at a few hundred MB and leaves the
    result identical.
    """
    Se = np.einsum('amn,np->amp', c, e, optimize=True)
    D = len(B)
    M = np.empty((D, D))
    for s in range(0, D, chunk):
        Bc = B[s:s+chunk]
        SB = np.einsum('amn,knp->kamp', c, Bc, optimize=True)
        sharp = -0.25 * (np.einsum('amp,kbpm->kab', Se, SB, optimize=True)
                         + np.einsum('kamp,bpm->kab', SB, Se, optimize=True))
        prod = 0.5 * (e @ Bc + Bc @ e) + sharp
        M[:, s:s+chunk] = np.einsum('imn,kmn->ik', B, prod, optimize=True)
    return 0.5 * (M + M.T)


def lambda_max(W, n):
    """theta and lambda_max(L_e | W^perp) at a critical point W."""
    from rsharp_basis_free import Q_full
    N, c, L2, alt_idx, B = weyl_basis(n)
    W = W / np.linalg.norm(W)
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    res = float(np.linalg.norm(QW - th * W))
    M = Le_matrix(W / th, B, c)
    wv = np.einsum('kmn,mn->k', B, W)
    wv /= np.linalg.norm(wv)
    P = np.eye(len(B)) - np.outer(wv, wv)
    ev = np.sort(np.linalg.eigvalsh(P @ M @ P))
    lam = float(ev[-2]) if abs(ev[-1] - 1) < 1e-6 else float(ev[-1])
    return th, lam, res
