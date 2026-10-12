"""Claim 1 (min-entry lemma) and Claim 2 (is the sphere product the extremiser)."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys, itertools
from scipy.optimize import minimize, linprog
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r106'))
from r106_core import *
rng=np.random.default_rng(106)

def bound(n,t): return np.sqrt(t/(n*(n-1)*(n-2)))

# ---- middle step: min |min y| over sum y=0, sum y^2=s, length M ----
def middle_step(M,s,trials=4000):
    best=np.inf; bestv=None
    for _ in range(trials):
        y=rng.standard_normal(M); y-=y.mean(); y*=np.sqrt(s)/np.linalg.norm(y)
        r=minimize(lambda z: -z.min(), y,
                   constraints=[{'type':'eq','fun':lambda z: z.sum()},
                                {'type':'eq','fun':lambda z: z@z-s}],
                   method='SLSQP',options={'maxiter':300,'ftol':1e-14})
        if r.success and -r.x.min()<best and abs(r.x.sum())<1e-8 and abs(r.x@r.x-s)<1e-8:
            best=-r.x.min(); bestv=r.x
    return best,bestv

print("=== Claim 1, middle step: min |min y| s.t. sum y = 0, sum y^2 = s ===")
for M,s in [(5,1.0),(7,2.0),(3,1.0),(9,0.7)]:
    b,v=middle_step(M,s,600)
    pred=np.sqrt(s/(M*(M-1)))
    print(f"  M={M} s={s}: numeric min={b:.9f}  claimed sqrt(s/(M(M-1)))={pred:.9f}  ratio={b/pred:.6f}")
    print(f"     argmin sorted = {np.sort(v).round(6)}")

# ---- vertex class projection ----
def proj_vertex(X):
    """nearest hollow symmetric zero-row-sum matrix (that set is a linear space)"""
    n=X.shape[0]; A=(X+X.T)/2; np.fill_diagonal(A,0.0)
    for _ in range(200):
        r=A.sum(1)
        A=A-(np.add.outer(r,r))/(n-2)+A.sum()/((n-1)*(n-2))*np.ones((n,n))
        A=(A+A.T)/2; np.fill_diagonal(A,0.0)
        if np.abs(A.sum(1)).max()<1e-14: break
    return A

def min_entry_min(n,t,trials=300):
    """minimise |min_{a!=b} K_ab| over the vertex class at fixed ||K||_F^2=t"""
    best=np.inf; bestK=None
    for _ in range(trials):
        K0=proj_vertex(rng.standard_normal((n,n))); K0*=np.sqrt(t)/np.linalg.norm(K0)
        x0=K0[np.triu_indices(n,1)]
        def unpack(x):
            K=np.zeros((n,n)); K[np.triu_indices(n,1)]=x; return K+K.T
        r=minimize(lambda x: -unpack(x).min(), x0,
                   constraints=[{'type':'eq','fun':lambda x: unpack(x).sum(1)},
                                {'type':'eq','fun':lambda x: x@x*2-t}],
                   method='SLSQP',options={'maxiter':600,'ftol':1e-16})
        K=unpack(r.x)
        if (np.abs(K.sum(1)).max()<1e-8 and abs(np.linalg.norm(K)**2-t)<1e-8
            and -K.min()<best):
            best=-K.min(); bestK=K
    return best,bestK

def matching_K(n,t):
    """the equality configuration: perfect matching heavy, everything else equal"""
    assert n%2==0
    c=np.sqrt(t/(n*(n-1)*(n-2)))
    K=-c*(np.ones((n,n))-np.eye(n))
    for a in range(0,n,2):
        K[a,a+1]=(n-2)*c; K[a+1,a]=(n-2)*c
    return K

print("\n=== Claim 2: min |min K| at t=2, vertex class ===")
print(f"{'n':>3} {'lemma bound':>12} {'matching K':>12} {'SLSQP min':>12} {'sphere prod':>12} {'claim2 witness':>14}")
c2={6:0.1732,8:0.1499,10:0.1444}
for n in (6,8,10):
    t=2.0
    Ksp=vertex_matrix(sphere_product(n//2,n//2)); Ksp/=np.linalg.norm(to_M(sphere_product(n//2,n//2)))
    sp=-Ksp.min()
    Km=matching_K(n,t)
    num,Kb=min_entry_min(n,t,120 if n<10 else 80)
    print(f"{n:>3} {bound(n,t):>12.6f} {-Km.min():>12.6f} {num:>12.6f} {sp:>12.6f} {c2[n]:>14.4f}")
    print(f"     matching-K checks: rowsum={np.abs(Km.sum(1)).max():.1e} |K|^2={np.linalg.norm(Km)**2:.10f}")
