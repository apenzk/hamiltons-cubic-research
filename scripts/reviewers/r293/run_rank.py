"""How many of the N criticality rows are new relative to the class list?
And do the two recorded contractions hold WITHOUT criticality?"""
import sys; sys.path.insert(0,'scripts/reviewers/r293'); sys.path.insert(0,'scripts/lib')
import numpy as np, r293_d123 as r
from r293_lp import Relax
from r293_points import randweyl, catalogue

print("two recorded contractions at RANDOM (non-critical) Weyl tensors:")
for n in (6,8):
    for W in randweyl(n,13,2):
        W=W/np.linalg.norm(W); d=r.quantities(n,W); lam=d['lam']; th=d['theta']
        sh=r.sharp_mine(n,W)
        c1=abs(d['Qg'].sum() + 2.0)                       # sum Q_g = -2||W||^2
        c2=abs((lam*d['Qg']).sum() - 2*np.trace(W@sh))    # sum lam Q = 2<W#,W>
        rows=np.abs(d['Qg'] - 2*th*lam + 2*lam**2).max()  # the N per-row equations
        print(f"  n={n}: |sum Q +2|={c1:.2e}  |sum lam Q - 2<W#,W>|={c2:.2e}"
              f"   max per-row criticality violation = {rows:.4f}")

print("\nrank of the constraint blocks at a fixed spectrum (n=6, n=8)")
for n in (6,8):
    R=Relax(n); rng=np.random.default_rng(2)
    lam=rng.normal(size=R.N); lam-=lam.mean(); lam/=np.linalg.norm(lam)
    w,s3,Qrow,Vrow,M2row=R.coeffs(lam)
    base=np.vstack([R.Am.toarray(), Qrow.sum(0)[None,:]])          # class A equalities
    withV=np.vstack([base, Vrow])
    Ac=Qrow - 2.0*lam[:,None]*w[None,:]
    full=np.vstack([withV, Ac])
    rk=lambda M: int(np.linalg.matrix_rank(M, tol=1e-9*max(M.shape)))
    print(f"  n={n}: rank(A-eqs)={rk(base)}  rank(+V)={rk(withV)}  rank(+V+crit)={rk(full)}"
          f"   -> criticality adds {rk(full)-rk(withV)} independent equations (N={R.N})")
