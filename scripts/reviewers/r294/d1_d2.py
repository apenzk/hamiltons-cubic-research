import sys; sys.path.insert(0,'scripts/reviewers/r294')
import numpy as np, core294 as C

pts = [('S^3xS^3', *C.sphere_product([3,3])), ('S^5xS^7', *C.sphere_product([5,7])),
       ('S^6xS^6', *C.sphere_product([6,6])), ('CP^2', *C.cpm(2)),
       ('CP^3', *C.cpm(3)), ('CP^4', *C.cpm(4))]
print(f"{'point':10s}{'n':>3s}{'theta':>11s}{'crit res':>11s}"
      f"{'max|Qg-2Wsh_gg|':>17s}{'max|Qg-.5Wsh|':>15s}{'D2 res(lam>0)':>15s}{'D2 res(lam<0)':>15s}{'Delta':>10s}")
for lbl,n,W in pts:
    th = C.theta(n,W); crit = np.abs(C.Qop(n,W)-th*W).max()
    lam,V,T = C.Tten(n,W)
    R,Qg,g,X = C.RQg(lam,T)
    Sh = V.T @ C.sharp(n,W) @ V
    d = np.diag(Sh)
    e2 = np.abs(Qg-2*d).max(); ehalf = np.abs(Qg-0.5*d).max()
    def d2(mask):
        if mask.sum()==0: return float('nan')
        l = lam[mask]
        return float(np.abs(X[mask]/(2*l)+l-g[mask]/(4*l) - th).max())
    p = lam>1e-9; m = lam<-1e-9
    print(f"{lbl:10s}{n:>3d}{th:>11.6f}{crit:>11.2e}{e2:>17.2e}{ehalf:>15.2e}"
          f"{d2(p):>15.2e}{d2(m):>15.2e}{g[p].sum():>10.4f}")

print("\n--- D1 with the brief's T = (c'/2)^2 instead of the code's T = c'^2 ---")
n,W = C.sphere_product([3,3]); lam,V,Th = C.Tten(n,W,half=True)
R,Qg,g,X = C.RQg(lam,Th); d = np.diag(V.T @ C.sharp(n,W) @ V)
print("  max|Q_g - 2 <W# v,v>| =", np.abs(Qg-2*d).max(), "   ratio Q_g/<W# v,v> =", (Qg/d)[:3])

print("\n--- off criticality: random Weyl_6, theta = <W,Q(W)> ---")
B = C.weyl_basis294(6); rng = np.random.default_rng(294)
for k in range(3):
    W = np.tensordot(rng.normal(size=B.shape[0]), B, axes=([0],[0])); W /= np.linalg.norm(W)
    th = C.theta(6,W); lam,V,T = C.Tten(6,W); R,Qg,g,X = C.RQg(lam,T)
    d = np.diag(V.T @ C.sharp(6,W) @ V)
    p = lam>1e-9
    res = X[p]/(2*lam[p])+lam[p]-g[p]/(4*lam[p]) - th
    print(f"  crit residual {np.abs(C.Qop(6,W)-th*W).max():.3f}   |Q_g-2W#_gg| {np.abs(Qg-2*d).max():.2e}"
          f"   D2 residual max {np.abs(res).max():.4f}  spread {res.min():+.3f}..{res.max():+.3f}")
    print("    g_g = 2X - 2Q_g residual:", np.abs(g - (2*X-2*Qg)).max())
