"""Padded critical points: W in Weyl_k embedded in Weyl_n. Full census of
criticality residual, distance from Weyl_n, saturation defect, dim r, nonzero r."""
import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r327')
from itertools import combinations
from core import *; from search import *
from scipy.optimize import least_squares
def embed(Wk,k,n):
    Pk=list(combinations(range(k),2)); Pn=list(combinations(range(n),2))
    ix=[Pn.index(p) for p in Pk]; N=len(Pn); out=np.zeros((N,N)); out[np.ix_(ix,ix)]=Wk; return out
rng=np.random.default_rng(11); rows=[]
for k in [4,5,6]:
    B,W_of,res_crit,_=make(k); d=B.shape[1]; Mk=ad_mats(k); pts=[]; seen=set()
    for t in range(30):
        sol=least_squares(res_crit, rng.standard_normal(d), method='lm', xtol=1e-14,ftol=1e-14,gtol=1e-14,max_nfev=3000)
        W=W_of(sol.x); r=report(W,k,Mk)
        if r['crit']>1e-10: continue
        key=tuple(np.round(np.linalg.eigvalsh(W),5))
        if key in seen: continue
        seen.add(key); pts.append(W)
    for n in range(k+1,9):
        Mn=ad_mats(n)
        for W in pts:
            Wp=embed(W,k,n); Wp/=np.linalg.norm(Wp); r=report(Wp,n,Mn)
            if r['crit']<1e-9: rows.append((k,n,r))
print('padded critical points:', len(rows))
print('  max crit residual %.2e   max dist(Weyl_n) %.2e'%(max(r['crit'] for _,_,r in rows), max(r['dW'] for _,_,r in rows)))
print('  max dim_r %d   max nonzero_r %d'%(max(r['dim_r'] for _,_,r in rows), max(r['r_nonzero'] for _,_,r in rows)))
mn=min(rows,key=lambda z: abs(z[2]['sat']))
print('  MIN |saturation defect| = %.6f  (k=%d -> n=%d, dim_r=%d, nonzero_r=%d, theta=%.6f)'%(abs(mn[2]['sat']),mn[0],mn[1],mn[2]['dim_r'],mn[2]['r_nonzero'],mn[2]['theta']))
mn2=min([z for z in rows if z[2]['r_nonzero']>0],key=lambda z: abs(z[2]['sat']))
print('  MIN |sat| among those with a NONZERO non-extreme eigenvalue = %.6f (k=%d->n=%d, dim_r=%d, nonzero_r=%d)'%(abs(mn2[2]['sat']),mn2[0],mn2[1],mn2[2]['dim_r'],mn2[2]['r_nonzero']))
