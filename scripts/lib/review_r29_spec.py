"""R29 attack 6: is lambda=1/2 attained on the whole orbit tangent? is lambda=1 simple?"""
import sys
sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r29_core import Alg, weyl_basis, ip, L_matrix
from review_r29_points import so_gens, rho_of


def orbit_tangent(alg, B, W, rtol=1e-9):
    D, N, _ = B.shape
    Bf = B.reshape(D, N * N)
    cols = []
    for A in so_gens(alg.n):
        r = rho_of(alg, A)
        M = r @ W - W @ r
        cols.append(Bf @ M.reshape(N * N))
    S = np.array(cols)                       # (N, D)
    u, s, vt = np.linalg.svd(S, full_matrices=False)
    k = int((s > rtol * s[0]).sum()) if s[0] > 0 else 0
    return k, vt[:k], s


def report(alg, B, v, name, rtol=1e-9):
    D = B.shape[0]
    W = np.tensordot(v, B, axes=([0], [0]))
    QW = alg.Q(W); th = ip(W, QW); e = W / th
    Le = L_matrix(alg, B, e); Le = 0.5 * (Le + Le.T)
    lam, vecs = np.linalg.eigh(Le)
    orb, T, s = orbit_tangent(alg, B, W, rtol)
    # explicit check: e o xi = xi/2 for every orbit-tangent direction
    err = 0.0
    for row in T:
        X = np.tensordot(row, B, axes=([0], [0]))
        Y = alg.circ(e, X)
        err = max(err, np.linalg.norm(Y - 0.5 * X))
    tol = 1e-7
    m1 = int(np.sum(np.abs(lam - 1.0) < tol)); mh = int(np.sum(np.abs(lam - 0.5) < tol))
    # is the 1-eigenspace spanned by e alone?
    idx1 = np.where(np.abs(lam - 1.0) < tol)[0]
    E1 = vecs[:, idx1]
    proj_e = np.linalg.norm(E1.T @ v)
    return dict(name=name, theta=th, resid=np.linalg.norm(QW - th * W), D=D,
                orb=orb, sv_gap=(s[orb - 1] / s[0] if orb else 0, s[orb] / s[0] if orb < len(s) else 0),
                half_mult=mh, one_mult=m1, orbit_half_err=err,
                lam=lam, e_in_E1=proj_e, S2=(lam ** 2).sum(), th2S2=th * th * (lam ** 2).sum(),
                th2S3=th * th * (lam ** 3).sum(), lam2=np.sort(lam)[::-1][1], lmin=lam.min())
