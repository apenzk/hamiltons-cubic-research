import numpy as np
from scipy.optimize import minimize
r=np.sqrt(1/3); P=8-2*(2+np.sqrt(3))
def phi(e2): return np.minimum(P, 6*e2*(1-e2/4))
def F(d): return sum(phi(max(r-x,0)**2) for x in d)
rng=np.random.default_rng(0)
for eta in [0.3,0.5,0.6,0.7,0.75,0.8,0.9,1.0,1.2]:
    best=9
    for k in range(600):
        d0=np.abs(rng.normal(0,1,6)); 
        if rng.random()<0.5: d0[rng.integers(0,6,rng.integers(1,4))]*=5
        d0*=np.sqrt(eta)/np.linalg.norm(d0)
        res=minimize(lambda d: F(np.abs(d)) , d0, constraints=[{'type':'ineq','fun':lambda d: eta-np.sum(d**2)}],method='SLSQP')
        v=F(np.abs(res.x)) if np.sum(res.x**2)<=eta+1e-6 else 9
        best=min(best,v,F(d0))
    print('eta %.2f  min partner-deficit sum %.4f'%(eta,best))
