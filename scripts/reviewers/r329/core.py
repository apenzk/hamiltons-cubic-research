"""Reviewer 329 -- independent implementation of Q, #, Weyl_n, criticality.
Built from definitions only. No reuse of the record's scripts."""
import numpy as np
import itertools, math

def so_basis(n):
    """Orthonormal basis of Lambda^2 R^n identified with so(n).
    phi_{ij} <-> matrix e_j e_i^T - e_i e_j^T, i<j.  <A,B> = -1/2 tr(AB) makes it orthonormal."""
    idx = [(i,j) for i in range(n) for j in range(i+1,n)]
    N = len(idx)
    B = np.zeros((N,n,n))
    for a,(i,j) in enumerate(idx):
        B[a,j,i] = 1.0
        B[a,i,j] = -1.0
    return idx, B

def struct_consts(n):
    """c_{abc} = <[phi_a,phi_b], phi_c> with <A,B> = -1/2 tr(AB)."""
    idx, B = so_basis(n)
    N = len(idx)
    c = np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            C = B[a]@B[b] - B[b]@B[a]
            if not np.any(C): continue
            for cc,(i,j) in enumerate(idx):
                # <C, phi_cc> = -1/2 tr(C phi_cc) = C[j,i]*1?  compute directly
                c[a,b,cc] = -0.5*np.trace(C@B[cc])
    return idx, B, c

def sharp(W, c):
    """(W^#)_{kl} = 1/2 sum_{abcd} c_{kab} c_{lcd} W_{ac} W_{bd}."""
    # M_{k,c,b} = sum_a c_{kab} W_{ac}
    T1 = np.einsum('kab,ac->kcb', c, W)
    T2 = np.einsum('kcb,bd->kcd', T1, W)
    return 0.5*np.einsum('kcd,lcd->kl', T2, c)

def Q(W, c):
    return W@W + sharp(W,c)

def _pairidx(n):
    return [(i,j) for i in range(n) for j in range(i+1,n)]

def op_to_R(W, n):
    """R_{ijkl} from symmetric operator W on Lambda^2 (basis e_i^e_j, i<j)."""
    idx = _pairidx(n); pos = {p:a for a,p in enumerate(idx)}
    R = np.zeros((n,n,n,n))
    for a,(i,j) in enumerate(idx):
        for b,(k,l) in enumerate(idx):
            v = W[a,b]
            R[i,j,k,l]= v; R[j,i,k,l]=-v; R[i,j,l,k]=-v; R[j,i,l,k]= v
    return R

def bianchi_ricci(W, n):
    R = op_to_R(W,n)
    Bi = R + np.transpose(R,(0,2,3,1)) + np.transpose(R,(0,3,1,2))   # R_ijkl+R_iklj+R_iljk
    Ric = np.einsum('ijkj->ik', R)
    return Bi, Ric

def weyl_basis(n, tol=1e-9):
    """Orthonormal basis (as vectors in sym N x N) of W_n = ker(Bianchi) cap ker(Ric), via SVD."""
    idx = _pairidx(n); N=len(idx)
    cols=[]; params=[]
    for a in range(N):
        for b in range(a,N):
            E = np.zeros((N,N)); E[a,b]=1.0; E[b,a]=1.0
            if a==b: E[a,b]=1.0
            params.append(E)
    rows=[]
    for E in params:
        Bi,Ric = bianchi_ricci(E,n)
        rows.append(np.concatenate([Bi.ravel(), Ric.ravel()]))
    A = np.array(rows).T                      # constraints x params
    U,s,Vt = np.linalg.svd(A, full_matrices=True)
    k = int((s>tol*max(1.0,s[0])).sum())
    K = Vt[k:]                                # null space, params coords
    P = np.array([E.ravel() for E in params]) # params -> flat matrix
    Bas = K@P                                 # each row is a flat N x N matrix
    # orthonormalise in the matrix (Frobenius) inner product
    Bg = np.array([b.reshape(N,N) for b in Bas])
    G = np.einsum('aij,bij->ab', Bg, Bg)
    w,V = np.linalg.eigh(G)
    keep = w>1e-10
    Bo = np.einsum('ka,aij->kij', (V[:,keep]/np.sqrt(w[keep])).T, Bg)
    return Bo

def dist_weyl(W, Bo):
    """distance of symmetric W from span(Bo) (orthonormal, Frobenius)."""
    coef = np.einsum('kij,ij->k', Bo, W)
    proj = np.einsum('k,kij->ij', coef, Bo)
    return np.linalg.norm(W-proj), proj

def theta0(n): return math.sqrt(2*(n-1)*(n-2))/n

def crit_data(W, c, n, Bo=None):
    QW = Q(W,c)
    th = float(np.tensordot(W,QW))/float(np.tensordot(W,W))
    res = np.linalg.norm(QW-th*W)
    d = None
    if Bo is not None: d = dist_weyl(W,Bo)[0]
    ev = np.linalg.eigvalsh(W)
    lmin, lmax = ev[0], ev[-1]
    slack = lmin+(n-2)*lmax-th
    return dict(theta=th, res=res, dist=d, lmin=lmin, lmax=lmax, slack=slack, ev=ev)

def subalg_W(n, blocks):
    """W = Pi_h - (dim h/N) I  normalised, h = span of phi_{ij} with i,j in same block."""
    idx=_pairidx(n); N=len(idx)
    h=[a for a,(i,j) in enumerate(idx) if blocks[i]==blocks[j]]
    P=np.zeros((N,N))
    for a in h: P[a,a]=1.0
    W=P-(len(h)/N)*np.eye(N)
    return W/np.linalg.norm(W), h
