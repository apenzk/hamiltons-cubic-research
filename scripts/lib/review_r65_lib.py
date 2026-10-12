"""Reviewer 65: independent implementation of so(n), its Cartan 3-form, and
the bracket-mass functional.  Written from scratch; imports nothing from the
repo's own b0_*/b_* scripts.

Conventions (as stated in the review brief):
    basis      phi_{ij} = E_ij - E_ji   for i<j
    metric     <X,Y> = (1/2) tr(X^T Y)          (so |phi_ij| = 1)
    3-form     omega(x,y,z) = <[x,y],z>         (totally antisymmetric)
    N          = n(n-1)/2 = dim so(n)
"""
import itertools
import numpy as np


def basis(n):
    """Orthonormal basis phi_{ij}, returned as an (N, n, n) array."""
    B = []
    idx = []
    for i, j in itertools.combinations(range(n), 2):
        M = np.zeros((n, n))
        M[i, j] = 1.0
        M[j, i] = -1.0
        B.append(M)
        idx.append((i, j))
    return np.array(B), idx


def ip(X, Y):
    return 0.5 * np.tensordot(X, Y, axes=([-2, -1], [-2, -1]))


def structure_tensor(n):
    """C[i,j,k] = <[f_i,f_j], f_k>, totally antisymmetric."""
    B, _ = basis(n)
    N = B.shape[0]
    C = np.zeros((N, N, N))
    for i in range(N):
        for j in range(N):
            br = B[i] @ B[j] - B[j] @ B[i]
            C[i, j] = 0.5 * np.einsum('ab,kab->k', br, B)
    return C


def ad_matrices(n):
    """ad(f_k) as an N x N matrix acting on so(n) in the phi basis."""
    C = structure_tensor(n)
    # [f_k, f_j] = sum_i C[k,j,i] f_i   =>  (ad f_k)_{ij} = C[k,j,i]
    N = C.shape[0]
    return np.array([C[k].T for k in range(N)])   # (ad f_k)_{ij} = C[k,j,i]


def mu(V, C):
    """Bracket mass  sum_{a,b in onb(m)} |[e_a,e_b]|^2  for V (N x d) orthonormal."""
    D = np.einsum('ijk,ia,jb->abk', C, V, V, optimize=True)
    return float((D ** 2).sum())


def iso_residual(V, C):
    """sum_{a,b,c} c'_{abc}^2 over an orthonormal basis of m -- zero iff isotropic."""
    D = np.einsum('ijk,ia,jb,kc->abc', C, V, V, V, optimize=True)
    return float((D ** 2).sum())


def orth(A):
    Q, _ = np.linalg.qr(A)
    return Q


def sympair_subspace(n, p):
    """Off-block-diagonal part of so(p)+so(q), q=n-p: an isotropic subspace of dim p*q."""
    B, idx = basis(n)
    cols = [t for t, (i, j) in enumerate(idx) if i < p <= j]
    V = np.zeros((len(idx), len(cols)))
    for c, t in enumerate(cols):
        V[t, c] = 1.0
    return V


def graph_subspace(n, edges):
    """Span of {phi_e : e in edges} -- isotropic iff the edge set is triangle-free."""
    _, idx = basis(n)
    pos = {e: t for t, e in enumerate(idx)}
    V = np.zeros((len(idx), len(edges)))
    for c, e in enumerate(edges):
        V[pos[tuple(sorted(e))], c] = 1.0
    return V
