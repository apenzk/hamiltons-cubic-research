"""Anchor the whole pipeline: theta(S^3 x S^3) must be sqrt(10/9)=1.054092553389."""
import numpy as np
import importlib.util, sys, os
spec = importlib.util.spec_from_file_location("c", os.path.join(os.path.dirname(__file__), "r109_collapse.py"))

# re-implement the pieces we need rather than import (the module runs on import)
def kn(A,B):
    o = np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
    o -= np.einsum('il,jk->ijkl',A,B)+np.einsum('jk,il->ijkl',A,B)
    return o

def weyl_from_riemann(R,n):
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); S=np.trace(Ric); Ric0=Ric-(S/n)*g
    return R - kn(Ric0,g)/(n-2) - S/(2*n*(n-1))*kn(g,g)

def sphere_product(p,q):
    n=p+q; R=np.zeros((n,n,n,n))
    gp=np.zeros((n,n)); gp[:p,:p]=np.eye(p)
    gq=np.zeros((n,n)); gq[p:,p:]=np.eye(q)
    R+=0.5*kn(gp,gp); R+=0.5*kn(gq,gq)   # kn(g,g)/2 gives constant curvature 1 block
    return weyl_from_riemann(R,n),n

def pairs(n): return [(i,j) for i in range(n) for j in range(i+1,n)]

def theta_of(W,n):
    P=pairs(n); N=len(P)
    M=np.array([[W[i,j,k,l] for (k,l) in P] for (i,j) in P])
    M=M/np.linalg.norm(M)
    lam,V=np.linalg.eigh(M)
    B=np.zeros((N,n,n))
    for a,(i,j) in enumerate(P): B[a,i,j]=1.0; B[a,j,i]=-1.0
    Vso=np.einsum('ba,bij->aij',V,B)
    comm=np.einsum('aik,bkj->abij',Vso,Vso)-np.einsum('bik,akj->abij',Vso,Vso)
    C=0.5*np.einsum('abij,gij->gab',comm,Vso); T=C**2
    p3=float((lam**3).sum()); sharp=0.5*np.einsum('gab,g,a,b->',T,lam,lam,lam)
    ad=0.5*(np.einsum('gik,bkj->gbij',Vso,B)-np.einsum('bik,gkj->gbij',B,Vso))
    ad=np.einsum('gbij,aij->gab',ad,B)
    g=np.array([np.linalg.norm(ad[k]@M-M@ad[k])**2 for k in range(N)])
    return p3+sharp,p3,sharp,lam,g,M

for (p,q) in [(3,3),(2,4),(4,4),(3,5)]:
    W,n=sphere_product(p,q)
    th,p3,sh,lam,g,M=theta_of(W,n)
    print(f"S^{p}xS^{q}  n={n}  theta={th:.12f}  p3={p3:.9f} <W#,W>={sh:.9f}  "
          f"sum g={g.sum():.9f} (4(n-1)={4*(n-1)})  sum lam g={lam@g:.9f} vs -4th={-4*th:.9f}")
print("expected theta(S^3xS^3) = sqrt(10/9) =", np.sqrt(10/9))
print("expected theta_0(2k)^2 = 2-3/k+1/k^2 : k=4 ->", np.sqrt(2-3/4+1/16))
