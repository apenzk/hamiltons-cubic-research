"""Validate the LP encoding against REAL critical Weyl tensors, then probe the 67/68 witness."""
import sys; sys.path.insert(0,'scripts/reviewers/r294')
import numpy as np
from itertools import combinations
import core294 as C
from d4_lp import lp

print("=== every LP constraint checked on the actual T of real critical points ===")
for lbl,(n,W) in [('S^3xS^3',C.sphere_product([3,3])),('S^3xS^5',C.sphere_product([3,5])),
                  ('CP^3',C.cpm(3)),('CP^4',C.cpm(4)),('S^6xS^6',C.sphere_product([6,6]))]:
    th = C.theta(n,W); lam,V,T = C.Tten(n,W)
    R = T.sum(2); Qg = np.einsum('gab,a,b->g',T,lam,lam)
    row = np.abs(T.sum((1,2)) - 2*(n-2)).max()
    pair = R.max()
    crit = np.abs(Qg - (2*th*lam - 2*lam**2)).max()
    ident = np.abs(R@lam + 2*lam).max()
    obj = np.sum(lam**3) + 0.5*np.einsum('abg,a,b,g->',T,lam,lam,lam)
    d = int((lam<-1e-9).sum())
    order = np.argsort(lam); Ts = T[np.ix_(order,order,order)]
    smmm = Ts[:d,:d,:d].sum()
    print(f"  {lbl:9s} n={n:2d}  rowmarg-2(n-2) {row:.1e}  max pair {pair:.6f}  crit {crit:.1e}"
          f"  ident {ident:.1e}  S_mmm {smmm:.1e}  theta(lam,T)-theta {abs(obj-th):.1e}")

print("\n=== the 67/68-class witness spectrum at n=6, d=4, under each constraint set ===")
base = np.array([0.41169,0.41169,0.41169,0.00884,0.00535,0.00203,0,0,0,0,0,-0.03895,-0.40411,-0.40411,-0.40411])
base = base/np.linalg.norm(base); base = np.sort(base)
d = int((base < -1e-9).sum())
for tag,kw in [('base list',dict(crit=False,ident=False)),('+identity',dict(crit=False,ident=True)),
               ('+criticality',dict(crit=True,ident=False)),('+both',dict(crit=True,ident=True))]:
    v = lp(base,6,d,smmm=True,**kw)
    print(f"  {tag:14s} -> {'INFEASIBLE' if v is None else format(v,'.6f')}")
print("  (spectrum: 3 x +0.4117, 3 tiny +, 5 zeros, -0.0390, 3 x -0.4041; d = 4)")
