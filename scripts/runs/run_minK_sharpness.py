"""Find the true sharp constant in |min K| >= c(n) sqrt(t), by MINIMISING |min K| over the
vertex class at fixed t.  This is counterexample-hunting for a conjectured sharp form --
a legitimate use of numerics.  The derived bound gives c = 1/sqrt(n(n-1)(n-2)); the balanced
sphere product sits at 1/sqrt((n-1)(n-2)), a factor sqrt(n) above.  Which is sharp?
"""
import numpy as np, itertools
from scipy.optimize import minimize
rng=np.random.default_rng(223)
def basis(n):
    """orthonormal basis of {K hollow symmetric, zero row sums} -- dimension n(n-3)/2."""
    pr=list(itertools.combinations(range(n),2)); N=len(pr); V=[]
    for _ in range(6*n*n):
        v=rng.standard_normal(N); K=np.zeros((n,n))
        for c,(i,j) in enumerate(pr): K[i,j]=K[j,i]=v[c]
        for _ in range(300):
            r=K.sum(1)/(n-2); K=K-np.add.outer(r,r)+(K.sum()/((n-1)*(n-2)))
            np.fill_diagonal(K,0); K=(K+K.T)/2
        V.append(np.array([K[i,j] for (i,j) in pr]))
    U,sv,_=np.linalg.svd(np.array(V).T,full_matrices=False)
    d=n*(n-3)//2
    return [U[:,k] for k in range(d)], pr, d
def Kof(v,B,pr,n):
    c=sum(v[k]*B[k] for k in range(len(B))); K=np.zeros((n,n))
    for q,(i,j) in enumerate(pr): K[i,j]=K[j,i]=c[q]
    return K
for n in [6,8,10]:
    B,pr,d=basis(n)
    def absmin(v):
        K=Kof(v,B,pr,n); nr=np.linalg.norm(K)
        if nr<1e-9: return 9.0
        K=K*np.sqrt(2)/nr                       # fix t = 2
        return abs(K[~np.eye(n,dtype=bool)].min())    # MINIMISE it: we want the sharp lower bound
    best=9.0
    for s in range(40):
        v0=rng.standard_normal(d)
        r=minimize(absmin,v0,method='Nelder-Mead',options={'maxiter':8000,'fatol':1e-13,'xatol':1e-11})
        if r.fun<best: best=r.fun
    derived=np.sqrt(2/(n*(n-1)*(n-2))); sphere=np.sqrt(2/((n-1)*(n-2)))
    print(f"n={n:2d}  t=2:  derived bound {derived:.6f}   sphere product {sphere:.6f}   MIN FOUND {best:.6f}"
          f"   ratio to derived {best/derived:.3f}, to sphere {best/sphere:.3f}")
