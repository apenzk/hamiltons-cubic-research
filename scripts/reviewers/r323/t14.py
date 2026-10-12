"""Penalty search: minimise Lemma-70 slack over the critical set."""
import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core, newton, math, time
from scipy.optimize import minimize
n=int(sys.argv[1]); K=int(sys.argv[2]); seed=int(sys.argv[3])
c=core.Ctx(n); rng=np.random.default_rng(seed); d=c.W.shape[0]
def unpack(z):
    z=z/np.linalg.norm(z); W=np.einsum('k,kab->ab',z,c.W); return W
def obj(z,mu):
    W=unpack(z); QW=core.Qmap(c,W); th=float(np.tensordot(W,QW,axes=([0,1],[0,1])))
    lam=np.linalg.eigvalsh(W); lmin,lmax=lam[0],lam[-1]
    if th<0: th=-th; lmin,lmax=-lmax,-lmin
    slack=lmin+(n-2)*lmax-th
    r=np.linalg.norm(QW-th*W)
    return slack+mu*r*r
best=(9e9,None); t0=time.time()
for t in range(K):
    z=rng.normal(size=d)
    for mu in [10.,100.,1000.,1e4,1e5]:
        r=minimize(obj,z,args=(mu,),method='Powell',options=dict(maxiter=4000,xtol=1e-8,ftol=1e-10))
        z=r.x
    W=unpack(z); th,res=core.crit_residual(c,W)
    if th<0: W=-W; th,res=core.crit_residual(c,W)
    lam=np.linalg.eigvalsh(W); lmin,lmax=lam[0],lam[-1]
    if lmin>=-1e-10: continue
    slack=lmin+(n-2)*lmax-th
    if res<1e-9 and slack<best[0]: best=(slack,(th,res,lmin,lmax,int(np.sum(np.abs(lam-lmin)<1e-8)),len(np.unique(np.round(lam,7))))); 
    if t%5==0: print(f'[{time.time()-t0:.0f}s] {t}/{K} best slack={best[0]:.9f} {best[1]}',flush=True)
print(f'n={n} MIN SLACK over critical set (penalty search, {K} starts): {best[0]:.9f}')
print('  (theta,res,lmin,lmax,mult_lmin,#distinct):',best[1])
