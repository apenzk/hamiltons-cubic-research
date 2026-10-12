import numpy as np, sys, math
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
from scipy.linalg import expm

def proj_W(T):
    n=T.shape[0]
    T=bianchi(sym_riemann(T)); T=sym_riemann(T)
    Q=kn_basis(n); v=T.ravel(); v=v-Q@(Q.T@v)
    return v.reshape(n,n,n,n)

_PIDX={}
def pidx(n):
    if n not in _PIDX:
        P=pairs(n); I=np.array([p[0] for p in P]); J=np.array([p[1] for p in P])
        _PIDX[n]=(P,I,J)
    return _PIDX[n]

def M_from_W(W):
    n=W.shape[0]; P,I,J=pidx(n)
    return W[I[:,None],J[:,None],I[None,:],J[None,:]]

def W_from_GM(GM,n):
    P,I,J=pidx(n)
    G=np.zeros((n,n,n,n))
    q=GM/4.0
    G[I[:,None],J[:,None],I[None,:],J[None,:]] += q
    G[J[:,None],I[:,None],I[None,:],J[None,:]] -= q
    G[I[:,None],J[:,None],J[None,:],I[None,:]] -= q
    G[J[:,None],I[:,None],J[None,:],I[None,:]] += q
    return G

def theta_grad(W):
    n=W.shape[0]; M=M_from_W(W)
    Ms=sharp(M,n)
    th=np.trace(M@M@M)+np.sum(Ms*M)
    GM=3.0*(M@M+Ms)
    return th, proj_W(W_from_GM(GM,n))

def k2_grad_W(W,F):
    n=W.shape[0]
    T=rotate(W,F)
    diag=np.einsum('abab->ab',T).copy(); np.fill_diagonal(diag,0.0)
    D=np.zeros((n,n,n,n))
    for a in range(n):
        for b in range(n):
            if a!=b: D[a,b,a,b]=2*diag[a,b]
    G=np.einsum('abcd,ia,jb,kc,ld->ijkl',D,F,F,F,F,optimize=True)
    return np.sum(diag*diag), proj_W(G)

def kappa_warm(W,F0,rng,starts=3,iters=200):
    cands=[F0] if F0 is not None else []
    return kappa2(W,starts=len(cands)+starts,iters=iters,rng=rng,F0list=cands)
