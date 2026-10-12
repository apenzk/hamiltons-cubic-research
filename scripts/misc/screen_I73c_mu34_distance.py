import numpy as np, itertools
from scipy.optimize import minimize
P=list(itertools.combinations(range(6),2))
def mu(s):
    v=[]
    for i,j in P: v+=[(s[i]-s[j])**2,(s[i]+s[j])**2]
    v=np.sort(v); return 2*v[:14].sum()
def d2(s):
    s=np.sort(np.abs(s))[::-1]; s=s/np.linalg.norm(s)
    dd=(s[1:]**2).sum()                      # to the nearest decomposable (keep s1, rescale ignored: upper bound)
    dj=((s-s.mean())**2).sum()               # to the nearest multiple of an equal-angle complex structure
    return min(dd,dj), s
rng=np.random.default_rng(0); best=0; arg=None
for t in range(4000):
    s=np.abs(rng.normal(size=6))
    # bias toward the two degenerate types
    if t%3==0: s=np.array([1,*(rng.random(5)*0.2)])
    if t%3==1: s=1+rng.normal(size=6)*0.1
    s/=np.linalg.norm(s)
    f=lambda z: -d2(z)[0]/max(mu(np.sort(np.abs(z/np.linalg.norm(z)))[::-1]),1e-12)
    r=minimize(f,s,method='Nelder-Mead',options={'maxiter':400,'xatol':1e-9,'fatol':1e-12})
    val=-r.fun
    m=mu(np.sort(np.abs(r.x/np.linalg.norm(r.x)))[::-1])
    if val>best and m<0.2: best=val; arg=(np.sort(np.abs(r.x/np.linalg.norm(r.x)))[::-1], m)
print('sup of min(dist_dec^2, dist_J^2)/mu34 over mu34<0.2:', best); print('at', np.round(arg[0],4), 'mu34', arg[1])
