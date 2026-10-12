"""Reviewer 58: independent implementation. No import of any code under review."""
import numpy as np
from itertools import combinations

def pairs(n):
    return list(combinations(range(n), 2))

def phis(n):
    """orthonormal so(n) basis phi_ij = E_ij - E_ji, <X,Y> = 1/2 tr(X^T Y)."""
    P = np.zeros((n*(n-1)//2, n, n))
    for a,(i,j) in enumerate(pairs(n)):
        P[a,i,j] = 1.0; P[a,j,i] = -1.0
    return P

_cache = {}
def struct(n):
    """c[a,b,g] = <[phi_a,phi_b], phi_g>."""
    if ('c',n) in _cache: return _cache[('c',n)]
    P = phis(n)
    comm = np.einsum('aij,bjk->abik', P, P) - np.einsum('bij,ajk->abik', P, P)
    c = 0.5*np.einsum('abik,gik->abg', comm, P)
    _cache[('c',n)] = c
    return c

def Amats(n):
    """(A_a)_{mn} = c_{amn}"""
    return struct(n)

def wsharp(W, n):
    """(W#)_{ab} = -1/2 tr(A_a W A_b W)."""
    A = Amats(n)
    M = np.einsum('amn,np->amp', A, W)          # A_a W
    return -0.5*np.einsum('amp,bpm->ab', M, M)

def Q(W, n):
    return W@W + wsharp(W, n)

def theta(W, n):
    return float(np.sum(W*Q(W,n)))

def fro(W):
    return float(np.sqrt(np.sum(W*W)))

# ---- tensor view -------------------------------------------------------
def pair_index(n):
    idx = {}
    for a,(i,j) in enumerate(pairs(n)):
        idx[(i,j)] = (a, 1.0); idx[(j,i)] = (a, -1.0)
    return idx

def R_of(W, n):
    """full 4-tensor R[i,j,k,l] from the pair-basis matrix"""
    idx = pair_index(n)
    R = np.zeros((n,n,n,n))
    for (i,j),(a,s1) in idx.items():
        for (k,l),(b,s2) in idx.items():
            R[i,j,k,l] = s1*s2*W[a,b]
    return R

def ricci(W, n):
    R = R_of(W,n)
    return np.einsum('ikjk->ij', R)

def bianchi_resid(W, n):
    R = R_of(W,n)
    B = R + np.transpose(R,(0,2,3,1)) + np.transpose(R,(0,3,1,2))
    return float(np.max(np.abs(B)))

# ---- Weyl_n as a linear space -----------------------------------------
def sym_basis(N):
    B = []
    for p in range(N):
        for q in range(p, N):
            M = np.zeros((N,N))
            if p==q: M[p,p]=1.0
            else: M[p,q]=M[q,p]=1.0/np.sqrt(2)
            B.append(M)
    return np.array(B)

def weyl_basis(n, tol=1e-9):
    """orthonormal basis (as flattened NxN sym matrices) of Weyl_n."""
    if ('wb',n) in _cache: return _cache[('wb',n)]
    N = n*(n-1)//2
    B = sym_basis(N)
    idx = pair_index(n)
    rows = []
    # Bianchi: for i<j<k<l
    for (i,j,k,l) in combinations(range(n),4):
        r = np.zeros(len(B))
        for m,M in enumerate(B):
            def g(p,q,s,t):
                a,s1 = idx[(p,q)]; b,s2 = idx[(s,t)]
                return s1*s2*M[a,b]
            r[m] = g(i,j,k,l)+g(i,k,l,j)+g(i,l,j,k)
        rows.append(r)
    # Ricci
    for i in range(n):
        for j in range(i,n):
            r = np.zeros(len(B))
            for m,M in enumerate(B):
                s = 0.0
                for k in range(n):
                    if k==i or k==j: continue
                    a,s1 = idx[(i,k)]; b,s2 = idx[(j,k)]
                    s += s1*s2*M[a,b]
                r[m] = s
            rows.append(r)
    Cm = np.array(rows)
    u,s,vt = np.linalg.svd(Cm)
    rank = int(np.sum(s>tol*max(1.0,s[0])))
    ns = vt[rank:]                    # (d, len(B))
    basis = np.einsum('dm,mij->dij', ns, B)
    # orthonormalise in Frobenius
    flat = basis.reshape(len(basis), -1)
    qq,_ = np.linalg.qr(flat.T)
    basis = qq.T.reshape(-1, N, N)
    _cache[('wb',n)] = basis
    return basis

def project_weyl(W, n):
    B = weyl_basis(n)
    f = B.reshape(len(B),-1)
    return (f.T @ (f @ W.reshape(-1))).reshape(W.shape)

def pad(W0, n0, n):
    N = n*(n-1)//2
    W = np.zeros((N,N))
    pr = pairs(n); i0 = {p:a for a,p in enumerate(pairs(n0))}
    for a,p in enumerate(pr):
        if p not in i0: continue
        for b,q in enumerate(pr):
            if q not in i0: continue
            W[a,b] = W0[i0[p], i0[q]]
    return W

def wcp2():
    """W of CP^2 in dim 4: (2 u3 u3^T - u1 u1^T - u2 u2^T)/sqrt6 on self-dual part."""
    n=4; P = phis(4); pr = pairs(4)
    def e(i,j):
        a = pr.index((i,j)); return P[a]
    SD = [ (e(0,1)+e(2,3))/np.sqrt(2), (e(0,2)-e(1,3))/np.sqrt(2), (e(0,3)+e(1,2))/np.sqrt(2) ]
    # coordinates in the pair basis
    V = np.array([[0.5*np.trace(s.T@P[a]) for a in range(6)] for s in SD])
    W = (2*np.outer(V[2],V[2]) - np.outer(V[0],V[0]) - np.outer(V[1],V[1]))/np.sqrt(6)
    return W
