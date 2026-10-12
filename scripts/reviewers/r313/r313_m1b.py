"""M1 assembly: dimension of the ad(p)-invariant subspace of Weyl_n, for every
Z2-grading p of so(n).  If it is 1, the equivariant graded critical point on that
pair is unique up to sign and is automatically critical (Q maps Weyl_n to Weyl_n
equivariantly, so Q(W) lies in the same 1-dim invariant space)."""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r313')
import r313_lib as R

def ad_matrix(n, X):
    """matrix of ad(X): Lambda^2 -> Lambda^2 in the phi basis, X an n x n antisym matrix."""
    B = R.basis_mats(n); P = R.pairs(n)
    Cm = X @ B - np.einsum('sij,jk->sik', B, X)   # [X, phi_s]
    return np.array([[Cm[s, i, j] for s in range(len(P))] for (i, j) in P])

def gens_so_kl(n, k):
    G = []
    for i in range(k):
        for j in range(i+1, k):
            X = np.zeros((n, n)); X[i, j] = 1; X[j, i] = -1; G.append(X)
    for i in range(k, n):
        for j in range(i+1, n):
            X = np.zeros((n, n)); X[i, j] = 1; X[j, i] = -1; G.append(X)
    return G

def gens_u(m):
    """u(m) inside so(2m): real 2m x 2m matrices commuting with J = blockdiag([[0,-1],[1,0]])."""
    n = 2*m
    J = np.zeros((n, n))
    for a in range(m):
        J[2*a, 2*a+1] = -1; J[2*a+1, 2*a] = 1
    G = []
    # real antisymmetric part:  A (real antisym m x m) -> A tensor I_2
    for i in range(m):
        for j in range(i+1, m):
            X = np.zeros((n, n))
            X[2*i:2*i+2, 2*j:2*j+2] = np.eye(2)
            X[2*j:2*j+2, 2*i:2*i+2] = -np.eye(2)
            G.append(X)
    # i*(real symmetric)  ->  S tensor J0
    J0 = np.array([[0., -1.], [1., 0.]])
    for i in range(m):
        for j in range(i, m):
            X = np.zeros((n, n))
            X[2*i:2*i+2, 2*j:2*j+2] += J0
            if i != j:
                X[2*j:2*j+2, 2*i:2*i+2] += J0
            G.append(X)
    G = [X for X in G if np.linalg.norm(X) > 0]
    # sanity: all commute with J and are antisymmetric
    for X in G:
        assert np.linalg.norm(X + X.T) < 1e-12
        assert np.linalg.norm(X @ J - J @ X) < 1e-12
    return G

def invariant_weyl_dim(n, gens, verbose=False):
    B = R.weyl_basis(n)
    dim = B.shape[0]
    V = np.eye(dim)               # current subspace, columns are Weyl coords
    for X in gens:
        a = ad_matrix(n, X)
        cur = np.tensordot(V.T, B, axes=(1, 0))       # (c, N, N)
        img = a @ cur - np.einsum('sij,jk->sik', cur, a)
        C = np.einsum('sab,tab->ts', img, B)          # (dim, c)
        G = C.T @ C
        ev, evec = np.linalg.eigh(0.5*(G+G.T))
        scale = max(ev[-1], 1.0) if ev.size else 1.0
        keep = evec[:, ev < 1e-16 * scale * max(G.shape)]
        V = V @ keep
        if V.shape[1] == 0:
            return 0, V
    return V.shape[1], V

if __name__ == '__main__':
    import itertools
    for n in (8, 10, 12, 13):
        print(f"--- n = {n} (dim Weyl = {R.weyl_dim_formula(n)}) ---")
        for k in range(1, n//2 + 1):
            d, V = invariant_weyl_dim(n, gens_so_kl(n, k))
            info = ""
            if d >= 1:
                W = R.from_coords(n, V[:, 0]); W /= np.sqrt(np.tensordot(W, W, axes=2))
                res, th = R.crit_residual(n, W)
                if th < 0: W = -W; res, th = R.crit_residual(n, W)
                info = f"  theta={th:.9f} crit_res={res:.1e}"
            print(f"  p = so({k})+so({n-k}):  dim Inv(Weyl) = {d}{info}")
        if n % 2 == 0:
            m = n//2
            d, V = invariant_weyl_dim(n, gens_u(m))
            info = ""
            if d >= 1:
                W = R.from_coords(n, V[:, 0]); W /= np.sqrt(np.tensordot(W, W, axes=2))
                res, th = R.crit_residual(n, W)
                if th < 0: W = -W; res, th = R.crit_residual(n, W)
                th2 = (m+1)*(2*m-1)/(3*m*(m-1))
                info = f"  theta={th:.9f} crit_res={res:.1e}  CP^m closed form={np.sqrt(th2):.9f}"
            print(f"  p = u({m}):  dim Inv(Weyl) = {d}{info}")
