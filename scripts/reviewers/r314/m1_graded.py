import sys, os, time, itertools
sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L

def sphere_product(n,p):
    q=n-p
    g=-1.0/(n-1); a=q/((n-1)*(p-1)) if p>1 else 0.0; b=p/((n-1)*(q-1)) if q>1 else 0.0
    Lam=np.zeros((n,n))
    for i in range(n):
        for j in range(n):
            if i==j: continue
            if i<p and j<p: Lam[i,j]=a
            elif i>=p and j>=p: Lam[i,j]=b
            else: Lam[i,j]=g
    return L.diag_op(n,Lam)

def theta_of(n,W):
    r=np.linalg.norm(W); Wh=W/r
    Qh=L.Q(n,Wh)
    th=float(np.sum(Wh*Qh))
    res=np.abs(Qh-th*Wh).max()
    return th,res,Wh

if __name__=='__main__':
  n=12
  for p in [4,5,6]:
    W=sphere_product(n,p)
    th,res,Wh=theta_of(n,W)
    print(f"n={n} S^{p}xS^{n-p}: theta={th:.9f} theta^2={th*th:.9f} crit_res={res:.2e} weylres={np.abs(L.weyl_proj_factory(n)[0](Wh)-Wh).max():.2e}")
  print('sqrt(3/2)=',np.sqrt(1.5))
