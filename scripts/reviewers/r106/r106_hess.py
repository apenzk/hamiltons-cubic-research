"""Machinery for Claim 4: the cubic form, its gradient, and the second-order
form at the diagonal maximiser restricted to off-diagonal Weyl directions."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r106'))
from r106_core import *
from scipy.sparse.linalg import LinearOperator, eigsh

def from_M_fast(M,n):
    P,_=pair_index(n); idx=np.array(P); W=np.zeros((n,n,n,n))
    I,J=idx[:,0],idx[:,1]
    W[np.ix_(I,J,I,J)]=M     # placeholder, filled below properly
    W=np.zeros((n,n,n,n))
    for si,sj in ((1,1),(-1,1),(1,-1),(-1,-1)):
        pass
    # direct assignment via broadcasting over the four index-sign combinations
    A=np.zeros((n,n,n,n))
    A[I[:,None],J[:,None],I[None,:],J[None,:]] = M
    A[J[:,None],I[:,None],I[None,:],J[None,:]] = -M
    A[I[:,None],J[:,None],J[None,:],I[None,:]] = -M
    A[J[:,None],I[:,None],J[None,:],I[None,:]] = M
    return A

def Pi_W(M,n):
    """orthogonal projection of a symmetric Lambda^2 matrix onto the Weyl subspace"""
    return to_M(weyl_project(from_M_fast(M,n)))

def sharp(M,n):
    c=struct(n)
    return 0.5*np.einsum('agd,bez,ge,dz->ab',c,c,M,M,optimize=True)

def Theta(M,n):   # cubic, unnormalised
    return np.trace(M@M@M)+np.sum(sharp(M,n)*M)

def grad(M,n):    # nabla Theta = 3(M^2 + M^#)
    return 3.0*(M@M+sharp(M,n))

def Tform(X,Y,Z,n):
    """symmetric trilinear T with T(X,X,X)=Theta(X), by polarization"""
    return (Theta(X+Y+Z,n)-Theta(X+Y,n)-Theta(Y+Z,n)-Theta(X+Z,n)
            +Theta(X,n)+Theta(Y,n)+Theta(Z,n))/6.0

def offdiag_basis_op(Mstar,n):
    """linear operator L on Weyl_off with <L d, d> = 6 T(Mstar,d,d)"""
    D=len(pairs(n))
    def proj_off(A):
        B=Pi_W((A+A.T)/2,n); B=B-np.diag(np.diag(B)); return B
    def matvec(v):
        d=np.zeros((D,D)); iu=np.triu_indices(D,1)
        d[iu]=v[:len(iu[0])]; d=d+d.T
        # symmetric matrices with zero diagonal are enough: Weyl_off has zero diagonal
        d=proj_off(d)
        L=(grad(Mstar+d,n)-grad(Mstar-d,n))/2.0
        L=proj_off(L)
        return L[iu]
    N=D*(D-1)//2
    return LinearOperator((N,N),matvec=matvec,dtype=float), N
