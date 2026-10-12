import sys, numpy as np, math, itertools
sys.path.insert(0,'scripts/reviewers/r329')
from core import *
from core import _pairidx

def W_from_h(n, hset):
    idx=_pairidx(n); N=len(idx)
    P=np.zeros((N,N))
    for a in hset: P[a,a]=1.0
    W=P-(len(hset)/N)*np.eye(N)
    nr=np.linalg.norm(W)
    return W/nr if nr>0 else W

def h_blocks(n, blocks):
    idx=_pairidx(n)
    return [a for a,(i,j) in enumerate(idx) if blocks[i]==blocks[j]]

def W_subalg_from_mats(n, mats):
    """h = span of the given so(n) matrices (in the phi basis); Pi_h via SVD."""
    idx,B=so_basis(n); N=len(idx)
    V=np.array([[ -0.5*np.trace(M@B[a]) for a in range(N)] for M in mats])
    U,s,Vt=np.linalg.svd(V, full_matrices=False)
    k=int((s>1e-9*max(s[0],1)).sum())
    Qb=Vt[:k]
    P=Qb.T@Qb
    W=P-(k/N)*np.eye(N)
    return W/np.linalg.norm(W), k

def W_cp(n, m):
    """W of CP^m padded into n>=2m: complex structure J on R^{2m}; Kaehler curvature op."""
    # curvature operator of CP^m (Fubini-Study, holomorphic sect curv 4):
    # R(X^Y) built from R_{ijkl} = g_ik g_jl - g_il g_jk + J_ik J_jl - J_il J_jk + 2 J_ij J_kl
    N2=2*m
    J=np.zeros((n,n))
    for i in range(m):
        J[2*i,2*i+1]=1; J[2*i+1,2*i]=-1
    g=np.zeros((n,n))
    for i in range(N2): g[i,i]=1.0
    R=np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g) \
      +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J) \
      +2*np.einsum('ij,kl->ijkl',J,J)
    idx=_pairidx(n); N=len(idx)
    Op=np.array([[R[i,j,k,l] for (k,l) in idx] for (i,j) in idx])
    return Op

def project_weyl(W,Bo):
    return dist_weyl(W,Bo)[1]

def diag_weyl(n,Bo,rng,ntry=1):
    """diagonal-in-the-phi-basis Weyl tensors: intersect W_n with diagonal matrices, via SVD."""
    idx=_pairidx(n); N=len(idx)
    # basis of diagonal symmetric matrices intersected with span(Bo): solve for coeffs x with off-diag(sum x_k Bo_k)=0
    rows=[]
    for a in range(N):
        for b in range(a+1,N):
            rows.append(Bo[:,a,b])
    A=np.array(rows)
    U,s,Vt=np.linalg.svd(A, full_matrices=True)
    k=int((s>1e-9*max(s[0],1)).sum())
    K=Vt[k:]
    return np.einsum('mk,kij->mij',K,Bo)
