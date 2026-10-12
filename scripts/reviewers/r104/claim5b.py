"""Strongest one-frame version (frame chosen to MINIMISE the relaxation), and the
multi-frame version the brief asks about."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r104'))
import numpy as np, weyl104 as w, relax104 as R
from scipy.optimize import minimize
from scipy.linalg import expm

def rotate(W,Q): return np.einsum('ia,jb,kc,ld,abcd->ijkl',Q,Q,Q,Q,W,optimize=True)

def theta_of(W,n):
    M=w.tensor_to_M(W,n); K=w.vertex_matrix(W,n)
    vecs,_=w.K_eigvecs_on_1perp(K,n)
    Rop=w.ring_W_operator(W,n,list(vecs))
    return 1.5*w.p3(np.linalg.eigvalsh(M))-0.5*w.p3(np.linalg.eigvalsh(Rop))

def inner_multi(ds,S,sign,nstarts=40,seed=0):
    """max sign*p3(x), ||x||^2=S, sum x=0, x >- d for EVERY d in ds."""
    N=len(ds[0]); cds=[np.cumsum(np.sort(np.asarray(d))[::-1]) for d in ds]
    rng=np.random.default_rng(seed)
    cons=[{'type':'eq','fun':lambda x: np.sum(x)},
          {'type':'eq','fun':lambda x: np.sum(x**2)-S},
          {'type':'ineq','fun':lambda x: x[:-1]-x[1:]}]
    for cd in cds:
        cons.append({'type':'ineq','fun':(lambda cd: (lambda x: np.cumsum(x)[:-1]-cd[:-1]))(cd)})
    best=-np.inf; bx=None
    starts=[]
    ok=np.concatenate([[N-1.0],-np.ones(N-1)]); ok*=np.sqrt(S/np.sum(ok**2))
    starts+= [ok, np.sort(-ok)[::-1]]
    for k in range(2,min(N,8)):
        v=np.concatenate([np.ones(k)*(N-k),-np.ones(N-k)*k]).astype(float); v*=np.sqrt(S/np.sum(v**2))
        starts+=[v,np.sort(-v)[::-1]]
    for _ in range(nstarts):
        z=np.sort(rng.standard_normal(N))[::-1]; z-=z.mean(); z*=np.sqrt(S/np.sum(z**2)); starts.append(z)
    for x0 in starts:
        r=minimize(lambda x:-sign*np.sum(x**3),x0,jac=lambda x:-sign*3*x**2,
                   constraints=cons,method='SLSQP',options={'maxiter':600,'ftol':1e-12})
        x=np.sort(r.x)[::-1]
        if abs(np.sum(x))>1e-7 or abs(np.sum(x**2)-S)>1e-7: continue
        if any((np.cumsum(x)[:-1]-cd[:-1]).min()<-1e-7 for cd in cds): continue
        v=sign*np.sum(x**3)
        if v>best: best,bx=v,x
    return best

n=6; th0=np.sqrt(2*(n-1)*(n-2))/n
tri=np.triu_indices(n,1)
def Qof(x):
    A=np.zeros((n,n)); A[tri]=x; return expm(A-A.T)

def sphere_prod(p,q):
    m=p+q; Rt=np.zeros((m,m,m,m))
    for blk in (list(range(p)),list(range(p,m))):
        gb=np.zeros((m,m))
        for i in blk: gb[i,i]=1.0
        Rt+=0.5*w.kn(gb,gb)
    W=w.weyl_project(w.bianchi_project(Rt),m)
    return W/np.linalg.norm(w.tensor_to_M(W,m))

rng=np.random.default_rng(555)
cases=[("random A",w.random_weyl(n,rng)),("random B",w.random_weyl(n,rng))]
Wsp=sphere_prod(3,3); cases.append(("S3xS3",Wsp))
Wp=Wsp+0.15*w.random_weyl(n,np.random.default_rng(3)); cases.append(("S3xS3+0.15",Wp/np.linalg.norm(w.tensor_to_M(Wp,n))))

print(f"theta_0(6) = {th0:.6f}")
print(f"{'W':>12} {'theta':>9} {'min_F Relax':>12} {'20-frame Relax':>15} {'60-frame':>10}")
for name,W in cases:
    th=theta_of(W,n)
    # (1) frame chosen to MINIMISE the relaxation
    def f(x):
        K=w.vertex_matrix(rotate(W,Qof(x)),n)
        return R.relax_for_K(K,nstarts=10)[0]
    best=9e9
    for s in range(5):
        x0=np.zeros(len(tri[0])) if s==0 else np.random.default_rng(s).standard_normal(len(tri[0]))
        r=minimize(f,x0,method='Powell',options={'maxiter':4000,'xtol':1e-4,'ftol':1e-6})
        K=w.vertex_matrix(rotate(W,Qof(r.x)),n)
        best=min(best,R.relax_for_K(K,nstarts=50)[0])
    # (2) many frames at once
    def multi(nf,seed):
        dsp=[];dsd=[]
        rg=np.random.default_rng(seed)
        for k in range(nf):
            Q=np.eye(n) if k==0 else np.linalg.qr(rg.standard_normal((n,n)))[0]
            K=w.vertex_matrix(rotate(W,Q),n)
            a,b=R.d_from_K(K); dsp.append(a); dsd.append(b)
        return 1.5*inner_multi(dsp,1.0,+1,nstarts=25)+0.5*(-inner_multi(dsd,3.0,-1,nstarts=25))*-1
    m20=multi(20,1); m60=multi(60,2)
    print(f"{name:>12} {th:>9.5f} {best:>12.5f} {m20:>15.5f} {m60:>10.5f}")
