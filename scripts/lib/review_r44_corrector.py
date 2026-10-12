"""Reviewer 44 -- is there a critical point with S > 0 near a degenerate S = 0 point?

S is gauge invariant and vanishes on the whole orbit, so a critical W' with S(W')>0 and
||W'-W_0|| small settles non-openness outright: dist(W', orbit) <= ||W'-W_0||.
Gauss-Newton with the analytic Jacobian  DF[X] = 2 W o X - 3<Q(W),X> W - theta X.
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r44_core import *
from review_r44_core import _M
from review_r44_padded import Le_matrix
from review_r44_branch import log

def circ_mat(W, n, B):
    """matrix of X -> W o X in the orthonormal Weyl basis B."""
    D = B.shape[1]; L = liftL(n); Nn = n * n
    Me = _M((L @ W) @ L.T, n)
    out = np.empty((D, D))
    for j in range(D):
        X = p_to_X(B[:, j], n)
        MX = _M((L @ X) @ L.T, n)
        G = MX @ Me.T; G = G + G.T
        G4 = G.reshape(n, n, n, n)
        S4 = 0.5 * (G4.transpose(0, 2, 1, 3) - G4.transpose(0, 2, 3, 1))
        Z = 0.5 * (W @ X + X @ W) + 0.25 * (L.T @ S4.reshape(Nn, Nn)) @ L
        out[:, j] = B.T @ X_to_p(Z, n)
    return 0.5 * (out + out.T)

def newton(c, n, B, iters=40):
    for _ in range(iters):
        c = c / np.linalg.norm(c)
        W = p_to_X(B @ c, n); QW = Qop(W, n)
        th = float(np.tensordot(W, QW))
        F = B.T @ X_to_p(QW - th * W, n)
        if np.linalg.norm(F) < 1e-14:
            break
        ML = circ_mat(W, n, B)
        q = B.T @ X_to_p(QW, n)
        J = 2 * ML - 3 * np.outer(W_ := c, q) - th * np.eye(len(c))
        J = 2 * ML - 3 * np.outer(c, q) - th * np.eye(len(c))
        d, *_ = np.linalg.lstsq(J, -F, rcond=1e-10)
        d = d - c * float(c @ d)
        for damp in (1.0, 0.5, 0.25, 0.1):
            cn = c + damp * d; cn /= np.linalg.norm(cn)
            Wn = p_to_X(B @ cn, n); Qn = Qop(Wn, n)
            thn = float(np.tensordot(Wn, Qn))
            Fn = B.T @ X_to_p(Qn - thn * Wn, n)
            if np.linalg.norm(Fn) < np.linalg.norm(F):
                c = cn; break
        else:
            break
    c = c / np.linalg.norm(c)
    W = p_to_X(B @ c, n); QW = Qop(W, n); th = float(np.tensordot(W, QW))
    return c, float(np.linalg.norm(B.T @ X_to_p(QW - th * W, n))), th, W

def hunt(Wsmall, n0, n, label, ts=(0.06, 0.12, 0.25, 0.4), ndir=12, seed=5):
    W0 = embed(Wsmall, n0, n) if n > n0 else Wsmall.copy()
    W0 = W0 / np.linalg.norm(W0)
    B = weyl_basis(n)
    c0 = B.T @ X_to_p(W0, n)
    th0 = float(np.tensordot(W0, Qop(W0, n)))
    M = Le_matrix(W0 / th0, n, B)
    ev, U = np.linalg.eigh(M)
    Kb = U[:, np.abs(ev - 0.5) < 1e-8]
    Ob, _ = orbit_tangent_basis(W0, n)
    ObB, _ = np.linalg.qr(B.T @ Ob)
    et, Ut = np.linalg.eigh(Kb @ Kb.T - ObB @ ObB.T)
    Tb = Ut[:, et > 0.5]; d = Tb.shape[1]
    log(f'[corrector {label} n={n}] dimWeyl={B.shape[1]} dimT={d} theta_0={th0:.9f}')
    rng = np.random.default_rng(seed)
    allf = []
    for t in ts:
        rows = []
        for _ in range(ndir):
            v = Tb @ rng.standard_normal(d); v /= np.linalg.norm(v)
            c, res, th, Wp = newton(c0 + t * v, n, B)
            S, _ = slack_S(Wp, n)
            rows.append((res, S, float(np.linalg.norm(Wp - W0)), th))
        ok = [r for r in rows if r[0] < 1e-11]
        allf += ok
        if ok:
            b = max(ok, key=lambda r: r[1])
            log(f'   t={t}: {len(ok)}/{ndir} converged; max S = {b[1]:+.3e} at '
                f'||W-W0||={b[2]:.4f}, theta={b[3]:.9f}; min ||W-W0|| among them = '
                f'{min(r[2] for r in ok):.4f}')
        else:
            log(f'   t={t}: 0/{ndir} converged below 1e-11')
    near = [r for r in allf if r[2] < 0.5]
    if near:
        log(f'   max S over all converged critical points within 0.5 of W_0: '
            f'{max(r[1] for r in near):+.3e}')

if __name__ == '__main__':
    log('--- corrector hunt (Gauss-Newton, analytic Jacobian) ---')
    hunt(sphere_product_W((2, 2)), 4, 6, 'S2xS2')
    hunt(sphere_product_W((3, 3)), 6, 6, 'S3xS3-native')
    hunt(sphere_product_W((3, 3)), 6, 8, 'S3xS3->8')
    hunt(sphere_product_W((2, 2)), 4, 8, 'S2xS2->8')
