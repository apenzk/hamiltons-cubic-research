import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *
from scipy.optimize import minimize

rng = np.random.default_rng(0)

# 1. max theta over Weyl_4 (unit norm)
def maxtheta(n, tries=40, seed=0):
    B = weyl_basis(n); d = len(B); r = np.random.default_rng(seed)
    best = -9; bw=None
    for _ in range(tries):
        x0 = r.standard_normal(d); x0/=np.linalg.norm(x0)
        def f(x):
            x = x/np.linalg.norm(x)
            W = np.einsum('d,dij->ij', x, B)
            return -theta(W,n)
        res = minimize(f, x0, method='BFGS', options={'maxiter':400})
        if -res.fun > best:
            best = -res.fun; bw = np.einsum('d,dij->ij', res.x/np.linalg.norm(res.x), B)
    return best, bw
m4,W4 = maxtheta(4, 30)
print('max theta Weyl_4 =', m4, ' sqrt(3/2)=', np.sqrt(1.5))
print('  its spectrum*sqrt6:', np.round(np.linalg.eigvalsh(W4)*np.sqrt(6),5))

# 2. padded CP2
W = wcp2()
for n in [5,6,8]:
    Wn = pad(W,4,n)
    print('pad->n=%d  bianchi %.1e ricci %.1e norm %.6f theta %.12f  spec(nonzero)'%(
        n, bianchi_resid(Wn,n), np.max(np.abs(ricci(Wn,n))), fro(Wn), theta(Wn,n)),
        np.round([v for v in np.linalg.eigvalsh(Wn) if abs(v)>1e-9],5))

# 3. Ricci identity  Ric = sum_alpha lam_alpha v_alpha v_alpha^T  (v as skew matrix)
n=6; B=weyl_basis(n); d=len(B)
x = rng.standard_normal(d); W = np.einsum('d,dij->ij',x,B); W/=fro(W)
lam,V = np.linalg.eigh(W)
P = phis(n)
acc = np.zeros((n,n))
for a in range(len(lam)):
    v = np.einsum('p,pij->ij', V[:,a], P)   # skew matrix of eigenvector
    acc += lam[a]*(v@v.T)
print('Ric identity residual:', np.max(np.abs(acc - ricci(W,n))), ' |Ric|=',np.max(np.abs(ricci(W,n))))
