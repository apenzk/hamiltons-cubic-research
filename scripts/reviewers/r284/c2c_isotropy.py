"""r284 -- the isotropy of padded W_{CP^2}: is it unitary on the support 4-plane?

findings/diagonality.md says the unitary-isotropy instrument has domain "native
dimension 4 only", and gives as its reason that padded W_{CP^2} is
non-diagonalisable "while its isotropy is not unitary".  ATTEMPTS.md states the
proposition for dim V = 2m >= 2 and lists padded W_{CP^2} (= Fox's S^4(alpha),
isotropy U(2) x O(n-4), m = 2) as its FIRST application.  This decides it.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, adj, Q
from b_cp2_nondegenerate import padded_cp2

def isotropy(n, W):
    A = adj(n); N = A.shape[0]
    M = np.array([(A[a] @ W - W @ A[a]).ravel() for a in range(N)]).T
    u, s, vt = np.linalg.svd(M)
    tol = max(M.shape) * s[0] * 1e-12
    k = int((s <= tol).sum())
    return k, vt[N - k:]           # coefficients over the basis phi_ab

if __name__ == "__main__":
    for n in (8, 12):
        W, B = padded_cp2(n)
        k, ker = isotropy(n, W)
        pairs, idx = pair_index(n)
        # rebuild each kernel element as a skew matrix on R^n, split by block V = span(e0..e3)
        supp = []
        for c in ker:
            X = np.zeros((n, n))
            for a, (i, j) in enumerate(pairs):
                X[i, j] += c[a]; X[j, i] -= c[a]
            supp.append(X)
        V = list(range(4))
        Vc = list(range(4, n))
        mixed = max(np.abs(np.array(supp)[:, :4, 4:]).max(), 0)
        blockV = np.array([X[np.ix_(V, V)] for X in supp])
        rkV = np.linalg.matrix_rank(blockV.reshape(len(supp), -1), tol=1e-9)
        blockVc = np.array([X[np.ix_(Vc, Vc)] for X in supp])
        rkVc = np.linalg.matrix_rank(blockVc.reshape(len(supp), -1), tol=1e-9)
        # J on V, from W_CP2's Kahler form: top eigenvector of W restricted to Lambda^2 V
        ev, EV = np.linalg.eigh(W)
        top = EV[:, int(np.argmax(ev))]
        J = np.zeros((n, n))
        for a, (i, j) in enumerate(pairs):
            J[i, j] += top[a]; J[j, i] -= top[a]
        J = J / np.linalg.norm(J, 2)
        print(f"n={n}: dim so(n)={n*(n-1)//2}  dim isotropy k(W)={k}  orbit={n*(n-1)//2-k}")
        print(f"   dim u(2)+so(n-4) = {4 + (n-4)*(n-5)//2}")
        print(f"   V-block span dim {rkV}, V^perp-block span dim {rkVc}, "
              f"max mixed entry {mixed:.2e}")
        print(f"   top eigenvector of W is a complex structure on V: "
              f"||J^2+I_V|| = {np.linalg.norm(J[np.ix_(V,V)]@J[np.ix_(V,V)] + np.eye(4)):.2e}")
        comm = max(float(np.linalg.norm(X[np.ix_(V,V)] @ J[np.ix_(V,V)] - J[np.ix_(V,V)] @ X[np.ix_(V,V)]))
                   for X in supp)
        print(f"   max ||[X_V, J_V]|| over the isotropy algebra = {comm:.2e}  "
              f"(0 means the V-part is exactly u(2), i.e. UNITARY)", flush=True)
