"""Reviewer 55, K3 part F: global minimisation of ||Psi(v)|| over the pure-excess
sphere, with an analytic gradient (validated against finite differences).

  Psi(v) = Pi_E(v o u_0),  u_0 = -A(v o v),  A = (2 L_e - 1)^+ (self-adjoint)
  F(v)   = ||Psi(v)||^2
  grad F = 2 Pi(Psi o u_0) - 4 Pi(v o A(v o Psi))     (Pi = projection on excess)
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from scipy.optimize import minimize
from review_r55_core import *
from review_r55_k3b import build, make_ops

s=build(); mat,coo,circ_c,pinv,PiE,Psi=make_ops(s)
half=s['half']; K=half.shape[1]; Oh=s['Oh']
Ex=np.eye(K)-Oh@Oh.T; u_,sv_,_=np.linalg.svd(Ex); Exb=u_[:,sv_>1e-8]
m=Exb.shape[1]
A=lambda x: -pinv(x)*(-1)          # A = (2L_e-1)^+ ; pinv already is that
def Aop(x): return pinv(x)

def pieces(z):
    zu=z/np.linalg.norm(z); a=Exb@zu; v=half@a
    y=circ_c(v,v); u0=-Aop(y)
    p=circ_c(v,u0); Ps=half.T@p            # in E(1/2) coords
    return zu,a,v,y,u0,p,Ps

def F(z):
    _,_,_,_,_,_,Ps=pieces(z); return float(Ps@Ps)

def gradF(z):
    nz=np.linalg.norm(z); zu,a,v,y,u0,p,Ps=pieces(z)
    Psi_vec = half@Ps                       # Psi as a Weyl vector
    g1 = circ_c(Psi_vec, u0)
    g2 = circ_c(v, Aop(circ_c(v, Psi_vec)))
    gW = 2*g1 - 4*g2
    gz = Exb.T @ (half.T @ gW)
    gz = (gz - (gz@zu)*zu)/nz
    return gz

rng=np.random.default_rng(31)
print("gradient check (finite differences):")
for _ in range(3):
    z=rng.normal(size=m); g=gradF(z); num=np.zeros(m); h=1e-6
    for i in range(m):
        e=np.zeros(m); e[i]=h
        num[i]=(F(z+e)-F(z-e))/(2*h)
    print(f"   rel err = {np.linalg.norm(g-num)/np.linalg.norm(num):.3e}")

print("\nglobal minimisation of ||Psi(v)|| on the 20-dim excess sphere")
best=[]; t0=time.time()
for trial in range(600):
    z0=rng.normal(size=m)
    r=minimize(F,z0,jac=gradF,method='L-BFGS-B',
               options=dict(maxiter=6000,maxfun=20000,ftol=1e-20,gtol=1e-16))
    best.append((np.sqrt(max(r.fun,0)), r.x/np.linalg.norm(r.x)))
    if trial%150==0: print(f"   trial {trial}: {np.sqrt(max(r.fun,0)):.3e} [{time.time()-t0:.0f}s]")
vals=np.array([b[0] for b in best])
print(f"   min ||Psi|| = {vals.min():.9f}")
print(f"   quantiles   = {np.percentile(vals,[0,1,5,25,50,100])}")
print(f"   how many below 1e-4 : {(vals<1e-4).sum()} of {len(vals)}")
print(f"   how many below 1e-6 : {(vals<1e-6).sum()} of {len(vals)}")
# also report the range of the scalar g on the excess sphere for the record
def gsc(z):
    zu,a,v,y,u0,p,Ps=pieces(z); return float(Ps@(Exb@zu))
gs=[]
for _ in range(400):
    z=rng.normal(size=m); gs.append(gsc(z))
print(f"\n   random-sample range of <Psi(v),v>: [{min(gs):.6f}, {max(gs):.6f}]")
# and its true extremes
def mg(sign):
    out=[]
    for _ in range(120):
        z0=rng.normal(size=m)
        r=minimize(lambda z: sign*gsc(z), z0, method='Powell',
                   options=dict(maxiter=4000,xtol=1e-9,ftol=1e-13))
        out.append(sign*r.fun)
    return min(out) if sign>0 else max(out)
print(f"   min <Psi(v),v> = {mg(1):.9f}    max <Psi(v),v> = {mg(-1):.9f}")
print(f"[{time.time()-t0:.0f}s]")
