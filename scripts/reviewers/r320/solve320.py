import sys; sys.path.insert(0,'scripts/reviewers/r320')
import numpy as np, lib320 as L
from scipy.optimize import least_squares

def mk(n):
    B=L.weyl_basis(n); D=B.shape[0]
    def W_of(x):
        x=np.asarray(x); x=x/np.linalg.norm(x)
        return np.einsum('t,tab->ab',x,B)
    def resid(x):
        W=W_of(x); q=L.Q(W,n); th=L.frob(W,q)
        R=q-th*W
        return np.einsum('tab,ab->t',B,R)
    return B,D,W_of,resid

def find(n,seed,x0=None,maxit=400):
    B,D,W_of,resid=mk(n)
    rng=np.random.default_rng(seed)
    x=rng.standard_normal(D) if x0 is None else x0
    x=x/np.linalg.norm(x)
    sol=least_squares(resid,x,xtol=1e-14,ftol=1e-14,gtol=1e-14,max_nfev=maxit)
    W=W_of(sol.x); q=L.Q(W,n); th=L.frob(W,q)
    return W,th,float(np.linalg.norm(q-th*W))
