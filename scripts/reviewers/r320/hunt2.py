"""Hunt high-theta critical points with dim E_+ <= kmax (and note the kernel)."""
import sys; sys.path.insert(0,'scripts/reviewers/r320')
import numpy as np, lib320 as L, json
from scipy.optimize import minimize
from solve320 import find
n=int(sys.argv[1]); kmax=int(sys.argv[2]); ntr=int(sys.argv[3]); out=sys.argv[4]
B=L.weyl_basis(n); D=B.shape[0]
def W_of(x):
    x=x/np.linalg.norm(x); return np.einsum('t,tab->ab',x,B)
def pen(x,mu,w):
    W=W_of(x); ev=np.linalg.eigvalsh(W)[::-1]
    p=np.clip(ev[kmax:],0,None)
    return -w*L.P_of(W,n)+mu*float(p@p)
rows=[]; rng=np.random.default_rng(23)
for s in range(ntr):
    x=rng.standard_normal(D)
    for mu,w in [(10.,1.),(100.,1.),(1000.,1.),(1e4,1.),(1e5,0.3)]:
        x=minimize(pen,x,args=(mu,w),method='L-BFGS-B',options=dict(maxiter=2000)).x
    try: W,th,rr=find(n,0,x0=x)
    except Exception: continue
    if rr>1e-9: continue
    if th<0: W=-W; th=-th
    ev=np.linalg.eigvalsh(W); tol=1e-8
    rp=int((ev>tol).sum()); rm=int((ev<-tol).sum()); k=len(ev)-rp-rm; N=len(ev)
    bd=(2/n)*np.sqrt(rp*N/(N-rp)) if 0<rp<N else float('inf')
    rows.append(dict(theta=float(th),rp=rp,rm=rm,ker=k,bound=float(bd),ok=bool(th<=bd+1e-9),
                     blmin=float((n-1)*abs(ev.min())),oklm=bool(th<=(n-1)*abs(ev.min())+1e-9)))
    print(f"{s} theta={th:.6f} rp={rp} rm={rm} ker={k} bound_r={bd:.6f} ok={th<=bd+1e-9} (n-1)|lmin|={(n-1)*abs(ev.min()):.6f}",flush=True)
json.dump(rows,open(out,'w'))
print("DONE")
