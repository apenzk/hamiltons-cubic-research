import numpy as np, sys, math
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
from t11_relax import min_p3_maj, max_p3_free, full_diag
n=12; N=66; D=77; A=1.5*max_p3_free(N); th0=math.sqrt(2*(n-1)*(n-2))/n
print(f"n=12 theta0={th0:.6f}  free relaxation={A+2.5472:.4f}")
print("Phi(c) with d only required to satisfy sum d=0, ||d||^2 >= c  (worst-case = flattest d)")
def dflat(c):
    a=math.sqrt(c/(D*(D-1))); d=np.full(D,a); d[-1]=-(D-1)*a; return np.sort(d)[::-1]
for c in [0.0,0.1,0.3,0.6,1.0,1.2252,1.5,2.0,2.5,2.9]:
    if c==0: print(f"  c={c:6.3f}  Phi={A+2.5472:.4f}"); continue
    v,_=min_p3_maj(dflat(c),3.0,tries=25,seed=3)
    print(f"  c={c:6.3f}  Phi={A-0.5*v:.4f}",flush=True)
print()
print("Phi with the ACTUAL d of specific tensors (shape used, not just norm):")
for name,W in [("balanced S^6xS^6",normalise(weyl_sphere_product(12,6))),
               ("CP^6",normalise(weyl_cpm(6))),
               ("CP^2 padded n=12",pad(normalise(weyl_cpm(2)),12)),
               ("S^5xS^7",normalise(weyl_sphere_product(12,5)))]:
    d=full_diag(W); th,_=theta_of(W)
    v,_=min_p3_maj(np.sort(d)[::-1],3.0,tries=25,seed=5)
    print(f"  {name:18s} theta={th:.6f} ||K||^2={np.sum(Kmat(W)**2):.4f} ||d||^2={np.sum(d**2):.4f} d_max={d.max():.4f}  Phi={A-0.5*v:.4f}",flush=True)
