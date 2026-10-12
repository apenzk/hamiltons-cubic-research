import sys; sys.path.insert(0,'scripts/reviewers/r97')
import numpy as np
from weyl97 import *
def spq(n,p):
    q=n-p; assert q>=2 and p>=2
    a=q/(p-1); b=p/(q-1); c=-1.0
    P=pairs(n); D=len(P); L=np.zeros((n,n))
    for (i,j) in P:
        v = a if (i<p and j<p) else (b if (i>=p and j>=p) else c)
        L[i,j]=L[j,i]=v
    assert np.abs(L.sum(axis=1)).max()<1e-12
    M=np.diag([L[i,j] for (i,j) in P]); M/=np.linalg.norm(M)
    return M
def cp2():
    n=4; P=pairs(4); idx={p:k for k,p in enumerate(P)}
    def bv(terms):
        v=np.zeros(6)
        for (i,j,s) in terms:
            if i<j: v[idx[(i,j)]]+=s
            else: v[idx[(j,i)]]-=s
        return v/np.linalg.norm(v)
    w1=bv([(0,1,1),(2,3,1)]); w2=bv([(0,2,1),(3,1,1)]); w3=bv([(0,3,1),(1,2,1)])
    t=1/np.sqrt(6)
    M=2*t*np.outer(w1,w1)-t*np.outer(w2,w2)-t*np.outer(w3,w3)
    return M
def check_in_Wn(M,n):
    W=M_to_W(M,n)
    b=np.abs(W+np.einsum('jkil->ijkl',W)+np.einsum('kijl->ijkl',W)).max()
    t=np.abs(np.einsum('ikjk->ij',W)).max()
    return b,t
print("=== named points ===")
for n,p in [(4,2),(6,3),(8,4),(10,5),(5,2),(6,2),(7,3),(9,4)]:
    M=spq(n,p); b,t=check_in_Wn(M,n); W=M_to_W(M,n)
    O=Wring(W,n,'iklj'); t3=np.trace(M@M@M)
    th=theta(M,n); rhs=1.5*t3-0.5*np.trace(O@O@O)
    th0=np.sqrt(2*(n-1)*(n-2))/n
    tag = " <-- balanced" if 2*p==n else ""
    print(f"S^{p}xS^{n-p} n={n}: bianchi={b:.1e} trace={t:.1e} |M|={np.linalg.norm(M):.6f} theta={th:.9f} claimB_rhs={rhs:.9f} theta0(n)={th0:.9f} 3trM3={3*t3:.9f}{tag}")
M=cp2(); b,t=check_in_Wn(M,4); W=M_to_W(M,4); O=Wring(W,4,'iklj'); t3=np.trace(M@M@M)
print(f"CP^2 n=4: bianchi={b:.1e} trace={t:.1e} |M|={np.linalg.norm(M):.6f} theta={theta(M,4):.9f} claimB_rhs={1.5*t3-0.5*np.trace(O@O@O):.9f} sqrt(3/2)={np.sqrt(1.5):.9f} 3trM3={3*t3:.9f} trO2={np.trace(O@O):.9f}")
