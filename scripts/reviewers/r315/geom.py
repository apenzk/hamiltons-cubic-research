import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import core


def proj_coeffs(B, X):
    return np.einsum('aij,ij->a', B, X)


def from_coeffs(B, w):
    return np.einsum('a,aij->ij', w, B)


def grading_J(alg, p):
    """diag matrix on Lambda^2 of conjugation eigenvalues for sigma=diag(I_p,-I_q)."""
    n = alg.n
    eps = np.array([1.0] * p + [-1.0] * (n - p))
    return np.array([eps[i] * eps[j] for (i, j) in alg.P])


def slice_basis(alg, B, p):
    """orthonormal basis of V = {W in Weyl : J W J = W}, J=Lambda^2 sigma."""
    j = grading_J(alg, p)
    JJ = np.outer(j, j)
    M = np.einsum('aij,bij->ab', B, B * JJ[None, :, :])   # matrix of conjugation on Weyl coords
    M = 0.5 * (M + M.T)
    ev, V = np.linalg.eigh(M)
    keep = V[:, ev > 0.5]
    # sanity: eigenvalues should be +-1
    return keep, ev


def ad_matrix(alg, c):
    """(ad phi_c)_{ab} = C[c,b,a] acting on Lambda^2."""
    return alg.C[c].T


def commutant_dim(alg, B, p, tol=1e-8):
    """dim of {W in Weyl : [ad X, W]=0 for all X in so(p)+so(q)}."""
    n = alg.n
    gens = [a for a, (i, j) in enumerate(alg.P) if (i < p and j < p) or (i >= p and j >= p)]
    dim = B.shape[0]
    G = np.zeros((dim, dim))
    for c in gens:
        ad = ad_matrix(alg, c)
        img = np.einsum('ij,ajk->aik', ad, B) - np.einsum('aij,jk->aik', B, ad)
        Mx = np.einsum('aij,bij->ab', img, B)   # rows: coeff a -> coeff b?  careful
        # map w -> coeffs of [ad, W(w)]:  out_b = sum_a w_a <[ad,B_a],B_b>
        G += Mx.T @ Mx
    ev, V = np.linalg.eigh(G)
    ker = V[:, ev < tol * max(1.0, ev.max())]
    return ker, ev


def theta_of(alg, W):
    return core.frob(W, alg.Q(W))
