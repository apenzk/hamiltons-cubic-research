import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, core, points


def Lmat(n, W, theta=None):
    """L_e in weyl_basis coordinates."""
    B = core.weyl_basis(n)
    d = B.shape[0]
    if theta is None:
        theta = core.P(n, W)
    Bf = B.reshape(d, -1)
    cols = np.empty((d, d))
    for k in range(d):
        img = core.circ(n, W, B[k]) / theta
        cols[:, k] = Bf @ img.reshape(-1)
    return cols, theta, B, Bf


def restrict_perp(Lm, Bf, W):
    d = Lm.shape[0]
    w = Bf @ W.reshape(-1)
    w = w / np.linalg.norm(w)
    # orthonormal basis of w^perp
    u, s, vt = np.linalg.svd(np.eye(d) - np.outer(w, w))
    Uc = u[:, s > 1e-8]
    return Uc.T @ Lm @ Uc, Uc, w


if __name__ == "__main__":
    for nm, W, n in [("S^3xS^5",) + points.sphere_product([3, 5]),
                     ("CP^4",) + points.cpm(4),
                     ("C5blowup",) + points.c5_blowup(),
                     ("S^5xS^5",) + points.sphere_product([5, 5])]:
        Lm, th, B, Bf = Lmat(n, W)
        sym_err = np.abs(Lm - Lm.T).max()
        Lp, Uc, w = restrict_perp(Lm, Bf, W)
        ev = np.linalg.eigvalsh(0.5 * (Lp + Lp.T))
        print(f"{nm:10s} d={Lm.shape[0]} theta={th:.9f} symerr={sym_err:.1e} "
              f"tr(L)={np.trace(Lm):+.12f} tr(L|perp)={np.trace(Lp):+.12f} "
              f"lam_max|perp={ev[-1]:.9f}  top5={np.round(ev[-5:],6)}")
