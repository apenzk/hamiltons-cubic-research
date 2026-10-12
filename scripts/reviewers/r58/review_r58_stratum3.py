"""Fast gradient hunt for signature (1 pos, 2 neg) inside Weyl_n."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *
from scipy.optimize import minimize

def make(n):
    B = weyl_basis(n); return B, B.reshape(len(B),-1)

def hunt(n, tries=200, seed=3, verbose=False):
    B,Bf = make(n); d=len(B); P=phis(n)
    r = np.random.default_rng(seed); found=[]
    def fg(X):
        nx = np.linalg.norm(X); x = X/nx
        W = np.einsum('d,dij->ij', x, B)
        lam,V = np.linalg.eigh(W)
        sel = [0,1,len(lam)-1]
        f = 1.0 - sum(lam[i]**2 for i in sel)
        g = np.zeros(d)
        for i in sel:
            v = V[:,i]
            g += -2*lam[i]*np.einsum('dij,i,j->d', B, v, v)
        # penalties: lam[1] <= -eps, lam[-1] >= eps, lam[-2] <= 0
        eps=0.02
        for (i,sgn,tgt,wt) in [(1,+1,-eps,50.0),(len(lam)-1,-1,eps,50.0),(len(lam)-2,+1,0.0,50.0)]:
            val = sgn*(lam[i]-tgt)
            if val>0:
                f += wt*val**2
                v=V[:,i]
                g += 2*wt*val*sgn*np.einsum('dij,i,j->d', B, v, v)
        g = (g - np.dot(g,x)*x)/nx
        return f, g
    for t in range(tries):
        X0 = r.standard_normal(d)
        res = minimize(fg, X0, jac=True, method='L-BFGS-B',
                       options={'maxiter':4000,'maxfun':8000,'ftol':1e-18,'gtol':1e-14})
        x = res.x/np.linalg.norm(res.x)
        W = np.einsum('d,dij->ij', x, B)
        lam,V = np.linalg.eigh(W)
        tol=1e-6
        npos=int(np.sum(lam>tol)); nneg=int(np.sum(lam<-tol))
        if npos==1 and nneg==2:
            rk=lambda M:int(np.sum(np.linalg.svd(M,compute_uv=False)>1e-6))
            v1=np.einsum('p,pij->ij',V[:,-1],P); v2=np.einsum('p,pij->ij',V[:,0],P); v3=np.einsum('p,pij->ij',V[:,1],P)
            found.append((theta(W,n), (rk(v1),rk(v2),rk(v3)), np.sort(lam[np.abs(lam)>tol]), W))
    return found

for n in [5,6,7,8]:
    f = hunt(n, tries=150, seed=100+n)
    print('n=%d : %d hits with signature (1 pos, 2 neg)'%(n,len(f)))
    if f:
        th=[a for a,_,_,_ in f]
        print('   theta: min %.12f max %.12f   sqrt(3/2)=%.12f'%(min(th),max(th),np.sqrt(1.5)))
        print('   rank triples:', sorted(set(b for _,b,_,_ in f)))
        s=sorted(set(tuple(np.round(c*np.sqrt(6),5)) for _,_,c,_ in f))
        print('   spectra*sqrt6 (distinct):', s[:6], '...' if len(s)>6 else '')
    sys.stdout.flush()
