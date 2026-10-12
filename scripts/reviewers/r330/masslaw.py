import numpy as np, core, fam

def analyse(name, n, W, wl, tol=1e-8):
    W = W/np.linalg.norm(W); c = wl.c; N = wl.N
    res, th = fam.crit_res(W, c)
    ev, V = np.linalg.eigh(W)
    lmin, lmax = ev[0], ev[-1]
    slack = lmin + (n-2)*lmax - th
    m = np.abs(ev-lmin) < tol; h = np.abs(ev-lmax) < tol; r = ~(m|h)
    dm, dh, dr = int(m.sum()), int(h.sum()), int(r.sum())
    # structure constants in the eigenbasis
    ce = np.einsum('ai,bj,ck,ijk->abc', V.T, V.T, V.T, c)
    T = ce**2
    rowmass_ordered = T.sum(axis=(1,2))
    # mass law, ORDERED convention (row mass = 2(n-2))
    Mm_ord = T[m].sum()                     # rows through m
    # rows through h, part on m x m
    hm_mm = T[np.ix_(h,m,m)].sum()
    resid_ord = T[h].sum() - hm_mm
    # UNORDERED convention (row mass = n-2)
    print(f"{name:26s} n={n:2d} res={res:.1e} slack={slack:+.3e} dims m/h/r={dm}/{dh}/{dr} "
          f"rowmass(ord)={rowmass_ordered.min():.4f}..{rowmass_ordered.max():.4f} vs 2(n-2)={2*(n-2)}")
    print(f"{'':26s}   M(ordered, m rows)={Mm_ord:.4f}  dim m*(n-2)={dm*(n-2)}  2*dim m*(n-2)={2*dm*(n-2)}")
    print(f"{'':26s}   residue(ordered)={resid_ord:.4f}  (n-2)(2dh-dm)={(n-2)*(2*dh-dm)}  dh(n-4)={dh*(n-4)}")
    print(f"{'':26s}   M/2={Mm_ord/2:.4f}   residue/2={resid_ord/2:.4f}")
    # off-support masses
    off_mm_h  = T[np.ix_(m,m,~h)].sum()
    off_mh_m  = T[np.ix_(m,h,~m)].sum()
    off_mr    = T[np.ix_(m,r,np.ones(N,bool))].sum() if dr else 0.0
    print(f"{'':26s}   [m,m] off h: {off_mm_h:.3e}   [m,h] off m: {off_mh_m:.3e}   [m,r]: {off_mr:.3e}")
    # T itself supported on (m,m,h)?
    mask = np.zeros((N,N,N), bool)
    for perm in [(m,m,h),(m,h,m),(h,m,m)]:
        mask |= np.einsum('a,b,c->abc', perm[0].astype(float), perm[1].astype(float), perm[2].astype(float)).astype(bool)
    print(f"{'':26s}   total T mass={T.sum():.1f}  mass OFF (m,m,h)={T[~mask].sum():.4f}")
    return dict(dm=dm,dh=dh,dr=dr)

for n in [6,8,10,12]:
    wl = core.Weyl(n)
    gens = fam.so_block(n, list(range(n//2))) + fam.so_block(n, list(range(n//2,n)))
    analyse(f"balanced S^{n//2}xS^{n//2}", n, fam.W_from_subalgebra(n,gens,wl), wl)
wl4=core.Weyl(4)
analyse("W_CP2 (n=4)", 4, fam.W_cp2(), wl4)
analyse("S2xS2 (n=4)", 4, fam.W_from_subalgebra(4,fam.so_block(4,[0,1])+fam.so_block(4,[2,3]),wl4), wl4)
wl6=core.Weyl(6)
analyse("max torus n=6 (control)", 6, fam.W_from_subalgebra(6,fam.torus(6),wl6), wl6)
