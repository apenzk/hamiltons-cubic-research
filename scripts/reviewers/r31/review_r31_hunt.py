"""Reviewer 31: hunt for critical points of P on the unit sphere of Weyl_n; classify."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r31_core import *
from review_r31_spec import sym_basis, build_L, orbit_tangent, all_gens


def weyl_basis(alg):
    B = sym_basis(alg.N)
    Bf = np.array([b.ravel() for b in B])
    D = len(B)
    Pw = np.zeros((D, D))
    for t, X in enumerate(B):
        Pw[:, t] = Bf @ alg.PW(X).ravel()
    w, V = np.linalg.eigh(Pw)
    k = weyl_dim(alg.n)
    U = V[:, -k:]                       # D x k
    return Bf, U                        # coords: W = (Bf.T @ (U @ c)).reshape(N,N)


class Chart:
    def __init__(self, alg):
        self.alg = alg
        self.Bf, self.U = weyl_basis(alg)
        self.k = self.U.shape[1]
        self.M = self.Bf.T @ self.U     # N^2 x k

    def mat(self, c):
        return (self.M @ c).reshape(self.alg.N, self.alg.N)

    def coef(self, W):
        return self.M.T @ W.ravel()


def ascend(alg, ch, c0, iters=4000, sigma=3.0):
    c = c0 / np.linalg.norm(c0)
    for _ in range(iters):
        W = ch.mat(c)
        v = ch.coef(alg.Q(W)) + sigma * c
        nv = np.linalg.norm(v)
        cn = v / nv
        if np.linalg.norm(cn - c) < 1e-14:
            c = cn
            break
        c = cn
    return c


def newton(alg, ch, c0, iters=200):
    c = c0 / np.linalg.norm(c0)
    k = ch.k
    for it in range(iters):
        W = ch.mat(c)
        QW = alg.Q(W)
        th = float(np.sum(QW * W))
        F = ch.coef(QW) - th * c
        if np.linalg.norm(F) < 1e-13:
            break
        # jacobian
        J = np.zeros((k, k))
        for t in range(k):
            X = ch.mat(np.eye(k)[t])
            DX = 2 * alg.circ(W, X)
            J[:, t] = ch.coef(DX) - 3 * np.sum(X * QW) * c - th * np.eye(k)[t]
        # constrain to tangent of sphere
        J = np.vstack([J, c[None, :]])
        rhs = np.concatenate([-F, [0.0]])
        d, *_ = np.linalg.lstsq(J, rhs, rcond=None)
        nd = np.linalg.norm(d)
        if nd > 0.3:
            d *= 0.3 / nd
        c = c + d
        c /= np.linalg.norm(c)
    return c


def classify(alg, W, tol=1e-7):
    W = W / np.sqrt(np.sum(W * W))
    th = float(np.sum(alg.Q(W) * W))
    if th < 0:
        W = -W; th = -th
    res = float(np.linalg.norm(alg.Q(W) - th * W))
    e = W / max(th, 1e-12)
    M, D = build_L(alg, e)
    ev = np.linalg.eigvalsh(M)
    dh = int((np.abs(ev - 0.5) < tol).sum())
    Ta = orbit_tangent(alg, W, all_gens(alg.n))
    s = np.linalg.svd(Ta, compute_uv=False)
    dorb = int((s > 1e-9 * max(s[0], 1e-300)).sum())
    top = ev[ev < 0.5 - tol].max() if (ev < 0.5 - tol).any() else -np.inf
    above = ev[(ev > 0.5 + tol) & (ev < 1 - tol)]
    return dict(theta=th, res=res, dimhalf=dh, orb=dorb, isotropy=alg.n * (alg.n - 1) // 2 - dorb,
                top_below=top, n_above_half=len(above),
                spec=np.unique(np.round(ev, 7), return_counts=True))
