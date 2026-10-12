"""Audit: the quartic SOS claim of an outside progress report (unpublished, held in the private record)

The source reports (provisional; no script, no rational Gram certificate) that the
least alpha for which  alpha|W|^4 - |Q(W)|^2  is a quadratic SOS on Weyl_5 is 216/119.

This computes the NONNEGATIVITY threshold  alpha_pos = max |Q(W)|^2/|W|^4, which
lower-bounds any SOS threshold.  Result: alpha_pos = 3/2 exactly, on a plateau
(every one of 1200 restarts attains it).  So the reported SOS threshold, if right,
sits strictly above nonnegativity by a factor 144/119 -- a genuine
nonnegative-but-not-SOS gap, which is the source's structural point.

Conventions match this repo: <X,Y> = tr(X^T Y) on Lambda^2, so ||Id||^2 = N.
Q is validated against scripts/curvature_operator.py at 2.7e-15.
"""
import sys, os, itertools, numpy as np
sys.path.insert(0, os.path.dirname(__file__))
import qfast
from scipy.optimize import minimize

n = 5
pairs, idx, N, E, c = qfast.setup(n)

def sym_basis(N):
    B = []
    for a in range(N):
        for b in range(a, N):
            M = np.zeros((N, N))
            if a == b: M[a, a] = 1.0
            else: M[a, b] = M[b, a] = 1/np.sqrt(2)
            B.append(M)
    return B

def weyl_basis(n, N, idx, B):
    rows = []
    for i, j, k, l in itertools.combinations(range(n), 4):
        rows.append([M[idx[(i,j)],idx[(k,l)]] - M[idx[(i,k)],idx[(j,l)]]
                     + M[idx[(i,l)],idx[(j,k)]] for M in B])
    for i in range(n):
        for j in range(i, n):
            r = []
            for M in B:
                s = 0.0
                for k in range(n):
                    if k in (i, j): continue
                    pi = (min(i,k), max(i,k)); pj = (min(j,k), max(j,k))
                    s += (1.0 if i < k else -1.0)*(1.0 if j < k else -1.0)*M[idx[pi], idx[pj]]
                r.append(s)
            rows.append(r)
    u, s, vt = np.linalg.svd(np.array(rows))
    null = vt[(s > 1e-10).sum():]
    return np.array([sum(cc*B[i] for i, cc in enumerate(row)) for row in null])

if __name__ == '__main__':
    B = sym_basis(N)
    basis = weyl_basis(n, N, idx, B); d = basis.shape[0]
    print(f'Weyl_{n} dim = {d} (expected {n*(n+1)*(n+2)*(n-3)//12})')

    def f(x):
        W = np.tensordot(x, basis, axes=1)
        QW = qfast.Q(c, W)
        return -np.trace(QW @ QW) / np.trace(W @ W)**2

    rng = np.random.default_rng(7); vals = []
    for _ in range(1200):
        r = minimize(f, rng.normal(size=d), method='L-BFGS-B',
                     options={'maxiter': 4000, 'ftol': 1e-16, 'gtol': 1e-14})
        vals.append(-r.fun)
    vals = np.array(vals); m = vals.max()
    print(f'alpha_pos = max |Q(W)|^2/|W|^4 = {m:.15f}   (3/2 to {abs(m-1.5):.1e})')
    print(f'restarts attaining it          = {(vals > 1.5-1e-9).sum()}/{len(vals)}  -> plateau')
    print(f'reported SOS threshold 216/119 = {216/119:.10f}   gap factor 144/119 = {144/119:.6f}')
