"""Reviewer 327: independent implementation of so(n), #, Weyl_n, criticality.
Built from definitions only. Conventions:
  Lambda^2 R^n = so(n), inner product <X,Y> = -tr(XY)/2, orthonormal basis
  A_{ij} = e_i e_j^T - e_j e_i^T for i<j.
  W is a symmetric operator on so(n).  W^#_{ab} = -(1/2) tr(ad_a W ad_b W).
  Q(W) = W^2 + W^#.  Critical: Q(W) = theta W, |W|_HS = 1.
"""
import numpy as np
from itertools import combinations

def pairs(n):
    return list(combinations(range(n), 2))

def basis_mats(n):
    P = pairs(n); N = len(P)
    B = np.zeros((N, n, n))
    for a, (i, j) in enumerate(P):
        B[a, i, j] = 1.0; B[a, j, i] = -1.0
    return B  # <A,A> = -tr(A^2)/2 = 1

def ip(X, Y):           # inner product on so(n)
    return -0.5*np.tensordot(X, Y, axes=([-2,-1],[-1,-2]))

def ad_mats(n):
    """M[a][c,d] = coefficient of phi_c in [phi_a, phi_d]."""
    B = basis_mats(n); N = B.shape[0]
    M = np.zeros((N, N, N))
    for a in range(N):
        C = B[a] @ B - B @ B[a]           # (N,n,n): [A_a, A_d]
        M[a] = np.einsum('dij,cji->cd', C, B) * (-0.5)
    return M

def struct_const(n):
    """c[a,b,c] = <[phi_a,phi_b],phi_c>, totally antisymmetric."""
    M = ad_mats(n)
    return np.einsum('acb->abc', M)   # M[a][c,b] = coeff of phi_c in [phi_a,phi_b]

def sharp(W, M):
    N = W.shape[0]
    BW = np.einsum('acd,de->ace', M, W)          # ad_a W
    return -0.5*np.einsum('ace,bec->ab', BW, BW)

def Q(W, M):
    return W @ W + sharp(W, M)

# ---------- Weyl_n ----------
def sym_coords(n):
    """orthonormal basis of Sym(so(n)) wrt <X,Y>=tr(XY); returns index helpers."""
    N = n*(n-1)//2
    idx = [(a,b) for a in range(N) for b in range(a,N)]
    return N, idx

def vec(X, idx):
    return np.array([X[a,b]*(1.0 if a==b else np.sqrt(2.0)) for a,b in idx])

def unvec(v, idx, N):
    X = np.zeros((N,N))
    for k,(a,b) in enumerate(idx):
        if a==b: X[a,a]=v[k]
        else:
            X[a,b]=X[b,a]=v[k]/np.sqrt(2.0)
    return X

def weyl_constraints(n):
    """Rows of a matrix A acting on vec(X): Bianchi + Ricci = 0."""
    P = pairs(n); pidx = {p:k for k,p in enumerate(P)}
    N = len(P); _, idx = sym_coords(n)
    kof = {(a,b):k for k,(a,b) in enumerate(idx)}
    def ent(i,j,k,l):
        """coefficients of R_{ijkl} = <R(e_i^e_j), e_k^e_l> in vec coords."""
        if i==j or k==l: return {}
        s = 1.0
        if i>j: i,j,s = j,i,-s
        if k>l: k,l,s = l,k,-s
        a,b = pidx[(i,j)], pidx[(k,l)]
        if a>b: a,b = b,a
        f = s*(1.0 if a==b else 1.0/np.sqrt(2.0))
        return {kof[(a,b)]: f}
    rows = []
    def addrow(terms):
        r = np.zeros(len(idx))
        for (i,j,k,l),co in terms:
            for key,f in ent(i,j,k,l).items(): r[key]+= co*f
        rows.append(r)
    for i,j,k,l in combinations(range(n),4):
        addrow([((i,j,k,l),1),((i,k,l,j),1),((i,l,j,k),1)])
    for i in range(n):
        for k in range(i,n):
            addrow([((i,j,k,j),1) for j in range(n)])
    return np.array(rows)

_wcache = {}
def weyl_proj(n):
    """orthogonal projector (in vec coords) onto Weyl_n."""
    if n in _wcache: return _wcache[n]
    A = weyl_constraints(n)
    # row space of A -> complement
    U,s,Vt = np.linalg.svd(A, full_matrices=False)
    r = int((s > 1e-9*s.max()).sum())
    V = Vt[:r]
    Pm = np.eye(A.shape[1]) - V.T@V
    _wcache[n] = Pm
    return Pm

def proj_weyl(X, n):
    N,idx = sym_coords(n)
    Pm = weyl_proj(n)
    return unvec(Pm@vec(X,idx), idx, N)

def dist_weyl(X, n):
    Y = proj_weyl(X, n)
    return np.linalg.norm(X-Y)

def dim_weyl(n):
    return int(round(np.trace(weyl_proj(n))))
