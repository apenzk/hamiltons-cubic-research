"""Is the equality configuration realisable as a Weyl vertex matrix? And odd n."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
from scipy.optimize import minimize
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r106'))
from r106_core import *
rng=np.random.default_rng(2026)

def diag_weyl_from_K(K):
    """coordinate-diagonal 4-tensor with W_abab = K_ab"""
    n=K.shape[0]; W=np.zeros((n,n,n,n))
    for a in range(n):
        for b in range(n):
            if a==b: continue
            W[a,b,a,b]=K[a,b]; W[a,b,b,a]=-K[a,b]
    return W

def matching_K(n,t):
    c=np.sqrt(t/(n*(n-1)*(n-2)))
    K=-c*(np.ones((n,n))-np.eye(n))
    for a in range(0,n,2): K[a,a+1]=K[a+1,a]=(n-2)*c
    return K

print("=== is the equality K a genuine Weyl vertex matrix? ===")
for n in (6,8,10,12):
    K=matching_K(n,2.0); W=diag_weyl_from_K(K)
    M=to_M(W)
    print(f" n={n}: weyl residuals {max(residuals(W).values()):.1e}  |M|_F={np.linalg.norm(M):.12f} "
          f" t={np.linalg.norm(vertex_matrix(W))**2:.12f}  theta={theta(W):.6f}  theta0={theta0(n):.6f}")

print("\n=== identity t/2 + |offdiag M|^2 = |M|^2 on random Weyl tensors ===")
for n in (5,6,7,8):
    for _ in range(3):
        W=rand_weyl(n,rng); M=to_M(W); M/=np.linalg.norm(M)
        t=np.linalg.norm(vertex_matrix(W)/np.linalg.norm(to_M(W)))**2
        off=M-np.diag(np.diag(M))
        r=abs(t/2+np.linalg.norm(off)**2-1.0)
    print(f" n={n}: residual {r:.1e}  (t={t:.4f})")

print("\n=== odd n: is the lemma bound attained? ===")
def unpack(x,n):
    K=np.zeros((n,n)); K[np.triu_indices(n,1)]=x; return K+K.T
def minmin(n,t,trials):
    best=np.inf;bK=None
    for _ in range(trials):
        A=rng.standard_normal((n,n)); A=(A+A.T)/2; np.fill_diagonal(A,0)
        x0=A[np.triu_indices(n,1)]
        r=minimize(lambda x:-unpack(x,n).min(),x0,
            constraints=[{'type':'eq','fun':lambda x:unpack(x,n).sum(1)},
                         {'type':'eq','fun':lambda x:2*x@x-t}],
            method='SLSQP',options={'maxiter':800,'ftol':1e-16})
        K=unpack(r.x,n)
        if np.abs(K.sum(1)).max()<1e-8 and abs(np.linalg.norm(K)**2-t)<1e-7 and -K.min()<best:
            best=-K.min();bK=K
    return best,bK
for n in (5,7,9,6):
    b,K=minmin(n,2.0,60)
    lb=np.sqrt(2.0/(n*(n-1)*(n-2)))
    print(f" n={n}: numeric min={b:.7f}  lemma bound={lb:.7f}  ratio={b/lb:.5f}")
    if n%2==1:
        s=np.round(np.sort(K[np.triu_indices(n,1)]),5)
        print(f"    sorted upper entries: {s}")
