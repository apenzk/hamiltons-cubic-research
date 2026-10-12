import numpy as np
from core import *; from weyl import *; from tools import *

def invariant_subspace(bas, pairs, g):
    """orthonormal basis of {W in span(bas) : L W L^T = W} where L = Lambda^2 g"""
    L = lam2(g, pairs)
    F = bas.reshape(len(bas),-1)
    N = bas.shape[1]
    # action on coefficients
    A = np.zeros((len(bas),len(bas)))
    for k,Wk in enumerate(bas):
        A[:,k] = F@ (L@Wk@L.T).ravel()
    # eigenvalue +1 subspace
    lam,V = np.linalg.eigh((A+A.T)/2)
    sel = V[:, np.abs(lam-1)<1e-8]
    # verify
    sub = np.einsum('ik,ijl->kjl', sel, bas)
    return sub

def make_sigma(n,k):
    d = np.ones(n); d[k:] = -1.0
    return np.diag(d)

def make_J(n):
    g=np.zeros((n,n))
    for i in range(n//2):
        g[2*i,2*i+1]=-1.0; g[2*i+1,2*i]=1.0
    return g
