import numpy as np, sys, math
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
from scipy.optimize import minimize

def p3(x): return float(np.sum(x**3))

def max_p3_free(N):
    # max sum x^3, sum x =0, sum x^2 = 1  -> (N-2)/sqrt(N(N-1))
    return (N-2)/math.sqrt(N*(N-1))

def min_p3_maj(dsorted, S2, tries=60, seed=0):
    """min sum w^3 over w sorted desc, sum w=0, sum w^2=S2, partial sums >= partial sums of d."""
    D=len(dsorted); rng=np.random.default_rng(seed)
    P=np.cumsum(dsorted)
    cons=[{'type':'eq','fun':lambda w: np.sum(w)},
          {'type':'eq','fun':lambda w: np.sum(w**2)-S2},
          {'type':'ineq','fun':lambda w: -np.diff(w)},                 # w_i >= w_{i+1}
          {'type':'ineq','fun':lambda w: np.cumsum(w)[:-1]-P[:-1]}]
    best=np.inf; bw=None
    for t in range(tries):
        if t==0:
            w0=np.sort(dsorted)[::-1].copy()
        elif t==1:
            b=math.sqrt(S2/(D*(D-1))); w0=np.full(D,b); w0[-1]=-(D-1)*b
        else:
            w0=rng.standard_normal(D); w0-=w0.mean(); w0*=math.sqrt(S2)/np.linalg.norm(w0); w0=np.sort(w0)[::-1]
        r=minimize(lambda w: np.sum(w**3), w0, jac=lambda w:3*w**2, constraints=cons,
                   method='SLSQP', options={'maxiter':800,'ftol':1e-12})
        if r.success or r.status==9:
            w=r.x
            if (abs(np.sum(w))<1e-6 and abs(np.sum(w**2)-S2)<1e-5
                and np.min(np.cumsum(w)[:-1]-P[:-1])>-1e-6):
                if np.sum(w**3)<best: best=float(np.sum(w**3)); bw=w
    return best,bw

def full_diag(W):
    B=s20_basis(W.shape[0])
    return np.array([np.sum(b*np.einsum('iklj,kl->ij',W,b)) for b in B])

n=12; N=n*(n-1)//2; D=n*(n+1)//2-1
print(f"n={n}: N=dim Lambda^2={N}, D=dim S^2_0={D}")
A=1.5*max_p3_free(N); B0=-0.5*(-math.sqrt(3)**3*max_p3_free(D))
print(f"unconstrained relaxation = 3/2 max p3(mu) - 1/2 min p3(omega) = {A:.4f} + {B0:.4f} = {A+B0:.4f}")
Wsp=normalise(weyl_sphere_product(n,n//2))
d=full_diag(Wsp); K=Kmat(Wsp)
print(f"balanced S^6xS^6: ||K||_F^2={np.sum(K*K):.6f}  ||d||^2={np.sum(d**2):.6f}  sum d={np.sum(d):.2e}")
om=ring_spectrum(Wsp)
print(f"  check majorization omega > d: min slack = {np.min(np.cumsum(np.sort(om)[::-1])-np.cumsum(np.sort(d)[::-1])):.3e}")
ds=np.sort(d)[::-1]
v,w=min_p3_maj(ds,3.0,tries=40,seed=1)
print(f"  min p3(omega) with omega > d(sphere product) = {v:.6f}   ==> relaxation = {A-0.5*v:.4f}")
