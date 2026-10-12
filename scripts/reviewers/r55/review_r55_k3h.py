"""Polish the minimiser of ||Psi|| with Gauss-Newton: is the minimum a true zero?"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from scipy.optimize import least_squares, minimize
from review_r55_core import *
from review_r55_k3b import build, make_ops

s=build(); mat,coo,circ_c,pinv,PiE,Psi=make_ops(s)
half=s['half']; K=half.shape[1]; Oh=s['Oh']
Ex=np.eye(K)-Oh@Oh.T; u_,sv_,_=np.linalg.svd(Ex); Exb=u_[:,sv_>1e-8]; m=Exb.shape[1]
def Psi_ex(z):
    zu=z/np.linalg.norm(z); return Psi(Exb@zu)
def R(z):
    return np.append(Psi_ex(z), np.linalg.norm(z)-1.0)
rng=np.random.default_rng(77)
print("Gauss-Newton (least_squares, numeric jac) on Psi(v)=0 over the excess sphere")
best=[]; t0=time.time()
for k in range(40):
    z0=rng.normal(size=m); z0/=np.linalg.norm(z0)
    sol=least_squares(R,z0,method='lm',xtol=1e-15,ftol=1e-15,gtol=1e-15,max_nfev=40000)
    v=np.linalg.norm(Psi_ex(sol.x))
    best.append((v,sol.x/np.linalg.norm(sol.x)))
vals=np.array([b[0] for b in best])
print(f"   min ||Psi|| = {vals.min():.3e}   quantiles {np.percentile(vals,[0,10,50,100])}")
print(f"   below 1e-6: {(vals<1e-6).sum()}/{len(vals)};  below 1e-10: {(vals<1e-10).sum()}/{len(vals)}")
# rank of the image of Psi on the excess sphere
imgs=[]
for _ in range(200):
    z=rng.normal(size=m); imgs.append(Psi_ex(z))
IM=np.array(imgs); sv=np.linalg.svd(IM,compute_uv=False)
print(f"\n   effective rank of the image of Psi|excess: {(sv>1e-9*sv[0]).sum()} of {K}; "
      f"top svals {np.round(sv[:6],4)}")
# examine the best point
vbest=best[int(np.argmin(vals))][1]
a=Exb@vbest
print(f"\n   best v: ||Psi||={vals.min():.3e}, <Psi,v>={float(Psi(a)@a):.6f}")
print(f"[{time.time()-t0:.0f}s]")
