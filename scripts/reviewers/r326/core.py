"""Reviewer 326 -- independent implementation of so(n), #, Q, Weyl_n, criticality.
Built from definitions only."""
import numpy as np
import itertools

def pairs(n):
    return [(i,j) for i in range(n) for j in range(i+1,n)]

def so_basis(n):
    """X_{ij} = (E_ij - E_ji)/sqrt(2); <X,Y> = tr(X^T Y) makes these orthonormal."""
    P = pairs(n); N = len(P)
    B = np.zeros((N,n,n))
    for a,(i,j) in enumerate(P):
        B[a,i,j] = 1/np.sqrt(2); B[a,j,i] = -1/np.sqrt(2)
    return B,P

_cache = {}
def struct(n):
    """c[a,b,c] = <[X_a,X_b], X_c>, totally antisymmetric."""
    if n in _cache: return _cache[n]
    B,P = so_basis(n)
    N = len(P)
    # [X_a,X_b] = X_a X_b - X_b X_a ; <A,B> = tr(A^T B) = -tr(AB) for antisym
    XB = np.einsum('aij,bjk->abik', B, B)
    C = XB - np.transpose(XB, (1,0,2,3))
    c = np.einsum('abik,cik->abc', C, B)*np.sqrt(2.0)
    # NORMALISATION: the record identifies so(n) with Lambda^2 R^n, basis e_i^e_j = E_ij-E_ji
    # orthonormal, i.e. <A,B> = tr(A^T B)/2.  In that convention c^2 = 1 on triangles and
    # sum_{ab} c_{vab}^2 = 2(n-2) for unit v.  Rescaling c by sqrt(2) reproduces it exactly.
    _cache[n] = (c,P,B)
    return c,P,B

def sharp(W, n):
    """(W#)_{ab} = 1/2 sum c_{ace} c_{bdf} W_cd W_ef."""
    c,P,B = struct(n)
    A = np.einsum('ace,cd->ade', c, W)
    D = np.einsum('bdf,ef->bde', c, W)
    return 0.5*np.einsum('ade,bde->ab', A, D)

def Q(W,n):
    return W@W + sharp(W,n)

def tensor4(W,n):
    """R_{ijkl} = <W (e_i^e_j), e_k^e_l>, e_i^e_j = E_ij - E_ji = sqrt2 X_ij."""
    c,P,B = struct(n)
    # M[a,i,j] = component: e_i^e_j = sqrt2 * X_{ij} for i<j (antisym in ij)
    n_ = n
    E = np.zeros((len(P), n_, n_))
    for a,(i,j) in enumerate(P):
        E[a,i,j] = np.sqrt(2); E[a,j,i] = -np.sqrt(2)
    # coefficient of e_i^e_j in basis X_a: <e_i^e_j, X_a> = sqrt2 delta
    co = np.einsum('aij,bij->ab', E, B)   # = sqrt2 * I
    G = co.T @ W @ co                     # 2*W  in pair index
    R = np.einsum('ab,aij,bkl->ijkl', G/2.0, E/np.sqrt(2), E/np.sqrt(2))
    return R

def bianchi_resid(W,n):
    R = tensor4(W,n)
    return np.abs(R + np.transpose(R,(0,2,3,1)) + np.transpose(R,(0,3,1,2))).max()

def ricci_resid(W,n):
    R = tensor4(W,n)
    return np.abs(np.einsum('ijil->jl', R)).max()

def is_weyl(W,n,tol=1e-10):
    return dict(sym=np.abs(W-W.T).max(), bianchi=bianchi_resid(W,n), ricci=ricci_resid(W,n),
                norm=np.linalg.norm(W))

def crit(W,n):
    """theta = <W,Q(W)>; residual = ||Q(W) - theta W||."""
    QW = Q(W,n)
    th = float(np.sum(W*QW))
    return th, float(np.linalg.norm(QW - th*W))

def eig_bracket(W,n):
    """eigenvalues lam and structure constants in the eigenbasis."""
    c,P,B = struct(n)
    lam,U = np.linalg.eigh(W)
    ce = np.einsum('abc,ai,bj,ck->ijk', c, U, U, U)
    return lam, ce, U

def diag_W(M):
    """W = diag over phi_{ab} with eigenvalue M[a,b]; M symmetric hollow."""
    n = M.shape[0]; P = pairs(n); N = len(P)
    return np.diag([M[i,j] for (i,j) in P])
