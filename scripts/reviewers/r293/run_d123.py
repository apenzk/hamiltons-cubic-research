import sys; sys.path.insert(0,'scripts/reviewers/r293'); sys.path.insert(0,'scripts/lib')
import numpy as np, r293_d123 as r
from r293_points import catalogue, randweyl
print(f"{'point':20s}{'n':>3}{'theta':>10}{'critres':>11}{'D1 max':>11}{'D2+ max':>11}{'D2- max':>11}{'Delta':>9}{'#0':>4}")
for n,W,lbl in catalogue():
    W = W/np.linalg.norm(W)
    th,res = r.crit_res(n,W)
    d = r.quantities(n,W); lam=d['lam']
    d1 = np.abs(d['Qg'] - 2*d['sharp_diag']).max()
    def d2err(mask):
        if mask.sum()==0: return float('nan')
        lg=lam[mask]
        return np.abs(d['M2'][mask]/(2*lg) + lg - d['gg'][mask]/(4*lg) - th).max()
    pos=lam>1e-9; neg=lam<-1e-9
    print(f"{lbl:20s}{n:>3}{th:>10.6f}{res:>11.2e}{d1:>11.2e}{d2err(pos):>11.2e}{d2err(neg):>11.2e}"
          f"{d['gg'][pos].sum():>9.4f}{int((np.abs(lam)<=1e-9).sum()):>4}")
print("\nrandom (NON-critical) Weyl tensors, theta := <W,Q(W)>:")
for n in (6,8):
    for W in randweyl(n, 7, 2):
        W=W/np.linalg.norm(W)
        th,res=r.crit_res(n,W); d=r.quantities(n,W); lam=d['lam']; pos=lam>1e-9
        d1=np.abs(d['Qg']-2*d['sharp_diag']).max()
        lg=lam[pos]; rhs=d['M2'][pos]/(2*lg)+lg-d['gg'][pos]/(4*lg)
        print(f"  n={n} theta={th:+.5f} critres={res:.3e}  D1max={d1:.2e}  RHS_gamma in "
              f"[{rhs.min():+.5f},{rhs.max():+.5f}]  max|RHS-theta|={np.abs(rhs-th).max():.4f}")
