"""Hunt for critical points: solve Q(W)=W in Weyl_n (scale-fixed form of Q(W)=theta W)."""
import numpy as np, core
from scipy.optimize import root

def find(n, tries=200, seed=0, scale=1.0):
    B = core.weyl_basis(n)
    K = B.shape[0]
    def G(x):
        W = np.einsum('k,kab->ab', x, B, optimize=True)
        q = core.Q(W, n)
        return np.einsum('kab,ab->k', B, q, optimize=True) - x
    rng = np.random.default_rng(seed)
    out = []
    for t in range(tries):
        x0 = rng.normal(size=K)*scale
        r = root(G, x0, method='hybr', tol=1e-13)
        if not r.success:
            continue
        if np.linalg.norm(G(r.x)) > 1e-11 or np.linalg.norm(r.x) < 1e-6:
            continue
        W = np.einsum('k,kab->ab', r.x, B, optimize=True)
        out.append(W/np.linalg.norm(W))
    return out
