"""Lean frame minimisation: min over SO(8) of the off-diagonal mass, with control."""
import sys, time, numpy as np
sys.path.insert(0, 'scripts/reviewers/r295'); sys.path.insert(0, 'scripts/lib')
from r295_core import pairs_of
from scipy.optimize import minimize
from scipy.linalg import expm
from review_r30_core import sphere_product_W
n = 8; prs = pairs_of(n)
I = np.array([p[0] for p in prs]); J = np.array([p[1] for p in prs])
tri = np.triu_indices(n, 1)
def rho(R): return R[np.ix_(I, I)]*R[np.ix_(J, J)] - R[np.ix_(I, J)]*R[np.ix_(J, I)]
def unp(x):
    A = np.zeros((n, n)); A[tri] = x; return expm(A - A.T)
def make(W):
    Wn = W/np.linalg.norm(W)
    def f(x):
        L = rho(unp(x)); M = L @ Wn @ L.T
        return float(np.sum(M*M) - np.sum(np.diag(M)**2))
    return f
def attack(W, lab, tries, seed, budget):
    f = make(W); rng = np.random.default_rng(seed); best = f(np.zeros(28)); t0 = time.time(); k = 0
    for t in range(tries):
        if time.time() - t0 > budget: break
        x0 = np.zeros(28) if t == 0 else rng.normal(scale=1.5, size=28)
        r = minimize(f, x0, method='L-BFGS-B', options=dict(maxiter=250, maxfun=12000))
        r = minimize(f, r.x, method='L-BFGS-B', options=dict(maxiter=250, maxfun=12000))
        best = min(best, float(r.fun)); k += 1
    print('  %-28s min off-diagonal MASS = %.8f  (%d starts, %.0fs)'
          % (lab, np.sqrt(max(best, 0)), k, time.time()-t0), flush=True)
W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
rng = np.random.default_rng(99); A = rng.normal(size=(n, n)); L = rho(expm(A - A.T))
Wc, _ = sphere_product_W([3, 5]); Wc /= np.linalg.norm(Wc); Wcr = L @ Wc @ L.T
attack(Wcr, 'rotated S^3xS^5 [control]', 40, 1, 120)
attack(W, 'the n=8 witness', 200, 2, 420)
