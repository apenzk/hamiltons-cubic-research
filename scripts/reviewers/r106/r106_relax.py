"""The both-sided Schur-Horn relaxation at a fixed vertex matrix K, and its slope."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
from scipy.optimize import minimize
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r106'))
from r106_core import *
rng=np.random.default_rng(11)

def side_max(dvec,S2,sign,starts=40):
    """max sign*sum x^3  s.t. sum x = 0, sum x^2 = S2, x majorizes dvec"""
    m=len(dvec); a=np.sort(dvec)[::-1]; cs=np.cumsum(a)
    def obj(x): return -sign*np.sum(x**3)
    cons=[{'type':'eq','fun':lambda x: x.sum()},
          {'type':'eq','fun':lambda x: x@x-S2},
          {'type':'ineq','fun':lambda x: np.cumsum(x)[:-1]-cs[:-1]},
          {'type':'ineq','fun':lambda x: x[:-1]-x[1:]}]
    best=-np.inf;bx=None
    for s in range(starts):
        if s==0: x0=a*np.sqrt(S2/(a@a))
        else:
            x0=np.sort(rng.standard_normal(m))[::-1]; x0-=x0.mean(); x0*=np.sqrt(S2)/np.linalg.norm(x0)
        r=minimize(obj,x0,constraints=cons,method='SLSQP',
                   options={'maxiter':400,'ftol':1e-12})
        x=r.x
        ok=(abs(x.sum())<1e-7 and abs(x@x-S2)<1e-6
            and (np.cumsum(x)[:-1]-cs[:-1]).min()>-1e-6)
        if ok and sign*np.sum(x**3)>best: best=sign*np.sum(x**3); bx=x
    return best,bx

def relax_at_K(K,n,starts=30):
    D=len(pairs(n))
    a=np.array([K[i,j] for i,j in pairs(n)])
    ev=np.linalg.eigvalsh(K)
    # restrict to 1-perp: drop the eigenvalue whose eigenvector is 1/sqrt(n) (=0)
    w,V=np.linalg.eigh(K); one=np.ones(n)/np.sqrt(n)
    k=int(np.argmax(np.abs(V.T@one))); b=-np.delete(w,k)
    dpsi=np.concatenate([a,b])
    m1,_=side_max(a,1.0,+1,starts)
    m2,_=side_max(dpsi,3.0,-1,starts)
    return 1.5*m1+0.5*m2

if __name__=="__main__":
    n=int(sys.argv[1]) if len(sys.argv)>1 else 12
    W=sphere_product(n//2,n//2); nrm=np.linalg.norm(to_M(W))
    Kst=vertex_matrix(W)/nrm
    print(f"n={n} theta0={theta0(n):.6f}  |K*|^2={np.linalg.norm(Kst)**2:.6f}")
    print(f"{'c':>7} {'t':>9} {'2-t':>9} {'R(K)':>10} {'R-theta0':>10} {'slope':>9}")
    for c in [1.0,0.999,0.995,0.99,0.98,0.95,0.90]:
        K=c*Kst; t=np.linalg.norm(K)**2
        R=relax_at_K(K,n,20)
        eps=2-t
        print(f"{c:>7.3f} {t:>9.5f} {eps:>9.5f} {R:>10.6f} {R-theta0(n):>10.6f} "
              f"{(R-theta0(n))/eps if eps>0 else float('nan'):>9.4f}")
