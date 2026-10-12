"""Hunt inside Weyl_n directly for signature (1 pos, 2 neg)."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *
from scipy.optimize import minimize

def analyse(W,n,tag=''):
    lam = np.linalg.eigvalsh(W); P = phis(n)
    return lam

def hunt(n, tries=80, seed=3, push_rank=False):
    B = weyl_basis(n); d=len(B); N=n*(n-1)//2
    r = np.random.default_rng(seed); found=[]
    P = phis(n)
    def W_of(x):
        W = np.einsum('d,dij->ij', x, B); return W/fro(W)
    def obj(x):
        W = W_of(x)
        lam,V = np.linalg.eigh(W)
        # keep lam[0],lam[1] (most negative) and lam[-1] (most positive)
        rest = 1.0 - lam[0]**2 - lam[1]**2 - lam[-1]**2
        pen = max(0.0, lam[1]+1e-3)**2*10 + max(0.0,-lam[-1])**2*10   # lam1<0 , lammax>0
        pen += max(0.0, lam[-2])**2*10   # second largest <= 0
        o = rest + pen
        if push_rank:
            v1 = np.einsum('p,pij->ij', V[:,-1], P)
            s = np.linalg.svd(v1, compute_uv=False)
            o += 0.3*max(0.0, 0.25 - s[n-2 if n%2 else n-1])**2 if False else 0.0
            o -= 0.05*s[2*((n//2)-1)]     # reward large smallest singular value of v1
        return o
    for t in range(tries):
        x0 = r.standard_normal(d)
        res = minimize(obj, x0, method='Powell', options={'maxiter':200000,'maxfev':200000,'xtol':1e-12,'ftol':1e-14})
        res = minimize(obj, res.x, method='Nelder-Mead', options={'maxiter':60000,'fatol':1e-16,'xatol':1e-12})
        W = W_of(res.x); lam,V = np.linalg.eigh(W)
        npos=int(np.sum(lam>1e-7)); nneg=int(np.sum(lam<-1e-7))
        if npos==1 and nneg==2:
            v1 = np.einsum('p,pij->ij', V[:,-1], P)
            v2 = np.einsum('p,pij->ij', V[:,0], P)
            v3 = np.einsum('p,pij->ij', V[:,1], P)
            rk = lambda M: int(np.sum(np.linalg.svd(M,compute_uv=False)>1e-6))
            found.append(dict(theta=theta(W,n), spec=lam[np.abs(lam)>1e-7],
                              rk=(rk(v1),rk(v2),rk(v3)),
                              cap=None, W=W))
    return found

for n,pr in [(5,False),(6,False),(6,True),(8,False),(8,True)]:
    f = hunt(n, tries=25, seed=10+n, push_rank=pr)
    print('n=%d push_rank=%s : %d hits'%(n,pr,len(f)))
    if f:
        th=[d['theta'] for d in f]
        print('   theta  min %.12f  max %.12f   target sqrt(3/2)=%.12f'%(min(th),max(th),np.sqrt(1.5)))
        print('   ranks (v_pos,v_neg1,v_neg2):', sorted(set(d['rk'] for d in f)))
        best=max(f,key=lambda d:d['theta'])
        print('   spectrum*sqrt6 of best:', np.round(np.sort(best['spec'])*np.sqrt(6),8))
    sys.stdout.flush()
