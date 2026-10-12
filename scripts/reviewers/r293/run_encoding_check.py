"""The real T of a real critical point must satisfy every row of the LP."""
import sys; sys.path.insert(0,'scripts/reviewers/r293'); sys.path.insert(0,'scripts/lib')
import numpy as np, r293_d123 as r
from r293_lp import Relax
from r293_points import catalogue, randweyl
for n,W,lbl in catalogue():
    if n not in (6,8): continue
    W=W/np.linalg.norm(W); d=r.quantities(n,W); lam=d['lam']; T=d['T']; th=d['theta']
    R=Relax(n); t=np.array([T[a,b,c] for (a,b,c) in R.tri])
    w,s3,Qrow,Vrow,M2row=R.coeffs(lam)
    print(f"{lbl:20s} n={n}")
    print(f"   marginal   max|Am t - (n-2)|  = {np.abs(R.Am@t - R.bm).max():.2e}")
    print(f"   pair cap   max(Ap t) = {(R.Ap@t).max():.6f}  (cap 2)")
    print(f"   theta      |s3 + w.t - theta| = {abs(s3+w@t-th):.2e}")
    print(f"   Q rows     max|Qrow t - Q_g|  = {np.abs(Qrow@t - d['Qg']).max():.2e}")
    print(f"   M2 rows    max|M2row t - M2_g|= {np.abs(M2row@t - d['M2']).max():.2e}")
    print(f"   vector id  max|Vrow t + 2lam| = {np.abs(Vrow@t + 2*lam).max():.2e}")
    print(f"   trace      |sum Q_g + 2|      = {abs(Qrow.sum(0)@t + 2):.2e}")
    print(f"   criticality max|Q_g-2*th*lam+2lam^2| = {np.abs(d['Qg']-2*th*lam+2*lam**2).max():.2e}")
    print(f"   T_aab = 0? max = {max(abs(T[a,a,b]) for a in range(R.N) for b in range(R.N)):.2e}")
for n in (6,):
    for W in randweyl(n,7,1):
        W=W/np.linalg.norm(W); d=r.quantities(n,W); lam=d['lam']; T=d['T']; th=d['theta']
        R=Relax(n); t=np.array([T[a,b,c] for (a,b,c) in R.tri])
        w,s3,Qrow,Vrow,M2row=R.coeffs(lam)
        print(f"random non-critical Weyl_{n}: marginal {np.abs(R.Am@t-R.bm).max():.2e} "
              f"cap {(R.Ap@t).max():.4f} vector-id {np.abs(Vrow@t+2*lam).max():.2e} "
              f"criticality-row violation {np.abs(d['Qg']-2*th*lam+2*lam**2).max():.4f}")
