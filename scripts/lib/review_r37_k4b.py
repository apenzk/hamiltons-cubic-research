"""Is the Schur step legitimate?  The honest ambient statement: sharp_bilin(I_p,.)
preserves the RAW (pp,mix) support block; compute the commutant of O(p)xO(q) there
(multiplicity-freeness) and on the -1/2 eigenspace (irreducibility of X_p (x) R^q)."""
import sys; sys.path.insert(0, 'scripts/lib')
import numpy as np
from scipy.linalg import block_diag
from review_r37_core import *
from review_r37_k1 import mask_ppmix

def lie_gens(p,q):
    """so(p) + so(q) generators as n x n matrices."""
    n=p+q; out=[]
    from itertools import combinations
    for (i,j) in combinations(range(p),2):
        X=np.zeros((n,n)); X[i,j]=1; X[j,i]=-1; out.append(X)
    for (i,j) in combinations(range(p,n),2):
        X=np.zeros((n,n)); X[i,j]=1; X[j,i]=-1; out.append(X)
    return out

def dlambda2(X, n):
    """derivative of Lambda^2 at identity: acts on Lambda^2 as ad-like."""
    P=pairs_of(n); N=len(P); idx={pp:a for a,pp in enumerate(P)}
    M=np.zeros((N,N))
    for b,(k,l) in enumerate(P):
        # d/dt (e^{tX} phi_kl e^{-tX}) = X phi_kl - phi_kl X ... in terms of basis
        ph=np.zeros((n,n)); ph[k,l]=1; ph[l,k]=-1
        C=X@ph - ph@X
        for a,(i,j) in enumerate(P): M[a,b]=C[i,j]
    return M

def commutant_dim(U, gens_lie, refl_rhos, tag=""):
    """U: (d, N, N) orthonormal basis of an invariant subspace of Sym^2(Lambda^2)?
    Here U is (d, N) columns spanning an invariant subspace of R^N under rho.
    gens_lie: list of dxd matrices (the restricted Lie action).
    refl_rhos: list of dxd orthogonal matrices (restricted reflection action)."""
    d=gens_lie[0].shape[0]
    C=np.zeros((d*d,d*d))
    I=np.eye(d)
    for X in gens_lie:
        K=np.kron(I,X)-np.kron(X.T,I)
        C+=K.T@K
    w,v=np.linalg.eigh(C)
    ker=v[:, w<1e-8*max(1.0,w.max())]
    dso=ker.shape[1]
    # now impose reflections
    cur=ker
    for R in refl_rhos:
        A=np.kron(R,R)              # vec(R M R^T) = kron(R,R) vec(M) with row-major vec
        G=cur.T@A@cur
        ww,vv=np.linalg.eigh(0.5*(G+G.T))
        cur=cur@vv[:, ww>0.5]
    return dso, cur.shape[1]

for (p,q) in [(3,4),(3,5),(4,4)]:
    n=p+q; A=struct_A(n); N=A.shape[0]; Ip=I_block(p,q,'p'); mask=mask_ppmix(p,q)
    # orthonormal basis of the raw (pp,mix) block, as (d,N,N)
    bas=[]
    for a in range(N):
        for b in range(a+1,N):
            if mask[a,b]:
                E=np.zeros((N,N)); E[a,b]=E[b,a]=1/np.sqrt(2.0); bas.append(E)
    bas=np.array(bas); d=bas.shape[0]
    M=np.zeros((d,d))
    for j in range(d): M[:,j]=coords(bas, sharp_bilin(Ip,bas[j],A))
    w,v=np.linalg.eigh(0.5*(M+M.T))
    # restricted Lie action on the block: V -> dr V + V dr^T with dr = dlambda2(X)
    def restricted_lie(sub):   # sub: (m,N,N) orthonormal
        out=[]
        for X in lie_gens(p,q):
            dr=dlambda2(X,n)
            G=np.array([[np.tensordot(sub[a], dr@sub[b]+sub[b]@dr.T) for b in range(sub.shape[0])] for a in range(sub.shape[0])])
            out.append(G)
        return out
    def restricted_refl(sub):
        out=[]
        for which in ('p','q'):
            g=np.eye(n)
            g[0,0] = -1 if which=='p' else 1
            if which=='q': g[p,p]=-1
            rho=lambda2(g)
            G=np.array([[np.tensordot(sub[a], rho@sub[b]@rho.T) for b in range(sub.shape[0])] for a in range(sub.shape[0])])
            out.append(G)
        return out
    if d<=64:
        dso,do=commutant_dim(None, restricted_lie(bas), restricted_refl(bas))
        print(f"({p},{q}) raw (pp,mix) block dim {d}: dim Comm_SO(p)xSO(q) = {dso}, dim Comm_O(p)xO(q) = {do}", flush=True)
    else:
        print(f"({p},{q}) raw block dim {d}: full-block commutant skipped (too large)", flush=True)
    # the -1/2 eigenspace alone
    sel=v[:, np.abs(w+0.5)<1e-8]
    Esub=np.einsum('kd,dij->kij', sel.T, bas)
    dso,do=commutant_dim(None, restricted_lie(Esub), restricted_refl(Esub))
    print(f"      E(-1/2) dim {Esub.shape[0]} (= X(p)q = {p*(p*p-4)//3*q}): dim Comm_SO = {dso}, dim Comm_O = {do}", flush=True)
