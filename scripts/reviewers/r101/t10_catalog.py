import numpy as np, sys, math
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
from fast import kappa_ms
rng=np.random.default_rng(4242)
n=12; th0=math.sqrt(2*(n-1)*(n-2))/n
print(f"n=12 catalog. theta0={th0:.6f}")
rows=[]
for k in range(2,7):
    W=pad(normalise(weyl_sphere_product(k+ (n if False else 0) if False else 12,k)) if False else None,n) if False else None
for k in range(2,7):
    Wk=normalise(weyl_sphere_product(12,k))   # S^k x S^(12-k) in n=12
    th,_=theta_of(Wk); k2,_=kappa_ms(Wk,starts=14,iters=200,rng=rng)
    rows.append((f"S^{k} x S^{12-k}",th,k2))
for m in range(2,7):
    Wm=pad(normalise(weyl_cpm(m)),12)
    th,_=theta_of(Wm); k2,_=kappa_ms(Wm,starts=14,iters=200,rng=rng)
    rows.append((f"CP^{m} padded",th,k2))
# lower-dim sphere products padded
for (k,l) in [(2,2),(3,3),(4,4),(5,5),(2,4),(3,5),(2,6),(4,6)]:
    if k+l>12: continue
    Wp=np.zeros((k+l,k+l,k+l,k+l))
    Wp=normalise(weyl_sphere_product(k+l,k))
    Wp=pad(Wp,12)
    th,_=theta_of(Wp); k2,_=kappa_ms(Wp,starts=14,iters=200,rng=rng)
    rows.append((f"S^{k} x S^{l} padded",th,k2))
for nm,th,k2 in sorted(rows,key=lambda r:-r[1]):
    flag="  <== theta >= theta0" if th>=th0-1e-9 else ""
    print(f"  {nm:22s} theta={th:.6f}  kappa2={k2:.6f}{flag}")
