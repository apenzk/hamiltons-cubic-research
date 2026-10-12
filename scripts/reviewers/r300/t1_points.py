import sys; sys.path.insert(0,'scripts/reviewers/r300')
import numpy as np, core300 as C

def report(name, W, n):
    QW = C.Q(n,W); th = float(np.tensordot(W,QW)); res = float(np.linalg.norm(QW-th*W))
    ric = np.abs(C.ricci(n,W)).max(); alt = np.abs(C.alt_defect(n,W)).max() if C.alt_defect(n,W).size else 0.0
    inW = np.linalg.norm(W - C.proj_weyl(n,W))
    th0 = np.sqrt(2*(n-1)*(n-2))/n
    dpos, dtot = C.delta_defect(n,W)
    print(f"{name:14s} n={n:2d} theta={th:.9f} ({th/th0:.4f} th0) crit_res={res:.2e} Ric={ric:.1e} Alt={alt:.1e} distWeyl={inW:.1e} Delta={dpos:.6f}/{dtot:.4f} (4(n-1)={4*(n-1)})")
    return th

W,n = C.sphere_pair(3,5); report("S^3xS^5", W, n)
W,n = C.cpm(4);           report("CP^4", W, n)
W,n = C.cpm(3);           report("CP^3", W, n)
W,n = C.c5_blowup();      report("C5 blowup", W, n)
