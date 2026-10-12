"""The Petersen-Wink symmetry defect, implemented from the definition."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r306_defs as R


def ad_matrix(alg, X):
    """Matrix of Y -> [X, Y] on so(n), in the orthonormal pair basis."""
    Bs = R.basis_so(alg.n)
    D = alg.D
    out = np.zeros((D, D))
    for a in range(D):
        Y = X @ Bs[a] - Bs[a] @ X
        for b in range(D):
            out[b, a] = np.sum(Bs[b] * Y)
    return out


def defect(alg, W, tol=1e-9, scale=2.0):
    """Delta = sum over strictly positive eigenvalues of ||[ad(v), W]||^2,
    with the eigenvectors normalised to ||v||_F^2 = scale."""
    lam, vec = np.linalg.eigh(W)
    Bs = R.basis_so(alg.n)
    tot = 0.0
    dens = []
    for i in range(len(lam)):
        X = np.einsum('a,aij->ij', vec[:, i], Bs) * np.sqrt(scale)
        A = ad_matrix(alg, X)
        g = np.sum((A @ W - W @ A) ** 2)
        dens.append((lam[i], g))
        if lam[i] > tol:
            tot += g
    return tot, dens
