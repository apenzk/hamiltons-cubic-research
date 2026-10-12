"""Reviewer 44 -- what the 9-dimensional excess is, and where it lives."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r44_core import *
from review_r44_padded import Le_matrix

def log(m):
    print(m, flush=True)
    with open('agent_logs/review_r44_padded.log', 'a') as f:
        f.write(m + '\n')

def block_mask(n, n0=6):
    p0, _ = pairs_of(n0); p1, idx1 = pairs_of(n); N = len(p1)
    ii = np.array([idx1[q] for q in p0])
    M = np.zeros((N, N), bool); M[np.ix_(ii, ii)] = True
    return M, ii

def study(n, W6, n0=6):
    W = embed(W6, n0, n) if n > n0 else W6.copy()
    W = W / np.linalg.norm(W)
    B = weyl_basis(n); D = B.shape[1]
    th = float(np.tensordot(W, Qop(W, n)))
    M = Le_matrix(W / th, n, B, tag=f'excess n={n}')
    ev, U = np.linalg.eigh(M)
    sel = np.abs(ev - 0.5) < 1e-8
    K = B @ U[:, sel]                               # p-space coords of E(1/2)
    Ob, sv = orbit_tangent_basis(W, n)              # orthonormal, p-space
    # orbit inside E(1/2)?
    resid = np.linalg.norm(Ob - K @ (K.T @ Ob))
    # transverse part
    Pk = K @ K.T
    Po = Ob @ Ob.T
    Tr = Pk - Po
    evt, Ut = np.linalg.eigh(Tr)
    Tb = Ut[:, evt > 0.5]
    Msk, ii = block_mask(n, n0)
    masses = []
    for j in range(Tb.shape[1]):
        X = p_to_X(Tb[:, j], n)
        masses.append(float((X[Msk]**2).sum() / (X**2).sum()))
    # is the whole transverse space inside the block subspace?  measure the
    # norm of the off-block part of the projector onto T
    offmass = 0.0
    for j in range(Tb.shape[1]):
        X = p_to_X(Tb[:, j], n)
        Y = X.copy(); Y[Msk] = 0.0
        offmass = max(offmass, np.linalg.norm(Y))
    log(f'[excess n={n}] dimE(1/2)={sel.sum()} orbit={Ob.shape[1]} transverse={Tb.shape[1]} '
        f'orbit-in-E(1/2) residual={resid:.2e} block-mass of transverse: '
        f'min={min(masses):.12f} max={max(masses):.12f} max off-block norm={offmass:.2e}')
    log(f'   L_e spectrum (value:mult): ' +
        '  '.join(f'{v:+.6f}:{c}' for v, c in zip(*np.unique(np.round(ev, 8), return_counts=True))))
    return Tb, K, Ob, W, B, th, M

if __name__ == '__main__':
    W6 = sphere_product_W((3, 3))
    for n in (6, 8, 10, 12):
        study(n, W6)
