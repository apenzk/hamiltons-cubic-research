import sys, time
sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r29_core import Alg, weyl_basis, ip, theta0
from review_r29_points import (so_gens, rho_of, invariant_subspace, from_coords,
                               newton_critical, orbit_dim, analyse)


def block_gens(n, blocks):
    g = []; off = 0
    for b in blocks:
        for i in range(off, off + b):
            for j in range(i + 1, off + b):
                A = np.zeros((n, n)); A[i, j] = 1; A[j, i] = -1
                g.append(A)
        off += b
    return g


def u_m_gens(m):
    """u(m) inside so(2m): complex structure J = block diag [[0,-1],[1,0]]."""
    n = 2 * m
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = -1; J[2 * k + 1, 2 * k] = 1
    g = []
    for A in so_gens(n):
        if np.abs(A @ J - J @ A).max() < 1e-12:
            g.append(A)
    # u(m) = so(2m) elements commuting with J
    basis = []
    for A in so_gens(n):
        C = A @ J - J @ A
        basis.append((A, C))
    # build by projection: solve linear system
    S = np.array([c.reshape(-1) for _, c in basis])
    u, s, vt = np.linalg.svd(S.T @ S if False else S, full_matrices=True)
    # nullspace of the map A -> [A,J]
    uu, ss, vv = np.linalg.svd(np.array([c.reshape(-1) for _, c in basis]).T @ np.eye(len(basis)) if False else np.array([c.reshape(-1) for _, c in basis]))
    tol = max(len(basis), n * n) * np.finfo(float).eps * ss[0]
    r = int((ss > tol).sum())
    ns = None
    # nullspace over coefficient space: rows of V corresponding to zero singular values of M where M[k]=vec([A_k,J])
    M = np.array([c.reshape(-1) for _, c in basis])
    uu, ss, vv = np.linalg.svd(M.T, full_matrices=True)  # columns = coefficient combos
    # easier: solve M^T x = 0 with x coefficients -> nullspace of M^T? M is (K, n^2); want x in R^K with x^T M = 0
    uu2, ss2, vv2 = np.linalg.svd(M)
    tol2 = max(M.shape) * np.finfo(float).eps * ss2[0]
    r2 = int((ss2 > tol2).sum())
    Nsp = uu2[:, r2:]  # (K, K-r2) coefficient nullspace
    out = []
    A_list = [A for A, _ in basis]
    for col in range(Nsp.shape[1]):
        X = sum(Nsp[k, col] * A_list[k] for k in range(len(A_list)))
        out.append(X)
    return out


def sp_gens(m):
    """sp(m)+sp(1) inside so(4m): quaternionic structures I,J,K on R^{4m}."""
    n = 4 * m
    def blk(M):
        A = np.zeros((n, n))
        for k in range(m):
            A[4*k:4*k+4, 4*k:4*k+4] = M
        return A
    I4 = np.array([[0,-1,0,0],[1,0,0,0],[0,0,0,-1],[0,0,1,0]], float)
    J4 = np.array([[0,0,-1,0],[0,0,0,1],[1,0,0,0],[0,-1,0,0]], float)
    K4 = I4 @ J4
    Ii, Jj, Kk = blk(I4), blk(J4), blk(K4)
    # sp(m): commutes with I,J,K ; plus sp(1) = span{I,J,K}
    A_list = so_gens(n)
    M = np.array([np.concatenate([(A@Ii-Ii@A).reshape(-1),
                                  (A@Jj-Jj@A).reshape(-1),
                                  (A@Kk-Kk@A).reshape(-1)]) for A in A_list])
    uu, ss, vv = np.linalg.svd(M)
    tol = max(M.shape) * np.finfo(float).eps * ss[0]
    r = int((ss > tol).sum())
    Nsp = uu[:, r:]
    out = [sum(Nsp[k, col] * A_list[k] for k in range(len(A_list))) for col in range(Nsp.shape[1])]
    return out + [Ii, Jj, Kk]


def crit_in_subspace(alg, B, V, ntry=12, seed=0):
    """V: (m,D) rows spanning an invariant subspace. Returns distinct critical coordinate vectors."""
    rng = np.random.default_rng(seed)
    found = []
    for t in range(ntry):
        v0 = V.T @ rng.standard_normal(V.shape[0])
        v, th, res = newton_critical(alg, B, v0)
        if res > 1e-9 or th <= 1e-8:
            continue
        if not any(abs(abs(np.dot(v, w)) - 1) < 1e-6 for w, _ in found):
            found.append((v, th))
    return found


def show(r):
    print(f"{r['name']:<26} n={r['n']:<3} D={r['D']:<5} theta={r['theta']:.9f} "
          f"(th0={theta0(r['n']):.6f}) resid={r['resid']:.1e} orb={r['orb']:<4} "
          f"sum(l)={r['sum1']:+.2e} th^2*S2={r['th2s2']:.9f} kappa={r['kappa']} "
          f"m(1)={r['mult1']} m(1/2)={r['multhalf']} m(0)={r['mult0']} "
          f"l2={r['lam_max_perp']:+.6f} lmin={r['lam_min']:+.6f} th^2*S3={r['th2s3']:+.6f}", flush=True)


if __name__ == '__main__':
    todo = sys.argv[1] if len(sys.argv) > 1 else 'small'
    rows = []
    specs = {
        'small': [(6, 'blocks', [(3,3),(2,4),(2,2,2)]), (6,'u',[3]),
                  (5,'blocks',[(2,3)]),
                  (7,'blocks',[(3,4),(2,5),(2,2,3)]),
                  (8,'blocks',[(4,4),(3,5),(2,6),(2,2,4),(2,3,3),(2,2,2,2)]),
                  (8,'u',[4]), (8,'sp',[2])],
        'big': [(9,'blocks',[(4,5),(3,6),(2,7),(3,3,3),(2,2,2,3)]),
                (10,'blocks',[(5,5),(4,6),(2,2,3,3),(2,2,2,2,2)]),
                (10,'u',[5])],
    }
    for (n, kind, args) in specs[todo]:
        a = Alg(n); B, _, _ = weyl_basis(a)
        for arg in args:
            t0 = time.time()
            if kind == 'blocks':
                gens = block_gens(n, list(arg)); label = 'S' + 'xS'.join(str(b) for b in arg)
            elif kind == 'u':
                gens = u_m_gens(arg); label = f'CP^{arg}'
            else:
                gens = sp_gens(arg); label = f'HP^{arg}'
            V = invariant_subspace(a, B, gens)
            pts = crit_in_subspace(a, B, V)
            for k, (v, th) in enumerate(pts):
                r = analyse(a, B, v, f'{label}#{k} inv{V.shape[0]}')
                rows.append(r); show(r)
            print(f"   [{label} n={n}: invdim={V.shape[0]}, {len(pts)} crit pts, {time.time()-t0:.1f}s]", flush=True)
    np.save(f'agent_logs/r29_cat_{todo}.npy', np.array([{k: v for k, v in r.items() if k != 'lam'} for r in rows], dtype=object), allow_pickle=True)
