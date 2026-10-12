"""Reviewer 55, K3 part C: is the third-order obstruction nonzero on the WHOLE
pure-excess sphere?

The tangent cone C of Crit(P) at e is invariant under translation by the orbit
tangent T:  if gamma is an arc in Crit with gamma'(0)=v then t -> exp(tsA)gamma(t)
is another, with derivative v + s(A.e).  So C = T exactly when C meets the
excess (= E(1/2) o- T) only at 0.  And C is contained in {Psi = 0}.

So: minimise ||Psi(v)||^2 and g(v) = <Psi(v),v> over the unit sphere of the 20-dim
excess.  A strictly positive minimum of g already forces Psi != 0, and

   g(v) = -<y, (2L_e-1)^+ y>  with y = v o v,

i.e. g > 0 exactly when v o v puts enough mass on eigenvalues of L_e below 1/2.
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *
from review_r55_k3b import build, make_ops
from scipy.optimize import minimize

def main():
    t0=time.time(); s=build(); mat,coo,circ_c,pinv,PiE,Psi = make_ops(s)
    K=s['half'].shape[1]; Oh=s['Oh']; half=s['half']
    Ex=np.eye(K)-Oh@Oh.T; u_,sv_,_=np.linalg.svd(Ex); Exb=u_[:,sv_>1e-8]
    m=Exb.shape[1]
    print(f"E(1/2)={K}, orbit={Oh.shape[1]}, excess={m}")
    def Psi_ex(z):
        a = Exb@z
        return Exb.T @ Psi(a), Psi(a)
    def g(z):
        z=np.asarray(z); nz=np.linalg.norm(z); a=Exb@(z/nz)
        return float(Psi(a)@a)
    def gg(z):
        nz=np.linalg.norm(z); zu=z/nz; a=Exb@zu
        gr = 4*(Exb.T@Psi(a))
        gr = (gr-(gr@zu)*zu)/nz
        return gr
    def f2(z):
        nz=np.linalg.norm(z); a=Exb@(z/nz); p=Psi(a); return float(p@p)
    rng=np.random.default_rng(23)
    print("\n--- minimise g(v) = <Psi(v),v> over the excess unit sphere (gradient, 400 starts)")
    vals=[]
    for _ in range(400):
        z0=rng.normal(size=m)
        r=minimize(g,z0,jac=gg,method='L-BFGS-B',options=dict(maxiter=4000,ftol=1e-18,gtol=1e-14))
        vals.append(r.fun)
    vals=np.array(vals)
    print(f"   min over starts = {vals.min():.9f}   (2nd,3rd smallest {np.sort(vals)[1]:.9f}, {np.sort(vals)[2]:.9f})")
    print(f"   max over starts = {vals.max():.9f}")
    print("\n--- maximise g too (for the range)")
    vals2=[]
    for _ in range(150):
        z0=rng.normal(size=m)
        r=minimize(lambda z:-g(z),z0,jac=lambda z:-gg(z),method='L-BFGS-B',
                   options=dict(maxiter=4000,ftol=1e-18,gtol=1e-14))
        vals2.append(-r.fun)
    print(f"   max g = {max(vals2):.9f}")
    print("\n--- minimise ||Psi(v)||^2 over the excess unit sphere (Powell, 60 starts)")
    best=[]
    for _ in range(60):
        z0=rng.normal(size=m)
        r=minimize(f2,z0,method='Powell',options=dict(maxiter=8000,xtol=1e-11,ftol=1e-15))
        best.append(np.sqrt(max(r.fun,0)))
    best=np.array(best)
    print(f"   min ||Psi|| = {best.min():.9f}  quantiles {np.percentile(best,[0,25,50,100]).round(6)}")
    print("\n--- and over the FULL E(1/2) sphere, tracking the excess component")
    def f2full(x):
        nx=np.linalg.norm(x); a=x/nx; p=Psi(a); return float(p@p)
    rec=[]
    for _ in range(60):
        x0=rng.normal(size=K)
        r=minimize(f2full,x0,method='Powell',options=dict(maxiter=8000,xtol=1e-11,ftol=1e-15))
        v=r.x/np.linalg.norm(r.x)
        rec.append((np.sqrt(max(r.fun,0)), np.linalg.norm(v-Oh@(Oh.T@v))))
    rec=np.array(rec)
    z=rec[rec[:,0]<1e-6]
    print(f"   zeros found: {len(z)}/60;  max excess component among them = "
          f"{z[:,1].max() if len(z) else float('nan'):.3e}")
    print(f"   residual quantiles {np.percentile(rec[:,0],[0,25,50,100]).round(8)}")
    print(f"[{time.time()-t0:.1f}s]")

if __name__=="__main__": main()
