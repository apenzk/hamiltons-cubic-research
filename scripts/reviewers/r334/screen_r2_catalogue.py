"""r334 screen: R2's two ratios at catalogued spectra. SCREEN only."""
import sys, os, numpy as np
sys.path.insert(0, "scripts/reviewers/r322")
import points

def report(name, n, lam):
    lam = np.array(lam, float); lam = lam[np.abs(lam) > 1e-10] if False else lam
    lmax, lmin = lam.max(), lam.min()
    print(f"{name:28s} n={n:3d} lmax={lmax:+.6f} lmin={lmin:+.6f} "
          f"lmax/(n-2)|lmin|={lmax/((n-2)*abs(lmin)):.6f}  |lmin|/((n-2)lmax)={abs(lmin)/((n-2)*lmax):.6f}")

for m in (2,3,4,5,6):
    n = 2*m; d = 2*m-1
    lam = [4*(m*m-1)/d] + [(2*m-4)/d]*(m*m-1) + [-2*(m+1)/d]*(m*m-m)
    report(f"CP^{m}", n, lam)
for m in (3,4,5,6):
    n = 2*m
    report(f"S^{m}xS^{m}", n, [n/(n-2)]*(n*(n-2)//4) + [-1.0]*(n*n//4))
for p,q in ((3,5),(5,7),(3,7)):
    n,W = points.sphere_product(p,q); report(f"S^{p}xS^{q}", n, np.linalg.eigvalsh(W))
for n in (6,8,10,12):
    N = n*(n-1)//2; r = n//2
    report(f"max torus so(2)^{n//2}", n, [1-r/N]*r + [-r/N]*(N-r))
for m in (1,2,3):
    n,W,M,th,res = points.c5_blowup(m)
    ev = np.linalg.eigvalsh(W)
    report(f"C_5 blow-up m={m} (th={th:.4f},res={res:.0e})", n, ev)
