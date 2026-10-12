import numpy as np, sys, math
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
from t11_relax import max_p3_free, full_diag
from scipy.optimize import minimize
D=77; A=1.5*max_p3_free(66); th0=math.sqrt(2*11*10)/12
def min_p3_topj(j,t,tries=30,seed=1):
    rng=np.random.default_rng(seed)
    cons=[{'type':'eq','fun':lambda w: np.sum(w)},
          {'type':'eq','fun':lambda w: np.sum(w**2)-3.0},
          {'type':'ineq','fun':lambda w: -np.diff(w)},
          {'type':'ineq','fun':lambda w: np.sum(w[:j])-t}]
    best=np.inf
    for k in range(tries):
        w0=rng.standard_normal(D); w0-=w0.mean(); w0*=math.sqrt(3)/np.linalg.norm(w0); w0=np.sort(w0)[::-1]
        r=minimize(lambda w: np.sum(w**3), w0, jac=lambda w:3*w**2, constraints=cons, method='SLSQP',
                   options={'maxiter':600,'ftol':1e-12})
        w=r.x
        if abs(np.sum(w))<1e-6 and abs(np.sum(w**2)-3)<1e-5 and np.sum(w[:j])>=t-1e-6 and np.max(np.diff(w))<1e-6:
            best=min(best,float(np.sum(w**3)))
    return best
cat={"S^6xS^6":normalise(weyl_sphere_product(12,6)),
     "CP^6":normalise(weyl_cpm(6)),
     "CP^2 pad":pad(normalise(weyl_cpm(2)),12),
     "CP^4 pad":pad(normalise(weyl_cpm(4)),12)}
print("cum_j(d_sorted) profiles (n=12, D=77):")
prof={}
for nm,W in cat.items():
    d=np.sort(full_diag(W))[::-1]; c=np.cumsum(d); prof[nm]=c
    th,_=theta_of(W)
    print(f"  {nm:9s} theta={th:.4f} ||d||1={np.abs(d).sum():.3f}  cum at j=5,10,20,30,40,50: "
          +" ".join(f"{c[x-1]:.3f}" for x in [5,10,20,30,40,50]))
b=math.sqrt(3/(D*(D-1))); wmin=np.full(D,b); wmin[-1]=-(D-1)*b
print("  free p3-minimiser omega cum at same j: "+" ".join(f"{np.cumsum(wmin)[x-1]:.3f}" for x in [5,10,20,30,40,50]))
print()
print("single-index constraint cum_j(omega) >= cum_j(d_sphereproduct):")
csp=prof["S^6xS^6"]
for j in [5,10,20,30,40,50,60]:
    v=min_p3_topj(j,csp[j-1])
    print(f"   j={j:3d} t={csp[j-1]:.4f}  Phi_j={A-0.5*v:.4f}",flush=True)
print(f"(free 4.0129, full majorization 2.9474, target theta0={th0:.4f})")
