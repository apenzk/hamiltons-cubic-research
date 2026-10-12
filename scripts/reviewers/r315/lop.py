import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import core, geom


def L_matrix(alg, B, W, chunk=64):
    """Lmat[b,a] = <L_W(B_a), B_b>  in the orthonormal Weyl basis B."""
    dim = B.shape[0]
    out = np.zeros((dim, dim))
    for a in range(dim):
        H = B[a]
        LH = alg.L(W, H)
        out[:, a] = np.einsum('bij,ij->b', B, LH)
    return 0.5 * (out + out.T)


def orbit_tangent(alg, B, W, tol=1e-9):
    """coeff vectors of {[ad X, W]} inside the Weyl basis."""
    cols = []
    for c in range(alg.N):
        ad = alg.C[c].T
        X = ad @ W - W @ ad
        cols.append(np.einsum('aij,ij->a', B, X))
    M = np.array(cols).T
    u, s, vt = np.linalg.svd(M, full_matrices=False)
    k = int(np.sum(s > tol * max(1.0, s[0])))
    return u[:, :k], s


def spectrum_report(alg, B, W, theta, name=''):
    dim = B.shape[0]
    Lm = L_matrix(alg, B, W)
    wc = np.einsum('aij,ij->a', B, W)
    wc = wc / np.linalg.norm(wc)
    Pperp = np.eye(dim) - np.outer(wc, wc)
    Lp = Pperp @ Lm @ Pperp
    ev, V = np.linalg.eigh(Lp)
    Le = ev / theta
    return Lm, Le, V, wc
