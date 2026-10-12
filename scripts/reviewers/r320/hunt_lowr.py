"""Hunt: a critical Weyl point with trivial kernel and dim E_+ below the cap n(n-2)/4."""
import sys; sys.path.insert(0,'scripts/reviewers/r320')
import numpy as np, lib320 as L, json
from scipy.optimize import minimize
n=int(sys.argv[1]); kmax=int(sys.argv[2]); ntr=int(sys.argv[3]); out=sys.argv[4]
B=L.weyl_basis(n); D=B.shape[0]; N=B.shape[1]
def W_of(x): 
    x=x/np.linalg.norm(x); return np.einsum('t,tab->ab',x,B)
def obj(x,mu):
    W=W_of(x); q=L.Q(W,n); th=L.frob(W,q); R=q-th*W
    r=np.einsum('tab,ab->t',B,R)
    ev=np.linalg.eigvalsh(W)[::-1]      # descending
    pen=np.clip(ev[kmax:],0,None)
    return float(r@r)+mu*float(pen@pen)
best=[]
rng=np.random.default_rng(11)
for s in range(ntr):
    x=rng.standard_normal(D)
    for mu in [3.0,30.0,300.0,3000.0]:
        res=minimize(obj,x,args=(mu,),method='L-BFGS-B',options=dict(maxiter=3000))
        x=res.x
    # polish on residual alone from there
    from solve320 import find
    try: W,th,rr=find(n,0,x0=x)
    except Exception: continue
    if rr>1e-9: continue
    if th<0: W=-W; th=-th
    ev=np.linalg.eigvalsh(W); tol=1e-8
    rp=int((ev>tol).sum()); rm=int((ev<-tol).sum()); k=len(ev)-rp-rm
    Nn=len(ev)
    bd=(2/n)*np.sqrt(rp*Nn/(Nn-rp)) if 0<rp<Nn else float('inf')
    best.append(dict(seed=s,theta=float(th),rp=rp,rm=rm,ker=k,bound=float(bd),
                     lmin=float(ev.min()),ok=bool(th<=bd+1e-9)))
    print(s,"theta=%.6f rp=%d ker=%d bound=%.6f ok=%s"%(th,rp,k,bd,th<=bd+1e-9),flush=True)
json.dump(best,open(out,'w'))
