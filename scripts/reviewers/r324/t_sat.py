"""Saturation rigidity: verify the derived chain, and hunt for saturating critical points."""
import numpy as np, core, points

def rowdata(W, n, v=None):
    lam, U = np.linalg.eigh(W)
    C = core.struct(n)
    Ce = np.einsum('abc,ai,bj,ck->ijk', C, U, U, U, optimize=True)
    if v is None:
        ve = np.zeros(len(lam)); ve[0] = 1.0
    else:
        ve = U.T @ v
    t = np.einsum('i,ijk->jk', ve, Ce)**2
    return lam, U, t

def summary(name, W, n):
    W = W/np.linalg.norm(W)
    cr, th = core.crit_resid(W, n)
    if th < 0:
        W = -W; cr, th = core.crit_resid(W, n)
    lam, U, t = rowdata(W, n)
    N = len(lam); lmin, lmax = lam[0], lam[-1]
    D = 0.5*float(((np.outer(lam, lam)-lmin*lmax)*t).sum())
    slack = D/abs(lmin)
    m1 = float((lam[:, None]*t).sum())
    print(f"{name:34s} n={n:2d} weyl={core.weyl_resid(W,n):.1e} crit={cr:.1e} theta={th:+.9f} "
          f"theta0={core.theta0(n):.6f} SLACK(D/|lmin|)={slack:.9f} "
          f"lmax(n-2)/(n|lmin|)={lmax*(n-2)/(n*abs(lmin)):.6f} 1stmom-(-2lmin)={m1+2*lmin:+.1e} "
          f"#eigs={len(np.unique(np.round(lam,9)))}")
    return dict(theta=th, slack=slack, crit=cr, lam=lam)
