import numpy as np, core, points
def rowmeasure(W, n, v):
    lam, U = np.linalg.eigh(W)
    C = core.struct(n)
    Ce = np.einsum('abc,ai,bj,ck->ijk', C, U, U, U, optimize=True)
    ve = U.T @ v
    t = np.einsum('i,ijk->jk', ve, Ce)**2
    return lam, t
def checks(name, W, n, seed=0, weylish=True):
    lam, U = np.linalg.eigh(W)
    v = U[:, 0]
    lamv, t = rowmeasure(W, n, v)
    m0 = t.sum(); m1 = float((lam[:, None]*t).sum())
    lmin, lmax = lam[0], lam[-1]
    cr, th = core.crit_resid(W, n)
    print(f"{name:30s} n={n} weyl={core.weyl_resid(W,n):.1e} crit={cr:.1e} theta={th:+.9f} "
          f"mass={m0:.9f} firstmom={m1:+.9f} (-2lmin={-2*lmin:+.9f}) "
          f"lmax*(n-2)/n/|lmin|={lmax*(n-2)/(n*abs(lmin)):.9f} theta/((n-1)|lmin|)={th/((n-1)*abs(lmin)):.9f}")
