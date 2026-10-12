"""Hunt: elements of Weyl_n with exactly 1 positive and 2 negative eigenvalues."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *
from scipy.optimize import minimize

def build(x, n, N):
    v = x[:3*N].reshape(3,N)
    # Gram-Schmidt
    qq,_ = np.linalg.qr(v.T); v = qq.T
    a = x[3*N]**2 + 1e-12; b = x[3*N+1]**2 + 1e-12
    l1 = a+b
    W = l1*np.outer(v[0],v[0]) - a*np.outer(v[1],v[1]) - b*np.outer(v[2],v[2])
    return W/fro(W), v, a, b

def hunt(n, tries=60, seed=1):
    N = n*(n-1)//2
    B = weyl_basis(n); f = B.reshape(len(B),-1)
    r = np.random.default_rng(seed); out=[]
    def obj(x):
        W,_,_,_ = build(x,n,N)
        w = W.reshape(-1); pw = f.T@(f@w)
        return float(np.sum((w-pw)**2))
    for t in range(tries):
        x0 = r.standard_normal(3*N+2)
        res = minimize(obj, x0, method='L-BFGS-B', options={'maxiter':3000,'maxfun':30000,'ftol':1e-18,'gtol':1e-14})
        if res.fun < 1e-16:
            W,v,a,b = build(res.x,n,N)
            P = phis(n)
            v1 = np.einsum('p,pij->ij', v[0], P)
            v2 = np.einsum('p,pij->ij', v[1], P)
            v3 = np.einsum('p,pij->ij', v[2], P)
            rk = lambda M: int(np.sum(np.linalg.svd(M, compute_uv=False) > 1e-7))
            lam = np.linalg.eigvalsh(W)
            npos = int(np.sum(lam > 1e-8)); nneg = int(np.sum(lam < -1e-8))
            out.append(dict(res=res.fun, theta=theta(W,n), spec=np.round(lam[np.abs(lam)>1e-8],6),
                            r1=rk(v1), r2=rk(v2), r3=rk(v3), npos=npos, nneg=nneg))
    return out

for n in [5,6,7,8]:
    o = hunt(n, tries=40, seed=n)
    print('n=%d  solutions found: %d / 40'%(n,len(o)))
    if o:
        th = np.array([d['theta'] for d in o])
        print('   theta range: %.12f .. %.12f   (sqrt(3/2)=%.12f)'%(th.min(),th.max(),np.sqrt(1.5)))
        ranks = sorted(set((d['r1'],d['r2'],d['r3']) for d in o))
        print('   (rank v1, rank v2, rank v3) observed:', ranks)
        sig = sorted(set((d['npos'],d['nneg']) for d in o))
        print('   (#pos,#neg):', sig)
        print('   sample spectrum*sqrt6:', np.round(o[0]['spec']*np.sqrt(6),6))
    sys.stdout.flush()
