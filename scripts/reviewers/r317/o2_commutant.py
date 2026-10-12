"""O2 step check: dim of the ad(p)-invariant subspace of Weyl_n for every
symmetric subalgebra p of so(n), and what the invariant point is."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib317 as L, points317 as PT


def so_kl(n, k):
    pairs, _, _ = L.pair_index(n)
    cols = []
    for a, (i, j) in enumerate(pairs):
        if (i < k) == (j < k):
            v = np.zeros(len(pairs)); v[a] = 1.0; cols.append(v)
    return np.array(cols).T


def u_m(n):
    m = n // 2
    J = np.zeros((n, n))
    for a in range(m):
        J[2*a, 2*a+1] = 1.0; J[2*a+1, 2*a] = -1.0
    AdJ = L.Lambda2(J, n)
    ev, V = np.linalg.eigh(AdJ)
    return V[:, ev > 0.5]


def invariant_dim(n, Pb, mats, tol=1e-8):
    D = len(mats)
    G = np.zeros((D, D))
    for k in range(Pb.shape[1]):
        adx = L.ad_on_lambda2(Pb[:, k], c)
        C = np.array([(adx @ M - M @ adx).ravel() for M in mats])
        G += C @ C.T
    ev, V = np.linalg.eigh(G)
    r = int((ev > tol * max(ev.max(), 1.0)).sum())
    return V[:, :D - r].T


for n in [6, 8, 10]:
    c = L.structure_constants(n)
    ns, coords, N = L.weyl_basis(n)
    mats = [L.coords_to_M(ns[d], coords, N) for d in range(ns.shape[0])]
    print(f'\n=== n={n}, dim Weyl = {len(mats)} ===')
    cands = [(f'so({k})+so({n-k})', so_kl(n, k)) for k in range(2, n//2 + 1)]
    if n % 2 == 0:
        cands.append((f'u({n//2})', u_m(n)))
    for name, Pb in cands:
        kerc = invariant_dim(n, Pb, mats)
        print(f'  p = {name:16s} dim p = {Pb.shape[1]:3d}   dim ad(p)-invariant Weyl = {kerc.shape[0]}')
        for row in kerc:
            M = sum(row[d] * mats[d] for d in range(len(mats)))
            M /= np.linalg.norm(M)
            ev = np.linalg.eigvalsh(M)
            npos = int((ev > 1e-9).sum()); nneg = int((ev < -1e-9).sum())
            res, th = L.crit_residual(M, c)
            vals, cnts = np.unique(np.round(ev, 8), return_counts=True)
            print(f'      theta={th:+.9f} res={res:.1e} dims(+,-,0)=({npos},{nneg},{N-npos-nneg}) '
                  f'spectrum={list(zip(vals, cnts))}')
