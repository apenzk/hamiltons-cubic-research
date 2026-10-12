"""Reviewer 97: independent implementation of algebraic Weyl tensor cubics."""
import numpy as np
import itertools

def pairs(n):
    return [(i,j) for i in range(n) for j in range(i+1,n)]

def pair_index(n):
    P = pairs(n); return {p:k for k,p in enumerate(P)}

def M_to_W(M, n):
    """M symmetric over pairs i<j  ->  W[i,j,k,l] with Riemann pair/antisymmetry."""
    P = pairs(n); D = len(P)
    W = np.zeros((n,n,n,n))
    for a,(i,j) in enumerate(P):
        for b,(k,l) in enumerate(P):
            v = M[a,b]
            for (ii,jj,s1) in ((i,j,1),(j,i,-1)):
                for (kk,ll,s2) in ((k,l,1),(l,k,-1)):
                    W[ii,jj,kk,ll] = s1*s2*v
    return W

def W_to_M(W, n):
    P = pairs(n); D = len(P)
    M = np.zeros((D,D))
    for a,(i,j) in enumerate(P):
        for b,(k,l) in enumerate(P):
            M[a,b] = W[i,j,k,l]
    return M

def sym_param_basis(n):
    """Basis of symmetric DxD matrices, as list of (a,b) with a<=b."""
    D = n*(n-1)//2
    return [(a,b) for a in range(D) for b in range(a,D)]

def weyl_basis(n, tol=1e-9):
    """Orthonormal basis of W_n, returned as array (dimW, D, D) of M-matrices."""
    D = n*(n-1)//2
    params = sym_param_basis(n)
    P = len(params)
    rows = []
    # precompute W for each param
    Ws = np.zeros((P, n,n,n,n))
    for t,(a,b) in enumerate(params):
        M = np.zeros((D,D)); M[a,b]=1.0; M[b,a]=1.0
        Ws[t] = M_to_W(M,n)
    # Bianchi constraints
    Bi = Ws + np.transpose(Ws,(0,2,3,1,4)) + np.transpose(Ws,(0,3,1,2,4))
    # careful: build explicitly
    Bi = np.zeros_like(Ws)
    Bi = Ws.copy()
    Bi += np.einsum('tjkil->tijkl', Ws)   # W_{jkil} placed at (i,j,k,l)
    Bi += np.einsum('tkijl->tijkl', Ws)   # W_{kijl}
    C1 = Bi.reshape(P,-1)
    # trace constraints sum_k W_{ikjk}
    Tr = np.einsum('tikjk->tij', Ws).reshape(P,-1)
    C = np.concatenate([C1, Tr], axis=1).T   # (numconstraints, P)
    U,S,Vt = np.linalg.svd(C, full_matrices=True)
    rank = int((S>tol*max(S[0],1)).sum())
    null = Vt[rank:]     # (P-rank, P)
    basis = []
    for v in null:
        M = np.zeros((D,D))
        for t,(a,b) in enumerate(params):
            M[a,b]+=v[t]; M[b,a]+=v[t]
        basis.append(M)
    return np.array(basis)

def struct_consts(n):
    P = pairs(n); D = len(P); idx = pair_index(n)
    phi = np.zeros((D,n,n))
    for a,(i,j) in enumerate(P):
        phi[a,i,j]=1.0; phi[a,j,i]=-1.0
    c = np.zeros((D,D,D))
    for a in range(D):
        for b in range(D):
            A = phi[a]@phi[b] - phi[b]@phi[a]
            for p,(i,j) in enumerate(P):
                c[a,b,p] = A[i,j]
    return c

_CACHE = {}
def get_c(n):
    if n not in _CACHE: _CACHE[n] = struct_consts(n)
    return _CACHE[n]

def sharp(M, n):
    c = get_c(n)
    return 0.5*np.einsum('agd,bez,ge,dz->ab', c, c, M, M, optimize=True)

def theta(M, n):
    return np.trace(M@M@M) + np.sum(sharp(M,n)*M)

def alpha(W):
    return np.einsum('tpsq,tpkl,sqkl->', W,W,W, optimize=True)

def beta(W):
    return np.einsum('tspq,tjpl,sjql->', W,W,W, optimize=True)

def s20_basis(n):
    B = []
    for i in range(n):
        for j in range(i+1,n):
            h = np.zeros((n,n)); h[i,j]=h[j,i]=1/np.sqrt(2); B.append(h)
    # traceless diagonal, orthonormal (Gram-Schmidt on d_k = E_kk - E_{k+1,k+1})
    Ds = []
    for k in range(n-1):
        d = np.zeros(n); d[:k+1]=1.0; d[k+1]=-(k+1)
        d = d/np.linalg.norm(d)
        Ds.append(np.diag(d))
    return B+Ds

def Wring(W, n, order='iklj'):
    B = s20_basis(n); m = len(B)
    O = np.zeros((m,m))
    for b,hb in enumerate(B):
        if order=='iklj':
            img = np.einsum('iklj,kl->ij', W, hb, optimize=True)
        else:
            img = np.einsum('ikjl,kl->ij', W, hb, optimize=True)
        for a,ha in enumerate(B):
            O[a,b] = np.sum(ha*img)
    return O
