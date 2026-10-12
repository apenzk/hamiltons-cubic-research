"""Reviewer 27, claim (E): the d_abc identification and its claimed non-generality."""
import numpy as np
from scipy.linalg import subspace_angles
import review_r27_core as C, review_r27_points as PT, review_r27_measure as M


def blocks_of_top(n, W, name, gens=None):
    o = M.analyse(n, W, name, want_vecs=True)
    ev, U = np.linalg.eigh(W)
    sel = ev < -1e-11
    mB = U[:, sel]; hB = U[:, ~sel]
    Pm = mB @ mB.T; Ph = hB @ hB.T
    lam = o['lam_max']
    idxs = np.where(o['evals'] > lam - 1e-9)[0]
    print('\n== %s  n=%d  lambda_max=%.15f  mult=%d   dim h=%d dim m=%d'
          % (name, n, lam, len(idxs), hB.shape[1], mB.shape[1]))
    Xs = []
    for k in idxs:
        X = np.einsum('k,kab->ab', o['evecs'][:, k], o['B'])
        X /= np.sqrt(np.trace(X @ X))
        Xs.append(X)
    mm = np.mean([np.trace((Pm @ X @ Pm) @ X) for X in Xs])
    hh = np.mean([np.trace((Ph @ X @ Ph) @ X) for X in Xs])
    mx = np.mean([2 * np.trace((Ph @ X @ Pm) @ X) for X in Xs])
    print('   block masses of top eigenspace: hh %.9f   mm %.9f   mixed %.9f' % (hh, mm, mx))
    return o, Xs, hB, mB, idxs


def su3_test():
    gens, f, d = PT.gens_su3_adjoint()
    n = 8
    W, r, Pi = PT.W_subalgebra(n, gens)
    o, Xs, hB, mB, idxs = blocks_of_top(n, W, 'su(3) bi-invariant')
    # the natural frame of h: the 8 generators ad_a, in phi-coordinates, orthonormalised
    pr, idx, c = C.struct(n)
    N = len(pr)
    F = np.zeros((8, N))
    for a in range(8):
        X = gens[a]
        for k, (i, j) in enumerate(pr):
            F[a, k] = X[i, j]
    G = F @ F.T
    print('   Gram of the ad_a frame: diag %.9f  offdiag max %.2e' % (G[0, 0], np.abs(G - np.diag(np.diag(G))).max()))
    Fo = F / np.sqrt(G[0, 0])
    # d_abc family
    Dfam = np.array([d[:, :, cc] for cc in range(8)])
    print('   d totally symmetric? %.2e   traceless? %.2e'
          % (max(np.abs(d - d.transpose(1, 0, 2)).max(), np.abs(d - d.transpose(0, 2, 1)).max()),
             np.abs(np.einsum('aac->c', d)).max()))
    Dv = Dfam.reshape(8, 64)
    Hs = np.array([Fo @ X @ Fo.T for X in Xs]).reshape(8, 64)
    print('   hh-block Frobenius norms: %s' % np.round(np.linalg.norm(Hs, axis=1), 8))
    Qd, _ = np.linalg.qr(Dv.T); Qh, _ = np.linalg.qr(Hs.T)
    ang = subspace_angles(Qd, Qh)
    print('   principal cosines between span{D(u)} and the hh-blocks: %s' % np.round(np.cos(ang), 12))
    print('   -> subspaces %s' % ('COINCIDE' if np.max(ang) < 1e-8 else 'DIFFER, max angle %.3e' % np.max(ang)))
    # also: is the mm block determined?  rank of the mm-block family
    ev, U = np.linalg.eigh(W); sel = ev < -1e-11
    Pm = U[:, sel] @ U[:, sel].T
    Ms = np.array([(Pm @ X @ Pm).ravel() for X in Xs])
    print('   rank of the mm-block family: %d' % np.linalg.matrix_rank(Ms, tol=1e-9))
    return d


if __name__ == '__main__':
    su3_test()
    W, r, Pi = PT.W_subalgebra(5, PT.gens_so3_in_so5())
    blocks_of_top(5, W, 'so(3) irreducible in so(5)')
    W, r, Pi = PT.W_subalgebra(10, PT.gens_so_adjoint(5))
    blocks_of_top(10, W, 'so(5) adjoint in so(10)')
