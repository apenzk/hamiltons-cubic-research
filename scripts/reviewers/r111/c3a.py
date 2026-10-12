"""Claim 3, part (a): the tangent space to Crit(P) at padded W_CP2 vs its O(n) orbit."""
import numpy as np, time
from core111 import Core
import points111 as P

def hess_matrix(C, M):
    B = C.weyl_basis(); k = len(B)
    cols = [C.hess_euclid(M, h).ravel() for h in B]
    A = np.array(cols).T                      # D^2 x k
    Bm = np.array([b.ravel() for b in B]).T    # D^2 x k
    return Bm.T @ A                            # k x k, in the ON Weyl basis

def report(C, M, tag):
    n = C.n; th = C.theta(M)
    B = C.weyl_basis(); k = len(B)
    w = np.array([np.sum(M*b) for b in B])
    H = hess_matrix(C, M); H = 0.5*(H+H.T)
    # restrict to W^perp inside Weyl_n
    Pp = np.eye(k) - np.outer(w, w)/(w@w)
    ev, EV = np.linalg.eigh(Pp @ (H - 3*th*np.eye(k)) @ Pp)
    # drop the radial direction (eigenvalue of the projected operator on w is 0 by construction)
    scale = max(1.0, np.abs(H).max())
    ker = int((np.abs(ev) < 1e-7*scale).sum()) - 1   # -1 for the killed radial direction
    Ot = C.orbit_tangent(M)                    # D^2 x D
    Otb = np.array([[np.sum(b*Ot[:,g].reshape(C.D,C.D)) for g in range(C.D)] for b in B])
    orb = int(np.linalg.matrix_rank(Otb, tol=1e-8))
    # check the orbit tangent really is in the kernel
    Q_, _ = np.linalg.qr(Otb)
    resid = np.linalg.norm((H - 3*th*np.eye(k)) @ Q_[:, :orb])
    print("%-16s n=%2d theta=%.9f th/th0=%.4f  crit-res=%.1e  S=%.3e  orbit=%3d  dim ker Hess=%3d  excess=%3d  ||(H-3th)T_orb||=%.1e"
          % (tag, n, th, th/C.theta0(), C.crit_residual(M), C.slack_struct(M), orb, ker, ker-orb, resid))
    return ker, orb

C4, M4 = P.cp2_native()
report(C4, M4, "W_CP2 native")
for n in (6, 8, 10):
    t=time.time(); Cn, Mp = P.pad(C4, M4, n); report(Cn, Mp, "W_CP2 padded")
    print("    (%.1fs)"%(time.time()-t))
for n in (6, 8):
    Cn = Core(n); report(Cn, P.sphere_product(Cn, (n//2, n//2)), "S^%dxS^%d"%(n//2,n//2))
