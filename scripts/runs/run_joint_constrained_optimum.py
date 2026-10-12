"""The constrained optimum, solved rather than read off an extremiser.

Parametrise the spectrum SORTED DESCENDING, which makes majorization linear:
    x_1 >= ... >= x_D,   cumsum(x)_j >= cumsum(d_sorted)_j,   sum x = 0,  sum x^2 = s2.
Maximise / minimise sum x^3.  Multistart SLSQP.
VALIDITY GATE: the relaxation must be non-increasing in t (more constraint cannot help).
A non-monotone sweep means the solver failed and the numbers are not reported.
"""
import numpy as np, itertools
from scipy.optimize import minimize
rng=np.random.default_rng(127)
def okum(D,s2,sign=+1):
    b=np.sqrt(s2/(D*(D-1))); x=np.full(D,b); x[-1]=-(D-1)*b
    return np.sort(sign*x)[::-1]
def solve(D,s2,dsorted,maximise,starts=12):
    cd=np.cumsum(dsorted)
    cons=[{'type':'eq','fun':lambda x: x.sum()},
          {'type':'eq','fun':lambda x: np.sum(x**2)-s2},
          {'type':'ineq','fun':lambda x: x[:-1]-x[1:]},
          {'type':'ineq','fun':lambda x: np.cumsum(x)-cd}]
    sgn=-1.0 if maximise else 1.0
    best=None
    for s in range(starts):
        if s==0: x0=okum(D,s2,+1 if maximise else -1)
        elif s==1: x0=dsorted*np.sqrt(s2/max(np.sum(dsorted**2),1e-12))
        else:
            x0=np.sort(rng.standard_normal(D))[::-1]; x0=x0-x0.mean(); x0*=np.sqrt(s2/np.sum(x0**2))
        r=minimize(lambda x: sgn*np.sum(x**3), x0, constraints=cons, method='SLSQP',
                   options={'maxiter':800,'ftol':1e-14})
        if not r.success: continue
        x=r.x
        if abs(x.sum())>1e-6 or abs(np.sum(x**2)-s2)>1e-6: continue
        if (np.cumsum(np.sort(x)[::-1])-cd).min()<-1e-7: continue
        v=np.sum(x**3)
        if best is None or (v>best if maximise else v<best): best=v
    return best
def randK(n,t,rng):
    A=rng.standard_normal((n,n)); K=(A+A.T)/2; np.fill_diagonal(K,0)
    for _ in range(400):
        r=K.sum(1)/(n-2); K=K-np.add.outer(r,r)+(K.sum()/((n-1)*(n-2)))
        np.fill_diagonal(K,0); K=(K+K.T)/2
    nr=np.linalg.norm(K)
    return None if nr<1e-12 else K*np.sqrt(t)/nr
def diags(K,n):
    pr=list(itertools.combinations(range(n),2))
    dphi=np.array([K[a,b] for (a,b) in pr])
    w,V=np.linalg.eigh(K); v1=np.ones(n)/np.sqrt(n)
    keep=[i for i in range(n) if abs(V[:,i]@v1)<0.9]
    return np.sort(dphi)[::-1], np.sort(np.concatenate([dphi,-w[keep]]))[::-1]
n=6; Dm=n*(n-1)//2; Do=(n-1)*(n+2)//2; t0=np.sqrt(2*(n-1)*(n-2))/n
print(f"n={n}  D_mu={Dm} D_om={Do}  theta_0={t0:.6f}   unconstrained relaxation = 3.7446")
print(f"  {'t':>6} {'max p3(mu)':>11} {'min p3(om)':>11} {'relaxation':>11} {'/theta_0':>9}")
vals=[]
for t in [0.25,0.5,1.0,1.5,1.9,2.0]:
    best=-9
    for trial in range(4):
        K=randK(n,t,rng)
        if K is None: continue
        dphi,d=diags(K,n)
        a=solve(Dm,1.0,dphi,True); b=solve(Do,3.0,d,False)
        if a is None or b is None: continue
        best=max(best,1.5*a-0.5*b)
    vals.append((t,best))
    print(f"  {t:6.2f} {'':>11} {'':>11} {best:11.5f} {best/t0:9.3f}")
mono=all(vals[i][1]>=vals[i+1][1]-1e-6 for i in range(len(vals)-1))
print(f"\nVALIDITY GATE -- non-increasing in t? {mono}")
print("  (if False the solver failed and these numbers are NOT reportable)")
