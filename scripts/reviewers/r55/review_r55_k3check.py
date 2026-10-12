"""Cross-check the third-order obstruction two independent ways."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *
from review_r55_k3b import build, make_ops

s=build(); mat,coo,circ_c,pinv,PiE,Psi = make_ops(s)
K=s['half'].shape[1]; Oh=s['Oh']; half=s['half']; V=s['V']; ev=s['ev']
Ex=np.eye(K)-Oh@Oh.T; u_,sv_,_=np.linalg.svd(Ex); Exb=u_[:,sv_>1e-8]
rng=np.random.default_rng(101)
print("route 1: g(v) = <Psi(v),v> via Psi")
print("route 2: g(v) = -<y,(2L_e-1)^+ y> with y = v o v   (must agree)")
print(f"{'k':>3} {'route1':>14} {'route2':>14} {'|v o v|':>12} {'mass on lam>1/2':>16}")
for k in range(8):
    a=Exb@rng.normal(size=Exb.shape[1]); a/=np.linalg.norm(a)
    v=half@a
    y=circ_c(v,v)
    g1=float(Psi(a)@a)
    yy=V.T@y
    d=2*ev-1.0
    keep=np.abs(d)>1e-7
    g2=-float((yy[keep]**2/d[keep]).sum())
    above=(ev>0.5+1e-9)
    print(f"{k:3d} {g1:14.9f} {g2:14.9f} {np.linalg.norm(y):12.6f} {float((yy[above]**2).sum())/float((yy**2).sum()):16.6f}")
print()
print("check: is v o v orthogonal to E(1/2)?  (2nd-order obstruction)")
for k in range(3):
    a=Exb@rng.normal(size=Exb.shape[1]); a/=np.linalg.norm(a)
    v=half@a; y=circ_c(v,v)
    print(f"   ||Pi_E(1/2)(v o v)|| = {np.linalg.norm(half.T@y):.3e}   ||v o v|| = {np.linalg.norm(y):.6f}")
print()
print("now minimise g over the excess sphere by brute random + Powell (no analytic jac)")
from scipy.optimize import minimize
def g(z):
    nz=np.linalg.norm(z)
    if nz<1e-12: return 0.0
    a=Exb@(z/nz); return float(Psi(a)@a)
vals=[]
for _ in range(60):
    z0=rng.normal(size=Exb.shape[1])
    r=minimize(g,z0,method='Powell',options=dict(maxiter=20000,xtol=1e-10,ftol=1e-14))
    vals.append((r.fun, np.linalg.norm(r.x)))
vals=np.array(vals)
print(f"   min g = {vals[:,0].min():.9f}, max g = {vals[:,0].max():.9f}, |z| range {vals[:,1].min():.2e}..{vals[:,1].max():.2e}")
print()
print("and minimise ||Psi(v)|| over the excess sphere (Powell)")
def f2(z):
    nz=np.linalg.norm(z)
    if nz<1e-12: return 1e6
    a=Exb@(z/nz); p=Psi(a); return float(p@p)
best=[]
for _ in range(60):
    z0=rng.normal(size=Exb.shape[1])
    r=minimize(f2,z0,method='Powell',options=dict(maxiter=20000,xtol=1e-10,ftol=1e-14))
    best.append(np.sqrt(max(r.fun,0)))
best=np.array(best)
print(f"   min ||Psi|| = {best.min():.9f}   quantiles {np.percentile(best,[0,25,50,100]).round(6)}")
