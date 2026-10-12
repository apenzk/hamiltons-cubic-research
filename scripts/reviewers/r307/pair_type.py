"""Is each graded point's own p really an so(3)+so(5) (resp. so(4)+so(4)) pair?
Test: m = R^p (x) R^q contains DECOMPOSABLE bivectors (rank 2) exactly when the pair is
O(n)-conjugate to a coordinate so(p)+so(q); minimise ||X ^ X|| over unit X in m."""
import sys, itertools, numpy as np
sys.path.insert(0, 'scripts/reviewers/r307')
from core307 import *
from scipy.optimize import minimize

def wedge_norm2(n, v):
    P = pairs_of(n); idx = {p: a for a, p in enumerate(P)}
    def g(i, j):
        if i == j: return 0.0
        return v[idx[(i, j)]] if i < j else -v[idx[(j, i)]]
    s = 0.0
    for (i,j,k,l) in itertools.combinations(range(n), 4):
        s += (g(i,j)*g(k,l) - g(i,k)*g(j,l) + g(i,l)*g(j,k))**2
    return s

def min_decomposable(n, U, tries=12, seed=0):
    """U: (N, k) orthonormal basis of m.  min ||X^X||^2 over unit X in m."""
    rng = np.random.default_rng(seed)
    best = np.inf
    for _ in range(tries):
        c0 = rng.normal(size=U.shape[1])
        f = lambda c: wedge_norm2(n, U @ (c/np.linalg.norm(c)))
        r = minimize(f, c0, method='Nelder-Mead',
                     options=dict(maxiter=20000, maxfev=20000, xatol=1e-10, fatol=1e-14))
        best = min(best, r.fun)
    return best

n = 8
recs = np.load('scripts/reviewers/r307/census_n8.npy')
ip0, im0 = pm_index(n, 3)
U0 = np.eye(28)[:, im0]
print(f'control: coordinate m of so(3)+so(5): min ||X^X||^2 = {min_decomposable(n, U0):.2e}')
ip4, im4 = pm_index(n, 4)
print(f'control: coordinate m of so(4)+so(4): min ||X^X||^2 = {min_decomposable(n, np.eye(28)[:, im4]):.2e}')
rng = np.random.default_rng(1)
Ur = np.linalg.qr(rng.normal(size=(28, 15)))[0]
print(f'control: a RANDOM 15-dim subspace:    min ||X^X||^2 = {min_decomposable(n, Ur):.2e}')
print()
for W in recs:
    W = W/np.linalg.norm(W)
    lam, V = np.linalg.eigh(W)
    th = float(np.tensordot(Q(n, W), W))
    Um = V[:, lam < -1e-9]
    print(f'  theta={th:.7f} dim p={int((lam>1e-9).sum())}: min ||X^X||^2 over m = '
          f'{min_decomposable(n, Um, tries=8):.2e}')
