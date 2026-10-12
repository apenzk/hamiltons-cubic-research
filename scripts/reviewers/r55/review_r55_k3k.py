"""Reviewer 55: every converged corrector landing, individually -- is it the base
orbit or a genuinely different critical point?  Orbit membership is tested by the
Lambda^2 spectrum and, for anything that differs, by explicit SO(10) alignment."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r55_k3j import (n,W,e0,th,B,D,Bf,V,ev,dinv,half,exc,c0,base_spec,
                            mat,G,pinvstep,correct,describe,Oq)
from review_r55_core import *
from scipy.optimize import minimize
from scipy.linalg import expm

prs=pairs_of(n)
def lam2(g):
    N=len(prs); M=np.zeros((N,N))
    for a,(i,j) in enumerate(prs):
        for b,(k,l) in enumerate(prs):
            M[a,b]=g[i,k]*g[j,l]-g[i,l]*g[j,k]
    return M
def orbit_dist(Wp, tries=8, seed=0):
    rng=np.random.default_rng(seed)
    def build(x):
        A=np.zeros((n,n))
        for t,(i,j) in enumerate(prs): A[i,j]=x[t]; A[j,i]=-x[t]
        return lam2(expm(A))
    def f(x):
        Gm=build(x); return float(np.linalg.norm(Gm@W@Gm.T-Wp))
    best=np.inf
    for _ in range(tries):
        x0=rng.normal(scale=0.7,size=len(prs))
        r=minimize(f,x0,method='Powell',options=dict(maxiter=20000,xtol=1e-8,ftol=1e-11))
        best=min(best,r.fun)
        if best<1e-5: break
    return best

rng=np.random.default_rng(9)
sets={'excess E(1/2)':[exc[:,i] for i in range(exc.shape[1])]}
rr=[]
for _ in range(20):
    v=rng.normal(size=D); v-=Oq@(Oq.T@v); v/=np.linalg.norm(v); rr.append(v)
sets['random Weyl_10']=rr
for tgt in (1.2060113,0.7602588,0.6666667,0.3333333,-0.6666667,0.0,0.4269255,-0.2602588):
    msk=np.abs(ev-tgt)<1e-6
    if msk.sum()==0: continue
    cols=V[:,msk]; dd=[]
    for _ in range(min(5,int(msk.sum()))):
        a=rng.normal(size=cols.shape[1]); v=cols@a; v/=np.linalg.norm(v); dd.append(v)
    sets[f'L_e {tgt:+.4f}']=dd

odd=[]
print(f"{'set':>18} {'t':>5} {'resid':>10} {'theta':>11} {'S':>9} {'|dc|':>8} {'specdev':>10}")
for name,dirs in sets.items():
    for t in (0.05,0.2,0.4,0.8,1.2,2.0):
        for dv in dirs:
            c,best=correct(c0+t*dv)
            info=describe(c)
            if info is None or info['res']>1e-5: continue
            if info['specdev']>1e-6:
                odd.append((name,t,info,c))
                print(f"{name:>18} {t:5.2f} {info['res']:10.2e} {info['theta']:11.7f} "
                      f"{info['S']:9.4f} {info['dc']:8.4f} {info['specdev']:10.2e}")
print(f"\n{len(odd)} converged landings with a Lambda^2 spectrum different from the base.")
for name,t,info,c in odd[:8]:
    X=mat(c); X/=np.linalg.norm(X)
    if float(np.tensordot(X,Q(n,X)))<0: X=-X
    dd=orbit_dist(X, tries=4)
    print(f"   {name} t={t}: theta={info['theta']:.7f} S={info['S']:.4f} specdev={info['specdev']:.3e} "
          f"-> min_{{g in SO(10)}} ||gWg^T - X|| = {dd:.4e}")
    print(f"      base spec (rounded): {np.unique(np.round(base_spec,6))}")
    print(f"      land spec (rounded): {np.unique(np.round(np.sort(np.linalg.eigvalsh(X)),6))}")
