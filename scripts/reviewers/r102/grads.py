import numpy as np, core
from scipy.linalg import expm

def tensorify(S, n):
    """symmetric Lambda^2 matrix S (over pairs i<j) -> tensor with Riemann pair symmetries."""
    I, J = core._pidx(n)
    T = np.zeros((n, n, n, n))
    T[I[:, None], J[:, None], I[None, :], J[None, :]] = S
    T[J[:, None], I[:, None], I[None, :], J[None, :]] = -S
    T[I[:, None], J[:, None], J[None, :], I[None, :]] = -S
    T[J[:, None], I[:, None], J[None, :], I[None, :]] = S
    return T

def grad_theta(W):
    """Euclidean gradient of theta w.r.t. W in <.,.>_4, projected onto Weyl."""
    n = W.shape[0]
    M = core.to_M(W)
    G = 3.0 * (M @ M + core.sharp(M, n))
    return 0.25 * core.project_weyl(tensorify(G, n))

def grad_kappa2(W, R):
    """Envelope gradient of ||K(RW)||_F^2 at fixed optimal frame R."""
    n = W.shape[0]
    T = core.rotate_W(W, R)
    u = core.vertex_K(T)
    E = np.zeros((n, n, n, n))
    for a in range(n):
        for b in range(n):
            if a != b: E[a, b, a, b] = 2.0 * u[a, b]
    # pull back: d/dW <E, R.W> = R^T . E
    G = core.rotate_W(E, R.T)
    return core.project_weyl(G)
