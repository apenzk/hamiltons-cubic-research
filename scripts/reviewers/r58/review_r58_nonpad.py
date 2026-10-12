"""Is there a (1 pos,2 neg) Weyl_n element with nondegenerate positive eigenvector (=> not a padding)?"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *
from scipy.optimize import minimize

def run(n, tries=300, seed=7):
    N=n*(n-1)//2; P=phis(n); m=n//2
    Bw=weyl_basis(n); Bf=Bw.reshape(len(Bw),-1)
    pr=pairs(n); pidx={p:a for a,p in enumerate(pr)}
    r=np.random.default_rng(seed)
    def obj(x):
        s=np.exp(x[:m]); s=s/np.linalg.norm(s)          # v1 block-diagonal, nondegenerate
        v1=np.zeros(N)
        for k in range(m): v1[pidx[(2*k,2*k+1)]]=s[k]
        u2=x[m:m+N]; u3=x[m+N:m+2*N]
        M=np.array([v1,u2,u3]); qq,_=np.linalg.qr(M.T); V=qq.T
        V[0]=v1*np.sign(np.dot(qq.T[0],v1))
        # re-orthonormalise keeping v1 exactly
        w2=u2-np.dot(u2,V[0])*V[0]; w2/=np.linalg.norm(w2)
        w3=u3-np.dot(u3,V[0])*V[0]; w3-=np.dot(w3,w2)*w2; w3/=np.linalg.norm(w3)
        a=np.exp(x[m+2*N]); b=np.exp(x[m+2*N+1]); l1=a+b
        W=l1*np.outer(v1,v1)-a*np.outer(w2,w2)-b*np.outer(w3,w3)
        W=W/fro(W)
        w=W.reshape(-1); res=w-Bf.T@(Bf@w)
        return float(np.sum(res**2)), W, s, a, b
    best=(9e9,None)
    t0=time.time(); hits=[]
    for t in range(tries):
        x0=r.standard_normal(m+2*N+2)*0.7
        res=minimize(lambda x: obj(x)[0], x0, method='L-BFGS-B',
                     options={'maxiter':6000,'maxfun':12000,'ftol':1e-20,'gtol':1e-16})
        f,W,s,a,b=obj(res.x)
        if f<best[0]: best=(f,(W,s,a,b))
        if f<1e-18: hits.append((W,s,a,b))
    print('n=%d tries=%d time=%.0fs  best residual %.3e  hits(<1e-18): %d'%(n,tries,time.time()-t0,best[0],len(hits)),flush=True)
    W,s,a,b=best[1]
    print('   best: s(v1)=',np.round(s,5),' a=%.5f b=%.5f'%(a,b),' theta=%.9f'%theta(W,n),flush=True)
    lam=np.linalg.eigvalsh(W); print('   spectrum:',np.round(lam[np.abs(lam)>1e-7],6),flush=True)
    for W,s,a,b in hits[:3]:
        print('   HIT s=',np.round(s,5),'theta=%.9f'%theta(W,n),flush=True)

for n in [6,8]:
    run(n, tries=250 if n==6 else 80, seed=n*11)
