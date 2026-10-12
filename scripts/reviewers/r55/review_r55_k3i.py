"""Bigger, gradient-armed hunt for a zero of Psi on the excess sphere, plus a look
at the minimiser."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from scipy.optimize import minimize
from review_r55_core import *
from review_r55_k3b import build, make_ops
s=build(); mat,coo,circ_c,pinv,PiE,Psi=make_ops(s)
half=s['half']; K=half.shape[1]; Oh=s['Oh']; B=s['B']
Ex=np.eye(K)-Oh@Oh.T; u_,sv_,_=np.linalg.svd(Ex); Exb=u_[:,sv_>1e-8]; m=Exb.shape[1]
def pieces(z):
    zu=z/np.linalg.norm(z); a=Exb@zu; v=half@a
    y=circ_c(v,v); u0=-pinv(y); p=circ_c(v,u0); Ps=half.T@p
    return zu,a,v,y,u0,Ps
def F(z):
    *_,Ps=pieces(z); return float(Ps@Ps)
def gradF(z):
    nz=np.linalg.norm(z); zu,a,v,y,u0,Ps=pieces(z)
    Pv=half@Ps
    gW=2*circ_c(Pv,u0)-4*circ_c(v,pinv(circ_c(v,Pv)))
    gz=Exb.T@(half.T@gW); gz=(gz-(gz@zu)*zu)/nz
    return gz
rng=np.random.default_rng(2024); t0=time.time()
vals=[]; args=[]
for k in range(1500):
    z0=rng.normal(size=m)
    r=minimize(F,z0,jac=gradF,method='L-BFGS-B',options=dict(maxiter=3000,maxfun=6000,ftol=1e-22,gtol=1e-18))
    vals.append(np.sqrt(max(r.fun,0))); args.append(r.x/np.linalg.norm(r.x))
vals=np.array(vals)
print(f"1500 L-BFGS starts on the 20-dim excess sphere  [{time.time()-t0:.0f}s]")
print(f"   min ||Psi||  = {vals.min():.12f}   (1/1650 = {1/1650:.12f})")
print(f"   quantiles    = {np.percentile(vals,[0,1,10,50,90,100])}")
print(f"   below 1e-6   = {(vals<1e-6).sum()};  below 1e-8 = {(vals<1e-8).sum()}")
vb=args[int(np.argmin(vals))]
a=Exb@vb; P=Psi(a)
print(f"\n   at the minimiser: ||Psi|| = {np.linalg.norm(P):.12f}, <Psi,v> = {float(P@a):.12f}")
print(f"   Psi parallel to v?  ||Psi - (Psi.v) v|| = {np.linalg.norm(P-(P@a)*a):.3e}")
X=np.einsum('d,dij->ij', half@a, B)
print(f"   minimiser as an operator: ||X||={np.linalg.norm(X):.6f}, "
      f"diagonal mass = {float((np.diag(X)**2).sum())/float((X**2).sum()):.3e}")
np.save('scratchpad/r55_vmin.npy', vb)
