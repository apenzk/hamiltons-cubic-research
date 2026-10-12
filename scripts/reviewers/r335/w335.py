"""Reviewer 335: independent implementation of the Weyl / Hamilton-Q setting.

Conventions (fixed here, checked in selftest):
  Lambda^2 R^n basis phi_{ij} = e_i ^ e_j, i<j, orthonormal.
  Identified with so(n) by phi_{ij} <-> E_ij - E_ji, inner product <X,Y> = tr(X^T Y)/2.
  c_abc = <[phi_a,phi_b],phi_c>;  T_abc = c_abc^2.
  (A#B)_ab = 1/2 sum_{cdef} c_acd c_bef A_ce B_df ;  W^# = W#W ; Q(W) = W^2 + W^#.
  Weyl W: symmetric operator on Lambda^2, first Bianchi, Ricci = 0, ||W||^2 = tr(W^2) = 1.
"""
import numpy as np, itertools, functools

def pairs(n):
    return [(i,j) for i in range(n) for j in range(i+1,n)]

@functools.lru_cache(maxsize=None)
def struct(n):
    """structure constants c[a,b,c] on so(n) in the phi basis."""
    P = pairs(n); N = len(P); idx = {p:k for k,p in enumerate(P)}
    M = np.zeros((N,n,n))
    for k,(i,j) in enumerate(P):
        M[k,i,j] = 1.0; M[k,j,i] = -1.0
    c = np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            br = M[a]@M[b] - M[b]@M[a]
            # <br, phi_c> = tr(br^T phi_c)/2 = br[i,j] for c=(i,j)
            for k,(i,j) in enumerate(P):
                c[a,b,k] = br[i,j]
    return c

@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal basis (list of NxN symmetric matrices) of the Weyl space W_n."""
    P = pairs(n); N = len(P); idx = {p:k for k,p in enumerate(P)}
    # symmetric matrix coordinates
    coords = [(a,b) for a in range(N) for b in range(a,N)]
    D = len(coords)
    def sym(v):
        S = np.zeros((N,N))
        for t,(a,b) in enumerate(coords):
            S[a,b] += v[t]; 
            if a!=b: S[b,a] += v[t]
        return S
    def Rt(S):
        """full tensor R[i,j,k,l] from operator matrix S"""
        R = np.zeros((n,n,n,n))
        for (i,j),a in idx.items():
            for (k,l),b in idx.items():
                v = S[a,b]
                for si,(ii,jj) in enumerate([(i,j),(j,i)]):
                    for sk,(kk,ll) in enumerate([(k,l),(l,k)]):
                        R[ii,jj,kk,ll] = v*(-1)**(si+sk)
        return R
    rows = []
    basisS = []
    for t in range(D):
        v = np.zeros(D); v[t] = 1.0
        basisS.append(sym(v))
    # constraints as linear functionals of the D coordinates
    cons = []
    for S in basisS:
        R = Rt(S)
        col = []
        for i in range(n):
            for j in range(n):
                for k in range(n):
                    for l in range(n):
                        col.append(R[i,j,k,l]+R[i,k,l,j]+R[i,l,j,k])
        ric = (np.einsum('ijkj->ik', R)).ravel()
        cons.append(np.concatenate([np.array(col), ric]))
    Aq = np.array(cons).T   # (#constraints, D)
    # nullspace
    U,s,Vt = np.linalg.svd(Aq)
    tol = max(Aq.shape)*np.finfo(float).eps*(s[0] if len(s) else 1.0)*10
    r = int((s>tol).sum())
    ns = Vt[r:]
    mats = [sym(w) for w in ns]
    # Gram-Schmidt in Frobenius inner product tr(XY)
    G = np.array([[np.sum(X*Y) for Y in mats] for X in mats])
    w,V = np.linalg.eigh(G)
    keep = w>1e-10
    Tm = V[:,keep]/np.sqrt(w[keep])
    out = []
    for k in range(Tm.shape[1]):
        out.append(sum(Tm[i,k]*mats[i] for i in range(len(mats))))
    return [np.array(X) for X in out]

def sharp(A,B,c):
    """(A#B)_ab = 1/2 sum c_acd c_bef A_ce B_df"""
    # X[a,d,e] = sum_c c[a,c,d] A[c,e]
    X = np.einsum('acd,ce->ade', c, A)
    return 0.5*np.einsum('ade,bdf,ef->ab'.replace('bdf','bef'), X, c, B) if False else \
           0.5*np.einsum('ade,bef,df->ab', X, c, B)

def Qmap(W,c):
    return W@W + sharp(W,W,c)

def theta_of(W,c):
    return float(np.sum(W*Qmap(W,c)))

def proj_weyl(X,B):
    return sum(float(np.sum(X*Bi))*Bi for Bi in B)

def Tten(W,c):
    """T_abc in W's eigenbasis; returns (lam, T)"""
    lam,U = np.linalg.eigh(W)
    cc = np.einsum('ai,bj,ck,ijk->abc', U, U, U, c)
    return lam, cc**2
