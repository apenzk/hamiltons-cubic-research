import numpy as np, sys, math
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
from t11_relax import min_p3_maj, max_p3_free, full_diag
D=77; A=1.5*max_p3_free(66)
def phi(ds,tries=25,seed=7):
    v,w=min_p3_maj(ds,3.0,tries=tries,seed=seed); return A-0.5*v, w
# which partial sums bind at the sphere product?
W=normalise(weyl_sphere_product(12,6)); d=np.sort(full_diag(W))[::-1]
val,w=phi(d)
slack=np.cumsum(w)[:-1]-np.cumsum(d)[:-1]
act=[k+1 for k in range(D-1) if slack[k]<1e-7]
print(f"sphere product: Phi={val:.4f}; active majorization indices k = {act[:20]}{'...' if len(act)>20 else ''} (count {len(act)})")
print("  d(sorted) head:",np.round(d[:6],4)," tail:",np.round(d[-4:],4))
print("  cumsum d at k=1,5,10,20,40,60,76:",np.round(np.cumsum(d)[[0,4,9,19,39,59,75]],4))
# alternative d shapes at fixed ||d||^2 = 1.2252
c=1.2252
shapes={}
a=math.sqrt(c/(D*(D-1))); v1=np.full(D,a); v1[-1]=-(D-1)*a; shapes['flat-top/one-neg']=v1
h=D//2; b=math.sqrt(c/D); v2=np.concatenate([np.full(h,b),np.full(D-h,-b*h/(D-h))]); shapes['balanced +-']=v2
v3=np.zeros(D); v3[0]=math.sqrt(c/2); v3[-1]=-math.sqrt(c/2); shapes['two spikes']=v3
v4=np.linspace(1,-1,D); v4*=math.sqrt(c)/np.linalg.norm(v4); shapes['linear ramp']=v4
shapes['sphere-product d']=d
for nm,v in shapes.items():
    v=np.sort(v)[::-1]; v=v-v.mean(); v*=math.sqrt(c)/np.linalg.norm(v)
    p,_=phi(v)
    print(f"  ||d||^2={c}: shape {nm:20s} d_max={v[0]:.4f} cum40={np.cumsum(v)[39]:.4f}  Phi={p:.4f}",flush=True)
