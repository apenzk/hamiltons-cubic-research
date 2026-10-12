import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r33_core as R
np.random.seed(0)

for n in [5, 6, 7, 8]:
    A = R.A_tensor(n); B = R.weyl_basis(n); D = n*(n-1)//2
    P = R.pairs(n); idx = R.pair_index(n)
    w = np.random.randn(n, n); w = (w + w.T)/2; np.fill_diagonal(w, 0)
    Wd = np.zeros((D, D))
    for (i, j) in P: Wd[idx[(i,j)], idx[(i,j)]] = w[i, j]
    S = R.sharp(A, Wd)
    err = max(abs(S[idx[(i,j)], idx[(i,j)]] - sum(w[i,k]*w[j,k] for k in range(n) if k not in (i,j))) for (i,j) in P)
    offdiag = np.max(np.abs(S - np.diag(np.diag(S))))
    def rw():
        c = np.random.randn(B.shape[0]); return np.einsum('k,kij->ij', c, B)
    X, Y, Z = rw(), rw(), rw()
    tri = lambda X,Y,Z: np.sum(R.circ(A, X, Y) * Z)
    vals = [tri(X,Y,Z), tri(Y,Z,X), tri(Z,X,Y), tri(Y,X,Z), tri(X,Z,Y), tri(Z,Y,X)]
    trisym = max(vals) - min(vals)
    XoY = R.circ(A, X, Y); Bf = B.reshape(B.shape[0], -1); Pi = Bf.T @ Bf
    closure = np.linalg.norm(XoY.reshape(-1) - Pi @ XoY.reshape(-1))
    L = R.L_matrix(A, X, B)
    print(f"n={n}: diag#err={err:.2e} #offdiag={offdiag:.2e} trisym={trisym:.2e} closure={closure:.2e} "
          f"tr(L_X)={np.trace(L):.2e} |L-L^T|={np.max(np.abs(L-L.T)):.2e}")
