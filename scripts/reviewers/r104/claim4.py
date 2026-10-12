import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r104'))
import numpy as np, weyl104 as w, relax104 as R
from scipy.optimize import minimize

n=int(sys.argv[1]) if len(sys.argv)>1 else 6
N=n*(n-1)//2; D=n*(n+1)//2-1
th0=np.sqrt(2*(n-1)*(n-2))/n
cap=1.5*(N-2)/np.sqrt(N*(N-1))+0.5*3**1.5*(D-2)/np.sqrt(D*(D-1))
print(f"n={n}: theta_0={th0:.6f}, product-of-Okumura cap={cap:.6f}")

def sphere_prod_K(p,q):
    m=p+q; Rt=np.zeros((m,m,m,m))
    for blk in (list(range(p)),list(range(p,m))):
        gb=np.zeros((m,m))
        for i in blk: gb[i,i]=1.0
        Rt+=0.5*w.kn(gb,gb)
    W=w.weyl_project(w.bianchi_project(Rt),m); M=w.tensor_to_M(W,m)
    return w.vertex_matrix(W/np.linalg.norm(M),m)

idx=[(i,j) for i in range(n) for j in range(i+1,n)]
def build(v):
    K=np.zeros((n,n))
    for a,(i,j) in enumerate(idx): K[i,j]=K[j,i]=v[a]
    return K
def vec(K): return np.array([K[i,j] for (i,j) in idx])

def project_K(K,t):
    for _ in range(500):
        rs=K.sum(axis=1)
        K=K-(np.add.outer(rs,rs))/(n-2)+(rs.sum()/((n-1)*(n-2)))*(np.ones((n,n))-np.eye(n))
        np.fill_diagonal(K,0); K=(K+K.T)/2
        if np.abs(K.sum(axis=1)).max()<1e-15: break
    nr=np.linalg.norm(K)
    return K/nr*np.sqrt(t) if nr>1e-14 else K

K0s=[sphere_prod_K(p,n-p) for p in range(3,n//2+1)] if n>=6 else []
rng=np.random.default_rng(4242)
print(f"{'t':>6} {'best Relax':>11} {'/theta_0':>9} {'from':>10}   [mu-part, om-part]")
for t in (0.05,0.1,0.25,0.5,1.0,1.5,1.8,1.9,1.95,1.99,2.0):
    best=(-9e9,None,'')
    # (a) scaled sphere-product K
    for K0 in K0s:
        K=project_K(K0.copy(),t); v,a,b=R.relax_for_K(K,nstarts=30)
        if v>best[0]: best=(v,(a,b),'s*K_sphere')
    # (b) random K
    for _ in range(150):
        K=R.random_vertex_matrix(n,t,rng); v,a,b=R.relax_for_K(K,nstarts=12)
        if v>best[0]: best=(v,(a,b),'random K')
    # (c) ascent over K from the best few starts
    def negf(x):
        K=project_K(build(x),t)
        return -R.relax_for_K(K,nstarts=8)[0]
    starts=[vec(project_K(K0.copy(),t)) for K0 in K0s]
    for _ in range(6):
        starts.append(vec(R.random_vertex_matrix(n,t,rng)))
    for x0 in starts:
        r=minimize(negf,x0,method='Nelder-Mead',options={'maxiter':1200,'fatol':1e-8,'xatol':1e-6})
        K=project_K(build(r.x),t); v,a,b=R.relax_for_K(K,nstarts=40)
        if v>best[0]: best=(v,(a,b),'ascent over K')
    print(f"{t:>6} {best[0]:>11.5f} {best[0]/th0:>9.3f} {best[2]:>14}   [{best[1][0]:.4f}, {best[1][1]:.4f}]")
