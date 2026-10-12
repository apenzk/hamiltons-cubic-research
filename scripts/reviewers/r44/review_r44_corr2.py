"""Reviewer 44 -- robust corrector (scipy least_squares with analytic Jacobian)."""
import numpy as np, sys
from scipy.optimize import least_squares
sys.path.insert(0, 'scripts/lib')
from review_r44_core import *
from review_r44_corrector import circ_mat
from review_r44_padded import Le_matrix
from review_r44_branch import log

def make(n, B):
    D = B.shape[1]
    def F(c):
        c = c / np.linalg.norm(c)
        W = p_to_X(B @ c, n); QW = Qop(W, n); th = float(np.tensordot(W, QW))
        return B.T @ X_to_p(QW - th * W, n)
    def J(c):
        nc = np.linalg.norm(c); ch = c / nc
        W = p_to_X(B @ ch, n); QW = Qop(W, n); th = float(np.tensordot(W, QW))
        q = B.T @ X_to_p(QW, n)
        Jh = 2 * circ_mat(W, n, B) - 3 * np.outer(ch, q) - th * np.eye(D)
        P = (np.eye(D) - np.outer(ch, ch)) / nc
        return Jh @ P
    return F, J

def hunt(Wsmall, n0, n, label, ts=(0.05, 0.1, 0.2, 0.35, 0.5), ndir=10, seed=17):
    W0 = embed(Wsmall, n0, n) if n > n0 else Wsmall.copy(); W0 /= np.linalg.norm(W0)
    B = weyl_basis(n); c0 = B.T @ X_to_p(W0, n)
    th0 = float(np.tensordot(W0, Qop(W0, n)))
    M = Le_matrix(W0 / th0, n, B); ev, U = np.linalg.eigh(M)
    Kb = U[:, np.abs(ev - 0.5) < 1e-8]
    Ob, _ = orbit_tangent_basis(W0, n); ObB, _ = np.linalg.qr(B.T @ Ob)
    et, Ut = np.linalg.eigh(Kb @ Kb.T - ObB @ ObB.T); Tb = Ut[:, et > 0.5]
    log(f'[corr2 {label} n={n}] dimT={Tb.shape[1]} theta_0={th0:.9f}')
    rng = np.random.default_rng(seed)
    for t in ts:
        rows = []
        for _ in range(ndir):
            v = Tb @ rng.standard_normal(Tb.shape[1]); v /= np.linalg.norm(v)
            r = least_squares(make(n, B)[0], c0 + t * v, jac=make(n, B)[1],
                              method='lm', xtol=1e-15, ftol=1e-15, gtol=1e-15,
                              max_nfev=20000)
            c = r.x / np.linalg.norm(r.x)
            Wp = p_to_X(B @ c, n); QW = Qop(Wp, n)
            th = float(np.tensordot(Wp, QW))
            res = float(np.linalg.norm(B.T @ X_to_p(QW - th * Wp, n)))
            S, _ = slack_S(Wp, n)
            d = float(np.linalg.norm(Wp - W0))
            rows.append((res, S, d, th))
        rows.sort()
        good = [r for r in rows if r[0] < 1e-12]
        log(f'   t={t}: best res={rows[0][0]:.2e} (S={rows[0][1]:+.3e}, d={rows[0][2]:.4f}, '
            f'theta={rows[0][3]:.9f}); {len(good)}/{ndir} below 1e-12'
            + (f'; among those max S={max(g[1] for g in good):+.3e} at d={max(good,key=lambda g:g[1])[2]:.4f}'
               if good else ''))

if __name__ == '__main__':
    log('--- corr2: LM with analytic Jacobian ---')
    hunt(sphere_product_W((2, 2)), 4, 6, 'S2xS2->6')
    hunt(sphere_product_W((2, 2)), 4, 8, 'S2xS2->8')
    hunt(sphere_product_W((3, 3)), 6, 8, 'S3xS3->8')
