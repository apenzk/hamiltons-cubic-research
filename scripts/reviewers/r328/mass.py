"""M3: the bracket-mass law at saturation, measured directly from T in the eigenbasis."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(__file__))
import core, lemma70

def T_eigen(n, W, tol=1e-8):
    lam, V = np.linalg.eigh(W)
    _, c = core.struct(n)
    ce = np.einsum('pqr,pa,qb,rc->abc', c, V, V, V, optimize=True)
    T = ce ** 2
    lmin, lmax = lam[0], lam[-1]
    mm = np.abs(lam - lmin) < tol
    hh = np.abs(lam - lmax) < tol
    rr = ~(mm | hh)
    return T, lam, mm, hh, rr

def report(n, W, tag):
    T, lam, mm, hh, rr = T_eigen(n, W)
    rows = T.sum(axis=(1, 2))
    dm, dh, dr = int(mm.sum()), int(hh.sum()), int(rr.sum())
    # M = ordered mass with a in m, b in m, c in h
    M = float(T[np.ix_(mm, mm, hh)].sum())
    # the two other orderings, as a symmetry check
    M2 = float(T[np.ix_(mm, hh, mm)].sum()); M3 = float(T[np.ix_(hh, mm, mm)].sum())
    # h rows outside m x m, measured directly
    mask_mm = np.outer(mm, mm)
    res_direct = float(T[hh].sum() - T[np.ix_(hh, mm, mm)].sum())
    # total mass off the (m,m,h) support (all orderings), measured directly
    supp = np.zeros_like(T, dtype=bool)
    for A, B, C in [(mm, mm, hh), (mm, hh, mm), (hh, mm, mm)]:
        supp[np.ix_(A, B, C)] = True
    off_supp = float(T[~supp].sum())
    print('%-22s n=%2d dims m/h/r %3d/%3d/%3d | rows [%.6f,%.6f] target %d' %
          (tag, n, dm, dh, dr, rows.min(), rows.max(), 2 * (n - 2)))
    print('        M(m,m,h) = %.6f   predicted dim_m (n-2) = %d   [orderings %.4f %.4f %.4f]' %
          (M, dm * (n - 2), M, M2, M3))
    print('        residue (h rows off mxm) direct = %.6f   (n-2)(2dh-dm) = %d   dh(n-4) = %d   off-support mass = %.4f' %
          (res_direct, (n - 2) * (2 * dh - dm), dh * (n - 4), off_supp))
    return dict(M=M, dm=dm, dh=dh, dr=dr, res=res_direct, off=off_supp)
