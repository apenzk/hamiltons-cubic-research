"""The joint (both-sided) relaxation, as a function of t = ||K||_F^2.

At a given K:  mu > d_phi with sum mu^2 = 1,  omega > d with sum omega^2 = 3,
where sum d_phi^2 = t/2 and sum d^2 = 3t/2.  Maximise 3/2 p3(mu) - 1/2 p3(omega).

DANGER TO TEST FIRST: majorization is a LOWER bound on spread, so it constrains only when
the norms nearly coincide.  At t = 0 both constraints vanish.  If K is a free variable in the
relaxation, the optimum sits at t = 0 and the whole both-sided idea is inert -- the same way
the kappa programme was.  Test that before anything else.
"""
import numpy as np
from scipy.optimize import minimize
def okumura_min_p3(D, s2):
    """min of sum x^3 over sum x = 0, sum x^2 = s2, D entries: one very negative."""
    b=np.sqrt(s2/(D*(D-1))); x=np.full(D,b); x[-1]=-(D-1)*b
    return np.sum(x**3), x
def okumura_max_p3(D, s2):
    v,x=okumura_min_p3(D,s2); return -v, -x
def best_mu(D, s2, dphi):
    """max sum mu^3 s.t. sum mu = 0, sum mu^2 = s2, mu majorizes dphi."""
    dd=np.sort(dphi)[::-1]; cd=np.cumsum(dd)
    x0=okumura_max_p3(D,s2)[1]
    cons=[{'type':'eq','fun':lambda x: x.sum()},
          {'type':'eq','fun':lambda x: np.sum(x**2)-s2},
          {'type':'ineq','fun':lambda x: np.cumsum(np.sort(x)[::-1])-cd}]
    r=minimize(lambda x:-np.sum(x**3), x0, constraints=cons, method='SLSQP',
               options={'maxiter':400,'ftol':1e-12})
    return -r.fun if r.success else np.sum(x0**3)
def worst_om(D, s2, d):
    dd=np.sort(d)[::-1]; cd=np.cumsum(dd)
    x0=okumura_min_p3(D,s2)[1]
    cons=[{'type':'eq','fun':lambda x: x.sum()},
          {'type':'eq','fun':lambda x: np.sum(x**2)-s2},
          {'type':'ineq','fun':lambda x: np.cumsum(np.sort(x)[::-1])-cd}]
    r=minimize(lambda x:np.sum(x**3), x0, constraints=cons, method='SLSQP',
               options={'maxiter':400,'ftol':1e-12})
    return r.fun if r.success else np.sum(x0**3)
for n in [6,8,12]:
    Dm=n*(n-1)//2; Do=(n-1)*(n+2)//2
    t0=np.sqrt(2*(n-1)*(n-2))/n
    print(f"\nn={n}  D_mu={Dm} D_om={Do}  theta_0={t0:.6f}")
    print(f"  {'t=||K||^2':>10} {'max p3(mu)':>11} {'min p3(om)':>11} {'joint relax':>12} {'vs theta_0':>11}")
    for t in [0.0,0.5,1.0,1.5,1.9,2.0]:
        # flat-shaped d at the given norm (the shape that makes majorization weakest)
        sp=t/2.0; sd=1.5*t
        dphi=okumura_min_p3(Dm,sp)[1] if sp>0 else np.zeros(Dm)
        dfull=okumura_min_p3(Do,sd)[1] if sd>0 else np.zeros(Do)
        a=best_mu(Dm,1.0,dphi); b=worst_om(Do,3.0,dfull)
        val=1.5*a-0.5*b
        print(f"  {t:10.2f} {a:11.5f} {b:11.5f} {val:12.5f} {val/t0:11.3f}")
