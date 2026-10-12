"""Fast probe of the third-order obstruction + its full cubic tensor structure."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *
from review_r55_k3b import build, make_ops

t0=time.time(); s=build(); mat,coo,circ_c,pinv,PiE,Psi = make_ops(s)
K=s['half'].shape[1]; Oh=s['Oh']; rng=np.random.default_rng(11)
Ex=np.eye(K)-Oh@Oh.T; u_,sv_,_=np.linalg.svd(Ex); Exb=u_[:,sv_>1e-8]
print(f"E(1/2)={K}, orbit={Oh.shape[1]}, excess={Exb.shape[1]}  [{time.time()-t0:.1f}s]")
m=[np.linalg.norm(Psi(Oh@rng.normal(size=Oh.shape[1])/1.0)) for _ in range(40)]
mo=[]
for _ in range(40):
    a=Oh@rng.normal(size=Oh.shape[1]); a/=np.linalg.norm(a); mo.append(np.linalg.norm(Psi(a)))
print(f"orbit dirs   ||Psi||: max {max(mo):.3e}")
me=[]
for _ in range(200):
    a=Exb@rng.normal(size=Exb.shape[1]); a/=np.linalg.norm(a); me.append(np.linalg.norm(Psi(a)))
me=np.array(me); print(f"excess dirs  ||Psi||: min {me.min():.5f} med {np.median(me):.5f} max {me.max():.5f}")
mm=[]
for _ in range(200):
    a=rng.normal(size=K); a/=np.linalg.norm(a); mm.append(np.linalg.norm(Psi(a)))
mm=np.array(mm); print(f"generic E(1/2)||Psi||: min {mm.min():.5f} med {np.median(mm):.5f} max {mm.max():.5f}")
# scalar <Psi(v),v>
sc=[]
for _ in range(200):
    a=Exb@rng.normal(size=Exb.shape[1]); a/=np.linalg.norm(a); sc.append(float(Psi(a)@a))
sc=np.array(sc); print(f"<Psi(v),v> excess: min {sc.min():.6f} med {np.median(sc):.6f} max {sc.max():.6f}")
print(f"[{time.time()-t0:.1f}s]")
