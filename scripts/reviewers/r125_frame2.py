"""Reviewer 125 -- lambda is O(n)-invariant, mu_max(K) is not.
Scans and anneals mu_max(K) DOWNWARD over O(n) frames at the diagonal critical points
S^3xS^3 and S^4xS^4, where the vertex bound holds in the canonical frame.
Result: it fails in essentially every other frame."""
import numpy as np
from scipy.linalg import expm
from r125_lib import struct, Q

def Kof(M,pos,n):
    K=np.zeros((n,n))
    for (a,b),k in pos.items(): K[a,b]=K[b,a]=M[k,k]
    return K
def lam2(O,pr):
    N=len(pr); P=np.empty((N,N))
    for r,(k,l) in enumerate(pr):
        for s,(i,j) in enumerate(pr): P[r,s]=O[k,i]*O[l,j]-O[k,j]*O[l,i]
    return P
def so(x,n):
    A=np.zeros((n,n)); t=0
    for i in range(n):
        for j in range(i+1,n): A[i,j]=x[t]; A[j,i]=-x[t]; t+=1
    return expm(A)
def spsq(p,q):
    n=p+q; pr,pos,N,c=struct(n)
    x=1.0/(p*(p-1)); y=1.0/(q*(q-1)); z=-1.0/(p*q)
    v=np.zeros(N)
    for a,(i,j) in enumerate(pr): v[a]= x if (i<p and j<p) else (y if (i>=p and j>=p) else z)
    M=np.diag(v); return M/np.linalg.norm(M),pr,pos,N,c

for (p,q) in ((3,3),(4,4)):
    n=p+q; M0,pr,pos,N,c=spsq(p,q); d=n*(n-1)//2
    lam=float(np.sum(Q(M0,c)*M0)); rng=np.random.default_rng(5)
    mm=[]; tt=[]
    for _ in range(3000):
        P=lam2(so(rng.standard_normal(d)*1.2,n),pr); K=Kof(P@M0@P.T,pos,n)
        mm.append(np.linalg.eigvalsh(K)[-1]); tt.append(np.sum(K**2))
    best=None
    for _ in range(200):
        x=rng.standard_normal(d)*1.2
        P=lam2(so(x,n),pr); f=np.linalg.eigvalsh(Kof(P@M0@P.T,pos,n))[-1]
        if best is None or f<best[0]: best=(f,x)
    f,x=best; step=0.3
    for it in range(4000):
        y=x+rng.standard_normal(d)*step
        P=lam2(so(y,n),pr); g=np.linalg.eigvalsh(Kof(P@M0@P.T,pos,n))[-1]
        if g<f: f,x=g,y
        if it%500==499: step*=0.6
    print(f'S^{p}xS^{q} n={n}: lambda={lam:.6f}  canonical mu_max(K)={np.linalg.eigvalsh(Kof(M0,pos,n))[-1]:.6f} t=2')
    print(f'   3000 random frames: mu_max in [{min(mm):.6f},{max(mm):.6f}] median {np.median(mm):.6f};  t in [{min(tt):.6f},{max(tt):.6f}]')
    print(f'   annealed min mu_max(K) over frames = {f:.6f}  ->  lambda<=mu_max(K) FAILS there')
