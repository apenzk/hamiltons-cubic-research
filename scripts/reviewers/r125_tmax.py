"""Reviewer 125 -- the surviving crack: maximise mu_max(K) and t over FRAMES.
The vertex bound lambda <= mu_max(K) <= sqrt(t) with t = 2 - 2*sum R <= 2.
Does some frame give mu_max(K) >= lambda at a non-diagonal critical point?"""
import numpy as np, sys
from scipy.linalg import expm
from r125_lib import struct, Q, to_tensor, from_tensor, weyl_basis, project

def Jm(m):
    n=2*m; J=np.zeros((n,n))
    for k in range(m): J[2*k,2*k+1]=1.0; J[2*k+1,2*k]=-1.0
    return J
def fs(m):
    n=2*m; J=Jm(m); d=np.eye(n)
    return (np.einsum('ik,jl->ijkl',d,d)-np.einsum('il,jk->ijkl',d,d)
            +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)
            +2*np.einsum('ij,kl->ijkl',J,J))

n=6; m=3
b,pr,pos,N,c=weyl_basis(n)
M0=from_tensor(fs(m),pos); M0=project(M0,b); M0/=np.linalg.norm(M0)
if np.sum(M0*Q(M0,c))<0: M0=-M0
lam=float(np.sum(Q(M0,c)*M0))
W0=to_tensor(M0,pos,n)
d=n*(n-1)//2
def so(x):
    A=np.zeros((n,n)); t=0
    for i in range(n):
        for j in range(i+1,n): A[i,j]=x[t]; A[j,i]=-x[t]; t+=1
    return expm(A)
def stats(x):
    O=so(x)
    Wr=np.einsum('ia,jb,kc,ld,abcd->ijkl',O,O,O,O,W0,optimize=True)
    K=np.array([[Wr[a,bb,a,bb] for bb in range(n)] for a in range(n)])
    return float(np.linalg.eigvalsh(K)[-1]), float(np.sum(K**2))
rng=np.random.default_rng(2)
for obj,name in ((0,'mu_max(K)'),(1,'t=||K||_F^2')):
    best=(-1e9,None)
    for _ in range(300):
        x=rng.standard_normal(d)*1.2
        f=stats(x)[obj]
        if f>best[0]: best=(f,x)
    f,x=best; step=0.4
    for it in range(6000):
        y=x+rng.standard_normal(d)*step
        g=stats(y)[obj]
        if g>f: f,x=g,y
        if it%600==599: step*=0.65
    mm,tt=stats(x)
    print(f"CP^3 n=6 lambda={lam:.6f}: maximising {name} over O(6) frames ->"
          f" mu_max(K)={mm:.6f}, t={tt:.6f} (t<=2 always)")
    print(f"   lambda <= mu_max(K) in the best frame? {'YES -- ROUTE ALIVE' if lam<=mm+1e-9 else 'NO'}"
          f"   (gap factor {lam/mm:.3f})")
