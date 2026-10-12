import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *
from scipy.optimize import minimize

def hunt(n, tries, seed):
    B = weyl_basis(n); d=len(B); Bf=B.reshape(d,-1); P=phis(n); N=n*(n-1)//2
    r=np.random.default_rng(seed); found=[]
    def quad(v): return Bf @ np.outer(v,v).reshape(-1)
    def fg(X):
        nx=np.linalg.norm(X); x=X/nx
        W=(x@Bf).reshape(N,N)
        lam,V=np.linalg.eigh(W)
        sel=[0,1,N-1]
        f=1.0-sum(lam[i]**2 for i in sel); g=np.zeros(d)
        for i in sel: g += -2*lam[i]*quad(V[:,i])
        eps=0.02
        for (i,sgn,tgt,wt) in [(1,+1,-eps,50.0),(N-1,-1,eps,50.0),(N-2,+1,0.0,50.0)]:
            val=sgn*(lam[i]-tgt)
            if val>0:
                f+=wt*val**2; g+=2*wt*val*sgn*quad(V[:,i])
        g=(g-np.dot(g,x)*x)/nx
        return f,g
    t0=time.time()
    for t in range(tries):
        res=minimize(fg, r.standard_normal(d), jac=True, method='L-BFGS-B',
                     options={'maxiter':1500,'maxfun':3000,'ftol':1e-18,'gtol':1e-14})
        x=res.x/np.linalg.norm(res.x); W=(x@Bf).reshape(N,N)
        lam,V=np.linalg.eigh(W); tol=1e-6
        if int(np.sum(lam>tol))==1 and int(np.sum(lam<-tol))==2:
            rk=lambda M:int(np.sum(np.linalg.svd(M,compute_uv=False)>1e-6))
            vs=[np.einsum('p,pij->ij',V[:,k],P) for k in (N-1,0,1)]
            found.append((theta(W,n), tuple(rk(v) for v in vs), np.sort(lam[np.abs(lam)>tol])))
    print('n=%d tries=%d time=%.1fs hits=%d'%(n,tries,time.time()-t0,len(found)), flush=True)
    if found:
        th=[a for a,_,_ in found]
        print('   theta min %.12f max %.12f   sqrt(3/2)=%.12f'%(min(th),max(th),np.sqrt(1.5)), flush=True)
        print('   rank triples (v+,v-,v-):', sorted(set(b for _,b,_ in found)), flush=True)
        print('   distinct spectra*sqrt6:', sorted(set(tuple(np.round(c*np.sqrt(6),4)) for _,_,c in found))[:8], flush=True)
    return found

for n,tr in [(5,60),(6,60),(7,40),(8,25)]:
    hunt(n,tr,100+n)
