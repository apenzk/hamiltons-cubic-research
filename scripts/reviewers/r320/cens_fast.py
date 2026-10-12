import sys; sys.path.insert(0,'scripts/reviewers/r320')
import numpy as np, lib320 as L, collections
from scipy.optimize import least_squares
n=int(sys.argv[1]); ntr=int(sys.argv[2])
B=L.weyl_basis(n); D=B.shape[0]; N=B.shape[1]
def W_of(x):
    x=x/np.linalg.norm(x); return np.einsum('t,tab->ab',x,B)
def resid(x):
    W=W_of(x); q=L.Q(W,n); th=L.frob(W,q); return np.einsum('tab,ab->t',B,q-th*W)
rng=np.random.default_rng(2024); rows=[]
for s in range(ntr):
    x=rng.standard_normal(D); x/=np.linalg.norm(x)
    sol=least_squares(resid,x,xtol=1e-13,ftol=1e-13,gtol=1e-13,max_nfev=200)
    W=W_of(sol.x); q=L.Q(W,n); th=L.frob(W,q); r=float(np.linalg.norm(q-th*W))
    if r>1e-9 or abs(th)<1e-7: continue
    if th<0: W=-W; th=-th
    ev=np.linalg.eigvalsh(W); tol=1e-8
    rp=int((ev>tol).sum()); rm=int((ev<-tol).sum()); k=len(ev)-rp-rm
    bd=(2/n)*np.sqrt(rp*N/(N-rp)) if 0<rp<N else np.inf
    rows.append((th,rp,rm,k,bd,(n-1)*abs(ev.min())))
    if s%50==0: print("  ...",s,len(rows),flush=True)
cap=n*(n-2)/4
print("n=%d census: %d critical points, N=%d, cap=%.2f"%(n,len(rows),N,cap))
print(" (dim E_+, ker) histogram:",dict(sorted(collections.Counter((r[1],r[3]) for r in rows).items())))
print(" max theta: %.6f   theta0(%d)=%.6f"%(max(r[0] for r in rows),n,L.theta0(n)))
print(" post-40 (dim E_+) bound violations:",sum(1 for r in rows if r[0]>r[4]+1e-9),
      " of which ker=0:",sum(1 for r in rows if r[0]>r[4]+1e-9 and r[3]==0))
print(" (n-1)|lmin| bound violations:",sum(1 for r in rows if r[0]>r[5]+1e-9))
sat=[r[0]/r[5] for r in rows if r[5]>0]
print(" theta/((n-1)|lmin|): min %.4f max %.4f  #equalities: %d of %d"%(min(sat),max(sat),sum(1 for v in sat if v>1-1e-6),len(sat)))
low=[r for r in rows if r[3]==0 and r[1]<cap]
print(" ker=0 with dim E_+ < cap:",len(low)," max theta there:",max([r[0] for r in low],default=None))
print(" ker=0 total:",sum(1 for r in rows if r[3]==0)," DONE")
