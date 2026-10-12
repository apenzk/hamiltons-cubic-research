"""Final coarse check: sample the excess sphere densely and report min ||Psi||."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *
from review_r55_k3b import build, make_ops
s=build(); mat,coo,circ_c,pinv,PiE,Psi=make_ops(s)
half=s['half']; K=half.shape[1]; Oh=s['Oh']
Ex=np.eye(K)-Oh@Oh.T; u_,sv_,_=np.linalg.svd(Ex); Exb=u_[:,sv_>1e-8]; m=Exb.shape[1]
rng=np.random.default_rng(4242); t0=time.time()
vals=[]
for _ in range(12000):
    z=rng.normal(size=m); a=Exb@(z/np.linalg.norm(z))
    vals.append(np.linalg.norm(Psi(a)))
vals=np.array(vals)
print(f"12000 uniform samples on the 20-dim excess sphere  [{time.time()-t0:.0f}s]")
print(f"   min  ||Psi|| = {vals.min():.6f}")
print(f"   quantiles    = {np.percentile(vals,[0,0.1,1,50,99,100]).round(6)}")
print(f"   below 0.01   = {(vals<0.01).sum()};  below 0.1 = {(vals<0.1).sum()}")
print(f"   (global minimum from 40 Gauss-Newton polishes: 6.061e-04)")
