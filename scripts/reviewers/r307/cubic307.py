"""Precompute the totally symmetric cubic tensor TQ_{aij} = <B_a, B_i o B_j> of
P(W) = <W, W^2 + W#W> on a chosen orthonormal basis {B_a}.  With it every solve is a
tensordot instead of 155 sharp evaluations.

  P(c)   = TQ_aij c_a c_i c_j
  grad_a = 3 TQ_aij c_i c_j                      (so Q(W) has Weyl-coefficients TQ_aij c_i c_j)
  F_a    = TQ_aij c_i c_j - theta c_a,  theta = P(c) at |c| = 1
  J_ab   = 2 TQ_aib c_i - 3 c_a (TQ_bij c_i c_j) - theta delta_ab
"""
import os, sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r307')
from core307 import cstruct


def build_TQ(n, basis, verbose=True):
    A = cstruct(n)                       # (N,N,N)
    N = A.shape[0]
    d = basis.shape[0]
    # R[j,a,m,n] = (A_a B_j)_{mn}
    R = np.einsum('amk,jkn->jamn', A, basis, optimize=True)
    Rt = np.ascontiguousarray(R.transpose(0, 1, 3, 2)).reshape(d*N, N*N)
    TQ = np.zeros((d, d, d))
    for i in range(d):
        AX = R[i].reshape(N, N*N)                    # (a, mn)
        T = (AX @ Rt.T).reshape(N, d, N)             # T[a,j,b] = tr(A_a B_i A_b B_j)
        # <B_i # B_j, B_k> = -1/2 sum_ab T[a,j,b] B_k[a,b]
        TQ[i] = -0.5*np.einsum('ajb,kab->jk', T, basis, optimize=True)
        if verbose and i % 25 == 0:
            print(f'   sharp cubic {i}/{d}', flush=True)
    # add the W^2 part: <B_a, sym(B_i B_j)> = tr(B_a B_i B_j) symmetrised
    BB = np.einsum('aij,bjk->abik', basis, basis, optimize=True)     # (d,d,N,N)
    S = np.einsum('abik,cki->abc', BB, basis, optimize=True)
    S = (S + S.transpose(0,2,1) + S.transpose(1,0,2) + S.transpose(1,2,0)
         + S.transpose(2,0,1) + S.transpose(2,1,0))/6.0
    TQ = (TQ + TQ.transpose(0,2,1) + TQ.transpose(1,0,2) + TQ.transpose(1,2,0)
          + TQ.transpose(2,0,1) + TQ.transpose(2,1,0))/6.0
    return TQ + S


def cached_TQ(n, p, basis, path=None):
    path = path or f'scripts/reviewers/r307/tq_n{n}_p{p}.npy'
    if os.path.exists(path):
        T = np.load(path)
        if T.shape[0] == basis.shape[0]:
            return T
    T = build_TQ(n, basis)
    np.save(path, T)
    return T
