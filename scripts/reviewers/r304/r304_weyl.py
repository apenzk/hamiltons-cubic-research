"""Orthonormal basis of Weyl_n = {R sym on Lambda^2 : first Bianchi = 0, Ric = 0}."""
import sys, itertools; sys.path.insert(0,'scripts/reviewers/r304')
import numpy as np, r304_core as C

def pair_index(n):
    P=C.pairs(n); idx={}
    for a,(i,j) in enumerate(P): idx[(i,j)]=(a,1.0); idx[(j,i)]=(a,-1.0)
    return P, idx

def sym_coords(m):
    return [(a,b) for a in range(m) for b in range(a,m)]

def constraint_matrix(n):
    P, idx = pair_index(n); m=len(P); SC=sym_coords(m)
    col={sc:k for k,sc in enumerate(SC)}
    rows=[]
    def entry(vec,i,j,k,l,w):
        if i==j or k==l: return
        a,sa=idx[(i,j)]; b,sb=idx[(k,l)]
        key=(a,b) if a<=b else (b,a)
        vec[col[key]] += w*sa*sb
    # first Bianchi over i<j<k<l
    for (i,j,k,l) in itertools.combinations(range(n),4):
        v=np.zeros(len(SC))
        entry(v,i,j,k,l,1.0); entry(v,i,k,l,j,1.0); entry(v,i,l,j,k,1.0)
        rows.append(v)
    # Ricci: Ric_ik = sum_j T[i,j,k,j]
    for i in range(n):
        for k in range(i,n):
            v=np.zeros(len(SC))
            for j in range(n):
                if j!=i and j!=k: entry(v,i,j,k,j,1.0)
            rows.append(v)
    return np.array(rows), SC

def weyl_basis(n):
    A,SC=constraint_matrix(n); m=len(C.pairs(n))
    u,s,vt=np.linalg.svd(A)
    ns=vt[np.sum(s>1e-9):]
    out=[]
    for v in ns:
        X=np.zeros((m,m))
        for k,(a,b) in enumerate(SC):
            X[a,b]+=v[k]; 
            if a!=b: X[b,a]+=v[k]
        out.append(X/np.linalg.norm(X))
    # re-orthonormalise in Frobenius
    G=np.array([X.ravel() for X in out])
    q,_=np.linalg.qr(G.T)
    return [q[:,k].reshape(m,m) for k in range(q.shape[1])]

if __name__=='__main__':
    for n in [5,6,7,8]:
        B=weyl_basis(n); print(n, len(B), n*(n+1)*(n+2)*(n-3)//12)
