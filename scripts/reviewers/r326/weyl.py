"""Reviewer 326 -- an explicit orthonormal basis of Weyl_n."""
import numpy as np, sys, os, itertools
sys.path.insert(0,os.path.dirname(__file__)); import core

_wc={}
def weyl_basis(n):
    if n in _wc: return _wc[n]
    P=core.pairs(n); N=len(P); idx={pq:i for i,pq in enumerate(P)}
    def cell(i,j):
        if i==j: return None,0
        return (idx[(i,j)],1.0) if i<j else (idx[(j,i)],-1.0)
    # symmetric-matrix coordinates
    sym=[(a,b) for a in range(N) for b in range(a,N)]
    sidx={ab:t for t,ab in enumerate(sym)}
    D=len(sym)
    def addR(row,i,j,k,l,coef):
        a,sa=cell(i,j); b,sb=cell(k,l)
        if a is None or b is None: return
        key=(a,b) if a<=b else (b,a)
        row[sidx[key]]+=coef*sa*sb
    rows=[]
    for i,j,k,l in itertools.combinations(range(n),4):
        for (p,q,r,s) in [(i,j,k,l),(i,j,l,k),(i,k,j,l)]:
            pass
        # Bianchi on the 4-set: R_ijkl + R_iklj + R_iljk = 0 (single independent relation)
        row=np.zeros(D); addR(row,i,j,k,l,1); addR(row,i,k,l,j,1); addR(row,i,l,j,k,1)
        rows.append(row)
    for a in range(n):
        for b in range(a,n):
            row=np.zeros(D)
            for i in range(n): addR(row,i,a,i,b,1)
            rows.append(row)
    A=np.array(rows)
    u,s,vt=np.linalg.svd(A)
    ns=vt[(s.shape[0] if A.shape[0]<D else 0):] if False else vt[np.sum(s>1e-9):]
    B=[]
    for v in ns:
        Mx=np.zeros((N,N))
        for t,(a,b) in enumerate(sym):
            Mx[a,b]+=v[t]; 
            if a!=b: Mx[b,a]+=v[t]
        B.append(Mx/np.linalg.norm(Mx))
    B=np.array(B)
    # re-orthonormalise in the Frobenius inner product
    G=np.einsum('aij,bij->ab',B,B)
    L=np.linalg.cholesky(np.linalg.inv(G))
    B=np.einsum('ba,bij->aij',L,B)
    _wc[n]=B
    return B

def project(S,n):
    B=weyl_basis(n)
    return np.einsum('a,aij->ij', np.einsum('aij,ij->a',B,S), B)

def random_weyl(n,rng):
    B=weyl_basis(n)
    c=rng.normal(size=B.shape[0]); W=np.einsum('a,aij->ij',c,B)
    return W/np.linalg.norm(W)
