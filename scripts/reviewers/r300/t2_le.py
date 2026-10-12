import sys; sys.path.insert(0,'scripts/reviewers/r300')
import numpy as np, core300 as C

pts = [("S^3xS^5",)+C.sphere_pair(3,5), ("CP^3",)+C.cpm(3), ("CP^4",)+C.cpm(4), ("C5",)+C.c5_blowup()]
for name,W,n in pts:
    th,res,M,Mp,ev,w,asym = C.lambda_max_perp(n,W)
    D=len(M)
    evfull = np.linalg.eigvalsh(M)
    # true perp spectrum: eigenvalues of Mp minus the one spurious 0 from the killed W direction
    evs = np.sort(ev)
    # identify: Mp has an exact zero eigenvector w
    lam = evs[-1]
    trM = float(np.trace(M)); trPerp = float(np.trace(Mp))
    print(f"{name:9s} n={n} dim={D} theta={th:.9f} asym(L_e)={asym:.1e}")
    print(f"    tr(L_e)={trM:.12f}   <W,L_eW>={float(w@M@w):.12f}   tr(L_e|perp)={trPerp:.12f}")
    print(f"    lambda_max|perp = {lam:.9f}   mult(top,1e-9)={int(np.sum(np.abs(evs-lam)<1e-9))}  mult(1/2)={int(np.sum(np.abs(evs-0.5)<1e-9))}")
    print(f"    full-space spec top5: {np.round(evfull[-5:],9)}")
    # tr(L_W) unnormalised
    MW,_ = C.Le_matrix(n, W/np.linalg.norm(W))
    print(f"    tr(L_W) at unit W = {float(np.trace(MW)):.3e}")
