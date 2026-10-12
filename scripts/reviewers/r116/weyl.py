import numpy as np, itertools
from core import *

def weyl_basis(n):
    pairs,B = so_basis(n)
    N = len(pairs)
    idx = {p:k for k,p in enumerate(pairs)}
    def sgn(i,j):
        if i==j: return None
        return (idx[(i,j)],1.0) if i<j else (idx[(j,i)],-1.0)
    # coordinates: symmetric NxN matrices, param by upper triangle
    coords = [(a,b) for a in range(N) for b in range(a,N)]
    D = len(coords); cidx = {c:k for k,c in enumerate(coords)}
    def put(row, a, b, v):
        key = (a,b) if a<=b else (b,a)
        row[cidx[key]] += v
    def Rentry(row, i,j,k,l, v):
        s1 = sgn(i,j); s2 = sgn(k,l)
        if s1 is None or s2 is None: return
        put(row, s1[0], s2[0], v*s1[1]*s2[1])
    rows=[]
    # first Bianchi: R_ijkl + R_iklj + R_iljk = 0, for i<j<k<l
    for i,j,k,l in itertools.combinations(range(n),4):
        r = np.zeros(D)
        Rentry(r,i,j,k,l,1.0); Rentry(r,i,k,l,j,1.0); Rentry(r,i,l,j,k,1.0)
        rows.append(r)
    # Ricci flat: sum_j R_ikjk... use Ric_il = sum_j R_ijlj
    for i in range(n):
        for l in range(i,n):
            r = np.zeros(D)
            for j in range(n):
                Rentry(r,i,j,l,j,1.0)
            rows.append(r)
    A = np.array(rows)
    # nullspace
    U,s,Vt = np.linalg.svd(A)
    tol = max(A.shape)*np.finfo(float).eps*s[0]
    ns = Vt[np.sum(s>tol):]
    # convert coordinate vectors to matrices, orthonormalise w.r.t. frobenius
    mats=[]
    for v in ns:
        M = np.zeros((N,N))
        for (a,b),k in cidx.items():
            M[a,b]+=v[k]
            if a!=b: M[b,a]+=v[k]
        mats.append(M)
    mats=np.array(mats)
    # gram-schmidt (frobenius)
    flat = mats.reshape(len(mats),-1)
    Qf,_ = np.linalg.qr(flat.T)
    basis = Qf.T.reshape(-1,N,N)
    return pairs, B, basis

def lam2(g, pairs):
    """action of g in O(n) on Lambda^2 in the E_ij basis"""
    N=len(pairs)
    M=np.zeros((N,N))
    for b,(k,l) in enumerate(pairs):
        for a,(i,j) in enumerate(pairs):
            M[a,b] = g[i,k]*g[j,l]-g[i,l]*g[j,k]
    return M
