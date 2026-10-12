import sys; sys.path.insert(0,'scripts/reviewers/r336')
import numpy as np, fast
from scipy.optimize import minimize
np.random.seed(4336)
n=6; P,N,q=fast.weyl_ortho(n); c=fast.struct(n); D=q.shape[1]
tgt=np.load('scripts/reviewers/r336/optspec.npy')
def spec(x):
    W=(q@x).reshape(N,N); W=(W+W.T)/2; W/=np.linalg.norm(W)
    return np.linalg.eigvalsh(W),W
def f(x):
    s,_=spec(x); return float(np.sum((s-tgt)**2))
best=(1e9,None)
for t in range(25):
    x0=np.random.randn(D)
    r=minimize(f,x0,method='Nelder-Mead',options={'maxiter':40000,'maxfev':40000,'fatol':1e-14,'xatol':1e-12})
    if r.fun<best[0]: best=(r.fun,r.x)
d,x=best
s,W=spec(x)
QW=fast.Q(W,c); th=float(np.sum(W*QW))
print('REALIZATION ATTEMPT for the T9-optimal spectrum at n=6')
print('  best ||sort(spec(W)) - target||^2 = %.6e   (i.e. distance %.6f)'%(d,np.sqrt(d)))
print('  achieved spectrum:'); print(np.round(s,6))
print('  target          :'); print(np.round(tgt,6))
print('  at the best fit: theta = %.6f   crit residual = %.4f'%(th,np.linalg.norm(QW-th*W)))
# control: can the method realise a spectrum that IS realizable?
Wc=(q@np.random.randn(D)).reshape(N,N); Wc=(Wc+Wc.T)/2; Wc/=np.linalg.norm(Wc)
ctl=np.linalg.eigvalsh(Wc)
def g(x):
    s,_=spec(x); return float(np.sum((s-ctl)**2))
bc=(1e9,None)
for t in range(10):
    r=minimize(g,np.random.randn(D),method='Nelder-Mead',options={'maxiter':40000,'maxfev':40000,'fatol':1e-14,'xatol':1e-12})
    if r.fun<bc[0]: bc=(r.fun,r.x)
print('  CONTROL (a spectrum known realizable): best distance = %.6e -> %.6f'%(bc[0],np.sqrt(bc[0])))
